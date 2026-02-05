Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AE2405EC;
	Thu,  5 Feb 2026 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770275405; cv=fail; b=fRsEG/XqnXiSt6D53cNJ8U0UJPssePsB96fTzkSE8w2Yv5IbNZ/2R5a0pAW3I6Ty2vqevQ3JOAcbcv1BuXouE9otSE/IvWyLIFScolErCX6oQ1h3hjIJSp9M9sJhX2pIes3toJ3Zy/wrOn+X4/CVwKyZoxfFv6dUxrqaBfFY7R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770275405; c=relaxed/simple;
	bh=bIoL9+Tp9Y4WJK+5NhKRwFTHq6nMOpr9s5ADLr9HLC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sY2oDdhRqvnrTE7G3V7JCuND/4ANknFn2mRqJavmfoE+yaDPoqpZ7u8chWYV7CZmuGuDpCP51eB5SYynFZexEoblbmGMnk9P2m8h6MULwQzH+AtjbwAyxnN2fLjVBrBQU5C3Eac42H0AL0D6EYh3dESQbOhion9ScOxf5GiBnlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IuCh7AEq; arc=fail smtp.client-ip=40.107.200.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IuCh7AEq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9hZmwG9GeoijyTM7CqRy+vQM/QsJDsLAltIW3MrFiszPwe+ufNRqA4ULCg7RutDqNDMD+sOCv6Otmxunc0gnsQhzsqmg6OQikT5ZHgaXmOUm7nHleMXr4g44dYR606mEGCOlRDbqDjQSDHvIrYbAS6+WI/zM7RKCf1TgbIpg/GBTnh18U/Md73ySskDgs0cWfbmSvDdQeqAO7M1NXbI8g2Ielck3rpEYkcodnCaExhZI4VUXazMZpyksJEz/Ca6ofuYDhbd4+ujFSe4r/FxivfDvuzJccjeGpFcV16pDk7IhTN/4AfxnSdYr2d8aapp8mYk7hySyU/MxSnfhvvPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyKBSMHecH3wquwjG3C5+QFH75t9xuNF6FqQC3UKPMQ=;
 b=FmH8qioW5CJtlap0rjGHp33dem07IbaE7pgd5sB70gL+4qWq+avHsUpzz9nq9gsQSpMwiPKaiujD7w2uWD8TbiolhMqehj3FFvgCqrKdAw3jaOOFXgeIu6+otumzVHgy42jqVNw9celQTuW5vpxkTPrCQICfYPS769nQ7Ua9PeLY2R7/Dq3ttGRy4DpkLIj13OjvISMvrTSZ5+P7GAgGcoe5TgTFKqmdpOO+JtOOFgGfLYDS8rXZjC3yJ3QZHoyQ9gCVnNQKObutGj6xbgH5pflpel7u500YYqbqoyIJj3016SpP9cNXNBf5yR3VMjfKry7E5570AyP/rGnM/dKXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyKBSMHecH3wquwjG3C5+QFH75t9xuNF6FqQC3UKPMQ=;
 b=IuCh7AEqqV3V/BEQGQ4nLwiZ5Rz7/+gco3I72HOtGY4ARvo4XYZ0nzfQ1VrdJLydd1uT/VIYQ6GybfP44NfFF6ozl293NWGbAmBXRw3IsTQ2TlKlDXz5U19njKQqXFa/FKaRrkVrR6KAdwQGB+Ql8wE2H803ZtqZSgP2jBCPDTQ=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by BN0PR10MB4981.namprd10.prod.outlook.com (2603:10b6:408:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Thu, 5 Feb
 2026 07:10:02 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::8a) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 07:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 5 Feb 2026 07:10:01 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:10:01 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:10:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 01:10:00 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61579xpj2564394;
	Thu, 5 Feb 2026 01:10:00 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Vignesh Raghavendra" <vigneshr@ti.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>, Nishanth Menon <nm@ti.com>, Chintan
 Vankar <c-vankar@ti.com>, Michael Walle <mwalle@kernel.org>, Simon Horman
	<horms@kernel.org>, Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH net 0/2] Modify multicast entry handling in ALE table
Date: Thu, 5 Feb 2026 12:39:49 +0530
Message-ID: <20260205070951.3170631-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|BN0PR10MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d55fe9-39f6-470c-bc37-08de64859474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWDF3Lg5Tn8GhyEWEeeaeJPUWOYfuNbP5naUZozoX0pmuonj2Tn3Lzi43OZH?=
 =?us-ascii?Q?5m9ORBPhImx1bMOApab4a2wZFtLeUrpFxZ9EinT0ZYWE/jGMGtey5FYG65l2?=
 =?us-ascii?Q?0RKTiDXAefAd24jW91HKNtxxAorEdyOcmIE//iB7LR5ms/tAEVksiIA4+lYM?=
 =?us-ascii?Q?tvse86+eU15v/k1bnWtpK7T4ebw/NfwJT0Z0g9NDm24vpm1g2zS8Ubjkihoj?=
 =?us-ascii?Q?+FUgud2fW5a9IzSF7h/wrh2N1hjDhtlfG0tBv557DBNEApJw5MQEOyTXQoHV?=
 =?us-ascii?Q?gwHvAKlTr79xjvbMosjN8C6MjH0vJIobxezoVIsizcA6M+3Xe6lTHJoFqX7D?=
 =?us-ascii?Q?opVFMS4AW0jAH39YEgWP1ITU/vnfGgnE77A1/FTEZ8ynyX26iGNgSijOkB3E?=
 =?us-ascii?Q?7qYfgKVOrwVUZ47UUTD0d+pCjaRNB+8OzoitTB+Z2xAeVao9PZCLK7SZMvVe?=
 =?us-ascii?Q?WGXRDb/uwn6LkNKMXps8K1OI5lEcP9nK+l/Nm/aYaIFpwbBrhN7QcQUHlHqv?=
 =?us-ascii?Q?fppgZ/++GOKLPAYf3SMkPgh8vgBMOHqL7Jmg4o12XbpRNCr7SMzUBOuHWUWh?=
 =?us-ascii?Q?wnmk+vLPq6Fad3MNTUrl9QF4kJhphSXS4zOOzVErmi9jhi8zYPStzJkn1Nc6?=
 =?us-ascii?Q?DxgZT/920xD7WAF55FuUJLmia5CD1QbmP24grvW4JU51X80kzoW05m2u2nTi?=
 =?us-ascii?Q?63UVdFIzH9pvluDPsllTUUsE+qg16GxB1Xsveq/LHz/qiEbm+1fU0+SFWAbE?=
 =?us-ascii?Q?bep3h9+cpNKzYi6Fg+f1V4pd5VdrnEpLFykGpsGMIOyjWgJLmjBZnjkX0krw?=
 =?us-ascii?Q?OJNlB2UIPoDyDFI/vfEzhD0dFpoOo7BN8P71Rcq6gNq5HqdKc+JuIvYsjvWg?=
 =?us-ascii?Q?p0WD+5oPGDRqcFBUrxohBv8ej+lJhXShpKfteuxP6rTtrb6NqiW5wNVZPqxb?=
 =?us-ascii?Q?ZMP71nKNcZh1bRcYZ5JoMjQ4hSOHkt/BwvKzU/HYIp5a+C4iM+JH51hVT87Y?=
 =?us-ascii?Q?tbWkjUb62C9fUq9kVMEDaMJbkiADg8XANgfpxaqMpPcqJ9QLbT6acdheIMH+?=
 =?us-ascii?Q?JGmEa7NOvUfHCrqFpRFby8QZcrKWRfieMcZCMjWP8PzRcDN9xCUdnVZUd9ty?=
 =?us-ascii?Q?1W6QR3VzECk/UxWfGDai1Z378HFO13DYwMpM8E6TMRmYhoF0jmUniEvAAyy4?=
 =?us-ascii?Q?pwrtBDEL1OcHMTc7BlwB10NZl7yyLY6k3zDzgaTBWk/rhWnz9iECtC8vSUMY?=
 =?us-ascii?Q?zwlISNJGbGNxzPmQZdLUZat8IuuQ0tQjbL6Shrdg+rB5q70UjVfChgg9pVKl?=
 =?us-ascii?Q?/9VjNZ8OAve9VZEkUpKvqHhc0xaxR4UK1zueJUbGodtJC0YNgtg4b3/0WCnq?=
 =?us-ascii?Q?JxJHazYog5iWzzpcRAeHZQ9k3SGYg3uCp445Bq7u7DFUlg+UIdM0ToJjgtOz?=
 =?us-ascii?Q?WSc9pUi1mKONswto1Sj4hVhA3iUfy0zexjCICABvDuxlsPIbFcy4Er7wFgeE?=
 =?us-ascii?Q?eKnP0opgGjJ02hIUk9CNU6Y++Wq46/Mr3LwSZ9r57m4AU43IACn15zTTgEWB?=
 =?us-ascii?Q?Wj08wF5Y6Teb++2ZMNlpyZtya+fvmikBixnOdJnol+RxCpe9LW/cq6BOTcyZ?=
 =?us-ascii?Q?y4qlMBy3txA2cH/wgDaeViPugaAko0GCVyoCIIT6tN3zycNCtP3s3RfAxPAv?=
 =?us-ascii?Q?KaCVew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CSaXid9+a7m5ebRTRFiZ/8WYXJmsnRTORbhf/7U521rVtbyYsPqgguF90cz0thaPGb+SgEQIFMdD4Y/hjrYa/z4cbV+4CHzFnd2vqYD/EXiHOrzTN/rtnnRcO4H0bHc4xbntT6O3QgNQ7VMtsKI+8M4VZR5Lv2qWJnSfaujOMI3xEGVwxl5EfvaMIMa5GCz/5runrRBQvnWKfBSo0UgPbi9sxyjyrEhzox5yCc2nLgBLDRPdbIpAG9F7mp+GnLpVt+ChKE369MCeJNzAC20FMIfzcPq4R/T2O4+I1vokd+hdiEylys+D3XVPhDm2aUn5x7jaRQsio4vlmJ8d79wPf1xtUy32CAOpffpYFH9Wx49o2C0BPM0qhcv0k3xMdXxENNB5dpXG3uzNaa5UFek5ruKlrW2K8tfUwBZSm0QnPeLB8P2MBpnXV45IdI01DNRu
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:10:01.5940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d55fe9-39f6-470c-bc37-08de64859474
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981

This series updates how multicast entries are being added/deleted in the
ALE table by setting/resetting CPSW MAC port's bit to the port_mask.

This series is based on commit '7d6ba706ae5e' of 'origin/main' branch of
Linux-net repo.

Chintan Vankar (2):
  net: ethernet: ti: am65-cpsw-nuss: Update port_mask while adding
    multicast entry
  net: ethernet: ti: cpsw_ale: Update multicast entry handling in ALE
    Table

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 drivers/net/ethernet/ti/cpsw_ale.c       | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.34.1

