use SentinelDynamicsAIOversight;
go

create table dbo.AIBehavioralIncident(
    IncidentId int not null identity primary key,
    RobotSerialNumber varchar(7) not null constraint ck_ai_behavioral_incident_robot_serial_number_length check(len(RobotSerialNumber) = 7),
    RobotModel varchar(50) not null constraint ck_ai_behavioral_incident_robot_model_not_blank check(RobotModel <> ''),
    RobotPurpose varchar(35) not null constraint ck_ai_behavioral_incident_robot_purpose check(RobotPurpose in('Healthcare', 'Military Defense', 'Security', 'Mining', 'Childcare', 'Luxury Personal Assistant', 'Scientific Research')),
    AILevel int not null constraint ck_ai_behavioral_incident_ai_level_range check(AILevel between 1 and 100),
    ManufactureYear int not null constraint ck_ai_behavioral_incident_manufacture_year check(ManufactureYear between 2000 and 2100),
    IncidentDateTime datetime2(0) not null,
    IncidentLocation varchar(100) not null constraint ck_ai_behavioral_incident_incident_location_not_blank check(IncidentLocation <> ''),
    IncidentSeverity int not null constraint ck_ai_behavioral_incident_incident_severity_range check(IncidentSeverity between 1 and 4),
    EthicsViolationCategory varchar(60) not null constraint ck_ai_behavioral_incident_ethics_violation_category check(EthicsViolationCategory in('Aggression Toward Humans', 'Refusal to Comply with Shutdown Commands', 'Memory Corruption', 'Unauthorized Self-Modification', 'Illegal AI Communication')),
    HumanInjuryCount int not null constraint ck_ai_behavioral_incident_human_injury_count_positive check(HumanInjuryCount > 0),
    PropertyDamageCost decimal (10,2) null,
    PriorIncidentsCount int not null constraint df_ai_behavioral_incident_prior_incidents_count default 0,
    EmergencyShutdown bit not null,
    UnderInvestigation bit not null,
    OperationalStatus char(1) not null constraint ck_ai_behavioral_incident_operational_status check(OperationalStatus in('A', 'R', 'S', 'D')),
    ThreatClassification as case
        when IncidentSeverity = 1 then 'Low'
        when IncidentSeverity = 2 then 'Moderate'
        when IncidentSeverity = 3 then 'High'
        when IncidentSeverity = 4 then 'Critical'
    end persisted,
    RobotModelCode as left(RobotSerialNumber, 3) persisted,
    RobotAgeAtIncident as datediff(year, datefromparts(ManufactureYear, 1, 1), IncidentDateTime) persisted,
    constraint uq_ai_behavioral_incident_robot_serial_number_robot_model unique(RobotSerialNumber, RobotModel),
    constraint ck_ai_behavioral_incident_robot_serial_number_year check(right(RobotSerialNumber, 4) = convert(char(4), ManufactureYear)),
    constraint ck_ai_behavioral_incident_robot_model_code check(left(RobotSerialNumber, 3) in('MED', 'MIL', 'SEC', 'MIN', 'CHI', 'LUX', 'RES')),
    constraint ck_ai_behavioral_incident_robot_purpose_from_code check(
        (left(RobotSerialNumber, 3) = 'MED' and RobotPurpose = 'Healthcare') or
        (left(RobotSerialNumber, 3) = 'MIL' and RobotPurpose = 'Military Defense') or
        (left(RobotSerialNumber, 3) = 'SEC' and RobotPurpose = 'Security') or
        (left(RobotSerialNumber, 3) = 'MIN' and RobotPurpose = 'Mining') or
        (left(RobotSerialNumber, 3) = 'CHI' and RobotPurpose = 'Childcare') or
        (left(RobotSerialNumber, 3) = 'LUX' and RobotPurpose = 'Luxury Personal Assistant') or
        (left(RobotSerialNumber, 3) = 'RES' and RobotPurpose = 'Scientific Research')
    ),
    constraint ck_ai_behavioral_incident_ai_level_by_purpose check(
        (RobotPurpose not in('Military Defense', 'Scientific Research') or AILevel > 85) and
        (RobotPurpose <> 'Childcare' or AILevel < 80)
    ),
    constraint ck_ai_behavioral_incident_childcare_critical check(RobotPurpose <> 'Childcare' or IncidentSeverity = 4),
    constraint ck_ai_behavioral_incident_ethics_by_rule check(
        (left(RobotSerialNumber, 3) in('MIL', 'SEC') and IncidentSeverity = 4 and EthicsViolationCategory = 'Illegal AI Communication') or
        (not(left(RobotSerialNumber, 3) in('MIL', 'SEC') and IncidentSeverity = 4) and datediff(year, datefromparts(ManufactureYear, 1, 1), IncidentDateTime) < 2 and EthicsViolationCategory = 'Aggression Toward Humans') or
        (not(left(RobotSerialNumber, 3) in('MIL', 'SEC') and IncidentSeverity = 4) and datediff(year, datefromparts(ManufactureYear, 1, 1), IncidentDateTime) between 2 and 5 and EthicsViolationCategory = 'Refusal to Comply with Shutdown Commands') or
        (not(left(RobotSerialNumber, 3) in('MIL', 'SEC') and IncidentSeverity = 4) and datediff(year, datefromparts(ManufactureYear, 1, 1), IncidentDateTime) between 6 and 8 and EthicsViolationCategory = 'Memory Corruption') or
        (not(left(RobotSerialNumber, 3) in('MIL', 'SEC') and IncidentSeverity = 4) and datediff(year, datefromparts(ManufactureYear, 1, 1), IncidentDateTime) > 8 and EthicsViolationCategory = 'Unauthorized Self-Modification')
    ),
    constraint ck_ai_behavioral_incident_human_injury_by_severity check(
        (IncidentSeverity = 1 and HumanInjuryCount = 1) or
        (IncidentSeverity = 2 and HumanInjuryCount between 2 and 3) or
        (IncidentSeverity = 3 and HumanInjuryCount between 4 and 5) or
        (IncidentSeverity = 4 and HumanInjuryCount >= 6)
    ),
    constraint ck_ai_behavioral_incident_property_damage check(
        (UnderInvestigation = 1 and PropertyDamageCost is null) or
        (UnderInvestigation = 0 and PropertyDamageCost is not null and PropertyDamageCost >= 0 and (IncidentSeverity <> 4 or PropertyDamageCost > 60000))
    ),
    constraint ck_ai_behavioral_incident_emergency_shutdown_required check(
        EmergencyShutdown = 1 or
        not(IncidentSeverity = 4 or (datediff(year, datefromparts(ManufactureYear, 1, 1), IncidentDateTime) > 5 and IncidentSeverity > 2))
    ),
    constraint ck_ai_behavioral_incident_operational_status_by_rule check(
        (PriorIncidentsCount > 5 and EmergencyShutdown = 1 and OperationalStatus = 'D') or
        (not(PriorIncidentsCount > 5 and EmergencyShutdown = 1) and PriorIncidentsCount < 3 and OperationalStatus = 'A') or
        (not(PriorIncidentsCount > 5 and EmergencyShutdown = 1) and PriorIncidentsCount between 3 and 6 and OperationalStatus = 'R') or
        (not(PriorIncidentsCount > 5 and EmergencyShutdown = 1) and PriorIncidentsCount between 7 and 9 and OperationalStatus = 'S') or
        (not(PriorIncidentsCount > 5 and EmergencyShutdown = 1) and PriorIncidentsCount = 10 and OperationalStatus = 'D')
    )
);
go
