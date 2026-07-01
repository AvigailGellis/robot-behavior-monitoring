/*
Sentinel Dynamics AI Oversight Director: 

My name is Dr. Michael Grant, Director of AI Safety Operations at Sentinel Dynamics,
a global developer of advanced humanoid artificial intelligence systems.

I oversee the company’s AI Behavioral Oversight Division, which is responsible for monitoring and investigating
dangerous behavioral incidents involving our robotic units.

Our organization develops advanced humanoid robots deployed across a wide range of industries,
including healthcare, military defense, security, mining, childcare, luxury personal assistance, and scientific research.

Recently, we have experienced a series of dangerous behavioral incidents involving our AI units,
including aggression toward humans, refusal to comply with shutdown commands, unauthorized self modification,
memory corruption, and illegal communication between AI systems.

In response to these issues and in compliance with new international AI safety regulations, the company is now required
to maintain detailed electronic records of every reported AI behavioral incident. 
We would like to begin by implementing a centralized database for recording and managing AI behavioral incidents involving our robotic units.

Each incident is stored as an individual record and is associated with one specific robotic unit, including the incident ID, robot serial number,
robot model, robot purpose classification, AI intelligence level, robot manufacture year, incident date and time, incident location, 
incident severity, ethics violation category, number of human injuries caused, the number of prior incidents associated with that robot and
property damage cost noting that this value may be unavailable during ongoing investigations and can therefore remain unrecorded until assessed.

For safety and compliance tracking, we also need to record whether emergency shutdown procedures were activated, 
and whether the case remains under investigation.

We also need to track the robot’s current operational status, which may indicate whether the unit is active, restricted, suspended, or decommissioned
depending on the severity of the incident and investigation outcome.

Robot Serial Number: Serial numbers must be exactly 7 characters, constructed as:
            First 3 characters - Robot Model Code prefix
            Last 4 characters - Manufacture Year
Robot Purpose: Derived from Robot Model Code prefix:
            MED - Healthcare
            MIL - Military Defense
            SEC - Security
            MIN - Mining
            CHI - Childcare
            LUX - Luxury Personal Assistant
            RES - Scientific Research
AI Intelligence Level: Scale from 1–100
            Military and research units must be > 85
            Childcare units must be < 80 (safety restriction)
Incident Severity: 1 - Low
            2 - Moderate
            3 - High
            4 - Critical
            If Robot Purpose is Childcare then Incident Severity must be 4, Childcare automatically escalates severity to Critical.
Ethics Violation Category: Determined based on robot age at the time of the incident, where:
            If Robot Age < 2 - Aggression Toward Humans
            If Robot Age between 2 and 5 - Refusal to Comply with Shutdown Commands
            If Robot Age between 6 and 8 - Memory Corruption
            If Robot Age > 8 - Unauthorized Self-Modification
            If Robot Purpose Classification is MIL or SEC and Incident Severity is 4 then 
            illegal communication between AI systems is detected 
            and Ethics Violation Category = Illegal AI Communication (overrides all other categories)
Number Of Human Injuries Caused: derived from Incident Severity
            If Incident Severity is 1 - then 1 person 
            If Incident Severity is 2 - then 2-3 people 
            If Incident Severity is 3 - then 4-5 people 
            If Incident Severity is 4 - then 6 or more people
Property Damage Cost: If Incident Severity is Critical - must exceed $60,000
            Null if Case Under Investigation is True
Emergency Shutdown Activated:
            True if:
            Incident Severity = 4 (Critical) or
            Robot age > 5 years and Incident Severity > 2
            Otherwise: may be True or False
RobotOperationalStatus: Derived after incident from Incident Severity:
            If Prior Incident Count is < 3 - A = Active
            If Prior Incident Count is between 3 and 6 - R = Restricted
            If Prior Incident Count is between 7 and 9 - S = Suspended
            If Prior Incident Count is 10 - D = Decommissioned
            If Prior Incident Count is > 5 and Emergency Shutdown Activated = True - status must be D (Decommissioned)

Questions:
Q: Do we need to store the exact time of each incident, or is the date sufficient?
A: Yes, the exact date and time must be recorded. Many incidents escalate within minutes.

Q: Can multiple robot models share the same serial number?
A: Yes. Robot serial numbers are not globally unique, but the combination of Robot Serial Number and Robot Model must remain unique.

Q: If a robot is decommissioned, can new incidents still be recorded for it?
A: No, decommissioned robots cannot generate operational incidents.

Q: Should prior incident count include incidents that are still under investigation?
A: Yes, all incidents must be included regardless of investigation status, since they still represent behavioral history of the robot.

Q: What should happen if property damage is not yet known during an ongoing investigation?
A: The property damage field should remain null until confirmed. It must not be estimated or set to zero during early investigation stages.

Q: If a robot has no previous incidents, how should prior incident count be represented?
A: It should be recorded as 0. Null values are not allowed for prior incident tracking.

Sample Data: 
RobotSerialNumber, RobotModel, RobotPurpose, AILevel, ManufactureYear, IncidentDateTime, IncidentLocation, IncidentSeverity, 
EthicsViolationCategory, HumanInjuryCount, PropertyDamageCost, PriorIncidentsCount, EmergencyShutdown, UnderInvestigation, OperationalStatus

MIL2012, MIL-Oracle Combat Unit, Military Defense, 92, 2012, 2020-03-01 18:45, RavenShield Defense Base, 4, Illegal AI Communication, 7, Null, 6, True, True, D
CHI2023, CHI-SafeNest Alpha, Childcare, 78, 2023, 2024-01-22 04:28, BrightFuture Learning Center, 4, Aggression Toward Humans, 9, 65780, 3, True, False, R
SEC2020, SEC-Sentinel Core, Security, 82, 2020, 2022-10-18 03:55, Central Metro Security Hub, 2, Refusal to Comply with Shutdown Commands, 3, Null, 10, False, True, D
MED2026, MED-AuraX I, Healthcare, 93, 2026, 2026-05-24 10:10, Northbridge Surgical Institute, 2, Aggression Toward Humans, 2, 27384, 7, True, False, D
MIN2015, MIN-ExcavaCore, Mining, 96, 2015, 2025-08-09 14:35, DeepCore Extraction Facility, 3, Unauthorized Self-Modification, 4, 52378, 4, True, False, R
RES2019, RES-QuantumThinker, Scientific Research, 87, 2019, 2021-06-14 16:15, NovaTech Advanced AI Testing Facility, 1, Refusal to Comply with Shutdown Commands, 1, 10958, 9, False, False, S
CHI2018, CHI-NannyCore, Childcare, 72, 2018, 2025-03-29 13:10, Little Horizons Childcare Campus, 4, Memory Corruption, 6, Null, 7, True, True, D
LUX2022, LUX-Assist Elite, Luxury Personal Assistant, 91, 2022, 2023-04-18 12:25, Grand Orion Luxury Resort, 2, Aggression Toward Humans, 3, 25083, 5, True, False, R 
MED2021, MED-VitaSync Alpha, Healthcare, 89, 2021, 2023-11-24 15:55, Eastvale Emergency Trauma Center, 1, Refusal to Comply with Shutdown Commands, 1, Null, 4, False, True, R
RES2019, RES-DataCore VII, Scientific Research, 95, 2019, 2021-12-18 17:32, Orion Scientific Research Facility, 4, Refusal to Comply with Shutdown Commands, 12, 87156, 8, True, False, D
MIN2025, MIN-DeepForge MK2, Mining, 82, 2025, 2026-09-02 05:40, IronVault Mining Complex, 3, Aggression Toward Humans, 5, 52000, 2, False, False, A


Reports:

1) List all High and Critical incidents including robot model, injuries, and threat classification ordered by highest threat.

2) Show total property damage cost grouped by robot model.

3) Show robots with repeated incidents and their operational status.

4) Show all incidents involving unauthorized self-modification.

5) Show the average AI intelligence level grouped by robot purpose classification.

6) Show the average repair cost grouped by incident severity.

7) Show all robots currently under government monitoring.

8) Show the number of incidents grouped by threat classification.
*/