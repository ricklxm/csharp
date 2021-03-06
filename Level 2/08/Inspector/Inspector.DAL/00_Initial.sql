/* DROP */

DROP INDEX [IX_Areas_Name] ON [dbo].[Areas]
GO
DROP INDEX [IX_Areas_SOATO] ON [dbo].[Areas]
GO
DROP TABLE [dbo].[Areas]
GO
ALTER TABLE [dbo].[FinIndexes] DROP CONSTRAINT [FK_FinIndexes_Organization]
GO
ALTER TABLE [dbo].[FinIndexes] DROP CONSTRAINT [DF_FinIndexes_Profit]
GO
ALTER TABLE [dbo].[FinIndexes] DROP CONSTRAINT [DF_FinIndexes_Revenue]
GO
ALTER TABLE [dbo].[FinIndexes] DROP CONSTRAINT [DF_FinIndexes_ProductVolume]
GO
DROP TABLE [dbo].[FinIndexes]
GO
DROP INDEX [IX_Organizations_OKPO_SOATO] ON [dbo].[Organizations]
GO
DROP TABLE [dbo].[Organizations]
GO
/* CREATE */

CREATE TABLE [dbo].[Areas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[SOATO] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Areas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Areas_Name] ON [dbo].[Areas]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IX_Areas_SOATO] ON [dbo].[Areas]
(
	[SOATO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE TABLE [dbo].[Organizations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OKPO] [varchar](8) NOT NULL,
	[SOATO] [varchar](10) NOT NULL,
	[INN] [varchar](10) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Type] [tinyint] NOT NULL,
 CONSTRAINT [PK_Organizations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Organizations_OKPO_SOATO] ON [dbo].[Organizations]
(
	[OKPO] ASC,
	[SOATO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE TABLE [dbo].[FinIndexes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrgId] [int] NOT NULL,
	[ProductVolume] [decimal](18, 4) NOT NULL,
	[Revenue] [decimal](18, 4) NOT NULL,
	[Profit] [decimal](18, 4) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
 CONSTRAINT [PK_FinIndexes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[FinIndexes] ADD  CONSTRAINT [DF_FinIndexes_ProductVolume]  DEFAULT ((0)) FOR [ProductVolume]
GO

ALTER TABLE [dbo].[FinIndexes] ADD  CONSTRAINT [DF_FinIndexes_Revenue]  DEFAULT ((0)) FOR [Revenue]
GO

ALTER TABLE [dbo].[FinIndexes] ADD  CONSTRAINT [DF_FinIndexes_Profit]  DEFAULT ((0)) FOR [Profit]
GO

ALTER TABLE [dbo].[FinIndexes]  WITH CHECK ADD  CONSTRAINT [FK_FinIndexes_Organization] FOREIGN KEY([OrgId])
REFERENCES [dbo].[Organizations] ([Id])
GO

ALTER TABLE [dbo].[FinIndexes] CHECK CONSTRAINT [FK_FinIndexes_Organization]
GO

