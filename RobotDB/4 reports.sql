use SentinelDynamicsAIOversight;
go

-- 1) List all High and Critical incidents including robot model, injuries, and threat classification ordered by highest threat.
select
    IncidentId,
    RobotModel,
    HumanInjuryCount,
    ThreatClassification
from dbo.AIBehavioralIncident
where IncidentSeverity in(3, 4)
order by IncidentSeverity desc, HumanInjuryCount desc;
go

-- 2) Show total property damage cost grouped by robot model.
select
    RobotModel,
    sum(PropertyDamageCost) as TotalPropertyDamageCost
from dbo.AIBehavioralIncident
group by RobotModel
order by TotalPropertyDamageCost desc;
go

-- 3) Show robots with repeated incidents and their operational status.
select
    RobotSerialNumber,
    RobotModel,
    PriorIncidentsCount,
    OperationalStatus
from dbo.AIBehavioralIncident
where PriorIncidentsCount > 0
order by PriorIncidentsCount desc;
go

-- 4) Show all incidents involving unauthorized self-modification.
select
    IncidentId,
    RobotSerialNumber,
    RobotModel,
    IncidentDateTime,
    IncidentLocation,
    EthicsViolationCategory
from dbo.AIBehavioralIncident
where EthicsViolationCategory = 'Unauthorized Self-Modification'
order by IncidentDateTime;
go

-- 5) Show the average AI intelligence level grouped by robot purpose classification.
select
    RobotPurpose,
    avg(cast(AILevel as decimal(5, 2))) as AverageAILevel
from dbo.AIBehavioralIncident
group by RobotPurpose
order by AverageAILevel desc;
go

-- 6) Show the average repair cost grouped by incident severity.
select
    IncidentSeverity,
    ThreatClassification,
    avg(cast(PropertyDamageCost as money)) as AverageRepairCost
from dbo.AIBehavioralIncident
group by IncidentSeverity, ThreatClassification
order by IncidentSeverity;
go

-- 7) Show all robots currently under government monitoring.
select
    IncidentId,
    RobotSerialNumber,
    RobotModel,
    RobotPurpose,
    IncidentSeverity,
    ThreatClassification,
    UnderInvestigation,
    OperationalStatus
from dbo.AIBehavioralIncident
where UnderInvestigation = 1 or OperationalStatus in('S', 'D') or IncidentSeverity = 4
order by IncidentSeverity desc, RobotModel;
go

-- 8) Show the number of incidents grouped by threat classification.
select
    ThreatClassification,
    count(*) as NumberOfIncidents
from dbo.AIBehavioralIncident
group by ThreatClassification
order by min(IncidentSeverity);
go
