Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09342E736A;
	Fri,  4 Sep 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527616; cv=fail; b=LC0vGbkJcpAC4Xji+O690RjmrGE4kx9KOAmDpCmNrCUZrmV4HsMHkGw0cu2rxzFKD1e/Kv0kGrn6v9J5I8e/2f/DrX+yQWi+7eGXb6wK+FVz8p+85Wik0vaEMQsUQ6Nw6kp9+r53B3IyYpXyCBpqk2DpDR+G1/ejWW8CE6ZzAUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527616; c=relaxed/simple;
	bh=Vbn+XLMaFzBjz/uvtk95yaSvYtDRv5PeHaLFfCPIbjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ito3o7c+m6zYFdqI4fnphy5dcSPmFF1zglkFfpe5Fb+Fe997WsrowiMZHiKl55AFl5jsd9h8zFcjLGVbm6quOfpPOBli43nuvlcTWeWqmlOy0RJTVitO00elTptTCy8AJ+CdzFKa/PSgAgh3Pj7yaQgYW3PAzZHQ89jSelJMgM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=g/Hrs1Ae; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IdEbR7F6; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="g/Hrs1Ae";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IdEbR7F6"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684AHoND3238091;
	Fri, 4 Sep 2026 08:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=6JwITzJS1HiqrdKiUyafv46BdgOOqAsiTlQP/jiss
	aY=; b=g/Hrs1AeHr72h4pY+n7deBihi043cdmW09PVBUvgR0wkkyWZOtqyv7GBA
	g9n2d/UCD/fxMcLMtZqrQMAH8CgvYKV764NtQia16IU0rwz6DP519afP5dxDdr4z
	rRDeqydgJI0YmBMIBAtxq8ko7iCA3RtUS3ERLtFZBRAmgx1lvdMc5/owK3IMXmQR
	YCOKfNwxL+DnsYdgaHyBUVhkX0Lu6Xb53RXuMaRwG6pjPqI9ElzuE2NdEtIQWO5l
	Xe9brMWtiQnZ4lkImL0PTdAtqH+Unh9z57sK8+nJRC5MMFsBpjVx2Vz5FzG3DF2U
	g1wCe0XMeJv1jpS3zwZ6CSY0DWY8Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfu6w99kh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 08:13:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N42nO0TKUz2LvWwRSIKDIIIJsFhwv5Qw+O6Z6J1U7hRI8XIBa6YH+pG8flp+peHqVunyBGrvjhLNajEn2Q6rRPhijSBjO6NpterGUl1EGzEOcMFtZrxEUzRG0Nr9TgWdi0SW+ABiMDJe5VyY/wy2FxOCHY1Q/Rz6YrF2LjZ7AAnFM99QncHyzLLC4OTAg7jhoJf/Hn3vR4632pYyem/gSnLpd7fBcQjgqd4dlZK3R1YLf6GarCo0ggB+FSMQQ1OEWEV2NTbQRy4UEZFP1/Xugj25sm675utRhU9m655ST9fyVrAmQanW1cMs6ZjNz8u4NHdYFn+iTuS7TZI5pkrT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JwITzJS1HiqrdKiUyafv46BdgOOqAsiTlQP/jissaY=;
 b=xgZtWqCLyYHHHdkJvj30r5U/Q9rYHTEeR1sFWPK8g4aaFhx/DRapJqUVjS7cPRwtahS7XMM/m7D/lS8CJX0gc7T8miOuOJws/1hX+qH47PvA4AnYkD5vJ7z3zHP4KcN7mnht/ZydvdBu6b9cSx7Afacl2QOyDjlXQvyg8kxYZa/nrqOa+cDeo7WC4Xz/HAjQbDoRZnusRItzI0K6AnBWP+a7BF9wzc+PxIfkGH+YKZQFCv/uAkgfMlhvQCLdniP2enaqvB7n1bbou/exWNn3aQ/bdECAFpuzRukng9X3vZBxcL53efj7T78R3ssJLqiPciAswlDMs2aEXru7jaisrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JwITzJS1HiqrdKiUyafv46BdgOOqAsiTlQP/jissaY=;
 b=IdEbR7F6+AeSEt0wx0j/zMZLq5GNsLeym4yNsJme7cxDj34vC3zl3Azd09+Xszo3G9p/AOJ70k8y7bZFKM372c5jAFVvIEvzAQ4AzrhaNnYwbGkcDuZrcSdnE6xuhHI1OCnn6ul9B8CoZWt0ix66AY0LMw+FNv7Zwt8aNiJTZOA=
Received: from SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::16)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Fri, 4 Sep 2026
 13:13:06 +0000
Received: from SJ1PEPF000037B5.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1c) by SJ0P220CA0025.outlook.office365.com
 (2603:10b6:a03:41b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 13:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000037B5.mail.protection.outlook.com (10.167.244.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 13:13:06 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:56 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 08:12:56 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.126])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684DCq58371029;
	Fri, 4 Sep 2026 08:12:55 -0500
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
Subject: [PATCH 7/8] i2c: omap: Switch to using BIT and GENMASK
Date: Fri, 4 Sep 2026 08:12:51 -0500
Message-ID: <20260904131252.2126353-8-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B5:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 693c0b41-6079-45e1-b225-08df0a864247
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|10086099003|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/ArhrriHRSYY10/KEO+Hr3WWr2qIXMZmZd3mSiatJPnyMy004cKZJmvSQo3plXblPGVdn0QVF+3Geko3+cDdGgCfXk9/dKE+prA9eAlLD4K8tjSP1CZXjEDpHBSwpuAjhWet/teMKeJDb3u/lm6Ze5sUPCrByuRgM1NKBNYGGbZ4GcnDFqAr6j4DeNqr8FghUDyu4irAse3h6YiOizy97tf/aDYEv7y5+TVmlO50DNwhXYT66vw0vI/5h5BCJe1OKHI+ifI4vGcQ+FTStdwyf14hK0f0E6RL9E5TYl+sNBxmaClZMZ3wM/xyGATbSO6Z8JJ/uPQL5sRADjp7euqIMfdVyXWN53qHALMzxf7vHa6b4jUqMpABGq1XWgTnVwycBG/93lkDrI2FaWup8XZ9NaaINGvOA9fDvotVX/wWYOU/2m3UePC6Pe1LCwkH3MvLOoCnTrkEz47Jp8vBmJJUFsn1ZwEfbbXPd4CoX1fFpOhFKiSVQEp3vZlfBBNnpUVJmjsIiSdUiKI9xR41DQp2/HZclzVfxvnj63uVcBDKWnO7P/4cihJmOxdExrL9gsTDNEHfyHiXRyDng2TWsuFAnbRjG4EhGwChVrNxSHXSWi0SGqqr3U0sdEGUfOLvy3jxldf7fW3ijGMVMqWI8RIYb9tinCXZ7BNu1RbBpT/eAETUXkKvIP1jHWe6UZqbhqF2ulTbLTnk7EP0eWph/jowbg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(10086099003)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rJ+BnmBKNyOKV6SODcwZGE5F75QyeBmLSI2zX8H+1hhhjXb4khyfUUA/XMx4naGT2mZGccDpXiBGrPjLas7bhF9DbaYeLpQjZCWKrNTT1cNd6odd1w+iRaZo9OFEOLDgpOT/2LlMBwAMhxqV5hqvuRXiJR+ZRKYVII9lhfdtEoGBrDQafegYchZUSFo4YV7137VgK1un5pyYMa3+ccks9ffInxP8JaRqVOKxnV4R7yAl0WQvRVz6fYyX/IAV6BocTmkXevVZXtS687XJtij/vK8G2rvalmHhHJt41KPyKiFLxP8tTeqwbypGCg6CUEu9dSLY9muov5UxXJFU9Y1EqNEZZexujb/wdN4CEnFY7WF5r1PQKmXNZs5ocORO76zIfHc5AXWo0PaC9vVJaCGoNEM6lZTkUAa1AnQD6y9NiG36SLIJOhU0yqDP/00kVi7a
X-Exchange-RoutingPolicyChecked:
	ENV0agIBnj7cYWVlkoxV5bI+etyz//Q1lNUZynSY709MZHpHtYQlxdxdsmd5FtIkUuxHnMSpLDmOJUAilWpgKfHV85TLvC/6Y4THb22hJrRXEgOsZ3BvL1AiIiE3w+WXuED8hv+A/0d3T8oImEmEovWeiC4lzbtQkH6HFy6K5Gk9v7fVk2G+b8ApFnmXkhitC93FOrqS8kN/FJCL8H7IgU0M94VIKWGRaljudx51mHqhu2/0rrMtrfgAJ3BXdrfsOoZwP5xeu61rAqpGGWXCwMF7y0B/0OTxxMiXHA3nc3w9vAAg1vmemg4ruUCnpsVM8SHVqW3fc12oH6NIdwV74g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:13:06.2436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693c0b41-6079-45e1-b225-08df0a864247
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Authority-Analysis: v=2.4 cv=XLoAjwhE c=1 sm=1 tr=0 ts=6a9ac3ea cx=c_pps
 a=/vFeFcp+ixIfR90aQz5jMA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=nc86A_OknvlbK2ZPRX4A:9
X-Proofpoint-ORIG-GUID: 5_DcAQjcCiE8sajEdOEks5pFoU23VVIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX0oIgOyF/hBGA
 FRe2x78mF60oD/YsNL+qUdGfugqsgx+zjKY4S0mE2OIfltffyM3osaafwVpEYfo5fAw1Oir+Ain
 OWyPHyokzQT2gvaN+lV/XNBUhe5kiKSyNIx2bBcItOx5kLVj4He1Xa+Mj6ySH4riEwc5P22Tmqj
 vzKuYO0rRUuzT1nZNJeUkj1Nsw6XjPLnS83Ns20QzQoAWttU3n+unRYN91OtRFtVyzQHsLo+Er2
 utb8HT8lZNUwqbVO+kRM7LZJeJSjImBjsQjkhdtm7Y634MvY2iSSiMoULCfBZT1rYfc0vfjCZgp
 j5h3WQWZie7F8pQgGTz5IPwHFN3fbyACKV3vpE3d9w8ZFaK/uyC/74IKcaCGqRzW03xRo/9KeKD
 APmKi1dUMnwT0opJ6lTy1yxpQLlH25fVZkRubjbZX8s5qAqtN9ZOGH454YsjED4hNQdvLkwy7T3
 sir06ok6Y3WzvqBrp/g==
X-Proofpoint-GUID: 5_DcAQjcCiE8sajEdOEks5pFoU23VVIC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX/8pBFkvQ9AnU
 MHai/D+2MtAu4HLqr1WZkLHZ8n8gp5MjHWH/g32XZh2nXnJnsIDW10+n8YZIUDFAzFvu+9xtSkO
 rI5IAjPAbYtA1Ysa5+uAIOAKoaTRDRo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040119

We have helpers for setting bit values and masks. Use them.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 82 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a50cf195c28cf..41464f92da046 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -79,64 +79,64 @@ enum {
 };
 
 /* I2C Status bits (OMAP_I2C_IE, OMAP_I2C_STAT, OMAP_I2C_WE) */
-#define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
-#define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
-#define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
-#define OMAP_I2C_STAT_ROVR	(1 << 11)	/* Receive overrun */
-#define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
-#define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
-#define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
-#define OMAP_I2C_STAT_STC	(1 << 6)	/* Start condition */
-#define OMAP_I2C_STAT_GC	(1 << 5)	/* General call */
-#define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
-#define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
-#define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
-#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack */
-#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost */
+#define OMAP_I2C_STAT_XDR	BIT(14)	/* TX Buffer draining */
+#define OMAP_I2C_STAT_RDR	BIT(13)	/* RX Buffer draining */
+#define OMAP_I2C_STAT_BB	BIT(12)	/* Bus busy */
+#define OMAP_I2C_STAT_ROVR	BIT(11)	/* Receive overrun */
+#define OMAP_I2C_STAT_XUDF	BIT(10)	/* Transmit underflow */
+#define OMAP_I2C_STAT_AAS	BIT(9)	/* Address as slave */
+#define OMAP_I2C_STAT_BF	BIT(8)	/* Bus Free */
+#define OMAP_I2C_STAT_STC	BIT(6)	/* Start condition */
+#define OMAP_I2C_STAT_GC	BIT(5)	/* General call */
+#define OMAP_I2C_STAT_XRDY	BIT(4)	/* Transmit data ready */
+#define OMAP_I2C_STAT_RRDY	BIT(3)	/* Receive data ready */
+#define OMAP_I2C_STAT_ARDY	BIT(2)	/* Register access ready */
+#define OMAP_I2C_STAT_NACK	BIT(1)	/* No ack */
+#define OMAP_I2C_STAT_AL	BIT(0)	/* Arbitration lost */
 
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
-#define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
-#define OMAP_I2C_BUF_RXFIF_CLR	(1 << 14)	/* RX FIFO Clear */
-#define OMAP_I2C_BUF_XDMA_EN	(1 << 7)	/* TX DMA channel enable */
-#define OMAP_I2C_BUF_TXFIF_CLR	(1 << 6)	/* TX FIFO Clear */
+#define OMAP_I2C_BUF_RDMA_EN	BIT(15)	/* RX DMA channel enable */
+#define OMAP_I2C_BUF_RXFIF_CLR	BIT(14)	/* RX FIFO Clear */
+#define OMAP_I2C_BUF_XDMA_EN	BIT(7)	/* TX DMA channel enable */
+#define OMAP_I2C_BUF_TXFIF_CLR	BIT(6)	/* TX FIFO Clear */
 
 /* I2C Configuration Register (OMAP_I2C_CON): */
-#define OMAP_I2C_CON_EN		(1 << 15)	/* I2C module enable */
-#define OMAP_I2C_CON_BE		(1 << 14)	/* Big endian mode */
-#define OMAP_I2C_CON_OPMODE_HS	(1 << 12)	/* High Speed support */
-#define OMAP_I2C_CON_STB	(1 << 11)	/* Start byte mode (master) */
-#define OMAP_I2C_CON_MST	(1 << 10)	/* Master/slave mode */
-#define OMAP_I2C_CON_TRX	(1 << 9)	/* TX/RX mode (master only) */
-#define OMAP_I2C_CON_XA		(1 << 8)	/* Expand address */
-#define OMAP_I2C_CON_RM		(1 << 2)	/* Repeat mode (master only) */
-#define OMAP_I2C_CON_STP	(1 << 1)	/* Stop cond (master only) */
-#define OMAP_I2C_CON_STT	(1 << 0)	/* Start condition (master) */
+#define OMAP_I2C_CON_EN		BIT(15)	/* I2C module enable */
+#define OMAP_I2C_CON_BE		BIT(14)	/* Big endian mode */
+#define OMAP_I2C_CON_OPMODE_HS	BIT(12)	/* High Speed support */
+#define OMAP_I2C_CON_STB	BIT(11)	/* Start byte mode (master) */
+#define OMAP_I2C_CON_MST	BIT(10)	/* Master/slave mode */
+#define OMAP_I2C_CON_TRX	BIT(9)	/* TX/RX mode (master only) */
+#define OMAP_I2C_CON_XA		BIT(8)	/* Expand address */
+#define OMAP_I2C_CON_RM		BIT(2)	/* Repeat mode (master only) */
+#define OMAP_I2C_CON_STP	BIT(1)	/* Stop cond (master only) */
+#define OMAP_I2C_CON_STT	BIT(0)	/* Start condition (master) */
 
 /* I2C SCL time value when Master */
 #define OMAP_I2C_SCLL_HSSCLL	8
 #define OMAP_I2C_SCLH_HSSCLH	8
 
 /* I2C System Test Register (OMAP_I2C_SYSTEST): */
-#define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
-#define OMAP_I2C_SYSTEST_FREE		(1 << 14)	/* Free running mode */
-#define OMAP_I2C_SYSTEST_TMODE_MASK	(3 << 12)	/* Test mode select */
+#define OMAP_I2C_SYSTEST_ST_EN		BIT(15)	/* System test enable */
+#define OMAP_I2C_SYSTEST_FREE		BIT(14)	/* Free running mode */
+#define OMAP_I2C_SYSTEST_TMODE_MASK	GENMASK(13, 12)	/* Test mode select */
 #define OMAP_I2C_SYSTEST_TMODE_SHIFT	(12)		/* Test mode select */
 /* Functional mode */
-#define OMAP_I2C_SYSTEST_SCL_I_FUNC	(1 << 8)	/* SCL line input value */
-#define OMAP_I2C_SYSTEST_SCL_O_FUNC	(1 << 7)	/* SCL line output value */
-#define OMAP_I2C_SYSTEST_SDA_I_FUNC	(1 << 6)	/* SDA line input value */
-#define OMAP_I2C_SYSTEST_SDA_O_FUNC	(1 << 5)	/* SDA line output value */
+#define OMAP_I2C_SYSTEST_SCL_I_FUNC	BIT(8)	/* SCL line input value */
+#define OMAP_I2C_SYSTEST_SCL_O_FUNC	BIT(7)	/* SCL line output value */
+#define OMAP_I2C_SYSTEST_SDA_I_FUNC	BIT(6)	/* SDA line input value */
+#define OMAP_I2C_SYSTEST_SDA_O_FUNC	BIT(5)	/* SDA line output value */
 /* SDA/SCL IO mode */
-#define OMAP_I2C_SYSTEST_SCL_I		(1 << 3)	/* SCL line sense in */
-#define OMAP_I2C_SYSTEST_SCL_O		(1 << 2)	/* SCL line drive out */
-#define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
-#define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
+#define OMAP_I2C_SYSTEST_SCL_I		BIT(3)	/* SCL line sense in */
+#define OMAP_I2C_SYSTEST_SCL_O		BIT(2)	/* SCL line drive out */
+#define OMAP_I2C_SYSTEST_SDA_I		BIT(1)	/* SDA line sense in */
+#define OMAP_I2C_SYSTEST_SDA_O		BIT(0)	/* SDA line drive out */
 
 /* OCP_SYSSTATUS bit definitions */
-#define OMAP_I2C_SYSS_RESETDONE		(1 << 0)
+#define OMAP_I2C_SYSS_RESETDONE		BIT(0)
 
 /* OCP_SYSCONFIG bit definitions */
-#define OMAP_I2C_SYSC_SOFTRESET		(1 << 1)
+#define OMAP_I2C_SYSC_SOFTRESET		BIT(1)
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
-- 
2.39.2

