USE [master]
GO
/****** Object:  Database [Databind]    Script Date: 5/26/2022 8:08:56 AM ******/
CREATE DATABASE [Databind]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Databind', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Databind.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Databind_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Databind_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Databind] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Databind].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Databind] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Databind] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Databind] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Databind] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Databind] SET ARITHABORT OFF 
GO
ALTER DATABASE [Databind] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Databind] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Databind] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Databind] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Databind] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Databind] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Databind] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Databind] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Databind] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Databind] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Databind] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Databind] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Databind] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Databind] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Databind] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Databind] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Databind] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Databind] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Databind] SET  MULTI_USER 
GO
ALTER DATABASE [Databind] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Databind] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Databind] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Databind] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Databind]
GO
/****** Object:  Table [dbo].[M_Event]    Script Date: 5/26/2022 8:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_Event](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Name] [nvarchar](100) NULL,
	[Date] [datetime] NULL,
	[Discription] [nvarchar](max) NULL,
	[images] [nvarchar](100) NULL,
	[createdBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdateBy] [int] NULL,
	[UpdateOn] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[Eid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Event]    Script Date: 5/26/2022 8:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Event](
	[Eid] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[createBy] [int] NULL,
	[CreateOn] [datetime] NULL,
	[UpdateBy] [int] NULL,
	[UpdateOn] [datetime] NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[M_Event] ON 

INSERT [dbo].[M_Event] ([EventId], [Title], [Name], [Date], [Discription], [images], [createdBy], [CreatedOn], [UpdateBy], [UpdateOn], [IsDeleted], [Eid]) VALUES (1, N'fregthyju', N'fweff646', CAST(N'2020-01-01T00:00:00.000' AS DateTime), N'fwfwcsc', N'', NULL, CAST(N'2022-05-26T07:33:51.417' AS DateTime), NULL, CAST(N'2022-05-26T07:34:15.397' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[M_Event] OFF
GO
SET IDENTITY_INSERT [dbo].[T_Event] ON 

INSERT [dbo].[T_Event] ([Eid], [Title], [createBy], [CreateOn], [UpdateBy], [UpdateOn], [IsDeleted]) VALUES (1, N'fregthyju', NULL, CAST(N'2022-05-26T07:03:33.600' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[T_Event] OFF
GO
/****** Object:  StoredProcedure [dbo].[Sp_BindMaster]    Script Date: 5/26/2022 8:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_BindMaster]
  @Procid int 
  as 
  begin
   if(@Procid=1)
   begin
   select 0 MasterId ,'-- Select Event --' MasterName
   union all
   select cast (Eid as int ) MasterId ,UPPER(Title)MasterName
   from T_Event
   where ISNULL(IsDeleted,0)=0
   order By MasterName asc
   end 
  end 
GO
/****** Object:  StoredProcedure [dbo].[Sp_Event]    Script Date: 5/26/2022 8:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Event]         
(            
@id int,  
@Title nvarchar(100),  
@procid int          
)            
as begin            
   if(@ProcId=1)            
     begin            
     if not exists(select 1 from T_Event where Title=@Title and isnull(IsDeleted,0)=0)            
     Begin             
     insert into T_Event(Title,CreateOn)            
     values(@Title,getdate())            
     select 'success'msg, EId,Title            
      from T_Event             
      where isnull(IsDeleted,0)=0            
     end            
     else            
     begin           
   select 'exists'msg, EId,Title           
      from T_Event           
               
      where isnull(IsDeleted,0)=0            
     end            
     end            
IF(@procid=2)            
 BEGIN            
  UPDATE T_Event            
  SET            
   Title = @Title,            
   UpdateOn = getdate()            
  WHERE EId=@Id             
  select 'update'msg, EId,Title      
      from T_Event           
    where isnull(IsDeleted,0)=0            
 END            
  IF(@procid=3)            
 BEGIN            
 select EId,Title         
  from T_Event            
   where isnull(IsDeleted,0)=0 and EId=@Id           
 END            
  IF(@procid=4)            
 BEGIN            
 select EId,Title     
  from T_Event            
   where isnull(IsDeleted,0)=0             
 END            
 IF(@procid=5)            
 BEGIN            
  update T_Event set IsDeleted=1 where EId=@Id             
 END            
end 
GO
/****** Object:  StoredProcedure [dbo].[Sp_M_Event]    Script Date: 5/26/2022 8:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_M_Event]    
(    
@id int ,    
@Eid int,    
@Title nvarchar(80),    
@Name nvarchar(50),    
@Date nvarchar(12),    
@Discription nvarchar(500),    
@Images nvarchar(100),    
@ProcId int=0    
)    
    
as     
begin    
if(@ProcId=1)    
begin          
       
insert into M_Event (Eid,Title,Name,Date,Discription,Images,CreatedOn) 
values(@Eid,@Title,@Name,convert(datetime,@Date,103),@Discription,@Images,GETDATE())    
    
select'success'msg,b.EventId,a.Eid,a.Title,b.Name ,Convert(nvarchar,b.Date,103)Date,b.Discription,    
REPLACE(b.Images,'~/','../')Images    
from M_Event b     
inner join    
T_Event a on b.Eid=b.Eid     
where ISNULL(a.IsDeleted,0)=0 and ISNULL (b.IsDeleted,0)=0    
end    
    
if(@ProcId=2)    
begin    
update  M_Event    
set    
Title=@Title,    
Eid=@Eid,  
Name =@Name,    
Date=Convert(datetime,@Date,103),    
Images=@Images,    
Discription =@Discription,    
UpdateOn=GETDATE()    
where EventId=@id    
select'update'msg,b.EventId,a.Eid,a.Title,b.Name ,Convert(nvarchar,b.Date,103)Date,b.Discription,    
REPLACE(Images,'~/','../')Images    
from M_Event b     
inner join    
T_Event a on b.Eid=a.Eid     
where ISNULL(a.IsDeleted,0)=0 and ISNULL (b.IsDeleted,0)=0    
end     
if(@ProcId=3)    
begin    
select b.EventId,a.Eid,a.Title,b.Name ,Convert(nvarchar,b.Date,103)Date,b.Discription,    
REPLACE(Images,'~/','../')Images    
from M_Event b     
inner join    
T_Event a on b.Eid=a.Eid     
where ISNULL(a.IsDeleted,0)=0 and ISNULL (b.IsDeleted,0)=0 and b.EventId=@id 
end     
if(@ProcId=4)    
begin    
select b.EventId,a.Eid,a.Title,b.Name ,Convert(nvarchar,b.Date,103)Date,Convert(nvarchar(50),Discription)Discription,    
REPLACE(Images,'~/','../')Images    
from M_Event b     
inner join    
T_Event a on b.Eid=a.Eid     
where ISNULL(a.IsDeleted,0)=0 and ISNULL (b.IsDeleted,0)=0    
end    
if(@ProcId=5)    
begin    
update M_Event set IsDeleted=1 where EventId=@id    
end 
if(@ProcId=6)
begin
select top 3  b.EventId,a.Eid,a.Title,b.Name ,Convert(nvarchar,b.Date,103)Date,Convert(nvarchar(95),Discription)Discription,    
REPLACE(Images,'~/','../')Images    
from M_Event b     
inner join    
T_Event a on b.Eid=a.Eid     
where ISNULL(a.IsDeleted,0)=0 and ISNULL (b.IsDeleted,0)=0  order by Date desc
end 
if(@ProcId=7)
begin
select  b.EventId,a.Eid,a.Title,b.Name ,Convert(nvarchar,b.Date,103)Date,Convert(nvarchar(95),Discription)Discription,    
REPLACE(Images,'~/','../')Images    
from M_Event b     
inner join    
T_Event a on b.Eid=a.Eid     
where ISNULL(a.IsDeleted,0)=0 and ISNULL (b.IsDeleted,0)=0 and b.EventId=@id
end
if(@ProcId=8)
begin
select  b.EventId,a.Eid,a.Title,b.Name ,Convert(nvarchar,b.Date,103)Date,Convert(nvarchar(50),Discription)Discription,    
REPLACE(Images,'~/','../')Images    
from M_Event b     
inner join    
T_Event a on b.Eid=a.Eid     
where ISNULL(a.IsDeleted,0)=0 and ISNULL (b.IsDeleted,0)=0 and EventId<>@id order by Date desc
end
end
GO
USE [master]
GO
ALTER DATABASE [Databind] SET  READ_WRITE 
GO
