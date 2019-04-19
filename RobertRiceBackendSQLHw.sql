--1
select FirstName+' '+LastName as FullName, CustomerId, Country from Chinook.dbo.Customer where country <> 'USA'

--2
select FirstName+' '+LastName as FullName, CustomerId, Country from Chinook.dbo.Customer where country = 'Brazil'

--3
select FirstName+' '+LastName as FullName, i.InvoiceId, i.InvoiceDate from Chinook.dbo.Customer c join Chinook.dbo.Invoice i on c.CustomerId=i.CustomerId where country = 'Brazil'

--4
select e.FirstName+' '+e.LastName as FullName, e.EmployeeId from Chinook.dbo.Employee e where e.Title = 'Sales Support Agent'

--5
select distinct BillingCountry from Chinook.dbo.Invoice

--6
select e.FirstName+' '+e.LastName as FullName, i.InvoiceId from Chinook.dbo.Employee e join Chinook.dbo.Customer c on e.EmployeeId=c.SupportRepId
																						join Chinook.dbo.Invoice i on c.CustomerId=i.CustomerId

--7
select i.Total, c.FirstName+' '+c.LastName as FullName, c.Country, e.FirstName+' '+e.LastName as SalesAgentName 
from Chinook.dbo.Employee e join Chinook.dbo.Customer c on e.EmployeeId=c.SupportRepId
join Chinook.dbo.Invoice i on c.CustomerId=i.CustomerId

--8
select count(invoiceid) as numberOfInvoices from Chinook.dbo.Invoice i where DATEPART(year,InvoiceDate)='2009' or DATEPART(year,InvoiceDate)='2011'

--9
select sum(i.Total) as salesAmounts, DATEPART(year,InvoiceDate) as Year from Chinook.dbo.Invoice i group by DATEPART(year,InvoiceDate)

--10
select count(invoiceid) as numberOfLinesFor37 from Chinook.dbo.InvoiceLine where InvoiceId = 37

--11
select invoiceid, count(invoiceid) as numberOfLines from Chinook.dbo.InvoiceLine group by InvoiceId

--12
select iv.InvoiceLineId, t.name from Chinook.dbo.Track t join Chinook.dbo.InvoiceLine iv on t.TrackId=iv.TrackId

--13
select iv.InvoiceLineId, t.name, t.composer from Chinook.dbo.Track t join Chinook.dbo.InvoiceLine iv on t.TrackId=iv.TrackId

--14
select count(invoiceid) as numberOfInvoices, BillingCountry from Chinook.dbo.Invoice group by BillingCountry

--15
select count(trackid) as numberOfTracks, p.PlaylistId, p.Name from Chinook.dbo.Playlist p join Chinook.dbo.PlaylistTrack pt on p.PlaylistId=pt.PlaylistId group by p.PlaylistId, p.Name

--16
select t.Name, m.Name, a.Title, g.Name from Chinook.dbo.Track t join Chinook.dbo.MediaType m on t.MediaTypeId=m.MediaTypeId
								  join Chinook.dbo.Album a on t.AlbumId=a.AlbumId
								  join Chinook.dbo.Genre g on t.GenreId=g.GenreId

--17
select InvoiceId, count(InvoiceLineId) as numberOfInvoiceLines from Chinook.dbo.InvoiceLine i group by InvoiceId	

--18
select e.FirstName+' '+e.LastName as FullName, sum(total) as totalSales 
from Chinook.dbo.Invoice i join Chinook.dbo.Customer c on c.CustomerId=i.CustomerId 
						   join Chinook.dbo.Employee e on c.SupportRepId=e.EmployeeId
		group by e.FirstName+' '+e.LastName

--19
select e.FirstName+' '+e.LastName as FullName 
						   from Chinook.dbo.Invoice i join Chinook.dbo.Customer c on c.CustomerId=i.CustomerId 
						   join Chinook.dbo.Employee e on c.SupportRepId=e.EmployeeId where DATEPART(year,InvoiceDate)='2009' group by e.FirstName+' '+e.LastName having sum(i.Total) =
(select max(totalSales) as HighestSeller from (
select e.FirstName+' '+e.LastName as FullName, sum(total) as totalSales, e.EmployeeId 
from Chinook.dbo.Invoice i join Chinook.dbo.Customer c on c.CustomerId=i.CustomerId 
						   join Chinook.dbo.Employee e on c.SupportRepId=e.EmployeeId
						  where DATEPART(year,InvoiceDate)='2009'
		group by e.FirstName+' '+e.LastName, e.EmployeeId) as f) 

--20
select e.FirstName+' '+e.LastName as FullName 
						   from Chinook.dbo.Invoice i join Chinook.dbo.Customer c on c.CustomerId=i.CustomerId 
						   join Chinook.dbo.Employee e on c.SupportRepId=e.EmployeeId group by e.FirstName+' '+e.LastName having sum(i.Total) =
(select max(totalSales) as HighestSeller from (
select e.FirstName+' '+e.LastName as FullName, sum(total) as totalSales, e.EmployeeId 
from Chinook.dbo.Invoice i join Chinook.dbo.Customer c on c.CustomerId=i.CustomerId 
						   join Chinook.dbo.Employee e on c.SupportRepId=e.EmployeeId
		group by e.FirstName+' '+e.LastName, e.EmployeeId) as f) 

--21
select count(customerid) as numberOfCustomers, c.SupportRepId from Chinook.dbo.Customer c group by c.SupportRepId

--22
select sum(total) as totalSales, billingcountry from Chinook.dbo.Invoice group by BillingCountry

--23
select c.Country 
						   from Chinook.dbo.Invoice i join Chinook.dbo.Customer c on c.CustomerId=i.CustomerId 
						   join Chinook.dbo.Employee e on c.SupportRepId=e.EmployeeId group by c.Country having sum(i.Total) =
(select max(totalSales) as HighestSeller from (
select c.Country, sum(total) as totalSales 
from Chinook.dbo.Invoice i join Chinook.dbo.Customer c on c.CustomerId=i.CustomerId 
						   join Chinook.dbo.Employee e on c.SupportRepId=e.EmployeeId
		group by c.Country) as f) 

--24
select top 1 count(il.TrackId) as numberOfTracks, t.Name 
from Chinook.dbo.InvoiceLine il join Chinook.dbo.Invoice i on i.InvoiceId=il.InvoiceId 
	join Chinook.dbo.Track t on t.TrackId=il.TrackId
where datepart(year,i.InvoiceDate)='2013' group by t.Name order by numberOfTracks desc

--25
select top 5 count(il.TrackId) as numberOfTracks, t.Name 
from Chinook.dbo.InvoiceLine il join Chinook.dbo.Invoice i on i.InvoiceId=il.InvoiceId 
	join Chinook.dbo.Track t on t.TrackId=il.TrackId
group by t.Name order by numberOfTracks desc

--26
select top 3 ar.Name, sum(total) as totalSales from Chinook.dbo.Invoice i 
join Chinook.dbo.InvoiceLine il on i.InvoiceId=il.InvoiceId 
join Chinook.dbo.Track t on il.TrackId=t.TrackId 
join Chinook.dbo.Album a on t.AlbumId=a.AlbumId 
join Chinook.dbo.Artist ar on a.ArtistId=ar.ArtistId
group by ar.Name
order by totalSales desc

--27
select top 1 m.Name, sum(total) as totalSales from Chinook.dbo.Invoice i 
join Chinook.dbo.InvoiceLine il on i.InvoiceId=il.InvoiceId 
join Chinook.dbo.Track t on il.TrackId=t.TrackId 
join Chinook.dbo.Album a on t.AlbumId=a.AlbumId 
join Chinook.dbo.Artist ar on a.ArtistId=ar.ArtistId
join Chinook.dbo.MediaType m on t.MediaTypeId=m.MediaTypeId
group by m.Name
order by totalSales desc