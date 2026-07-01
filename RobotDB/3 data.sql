use SentinelDynamicsAIOversight;
go

insert dbo.AIBehavioralIncident(RobotSerialNumber, RobotModel, RobotPurpose, AILevel, ManufactureYear, IncidentDateTime, IncidentLocation, IncidentSeverity, EthicsViolationCategory, HumanInjuryCount, PropertyDamageCost, PriorIncidentsCount, EmergencyShutdown, UnderInvestigation, OperationalStatus)
select 'MIL2012', 'MIL-Oracle Combat Unit', 'Military Defense', 92, 2012, '2020-03-01 18:45', 'RavenShield Defense Base', 4, 'Illegal AI Communication', 7, null, 6, 1, 1, 'D'
union all select 'CHI2023', 'CHI-SafeNest Alpha', 'Childcare', 78, 2023, '2024-01-22 04:28', 'BrightFuture Learning Center', 4, 'Aggression Toward Humans', 9, 65780, 3, 1, 0, 'R'
union all select 'SEC2020', 'SEC-Sentinel Core', 'Security', 82, 2020, '2022-10-18 03:55', 'Central Metro Security Hub', 2, 'Refusal to Comply with Shutdown Commands', 3, null, 10, 0, 1, 'D'
union all select 'MED2026', 'MED-AuraX I', 'Healthcare', 93, 2026, '2026-05-24 10:10', 'Northbridge Surgical Institute', 2, 'Aggression Toward Humans', 2, 27384, 7, 1, 0, 'D'
union all select 'MIN2015', 'MIN-ExcavaCore', 'Mining', 96, 2015, '2025-08-09 14:35', 'DeepCore Extraction Facility', 3, 'Unauthorized Self-Modification', 4, 52378, 4, 1, 0, 'R'
union all select 'RES2019', 'RES-QuantumThinker', 'Scientific Research', 87, 2019, '2021-06-14 16:15', 'NovaTech Advanced AI Testing Facility', 1, 'Refusal to Comply with Shutdown Commands', 1, 10958, 9, 0, 0, 'S'
union all select 'CHI2018', 'CHI-NannyCore', 'Childcare', 72, 2018, '2025-03-29 13:10', 'Little Horizons Childcare Campus', 4, 'Memory Corruption', 6, null, 7, 1, 1, 'D'
union all select 'LUX2022', 'LUX-Assist Elite', 'Luxury Personal Assistant', 91, 2022, '2023-04-18 12:25', 'Grand Orion Luxury Resort', 2, 'Aggression Toward Humans', 3, 25083, 5, 1, 0, 'R'
union all select 'MED2021', 'MED-VitaSync Alpha', 'Healthcare', 89, 2021, '2023-11-24 15:55', 'Eastvale Emergency Trauma Center', 1, 'Refusal to Comply with Shutdown Commands', 1, null, 4, 0, 1, 'R'
union all select 'RES2019', 'RES-DataCore VII', 'Scientific Research', 95, 2019, '2021-12-18 17:32', 'Orion Scientific Research Facility', 4, 'Refusal to Comply with Shutdown Commands', 12, 87156, 8, 1, 0, 'D'
union all select 'MIN2025', 'MIN-DeepForge MK2', 'Mining', 82, 2025, '2026-09-02 05:40', 'IronVault Mining Complex', 3, 'Aggression Toward Humans', 5, 52000, 2, 0, 0, 'A';
go
