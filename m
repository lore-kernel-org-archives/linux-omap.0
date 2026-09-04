Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655C33F5B3;
	Fri,  4 Sep 2026 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527599; cv=fail; b=RGbB3LhcvcZXnO2+9TPLEjZi03K3vZju4HrLKxffetzkCHBqB+zFB9vu9r4lCgTx5Ls5VARIoh0ovNsV8gu2ig2ZIiYSD5n9gjle6xM0iHTylPbyRtk8cyMESbXgXpPNY8f6GniXYoPctLwmEDlgvOLwZjesQ1aSxLlCpx+z278=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527599; c=relaxed/simple;
	bh=GDn6C24jQP/nYwTqVRg5BwRDzzRAK7MhPAq6yGPJ2yo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3OQfii5UshM3XzS8BLK/L8VfInEiwGhsm5cqvfyX/YlqBZpUDq9WDSnlkD7PQ8uUs48GKuyRO6O2gHkFSxtXg2W777271C/F5heVgEyzvtMqd2oQWGqvVypzDSlTjl9mHltgtrCIoirfVf8vfSK++Jz7z1oXJ1F2zsLIg9ooDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=SLw6rmHJ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A8S2ZOa6; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="SLw6rmHJ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A8S2ZOa6"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHELu3456761;
	Fri, 4 Sep 2026 08:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=sbXxU+1wdiI2yQMPe0FuJNV+bhlJlCPVgH3GrkZHY
	84=; b=SLw6rmHJy7p4BNNewwyDNhzfizeHJ6thRjGiz6CoQbxYv/f0lT9XCy8pY
	eUYsYz/WhdfQom5atSkso8Z5GMdjMXvgl/p4MMNUXcC9peLAVIxkGOOkSALQl4P7
	14EvxcygDoCAVEOxv8sxi2xThI3Ps39q3a+1hBaAAVLtjDAGVvJ/9C09eLnw5qEm
	jVJ74eHiMAcsyZs6bNq3OSozIcTrUUilRzJMvde8w+jnzquDFgXnnajbXMWTQ86+
	piFSruH0qRI1Y5ny7DryMoebCUd7Gu0k4FLDQJlZS/L5+BhoG6LB8OKK9Ux5dMvJ
	K0nnNcq1L1PwcGJCXr/uPr+sovfxA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xv399-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 08:13:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POkG3DTNS7urWZnCK/U4Jg9bJp4jFNAfohbuk2RvIbnnt5W/fNmkY4tRZ6Mgnc7pLCC4et3S6ygmx/nStxqQ7LIL3HP2myIZeJFwZ5SzA1LUC/T3Ykx+PUOK8jpL7Blw262E4n4Ui2vTz4/XmVUp4IYbHLSp1N9MVdAf0z7irLEOQn9SrmSSH+6z39ReeGRp4F+KO3Vt5BLwDgWJSFoMCi1S+uum76Vc1C+f8bZjXMo39K+OZm7YntSoLZ1n+l46eAV0z3YaQP1+pEBYzxMFe1L7HPPLGixcky1nQ34I53FWvn6NSHqAXN261Mj2X0chDZFpcBvYKeSjzGuHRZEsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbXxU+1wdiI2yQMPe0FuJNV+bhlJlCPVgH3GrkZHY84=;
 b=fK/37kHR47TdqeVNKD00h1cAC43Kb1euNLZS3R0i4dJ8vSYTm+gN0AywJ6B1cSL7hTo+BwJatXLyxvH4wbPljdJrxg3O9dcLFjRwqUtwUGjbawGsoN8eG2qNFLLBaOQNpR950YmHNZQqQN+NRtKwstYgSOXRb39AFEVb/NqcJ+T/YHLuHnFs+0v9zofbGrv5bF4mOq6Zvrvpt/CjH730r0iAlpuFkSkeMgtMtRC3BAo+dH5bT2uOHDcIskywRh215mgsTSWN6tlJzEZK9C+81lCjhVmk3TcY05U3INuUPrZPNXEgEnAJ9XZz+LBrwlpo5tH1URCHjeRbw/wTby8V9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbXxU+1wdiI2yQMPe0FuJNV+bhlJlCPVgH3GrkZHY84=;
 b=A8S2ZOa654MStDItZikVczcj14Lb5xpiqmSIhFeZFzi3IVJYgfCX1ASbSMqXV2LnW9SqVcsDAqvRLGck/gKwWWmeX3XOJHo1331Pp2WYq/JJl1xdAQhBoZ0rGq1BrqsVJF3+fZ3nprN4bcYJF+PoTEGuZ/KeurA0iofQITu90Xk=
Received: from DM6PR02CA0155.namprd02.prod.outlook.com (2603:10b6:5:332::22)
 by IA1PR10MB6268.namprd10.prod.outlook.com (2603:10b6:208:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 13:12:59 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::41) by DM6PR02CA0155.outlook.office365.com
 (2603:10b6:5:332::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 13:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 13:12:59 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:53 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 08:12:53 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.126])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684DCq52371029;
	Fri, 4 Sep 2026 08:12:53 -0500
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
Subject: [PATCH 1/8] i2c: omap: Drop bit shift for I2C register addresses
Date: Fri, 4 Sep 2026 08:12:45 -0500
Message-ID: <20260904131252.2126353-2-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|IA1PR10MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f350b7-e63a-414e-3d4d-08df0a863e44
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i4xZgCkD2gVK8jzwTR1DKDACEj6uG8uyXRllzk0Ue8I2V/ckOyDvurTjJw/74R6cmWvQzS10V67NOkDC+kMcS0rdZY/Ygn6+2dCNgaFLC76vyKEJqhCFSzNRLWi94Jg2iby1onUKKGXPeASL1FE09oCl70ZiQ3aCVePeS2FttZj0bYf8if+l1cv2Jiq07Ow4pAI1CoZ02Z4Xm9UaPNq55SpiOdJcAW+FaiiGOVPv+G0OE5CAv885s4+DaZ63hIs6bMAofP3qzzbu38gd8uXzjbNlX66dfmlpsy9OmPckrodUGL1NW383uESrbTPC41EcN/XXQpqocxCUojCQpf1D45zTee/Mhby9uSn81ZOD64nrdgG4P+NXA9sZ+SLLxUp78tBaUUah7XW5apsGtytl1cubSUKp167euaeSRNWlfDuNZA8KrkrlUoY/oRwuQg5Xhn27Y/n1ZVcJ3DlrvTu/L54DdxbZ1+rmtT2n0oO9MWXcjUZzh9tZf+2BP4AsfRijkbZhliDb8KM3FUWG3/g6EG/+YWkVGESRAXaXMEj/oxpu9NTapbCrQe5pgEANvsA4TIAu+qi5E0JU4xCYJVAu4saTvQeSUkA7pZYYQ+PO2GVcbieVoY3Jav4dQtv9kxuSJfvonwRrlhkU42SjpABuy9gScZ86SNmrwdGy7AICO4+hvYU45B8YEH1rhj3Jpqk45ucbyJPq14+p3FEy8/7ecQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	14xC5m3p8L7L88yvxJSZwKm6BaBxE5K1zw9tU88KYsyTUg2Wa9CnbuUqenF9lowi6Cs7lCVkJZDerhU4/vpXrbBus/4rrHrO+K7fviQs/v8s1l1KIGexO3Qnq46LFznjOaw2NKtiSggKbeEaPjbQfS3aCPr3yGmX6q/1KeWpBJ9nPOMeQKmogXfH0GWYar5Ez/9Bvw2k1g3GoJCy2lwxyoxcDkYBhldasIA07/EQK5GljGvH8N99Mhn7NH/JRNtMJlsPqHnlFKImidowWE+5Jw0ZXsJJSHIg4Q0kz5NWLtB6BpZ14mcFHQ+ytupawavQS81L2QV9faPjbgdwijnQ1W/RrY9A+BlAObDEIdhw7YEFf8NfbYMlPEZ3QNTgjhPsQftafHP5n9l7BZS9u8xWXlpQYZK6pdAspcup1gyxiFw1DqH8XMQPNE4fCEvnYP/0
X-Exchange-RoutingPolicyChecked:
	Ui3p6IprTgM+R5InbsFZhzPQpej4Hcxg05Bgr+RYcG327ias4Q95RD4uGbzXnKLjg0rNF3pGd4hrL0ngTBeAZmTh6gIzpz6LV1oe/5lPq5q3CiKUpJUlikx1Jinri/i3bY9KQN0HuabqZ0D8HwYhsudUaggONJXRvCC++MQ5M0Cg0M21oKcPNHrf0HuIBkoX9+kNOCM7gx+zefZRveE15WVeW5I4JCgKyUutz50dnhJK4WUBqb5w4zVwcZOHTRKnxYD/KMa3qq6zx6/hlN1BZCTbpf4ADK4RGFUYiG3XgcQ4Difb9d4MANCKK1Z0nVizqyHlSMndgZ2S+/Ti+aq0CQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:12:59.5582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f350b7-e63a-414e-3d4d-08df0a863e44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6268
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfXz3ME5cwcY3dL
 ekvoUXvOYCxiO4oDWWj+KzNbaC6eDtDFeC5Sg8V/NCn1n2AGivkEh/GBvKeYiIRtk2mFSCYSEZl
 DRLF04s+4HQpfABrcTSSb/nDgVCdP+Y=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9ac3e2 cx=c_pps
 a=eHfeAi0ej4loD7KcX6Y+qw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=0HO5tbt_YLp_22CWDAYA:9
X-Proofpoint-GUID: 13HWF4Nh1eHQJcSsA92wnnoIr2BE53zv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX+RzQUO+Qus3v
 W8yy3oWqCcHyxYORwZpM2xSC4ATYW25xdGX30iK55LVe2Mn24I3CmaS2Ta12uYiRSZpD2glT6HD
 x/F/dS4p2oEExjkptAytxNiaZ1FthVpHD0eaVGq0xK7rnhFQ0aGrajYbcmpxySL7mQP7f+bg75M
 7gzQ1x7+Z3BHimR3y6aIiJoB1O/jFPF77EgjbwGKATP7+J8mXGudeC38p88xqh2xDy+OM1ouj4N
 C2ownnA+t67u4jzBCk1bCOl5XUsRVxdUKKSkcUDWgpyhet38o1nTr/uIq/W4rAsW0K3knvAt0Bu
 U2/uGICm6gwvNh7/lmy2V7AOqO8lEXvc0r2oNLmxDbF+Tw4qoJgjAdrZqaj27xJLOW1mhUXcHAn
 ZfZcUw8VrUMbqqV/a1lt6QRGT9lhdYF4RpSjIOVImqtToUCkJnL/5NmTJofmxheyvsUpHEMfkr1
 pEaQVMTob+c8sfd/0ZA==
X-Proofpoint-ORIG-GUID: 13HWF4Nh1eHQJcSsA92wnnoIr2BE53zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040119

No remaining board device uses a shift other than 2, and no DT supported
platform ever did. We can drop this flag and use the pre-shifted register
addresses. This simplifies the register access.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-omap1/i2c.c              |  4 ---
 drivers/i2c/busses/i2c-omap.c          | 50 +++++++++++---------------
 include/linux/platform_data/i2c-omap.h |  5 ---
 3 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 94d3e7883e027..bc7828a858941 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -61,10 +61,6 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
 		       OMAP_I2C_FLAG_16BIT_DATA_REG |
 		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
 
-	/* how the cpu bus is wired up differs for 7xx only */
-
-	pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_2;
-
 	pdev->dev.platform_data = pdata;
 
 	return platform_device_register(pdev);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f02d294db42a6..72f979eec7311 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -180,7 +180,6 @@ struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
-	int			reg_shift;      /* bit shift for I2C register addresses */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
@@ -217,23 +216,23 @@ struct omap_i2c_dev {
 
 static const u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_REV_REG] = 0x00,
-	[OMAP_I2C_IE_REG] = 0x01,
-	[OMAP_I2C_STAT_REG] = 0x02,
-	[OMAP_I2C_IV_REG] = 0x03,
-	[OMAP_I2C_WE_REG] = 0x03,
-	[OMAP_I2C_SYSS_REG] = 0x04,
-	[OMAP_I2C_BUF_REG] = 0x05,
-	[OMAP_I2C_CNT_REG] = 0x06,
-	[OMAP_I2C_DATA_REG] = 0x07,
-	[OMAP_I2C_SYSC_REG] = 0x08,
-	[OMAP_I2C_CON_REG] = 0x09,
-	[OMAP_I2C_OA_REG] = 0x0a,
-	[OMAP_I2C_SA_REG] = 0x0b,
-	[OMAP_I2C_PSC_REG] = 0x0c,
-	[OMAP_I2C_SCLL_REG] = 0x0d,
-	[OMAP_I2C_SCLH_REG] = 0x0e,
-	[OMAP_I2C_SYSTEST_REG] = 0x0f,
-	[OMAP_I2C_BUFSTAT_REG] = 0x10,
+	[OMAP_I2C_IE_REG] = 0x04,
+	[OMAP_I2C_STAT_REG] = 0x0c,
+	[OMAP_I2C_IV_REG] = 0x0c,
+	[OMAP_I2C_WE_REG] = 0x0c,
+	[OMAP_I2C_SYSS_REG] = 0x10,
+	[OMAP_I2C_BUF_REG] = 0x14,
+	[OMAP_I2C_CNT_REG] = 0x18,
+	[OMAP_I2C_DATA_REG] = 0x1c,
+	[OMAP_I2C_SYSC_REG] = 0x20,
+	[OMAP_I2C_CON_REG] = 0x24,
+	[OMAP_I2C_OA_REG] = 0x28,
+	[OMAP_I2C_SA_REG] = 0x2c,
+	[OMAP_I2C_PSC_REG] = 0x30,
+	[OMAP_I2C_SCLL_REG] = 0x34,
+	[OMAP_I2C_SCLH_REG] = 0x38,
+	[OMAP_I2C_SYSTEST_REG] = 0x3c,
+	[OMAP_I2C_BUFSTAT_REG] = 0x40,
 };
 
 static const u8 reg_map_ip_v2[] = {
@@ -267,14 +266,12 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap);
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *omap,
 				      int reg, u16 val)
 {
-	writew_relaxed(val, omap->base +
-			(omap->regs[reg] << omap->reg_shift));
+	writew_relaxed(val, omap->base + omap->regs[reg]);
 }
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *omap, int reg)
 {
-	return readw_relaxed(omap->base +
-				(omap->regs[reg] << omap->reg_shift));
+	return readw_relaxed(omap->base + omap->regs[reg]);
 }
 
 static void __omap_i2c_init(struct omap_i2c_dev *omap)
@@ -1214,19 +1211,16 @@ static struct omap_i2c_bus_platform_data omap2420_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
 	.flags = OMAP_I2C_FLAG_NO_FIFO |
 			OMAP_I2C_FLAG_SIMPLE_CLOCK |
-			OMAP_I2C_FLAG_16BIT_DATA_REG |
-			OMAP_I2C_FLAG_BUS_SHIFT_2,
+			OMAP_I2C_FLAG_16BIT_DATA_REG,
 };
 
 static struct omap_i2c_bus_platform_data omap2430_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2 |
-			OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
+	.flags = OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };
 
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_i2c_bus_platform_data omap4_pdata = {
@@ -1384,8 +1378,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, omap);
 	init_completion(&omap->cmd_complete);
 
-	omap->reg_shift = (omap->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
-
 	pm_runtime_enable(omap->dev);
 	pm_runtime_set_autosuspend_delay(omap->dev, OMAP_I2C_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(omap->dev);
diff --git a/include/linux/platform_data/i2c-omap.h b/include/linux/platform_data/i2c-omap.h
index 3444265ee8ee7..fe6753cd17bf5 100644
--- a/include/linux/platform_data/i2c-omap.h
+++ b/include/linux/platform_data/i2c-omap.h
@@ -23,11 +23,6 @@
 #define OMAP_I2C_FLAG_16BIT_DATA_REG		BIT(2)
 #define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK	BIT(5)
 #define OMAP_I2C_FLAG_FORCE_19200_INT_CLK	BIT(6)
-/* how the CPU address bus must be translated for I2C unit access */
-#define OMAP_I2C_FLAG_BUS_SHIFT_NONE 0
-#define OMAP_I2C_FLAG_BUS_SHIFT_1		BIT(7)
-#define OMAP_I2C_FLAG_BUS_SHIFT_2		BIT(8)
-#define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
 
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
-- 
2.39.2

