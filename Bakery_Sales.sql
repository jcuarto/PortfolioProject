 
 
 --Select all data from Bakery Price--

 SELECT * FROM [Portfolio_Project].[dbo].[Bakery Price]

 --update bakery price item which does not match the name in sales data --

 UPDATE [Portfolio_Project].[dbo].[Bakery Price] set 
	Name = 
		CASE WHEN Name = 'valina latte' THEN 'vanila latte'	
		 WHEN Name = 'ice milk tea' THEN 'milk tea'
		 WHEN Name = 'ice coffe latter' THEN 'caffe latte'
		ELSE Name END


-- insert price for americano --
INSERT INTO [Portfolio_Project].[dbo].[Bakery Price](Name,Price) VALUES('americano','6000')

  --Select all sales transaction--

 SELECT * FROM [Portfolio_Project].[dbo].[Bakery Sales] 


  --remove null datetime and total sales fromdata--

 SELECT * FROM [Portfolio_Project].[dbo].[Bakery Sales] WHERE [datetime] is not null AND total is not null

 --get all the columns that will be using in bakery sales--

 SELECT [datetime],
		[angbutter],
		[plain bread],
		[jam],
		[americano],
		[croissant],
		[caffe latte],
		[tiramisu croissant],
		[cacao deep],
		[pain au chocolat],
		[almond croissant],
		[croque monsieur],
		[mad garlic], 
		[milk tea],
		[gateau chocolat],
		[pandoro],
		[cheese cake], 
		[lemon ade], 
		[orange pound], 
		[wiener], 
		[vanila latte],
		[berry ade],
		[tiramisu],
		[merinque cookies]
		FROM [Portfolio_Project].[dbo].[Bakery Sales] WHERE [datetime] is not null AND total is not null


		-- add column for monthname,date,time,day of the week--

		SELECT [datetime],
		DATENAME(MONTH,datetime) Month_Name,
		CONVERT(date,datetime) Transaction_date,
		CAST(DATEPART(HOUR,datetime) as varchar) + ':00' Transaction_time ,
		DATENAME(WEEKDAY,datetime) day_name,
		[angbutter],
		[plain bread],
		[jam],
		[americano],
		[croissant],
		[caffe latte],
		[tiramisu croissant],
		[cacao deep],
		[pain au chocolat],
		[almond croissant],
		[croque monsieur],
		[mad garlic], 
		[milk tea],
		[gateau chocolat],
		[pandoro],
		[cheese cake], 
		[lemon ade], 
		[orange pound], 
		[wiener], 
		[vanila latte],
		[berry ade],
		[tiramisu],
		[merinque cookies]
		FROM [Portfolio_Project].[dbo].[Bakery Sales] WHERE [datetime] is not null AND total is not null



		--unpivot data: transpose column into rows--

		SELECT [datetime],
		DATENAME(MONTH,datetime) Month_Name,
		CONVERT(date,datetime) Transaction_date,
		CAST(DATEPART(HOUR,datetime) as varchar) + ':00' Transaction_time ,
		DATENAME(WEEKDAY,datetime) day_name,item,Quantity FROM (SELECT datetime,[angbutter],
		[plain bread],
		CAST([jam] as float) jam,
		[americano],
		CAST([croissant] as float) croissant,
		CAST([caffe latte] as float) [caffe latte],
		[tiramisu croissant],
		[cacao deep],
		CAST([pain au chocolat] as float) [pain au chocolat],
		CAST([almond croissant] as float)[almond croissant],
		CAST([croque monsieur] as float)[croque monsieur],
		CAST([mad garlic] as float)[mad garlic], 
		[milk tea],
		CAST([gateau chocolat] as float)[gateau chocolat],
		CAST([pandoro] as float)[pandoro],
		CAST([cheese cake] as float)[cheese cake], 
		CAST([lemon ade] as float)[lemon ade], 
		[orange pound], 
		CAST([wiener] as float)[wiener], 
		[vanila latte],
		CAST([berry ade] as float)[berry ade],
		CAST([tiramisu] as float)[tiramisu],
		CAST([merinque cookies] as float) [merinque cookies] FROM [Portfolio_Project].[dbo].[Bakery Sales]) p
		UNPIVOT (Quantity For Item IN([angbutter],
		[plain bread],
		[jam],
		[americano],
		[croissant],
		[caffe latte],
		[tiramisu croissant],
		[cacao deep],
		[pain au chocolat],
		[almond croissant],
		[croque monsieur],
		[mad garlic], 
		[milk tea],
		[gateau chocolat],
		[pandoro],
		[cheese cake], 
		[lemon ade], 
		[orange pound], 
		[wiener], 
		[vanila latte],
		[berry ade],
		[tiramisu],
		[merinque cookies])) AS unpvt


		--CREATING CTE and view

CREATE VIEW BakerySalesView AS	
	WITH transformed_data(datetime,Month_Name,Transaction_date,Transaction_time,day_name,item,Quantity) AS
		(
		SELECT [datetime],
		DATENAME(MONTH,datetime) Month_Name,
		CONVERT(date,datetime) Transaction_date,
		CAST(DATEPART(HOUR,datetime) as varchar) + ':00' Transaction_time ,
		DATENAME(WEEKDAY,datetime) day_name,item,Quantity FROM (SELECT datetime,[angbutter],
		[plain bread],
		CAST([jam] as float) jam,
		[americano],
		CAST([croissant] as float) croissant,
		CAST([caffe latte] as float) [caffe latte],
		[tiramisu croissant],
		[cacao deep],
		CAST([pain au chocolat] as float) [pain au chocolat],
		CAST([almond croissant] as float)[almond croissant],
		CAST([croque monsieur] as float)[croque monsieur],
		CAST([mad garlic] as float)[mad garlic], 
		[milk tea],
		CAST([gateau chocolat] as float)[gateau chocolat],
		CAST([pandoro] as float)[pandoro],
		CAST([cheese cake] as float)[cheese cake], 
		CAST([lemon ade] as float)[lemon ade], 
		[orange pound], 
		CAST([wiener] as float)[wiener], 
		[vanila latte],
		CAST([berry ade] as float)[berry ade],
		CAST([tiramisu] as float)[tiramisu],
		CAST([merinque cookies] as float) [merinque cookies] FROM [Portfolio_Project].[dbo].[Bakery Sales]) p
		UNPIVOT (Quantity For Item IN([angbutter],
		[plain bread],
		[jam],
		[americano],
		[croissant],
		[caffe latte],
		[tiramisu croissant],
		[cacao deep],
		[pain au chocolat],
		[almond croissant],
		[croque monsieur],
		[mad garlic], 
		[milk tea],
		[gateau chocolat],
		[pandoro],
		[cheese cake], 
		[lemon ade], 
		[orange pound], 
		[wiener], 
		[vanila latte],
		[berry ade],
		[tiramisu],
		[merinque cookies])) AS unpvt
		)

		--get the price of items on price table--
	SELECT sales.datetime,sales.Month_Name,sales.Transaction_date,sales.Transaction_time,sales.day_name,sales.item,sales.Quantity,price.price,(sales.Quantity*price.price) AS total_price FROM transformed_data sales LEFT JOIN [Portfolio_Project].[dbo].[Bakery Price] price ON
		sales.item = price.name 

		

		--SELECT ALL DATA FROM VIEW
	SELECT * from BakerySalesView