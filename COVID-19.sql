create table CovidDeaths(iso_code varchar,
						 continent varchar,
						 location varchar,
						 date varchar,
						 population numeric,
						 total_cases varchar,
						 new_cases numeric,
						 total_deaths varchar,
						 new_deaths numeric,
						 total_deaths_per_million varchar,
						 new_deaths_per_million numeric,
						 reproduction_rate varchar,
						 icu_patients varchar,
						 hosp_patients varchar,
						 weekly_icu_admissions varchar,
						 weekly_hosp_admissions varchar
)

create table CovidVaccinations(iso_code varchar,
							   continent varchar,
							   location varchar,
							   date varchar,
							   total_tests varchar,
							   new_tests varchar,
							   positive_rate varchar,
							   tests_per_case varchar,
							   tests_units varchar,
							   total_vaccinations varchar,
							   people_vaccinated varchar,
							   people_fully_vaccinated varchar,
							   total_boosters varchar,
							   new_vaccinations	varchar,
							   stringency_index float,
							   population_density float,
							   median_age float,
							   aged_65_older float,
							   aged_70_older float,
							   gdp_per_capita float,
							   extreme_poverty varchar,	
							   cardiovasc_death_rate float,
							   diabetes_prevalence float,
							   handwashing_facilities float,
							   life_expectancy float,
							   human_development_index float,
							   excess_mortality_cumulative varchar,
							   excess_mortality varchar
)
select * from coviddeaths;
select * from CovidVaccinations;

--Portfolio Project Queries

--a.Datewise Likelihood of dying due to covid-Totalcases vs TotalDeath- in India

select date,total_cases,total_deaths,(cast (total_deaths as double precision)/cast(total_cases as double precision)*100) as death_percentage 
from CovidDeaths
where location like '%India%';


--b.Total % of deaths out of entire population- in India

select (cast(max(total_deaths) as double precision)/avg(cast(population as double precision))*100) as percentage 
from "CovidDeaths" 
where location like '%India%';


--c.Verify b by getting info separately

select max(total_deaths) as total_deaths,avg(cast(population as double precision)) as population 
from "CovidDeaths" 
where location like '%India%';


SELECT * FROM public."CovidDeaths" 
where location like '%India%';


--d.Country with highest death as a % of population

select location,(cast(max(total_deaths) as double precision)/avg(cast(population as double precision))*100) as percentage 
from CovidDeaths
group by location 
order by percentage desc;

--e.Total % of covid +ve cases- in India

select (cast(max(total_cases) as double precision)/avg(cast(population as double precision))*100) as percentage 
from CovidDeaths 
where location like '%India%';


--f.Total % of covid +ve cases- in world

select location,(cast(max(total_cases) as double precision)/avg(cast(population as double precision))*100) as percentage 
from CovidDeaths 
group by location 
order by percentage desc;


--g.Continentwise +ve cases

select location,max(total_cases) as total_cases 
from CovidDeaths 
where continent is null 
group by location 
order by total_cases desc;


--h.Continentwise deaths

select location,max(total_deaths) as total_deaths 
from CovidDeaths 
where continent is null 
group by location 
order by total_deaths desc;


--i.Daily newcases vs hospitalizations vs icu_patients- India

select date,new_cases,hosp_patients,icu_patients 
from CovidDeaths 
where location='India';


--j.countrywise age>65

select CovidDeaths.location,CovidVaccinations.aged_65_older 
from CovidDeaths 
join CovidVaccinations on CovidDeaths.iso_code=CovidVaccinations.iso_code and CovidDeaths.date=CovidVaccinations.date;

select avg(CovidDeaths.population), max(CovidVaccinations.people_fully_vaccinated), CovidVaccinations.total_boosters 
from CovidDeaths inner join CovidVaccinations on CovidDeaths.iso_code=CovidVaccinations.iso_code and CovidDeaths.date=CovidVaccinations.date  
group by CovidVaccinations.location, CovidVaccinations.total_boosters ;


--k. Countrywise total vaccinated persons

select CovidDeaths.location as country,max(CovidVaccinations.people_fully_vaccinated) as Fully_vaccinated 
from CovidDeaths 
join CovidVaccinations on CovidDeaths.iso_code=CovidVaccinations.iso_code and CovidDeaths.date=CovidVaccinations.date 
where CovidDeaths.continent is not null 
group by country 
order by Fully_vaccinated desc;
