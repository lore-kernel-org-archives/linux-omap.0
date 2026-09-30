Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC10472520;
	Wed, 30 Sep 2026 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807755; cv=fail; b=VTsVwrsM+8/ua1Op3+69Loq+jgyl6juEgMJ+j0PeJnO14lhjb6tH4Y8cTsIgUXyu3iAIcMwL20aBmGouzT9P0Hk9WdTeVvzRgkt8wYBEGhEYBxTSLMqJMgqac7OTjnaeGVPk2sK8JqZQn4wihgFfyfp54uCUAN/UpWq7DsvG3po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807755; c=relaxed/simple;
	bh=LfKoim6zEhIwHVmgKcYVnqh3IK3Qwkt/r9hoYY2IBtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPg7WGmBS80QMNQ2CZFZDtwREzLVNOsWUyHmzMqhutWfvZ4owPt8VU6qMnPuUEOA6dLJmYtKvREf6JWWqM46xU9CTYDZ8f5R4RxPcuH+XO78ZPh3QuaNY/kPfQQyCyX6DlSudqfBSOUs5O++/lnSLILOU0suRJhY5ZIdY9A6zlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=RaJayLn3; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=r5Hc8+Ry; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="RaJayLn3";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="r5Hc8+Ry"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68UKkGfK4104489;
	Wed, 30 Sep 2026 17:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=3g7onLK7H7RNI8yRrd9eBT3uzhzen7xC6ne+yR55R
	VI=; b=RaJayLn3/mZZ6HpWLwrlZL+fDH9CUl8HmoTNXEXCaM2LYm1iO38UdnB68
	D0jNS/7G54szJ4hyCQGSrVJS/RfI+euW5LfwRYQS0gyS1D2bDkGBIHeFYxewtY2o
	1wN9xg3ABicxoBy0R8UAQ7W62rbaQXxBA2LfXA73RaOkTGrc+OxL9BzEV4GxOTV/
	itFLchIpKjdaFgPfMF0A2b9OVHuK3b0vOaJPypxt9S7miAO0PBRz1pZbKAW05G+A
	v3cstyavsQWXCIndaRAiE1vwGVCaBpsdevP1bChTNpf+/KkWmESSLtgtkVoIwusn
	sz8rdjJ/Ig6vf0AA4edhavAWO721w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	by m0380145.ppops.net (PPS) with ESMTPS id 4h10t1uvfq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkQv/okDl4kxBufFRKfjYL3Xe3COCdtS0Rzw+TxnE2IqeOuLIRmn0pNrksrfAvbnwlha4Z7DFxp8QoRfxdxNRhpsvmq38OHwoE2Owu9pAobPlIYH9nXnCVWLckJgXV+HOMCC27qjLAEFOV/hb/EEdAFYmcdGMarC71Yj1IC645XOFwj9xV334W3HD0MbUeIoYiJ8PzjFC69ul8H+DTMWOQLg+vl4xSVTiwiYZvF4kofXgbeECQuu9Vc3PWopNJAo7e5+VOUcG1v+/zp3Jq/dxFoiCN4h4oT+TfdVXisYNiKt9to9CLWvI9o8aEer1p8lZe1/2wyka/3zZLVxFj6moQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g7onLK7H7RNI8yRrd9eBT3uzhzen7xC6ne+yR55RVI=;
 b=AcGvjfD1Vy94j3PWkhttCvUTLddfz+u6K9y6h39L4mqyvfS6smne8kCVG4CRROXVWWtFuezhNOWoOKXTGnsvHw7sdzJObt9VVxVzMlEJSfhRP86QbiLwDORAEEnUM8Gg+60teWxsOq84nQ8SMX8loRpzArBvs92dcFzS7/w2CiT1DQKcbnXni0prtMRhKBnfLkoiezDuRJmP13OiGp30zDBfH9EUqOBG5zU+HsQWuRJiOVnhsrSAc/4FaugfbzAPGdRBjDb2brTWLMVuSUFbxvggqIkU31AR2RTi+DbrCCwgNyYc1ZBTd9S9Crr4QgOmvvp6UEHWBUEVJUab5MGzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g7onLK7H7RNI8yRrd9eBT3uzhzen7xC6ne+yR55RVI=;
 b=r5Hc8+RyU91Eys6fdHKRJs9E1S3UFBn9Cr8lIQr/7F8y63HDm18F+MZcaOmdxdEgPCSzj8TuM7jXk/5xZxAvnRr3qnsN+ehQCClFGwsO3WuESUYjr6OAKf2V/r8Cpy38tp8CUOSUdg6IQH99ZU4mBJxEQFWdzIfsC+Al7kBS0c4=
Received: from CH2PR18CA0045.namprd18.prod.outlook.com (2603:10b6:610:55::25)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 22:35:42 +0000
Received: from BN5PEPF0004698C.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::9a) by CH2PR18CA0045.outlook.office365.com
 (2603:10b6:610:55::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 22:35:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF0004698C.mail.protection.outlook.com (10.167.245.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:35:40 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:06 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:06 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3Tw3969567;
	Wed, 30 Sep 2026 17:35:06 -0500
From: Andrew Davis <afd@ti.com>
To: Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        "Andreas
 Kemnade" <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>,
        "Roger
 Quadros" <rogerq@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [uL RFC PATCH v3 6/8] i2c: omap: Make reset bit name match register name
Date: Wed, 30 Sep 2026 17:35:01 -0500
Message-ID: <20260930223503.616776-7-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260930223503.616776-1-afd@ti.com>
References: <20260930223503.616776-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698C:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: d3aab4dd-d2a9-46e5-05dd-08df1f432830
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RneUFCMeePb610qdeJsid2Qi8T+EfQL/5Wpm/o46WNOtB7yHUyrgNFIeIiFvdQw7AUwTpaRlOXKuFYuBzkAB/kU9nxQYmdBmuaXqUaYAj7B9NrGAHjSsN0uLGrQNNsn2MIvkv9BEmSDh+Zrk9WZZZKM2Qb2HllkURbBNQ+w+tCxlXfutQ9Kxg/TM0QTTSmcbeg23z1lBvUyp/PYb2Qx6vOvP95dxXZ/FtGiL+JF6z4OJw8WOOsVA2lRmi1laih44LOv3hWqJaTSNkOvhfUyLZaC99BWmdW6OcnYqVepjuiStx0vXWBOexNvNu54tRnlmBzBwvkedewdoFuCnL4+WIU4JsbwGPmR7rtynL/43tkboOWPMZb7PdrpFHHYROpZx6zt9GELIq7ajvqNeaPKN4mM6+ISkkWJ13HIS27iz3zLmiBnGeVZuAJOiV0YXSaHdB+hBef839VlTprqEA6s+1+gavgPbGq2qyoInxB1umPtPZLhaoVuGMRcCL9PAcQIvbP+YRtoaYndsUmSexebydE/T2cqTEhd+QQ8DxI6/YlJe+k5KhdVxQHQmKq1TaRHg1l/5TWa2YY0EI2qecyUh3cya+nklIaZFX8XGuBSK9mtPFUhr4C4A48J1QAf2VgucHVzquagkc7UhI6j9v8jfN5Jeep8wdke1q+twlexI0rRMWNHr6dili0dGcQOmLMGOqH8D6x6HAXKVX6sdxgkY+w==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xpn6FYUbcfC+RdwCP6tKjv6MEOo9FM2UCevx4WIcaaYxQI1tAYOfRFFlgOlwkxb2ToNapcPaOE5iK4E3qJKLfLVKQIkCqAXrPFi3OnvDBlnelGlSJZS9Dmpooz+/5xPg+tStjIgRrkY4MGoqG+SlsIX9lshFtNzzlwNlKmPEs1/8FktlHYWfTnGK/jYjgTY+he8jTsP9L0zJRiT2XfrEloKC3JUSSITe5w61P9YPD3RERcJO9c0CBrSBJ2Sj+x+GukLxSxueH6wk4uDj2LlUIsaydw4gsk09C6WzZPTk3xxhOY3JwDcI7a0RhPUS4G84n9NVbLvDyrxf9tye8Qgs+YuqYnfVnD5kM3HGdPBwu7Eg/CEEJQTabpZy0hs9upwNScxWuhV7XGIbhxa3qMWp3/l1Xm+YfstI4379nVLqMvgitTaGihzQeeYgoRUTfTyt
X-Exchange-RoutingPolicyChecked:
	v9qyknN0svbXkE2k0C5VQs0NFiGkJjohXiEzst0UsLCAgBDE91aEEas/7yX3nb086nvpggSm6crKsW62VWoHmK2pjaV7QKtwOPsfeH+qGbzLY89+37m9FeCxR3uGTVZ0G9JnCsw18WmsIwI8fHtk6reB2KyUrX3y3tn8XyHb7y4DP9q85X703GcqFiUrZW2CkB5HoWphtCwxrxdGfBokFXuAWkXwoWGFIqYp72+qmR6p6x95MUhILcjKN2UXiQMHKs5ah8wXFudkI4t72YVrMtOwwEzH2YREXD2FrLdSCzzo0sJfbQoz7th2OiEwwU/+MAxZhAXdJ9ktoa/R5PPDyQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:40.6271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aab4dd-d2a9-46e5-05dd-08df1f432830
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX8OhQsw6hPdrr
 CUqG6jTwPlBUesgb3UlhHCXm+d4E9WsiAxuWAAEjgZyUS3ZiiHrYXkGhJaIWNo42D3Ui/skAj9n
 M1YOivrG479EXQp0auDevuoo1mHqyd0=
X-Proofpoint-ORIG-GUID: rql-KI9LOv2kzKBvrE2XLYhOpRQOIXEK
X-Authority-Analysis: v=2.4 cv=C7R8WgP+ c=1 sm=1 tr=0 ts=6abd8ec1 cx=c_pps
 a=i69ZgmgbQZPDBD2C4G6j1A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=jiVZLek5lCiKkj7Mo_QA:9
X-Proofpoint-GUID: rql-KI9LOv2kzKBvrE2XLYhOpRQOIXEK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfXzpJ3sNRqnqYr
 pgAHRJqs3c8NnC7yDbvo11Kpcvv6kI6gvBqg5en0THLz3tw2azwKJqmk28V2+cvra86MsF1JSSp
 YBRcl0ZwS27ZSLhYdbe2p08Uw7jkiJGmpw1I2f2bzCQQAUfBSrNXPFt1UXflGtDZLZ4MaaS7F3Q
 GQBMAaQKMninV5Op41tulEMXE/fdalihlPNDzLn4/UnCtjBMsB1+idfpNRac+hZ22kwUE8GiBdK
 X+Ab35TPYSv5M/rxsJQbI05x919WBwoj6FHmqSEqbGOSeJSBrS6q2Hl0ws5MrRqHCmgKs+L9MLq
 ezUTatKfGNzKDrxIcOfcweRcFpfR4Rni/AJHHZ7stqt6ukIFlno4eAwaBeo22sR26/kUhoA/hwt
 d2Nyhn9u5/DLhJq7XhORt3qaAj/JEY1Uj74+lgebNdeldSEaYyq8czmUxfX6RUnebNNo7+bEmL3
 0N9d6QYxIZMlHSVbclQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

The bit definitions usually match the register name definition to make
matching bits to registers more clear. Do this for the bits inside
OMAP_I2C_SYSS_REG and OMAP_I2C_SYSC_REG registers. Remove unused bits.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c28dedd640741..5d5a237c07a5e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -133,17 +133,10 @@ enum {
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
 
 /* OCP_SYSSTATUS bit definitions */
-#define SYSS_RESETDONE_MASK		(1 << 0)
+#define OMAP_I2C_SYSS_RESETDONE		(1 << 0)
 
 /* OCP_SYSCONFIG bit definitions */
-#define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
-#define SYSC_SIDLEMODE_MASK		(0x3 << 3)
-#define SYSC_ENAWAKEUP_MASK		(1 << 2)
-#define SYSC_SOFTRESET_MASK		(1 << 1)
-#define SYSC_AUTOIDLE_MASK		(1 << 0)
-
-#define SYSC_IDLEMODE_SMART		0x2
-#define SYSC_CLOCKACTIVITY_FCLK		0x2
+#define OMAP_I2C_SYSC_SOFTRESET		(1 << 1)
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
@@ -293,13 +286,13 @@ static int omap_i2c_reset(struct omap_i2c_dev *omap)
 			omap_i2c_read_reg(omap, OMAP_I2C_CON_REG) &
 				~(OMAP_I2C_CON_EN));
 
-		omap_i2c_write_reg(omap, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
+		omap_i2c_write_reg(omap, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SOFTRESET);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
 		timeout = jiffies + OMAP_I2C_TIMEOUT;
 		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 		while (!(omap_i2c_read_reg(omap, OMAP_I2C_SYSS_REG) &
-			 SYSS_RESETDONE_MASK)) {
+			 OMAP_I2C_SYSS_RESETDONE)) {
 			if (time_after(jiffies, timeout)) {
 				dev_warn(omap->dev, "timeout waiting "
 						"for controller reset\n");
-- 
2.39.2

