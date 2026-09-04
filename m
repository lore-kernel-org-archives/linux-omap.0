Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31210494A02;
	Fri,  4 Sep 2026 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527638; cv=fail; b=njphTbb8mdo0z6Yy5a9c7DXfDbP46lX51rQGKeNKmX5IoPShJZ8X0ORwxiNpNc6D4Qn3INZ8adkVHkjgQTsFBlDYeGwOT/InbKLjJc5RSIKUkl1DXPpMLQaaqNUBLxqL3Q86dXVtAJID42NTuz8TZzKgPEInqjBSQVFABF81PSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527638; c=relaxed/simple;
	bh=zRdXX2S7cfFWaed8buWY1oJSQQ+1NNUG+ZARWvgYeJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlLsDNr7ZfgNs2GnaIQktlM9vb3/90XzpaFiGxv3/WFBVmnS1qruxoIP0h7ObqI0ofyqZWnexjf2qinX3ukA7HvwMRGR26/+nZKaMyZdjw2QS5wpq4lTCu8nWSOR5ZAhXpuM6yNyhHFfji+U1q4dcC4ADcWZK1EM9bdnYHAhpvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ADEHn3f4; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lv3Q3RpB; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ADEHn3f4";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lv3Q3RpB"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684AHcue3603256;
	Fri, 4 Sep 2026 08:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=K7POOkoENI7pBO6nO+goDRRn5n4Glh+Ta45eXMG4r
	N4=; b=ADEHn3f4Kgi1X7O9p2iC0M8fduKUTww9q1ttSfuZ9uejWt/t+yGFWoJGE
	WFhVkIF/Y45zJqkTLYgCQUn2zJsZBXjjRsJTO8V0WKgeDm0VDi+HGMgokuYOyazc
	76Pht00AfzhTQDHTwnmwNUopW7yvZ9tNKhsVbFmMu+hS0qw6w9AqD2OjaBWOanuy
	T4L3f4TB4epj+FSwBpvsyjoQW2d9c0e42CxJ2m3pxqSmx3GWI/adYqhAZ7Vb8ppH
	Bga1N3hp9I6QIUc1EMORMGQJLLFhZFnzmw+1ZHDJrTqkhKs4z2B8e1x1EL15WT0y
	8ibw1UE6lTOf+4UuAp+o+bnpraTDQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq6ev0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 08:13:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLg9N7ocDiPutxjqM8rRyygyfq4XqV+0ppV0/+mjcX8sUNX31xQhXOBQfgvVmdQ2OpItk7NH0sYFqKdBQlBuu9dmf66ORVRioIu0zPLHG9xDFDj2r7EdhXdTWLrqmfa8YcLXwb0llCJrj8LKHOZJz99DFk077I/pyyHgJbcjoFF8cPHuLi527E+VsS4S7O04kBcr2yfqm/HfEeFSLRsh/tLtCUhdAjMkRpPO4poRWJ+5xYR0X4wS2lvYlJ5al8V5TXvI9/g9rXZ8ydpqu4OVbObyDuviZ/WI3SxJXmS9sjSSI6EJZKO7y3PRLGy/xCHsdjEQtWFb7Hq+J4JOsY2v6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7POOkoENI7pBO6nO+goDRRn5n4Glh+Ta45eXMG4rN4=;
 b=DI/akh5juhNsaBsX82hi5tTDdoYuIhN6v99uWt87ZYPCg5QaOGaXwBs9EXyr+AVBbCgB4GH7fENK62c1Y/ZPZw/UZTzGzXtzimwBDiWzTEdzuFKGT+DNkEhlm5ljz5TaBiZDr8e2ulJmOfszacLjruQ+qXJlI9YkkkPoh4mX7lFhrqkDV6q81sXgABgzu+0kELBOx/jtYuvoacovKmWePxM+2FZnfX6+ICPodjGcaiq1olLHhPnD9EHTfR4MWVpWdfklbZ2b7ELpcGa1m0nCxa5U5vhg0cFtYs+921Omu8h80qHRtcJRQHrkDcB1S4FxQILZqiJZbbP6KSuTs+Sfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7POOkoENI7pBO6nO+goDRRn5n4Glh+Ta45eXMG4rN4=;
 b=lv3Q3RpBeRjGQcyiZKlfkhCjTM9sY3+0BE6cL9cyoqW+e5g9EIKVZjFavydg7O0YNn7oAAQcjCDV89VeXZ7Jo+LV1lp4RXRbHScDNRmBFmsMhVEVYHTOBrrWxGS3Ss8ceK0cbe32tL3F5vAB18SDQJC/sO/IOnZ1H+OP2W+tEU4=
Received: from BN9PR03CA0745.namprd03.prod.outlook.com (2603:10b6:408:110::30)
 by DS0PR10MB6919.namprd10.prod.outlook.com (2603:10b6:8:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 13:13:44 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::44) by BN9PR03CA0745.outlook.office365.com
 (2603:10b6:408:110::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Fri, 4
 Sep 2026 13:13:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 13:13:42 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:54 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 08:12:54 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.126])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684DCq55371029;
	Fri, 4 Sep 2026 08:12:54 -0500
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
Subject: [PATCH 4/8] i2c: omap: Combine event flags register definitions
Date: Fri, 4 Sep 2026 08:12:48 -0500
Message-ID: <20260904131252.2126353-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260904131252.2126353-1-afd@ti.com>
References: <20260904131252.2126353-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS0PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ca11f3-d9c3-4768-a2a8-08df0a8657ba
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FeEJWGXmx+HeW5SeKXzGRHd3ruKkKIpENoYRfIu3X5eyzSmB7ceMgUxc+fkuiPVlVM9Mlp6J4wO/c9pIfV2Q6AnFwZ29pJonzYR+ciAaRT0CKbtFa3P7fT7aYqcTDgVgfiofRGLNVrr596t193CDURDQlD3MRf/7/f2H6tKaDxkwplubbRsmcJuMgDDirOcD7Rbb3bRlDJQixw1zfqyJqleioepFoATngvhjPUWIV4ji62GjipBW6wqu6yXERgx10sYusN84DtN2o3Fudb4eAH1V3HXNh9nm3wNJyDSOQlt4bPROb28JKugmVDDSOfPeehu6OH7zUDh3rpNac0o1eC2y8IV9okJ/Dd+GrdeIRObeAtxXKU5/Oww/tm+sFmsCLxF4WKNBt+OINtoCCMpOW4tNj3nPmfKtZDyaOF9HHR/vYgL35vkjhNuosfFZ4lpVIqXVexaY+yGkSxqBqCcPZDz48bSwAy4RPOwNsrWy85srMCyveI7yMTM+Z8046WQ9E5LW1wm+uemxAkDSTB/MV9WcqKdrgXchJZnWngHy+KCQ+CHE87UNmbdCcfwPI773fuzlzVxXyheKYDlD7r4CAbYyFdpMJfLSe8wrOGr24uWNF+fkqv5C3PGESwfSWWLlJmMvKKA27/Tw5nGulibCQfGuBnIKzS3Wjhw0cZJbhJYVNKmyOiS+Qb6M6aQ2Lya729ZuTjOgAjOOYRjXnxKfvQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	23WkC/IBvbXlaH5gpL9KZHiC0SCGKECx49c9QxYKpxoveRYkwj4Ei5JucOwl8lttg4tJj+XBmW/GIFmk9nS/kKbPihsh9Ox7Xfgre2pYAENabqH7lQB8RmUcZW2ttUvAAFlDDAq99zuEV1Wd+KzM8pvvUhGbWLjAOhlpBAhNX6EQjOWT/S67OdIGHf5Ty8Oow13EyzvKctssYHiTDA5IXnD79ln0Wgcnc7q1M1ZtEOY0ASHs1IcBjQAdZNS09pinrv1GDAPY6z/KJIdw9p9t1L2BUsXn8nsToaXz4OX/sWOJqmcLRNvo2DzdNg6ZvmLh9wsw7SGHjFx8lzS2GSOVszOEdSV/Kig7kAc8nfC0Aj98SjXX7/fH+lB1EZFMmEGSkxPsfin0VbbPNnAwfxC1+lHaeeAx3EQ/qAo45CRfT6VgeG1sA4tdCxtqdDAeMDYZ
X-Exchange-RoutingPolicyChecked:
	4PAqhSmy5hGQtuGmjDBAdPOc0QEKEkr7Nc6GU/eB203E2Wi1WLmLAbgO/WRSPvSP9XHZLBSJf/QKphSlVISO9glpX1Z1waT3aLBXlZflVVR5Buo6LT2gh36aQ8MfDcoMZ8j5LEMqCYHWmHSZ3barDmDID5PKzGIJWKxBlcCBYgmz80O1VfrdUKuthOo0rKKdzYvYQFSxMf/uXTN1MbsY1eCMvIZjRqfPvwKDlrfiYKRwTlukpYa84yHO08W13z9zaNF+yRSvQCLuMM6l1AycIoBKBXtOMOzrhb0ZgZAG0PStbaZfkRcrdJCqZTdR1nizsa8+4rjzKJGiXLx257gsjg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:13:42.2421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ca11f3-d9c3-4768-a2a8-08df0a8657ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6919
X-Proofpoint-GUID: 9GQdz-k_kUZwhIj2oN1vYHofV3k633Ts
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9ac40a cx=c_pps
 a=v9d8l4VwGb/BX2RVr192eg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=-VTgE4bae0sfXoRtrj0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX+IKSgxodIoO8
 NPoBbgWJDDrkFevIsS+ZJiiomFqaMzLPBnS60HJ3gvXEA1eOfyGQf9dMTiMQkIzX0O+IOAHfGIK
 zG3+oi8AGB/CG4/mno+gRfjnfpr7F4o8/dr3WVGarjwQXKLnQSHFwAyMsSTINty90WV28XG42BA
 VnCB7FKpJR2WborzQukOxPkg9a3vzcVyBoY7vmDseIwLlb0VZByksODAArdcrA95mLzcNtGRUKt
 5aEJMDqJNdgVZ2TUedu2QY/H7dm430+nZs84+RcLxPQM4oRpvghdSpi+yGzFA8LRkCIsQInHvTl
 44CREHtt6zGZjpWqKJda+vXYJm7O1CgNIgJV0rtGbMvSBcYYVOAuWB5mFUaz0x2PEODOyUSH7m6
 5lflSFTtbTUiS1/u19kjnf4OsR8+OCIlAqeLaThm2UjQqBWkAjPxyinK0LUOsucAI8bYXFUm+ok
 Bqh66PA5/acKAJrxRMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX4Tci7ycM1DPw
 N72f4m7gT8ptBrikkeBbeH/JUvVp7vPs31/FKmhoDt9m1eOXBOeEySOqXiUj4R4SQ4xyldUA648
 5FF2P9fQB/le36D2EdCgkp8XcxpWs8g=
X-Proofpoint-ORIG-GUID: 9GQdz-k_kUZwhIj2oN1vYHofV3k633Ts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040119

The position of the status, interrupt enable, and wakeup enable bits for
each event are the same in each of their respective registers. We only
need one set of offset definitions that can be shared.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 58 ++++++++++++++---------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e03519d939755..cc65dc90770d1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -78,16 +78,7 @@ enum {
 	OMAP_I2C_IP_V2_IRQENABLE_CLR,
 };
 
-/* I2C Interrupt Enable Register (OMAP_I2C_IE): */
-#define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
-#define OMAP_I2C_IE_RDR		(1 << 13)	/* RX Buffer drain int enable */
-#define OMAP_I2C_IE_XRDY	(1 << 4)	/* TX data ready int enable */
-#define OMAP_I2C_IE_RRDY	(1 << 3)	/* RX data ready int enable */
-#define OMAP_I2C_IE_ARDY	(1 << 2)	/* Access ready int enable */
-#define OMAP_I2C_IE_NACK	(1 << 1)	/* No ack interrupt enable */
-#define OMAP_I2C_IE_AL		(1 << 0)	/* Arbitration lost int ena */
-
-/* I2C Status Register (OMAP_I2C_STAT): */
+/* I2C Status bits (OMAP_I2C_IE, OMAP_I2C_STAT, OMAP_I2C_WE) */
 #define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
 #define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
 #define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
@@ -95,29 +86,13 @@ enum {
 #define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
 #define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
 #define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
+#define OMAP_I2C_STAT_STC	(1 << 6)	/* Start condition */
+#define OMAP_I2C_STAT_GC	(1 << 5)	/* General call */
 #define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
 #define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
 #define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
-#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack interrupt enable */
-#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
-
-/* I2C WE wakeup enable register */
-#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
-#define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
-#define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
-#define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
-#define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
-#define OMAP_I2C_WE_GC_WE	(1 << 5)	/* General call wakeup */
-#define OMAP_I2C_WE_DRDY_WE	(1 << 3)	/* TX/RX data ready wakeup */
-#define OMAP_I2C_WE_ARDY_WE	(1 << 2)	/* Reg access ready wakeup */
-#define OMAP_I2C_WE_NACK_WE	(1 << 1)	/* No acknowledgment wakeup */
-#define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
-
-#define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
-				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
-				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
-				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
-				OMAP_I2C_WE_NACK_WE | OMAP_I2C_WE_AL_WE)
+#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack */
+#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost */
 
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
 #define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
@@ -360,7 +335,16 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 		 * WFI instruction.
 		 * REVISIT: Some wkup sources might not be needed.
 		 */
-		omap->westate = OMAP_I2C_WE_ALL;
+		omap->westate = (OMAP_I2C_STAT_XDR |
+				 OMAP_I2C_STAT_RDR |
+				 OMAP_I2C_STAT_AAS |
+				 OMAP_I2C_STAT_BF |
+				 OMAP_I2C_STAT_STC |
+				 OMAP_I2C_STAT_GC |
+				 OMAP_I2C_STAT_RRDY |
+				 OMAP_I2C_STAT_ARDY |
+				 OMAP_I2C_STAT_NACK |
+				 OMAP_I2C_STAT_AL);
 	}
 
 	if (omap->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
@@ -459,10 +443,14 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 		sclh = fclk_rate / (omap->speed * 2) - 7 + psc;
 	}
 
-	omap->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			OMAP_I2C_IE_AL)  | ((omap->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
+	omap->iestate = (OMAP_I2C_STAT_XRDY |
+			 OMAP_I2C_STAT_RRDY |
+			 OMAP_I2C_STAT_ARDY |
+			 OMAP_I2C_STAT_NACK |
+			 OMAP_I2C_STAT_AL);
+
+	if (omap->fifo_size)
+		omap->iestate |= (OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_XDR);
 
 	omap->pscstate = psc;
 	omap->scllstate = scll;
-- 
2.39.2

