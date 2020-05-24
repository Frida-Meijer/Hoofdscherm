USE activitiesapp;

/*
	Gemaakt: 	2020-05-17
    Door:	 	WSH
    Doel: 		Leeggooien en vullen met testset van de basis tabellen van
				de activiteitenapp t.b.v. de eindopdracht leergang programmeren.
*/


/*
	Zet save update uit om alles weg te kunnen gooien.
	Anders moet het met behulp van de sleutel.
*/
SET SQL_SAFE_UPDATES=0;

/*
	Gooi de tabellen leeg en laat het sleutelveld weer bij 1 beginnen.
*/
DELETE FROM bridge_activitiesagegroups;
ALTER TABLE bridge_activitiesagegroups AUTO_INCREMENT = 1;
DELETE FROM activities;
ALTER TABLE activities AUTO_INCREMENT = 1;
DELETE FROM agegroups;
ALTER TABLE agegroups AUTO_INCREMENT = 1;
DELETE FROM categories;
ALTER TABLE categories AUTO_INCREMENT = 1;
DELETE FROM pricegroups;
ALTER TABLE pricegroups AUTO_INCREMENT = 1;


/*
	Zet safe update weer aan.
*/
SET SQL_SAFE_UPDATES=1;

/*
	Vul de category tabel
*/
INSERT INTO activitiesapp.categories(CategoryCode,CategoryName,CategoryDescription)
VALUES('Fietsen','Fietsen','Alle activiteiten m.b.t. fietsen. Van Mountainbike routes t/m tourischtische tours');
INSERT INTO activitiesapp.categories(CategoryCode,CategoryName,CategoryDescription)
VALUES('Quizzen','Quizzen','Van Pubquiz tot Harry Potter Quiz, voor elk wat wils!');
INSERT INTO activitiesapp.categories(CategoryCode,CategoryName,CategoryDescription)
VALUES('Social','Social','Van babbelbox tot chatprogram, mense praten met mensen');

/*
	Vul de PriceGroups tabel
*/
INSERT INTO activitiesapp.pricegroups(PriceGroupCode,PriceGroupName,PriceGroupDescription,PriceGroupStart,PriceGroupEnd)
VALUES ('Gratis','Gratis','Hieronder vallen alle activitetien die minder dan een euro kosten',0,1);
INSERT INTO activitiesapp.pricegroups(PriceGroupCode,PriceGroupName,PriceGroupDescription,PriceGroupStart,PriceGroupEnd)
VALUES ('Goedkoop','Goedkoop','Activiteiten vanaf 1 tot 20 euro',1,20);
INSERT INTO activitiesapp.pricegroups(PriceGroupCode,PriceGroupName,PriceGroupDescription,PriceGroupStart,PriceGroupEnd)
VALUES ('Redelijk','Redelijk','Activiteiten vanaf 20 tot 60 euro',20,60);
INSERT INTO activitiesapp.pricegroups(PriceGroupCode,PriceGroupName,PriceGroupDescription,PriceGroupStart,PriceGroupEnd)
VALUES ('Prijzig','Prijzig','Activiteiten vanaf 60 tot 100 euro',60,100);
INSERT INTO activitiesapp.pricegroups(PriceGroupCode,PriceGroupName,PriceGroupDescription,PriceGroupStart,PriceGroupEnd)
VALUES ('Duur','Duur','Activiteiten die meer dan 100 euro kosten',100,9999999);

/*
	Vul de AgeGroups Tabel
*/
INSERT INTO activitiesapp.agegroups(AgeGroupCode,AgeGroupName,AgeGroupDescription,AgeGroupStart,AgeGroupEnd)
VALUES ('0-9','0-9','Tot 9 jaar',0,9);
INSERT INTO activitiesapp.agegroups(AgeGroupCode,AgeGroupName,AgeGroupDescription,AgeGroupStart,AgeGroupEnd)
VALUES ('6-12','6-12','Vanaf 6 tot 12 jaar',6,12);
INSERT INTO activitiesapp.agegroups(AgeGroupCode,AgeGroupName,AgeGroupDescription,AgeGroupStart,AgeGroupEnd)
VALUES ('12+','12+','Vanaf 12 jaar en ouder',12,200);

/*
	Vul Activiteiten
*/

INSERT INTO activitiesapp.activities
(
	CategoryID,
	PriceGroupID,
	ActivityCode,
	ActivityName,
	ActivityDescription,
	ActivityDescriptionShort,
	ExternalURL,
	ActivityCost,
	ActivityAgeMinimum,
	ActivityAgeMaximum
)
SELECT categories.CategoryID
      ,pricegroups.PriceGroupID
      ,SOURCE.ActivityCode
      ,SOURCE.ActivityName
      ,SOURCE.ActivityDescription
      ,SOURCE.ActivityDescriptionShort
      ,SOURCE.ExternalURL
      ,SOURCE.ActivityCost
      ,SOURCE.ActivityAgeMinimum
      ,SOURCE.ActivityAgeMaximum
FROM
(
	SELECT 'MtbBelgaGroningen' AS ActivityCode
          ,'MTB Belga' AS ActivityName
          ,'De mountainbike is voorzien van modern schakelmateriaal van Shimano of Sram. Pedalen met of zonder clicksysteem is mogelijk. De meest voorkomende clicksystemen van Shimano zijn beschikbaar. Heb je andere, neem ze dan even mee. De mountainbike is voorzien van tenminste één bidonhouder. Een bidon dien jezelf mee te nemen, maarkun je bij afhalen ook aanschaffen. ' AS ActivityDescription
          ,'Huur een MTB bij Belga in Groningen' AS ActivityDescriptionShort
          ,'https://www.belgafietsen.nl/fietsverhuur/' AS ExternalURL
          ,19.95 AS ActivityCost
          ,10 	AS ActivityAgeMinimum
          ,99 	AS ActivityAgeMaximum
          ,'Fietsen' AS CategoryCode
	UNION ALL
    SELECT 'PQZ_Amnesty' AS ActivityCode
          ,'Pubquiz Amnesty' AS ActivityName
          ,'Daag je vrienden, collega’s, medestudenten, buren en andere relaties uit voor de pittigste pubquiz van Nederland. Organiseer ’m zelf, in de kroeg, op kantoor, in de sportkantine of thuis en laat zien wie werkelijk recht van spreken heeft. Download de GRATIS Pubquiztoolkit met quiz, poster, scoreformulieren, banners en handleiding.' AS ActivityDescription
          ,'Een gratis pubquiz aangeboden door Amnesty' AS ActivityDescriptionShort
          ,'https://www.amnesty.nl/kom-in-actie/vrijwilliger/download-de-gratis-pubquiz?gclid=EAIaIQobChMIvpTvhcm66QIVmrd3Ch0rLggDEAAYASAAEgIRBfD_BwE' AS ExternalURL
          ,0.0 AS ActivityCost
          ,7 	AS ActivityAgeMinimum
          ,99 	AS ActivityAgeMaximum
          ,'Quizzen' AS CategoryCode
	/*
		Gebruik onderste select om activiteiten toe te voegen, net als de twee hierboven.
    */
    /*
    UNION ALL
    SELECT '' AS ActivityCode
          ,'' AS ActivityName
          ,'' AS ActivityDescription
          ,'' AS ActivityDescriptionShort
          ,'' AS ExternalURL
          ,0.0 AS ActivityCost
          ,0 	AS ActivityAgeMinimum
          ,99 	AS ActivityAgeMaximum
          ,'' AS CategoryCode
    */
) AS SOURCE
LEFT OUTER JOIN categories
	ON SOURCE.CategoryCode = categories.CategoryCode
LEFT OUTER JOIN pricegroups
	ON SOURCE.ActivityCost >= pricegroups.PriceGroupStart
    AND SOURCE.ActivityCost < pricegroups.PriceGroupEnd
;

/*
	Vul Bridge
*/

INSERT INTO bridge_activitiesagegroups(ActivityID,AgeGroupID)
SELECT ActivityID
      ,AgeGroupID
FROM activities
LEFT OUTER JOIN agegroups
	ON /* De start van de activtieti valt in de groep b.v. activiteit 6-9 groep 3-7 */
    (	
		activities.ActivityAgeMinimum >= agegroups.AgeGroupStart
		AND activities.ActivityAgeMinimum <= agegroups.AgeGroupEnd
	)
    OR /* Het einde van de activiteit valt in de groep b.v. activiteit 3-9 groep 7-12 */
    (
		activities.ActivityAgeMaximum >= agegroups.AgeGroupStart
        AND activities.ActivityAgeMaximum <= agegroups.AgeGroupEnd
    )
    or /* De groep valt binnen een activiteit b.v. activiteit 6-12 groep 7-11 */
    (
		activities.ActivityAgeMinimum <= agegroups.AgeGroupStart
        AND activities.ActivityAgeMaximum >= agegroups.AgeGroupEnd
    )
;

/*
	Test of de tabellen gevuld zijn
*/

SELECT categories.CategoryName
      ,pricegroups.PriceGroupName
	  ,activities.* 
FROM activities
LEFT JOIN pricegroups
	ON activities.PriceGroupID = pricegroups.PriceGroupID
LEFT JOIN categories
	ON activities.CategoryID = categories.CategoryID
;
SELECT agegroups.AgeGroupName
      ,activities.*
FROM activities
LEFT JOIN bridge_activitiesagegroups
	ON activities.ActivityID = bridge_activitiesagegroups.ActivityID
LEFT JOIN agegroups
	ON bridge_activitiesagegroups.AgeGroupID = agegroups.AgeGroupID
