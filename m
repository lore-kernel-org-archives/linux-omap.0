Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D533A75BD;
	Wed, 30 Sep 2026 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807727; cv=fail; b=KvtSttGOAZwENIEEL6rq1BHb48n1peGxeocONFfD3ntv4B2LlVCeNRqdWqk5VFE5Mk50u1bUVkY/bETaCIjqOha/UeF0tCTAvia+ea1weGd9npUuOusGOrXUwV4WnV0eI75ApMM4ZnQ2c1yGZND9kln6PlRPmbTJmZi5Tdhx8iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807727; c=relaxed/simple;
	bh=wthCmIWSQClCBaOJjzhuPAZPLmb91PcfIPBtG8sI1oc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbS1RbDSwOJtp7GzLUz91bDqoxU1YtbU3a6KUspT6nhtgp8zXBx5tAqhks87hYSBPzxxgeX13kjRmX8zyLQJqqqU+328hCgdUIW5OU7LANHe1fhZyf7c54f9vXx3Vl9thmNNuVyUqjKzyuqAGsxoQlFIxZh2+sgBV3E9ER6YQjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ECzJCL8Z; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=Z9FIT1rr; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ECzJCL8Z";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="Z9FIT1rr"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UKkImo3825922;
	Wed, 30 Sep 2026 17:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=dVmFnMSIMeoCU4qcG6WqOjg3nVWko/V1JWWP4Nwo3
	D4=; b=ECzJCL8Z9KIttA+FGROmZOPxP7oJG9woh/0yQy0lhx3fYSVfyEUFaADlP
	KodQvLHGhSUWzrOMcpqVdBQjVrvyjyAbSMBjJZbHUQc5PP051opdx69sFbKObQt/
	4eBlCnK7D8OKmR8rTqZQO1gIAmX921+wZkxo/y+Lf3gzeaB89nm35/X+Cucw0Fz5
	peOhxJMeSgFi1fu8p/vxrre3Rikp/98EvYthut+2hpDV3q2CfqL//axjHw4Lr/mY
	sPh0QWHiXXdMnvATgc5dVJK1Z2TvqR+UQfBteroIm7ohB5B+rVuNxRx+0bbZg5xv
	gstFkKox0Ms9I17TrGhNC68msPo7g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h17djs9ps-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPYMD3C2KTdQPqyknOBRNPvjR5kxKs40fhAmDeunbopQik8ylakHH20LgMoeJUtnb3+QfZGugAx4KR1aqwkQkiRTnqCzp1a7Qda3wfIrmlZZvHJW1z2u8n8yDYkJJjYXa1pS2beGkqxifMlgsc6fzQfDTu5XRu4dGh6TnHrEyxktyiSJFhkRYOdL9wb/CbsK3UHMD4qBa+fjEsBIzTa8VBzug8IAf2TbhU6sYgMwSQZV/4wxSZIW9DijaOJGN6eLr4/W6GFBHW6lgWcWIchYxXOErDcCKD8hmsAlY7LHTPs7H9FMTWWZ1jLIRUyW+cvex8lQeSK55gNQthfrHSRUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVmFnMSIMeoCU4qcG6WqOjg3nVWko/V1JWWP4Nwo3D4=;
 b=AnwZtby3ID0pddcx83R1pgqnMU3XnoRD5K+Wwtn72UVI43DWnDg9B8xEhd3CfaYT02rDtlrhgb4tRi5fI8OXTCuIf1k4tjToHmOs6pz7BLQUPO0K69eGJHs2kykRWNYgJ79e9mBkq6GQRr5a6/wy+Nn6+jeiyEYvw2oXxM2wwYg/HBtvd2/d0SgFt9v+eqLnNpedxGE4PbJ3lSEFc93pj3bpMo13k03V4bnmSuz0E5QGXjjFMP+SiEXJgZkUOKQyoWQP47Z/bPs+0iIwG9JCp+7gPffyrCbd/0pojtze8PVxR5HtFtKAUm0TOAYi7AjdQV/YMnwIWRtkwglIfxbEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVmFnMSIMeoCU4qcG6WqOjg3nVWko/V1JWWP4Nwo3D4=;
 b=Z9FIT1rr8V2AYl6YsBZfOKgyL+a05BRnauYH3VAZLCbMJs/jIIpVrGNnhiN43IzLI4+yt14fplMmE3WRFygMPOrmnh25i5WO1VfVZnOV586lu9bYvFjKCIr+cOahKQv/0U6zC8NTztKL7WdGASVLjP4Ye2ZAYLGaqCmdTJ+j/VQ=
Received: from BN9PR03CA0398.namprd03.prod.outlook.com (2603:10b6:408:111::13)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Wed, 30 Sep
 2026 22:35:14 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::1c) by BN9PR03CA0398.outlook.office365.com
 (2603:10b6:408:111::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 22:35:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:35:14 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:07 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:07 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3U03969567;
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
Subject: [uL RFC PATCH v3 8/8] i2c: omap: Add OMAP_I2C_BUF_{TX,RX}TRSH definitions
Date: Wed, 30 Sep 2026 17:35:03 -0500
Message-ID: <20260930223503.616776-9-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|BLAPR10MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5e4345-2e45-416f-4d05-08df1f4318a0
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x9fQKkl8y7Wxr5ClnCjV4lYT5ZgYz9ZADL8OUoIy9kADjcRpFH6YL1+g186qBf2of841PXxr4MGJ0ymt8SQujX9IKFhYOBfpjm3n60w7ye+5cE8bNjuToOfHZq07o/oaCrFadT62CEfU8CcCP+eMw6cGaT1OvF3VbaANurZcudeuYRNYr9YcgCQS8b7/I2k+tzUM+hjlV8AvY5GpOUxXUDD4jG6MrBUvvwDJ11jBJti8EBCEnJk53qSYh54oShSE6bDQiU5QbnD/iSXd+21hy3kQEHK353IwNJmFDzY+TSUQyzNAMdq1CHi5C2GktGPXXvB+agjhZzGJGLUwf/a/s6GDUWrp8kogxwlOiRNlpRrpSonRsu57+MJ9UiJ8ijT+qaTUQJQ6JIYvaeBgiUzN9Zg0YAYZxgqWS63cgs4Ynr0q2SRy/NET3qJ4klSd8ljMnuD10gOmSRwtbDbSqSLS7zWUoLeL2Fu3JlkZE321C+T4B4DI4+phpRBW9iefs/4l7oq8gbarv2Vaz3p22rdScCcsk3jY32u55bRGtQtkYoYyx4eRGeVH9Ca3l//LD8ONf0Y2HWbgNqg0RJoDyk6enr3iY9HyhGt6E7p9moP+xlYGDpLttTvgoDAypGxdRiqF5yLyMPNSqnSRezcvmrxf26/KzwDUMbEP+rFPSGvmBnX8Sy1Lgn0ZEcKI0/qjVFgjwS1UqFIvILuysPNNY2vauA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dS9nVFsQNob53s/KZRPKshrlycflxxrJGsWNLIzFEurjfwOlj9H/mb+W8qI285LQ7+a6a1/0cF7j9VAwqBMyvx7H6n0IpqstP7c+/6zvApnmLCFwDzqDlzkmkq7rSZCGJ1R0xI7g/i+n4XHW9QERjMoAf1KP+4PKXfFkmeJJN+a+X7PtrKAZtxLG/xakzTOnDk/hgh+kBkQeYE+FjQTMvPipcugCgQs+wHHfSqYvJOmxZbKmeDhcompnXxPW4CTU+dfEesDHISJMPOGo2FpItlOZfHTwxWSsuxRVJOYbRPosRgzKu5pewmBnhu/3Zp5zEqEGVjwHta5XpryEe1KKPn4TBKAvpnMBdJFaClUO1LX4gAbnZSVsZ5ddiiGDHJcTEL3Tr+6iL4vZakBc4NvOc7PeYzb4AueqQ/5OZ61hHexbno98Nr+dfeRQtG1+rL+R
X-Exchange-RoutingPolicyChecked:
	t7yO6GyPNzZOyzX4iDtZuh4FvALIe2kDG7TUNPJM8n7TNOb1FhPzU2NMCmsaKFIVmeBZsCzzisDouQ7h3rlzsmWi5erRv6cI2nuLs89kGZl5IWWHk46pQxPR393u2xZGoZs7Rc10yydNdcvl9CdEEz+6ZBwth6yhUS54yhtxEIzzvn7znt2rilQei0eaOCtqOkS0i3ceSpD9845+1SCJomVHUhUzIIbYo8Rc5ufTMsH/yhimPtpaTuV/i/mluNBXBHrrfEveMkMXtb5wDygRyYJBNEFnxDu98VuOlkp+MsfuaQsUKbZiRvd1n4Vl4/JGlesyf2iFIHOFvg286tfndA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:14.5145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5e4345-2e45-416f-4d05-08df1f4318a0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-GUID: AD0g1Ed_DhKdDhtOcER31ninZ04olanK
X-Authority-Analysis: v=2.4 cv=aswnmiZV c=1 sm=1 tr=0 ts=6abd8ea4 cx=c_pps
 a=qHW1pi9L+1RZ0SKNcL3CYw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=9kDT9J43iM3-Rq2zlG0A:9
X-Proofpoint-ORIG-GUID: AD0g1Ed_DhKdDhtOcER31ninZ04olanK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX5XfEKFff33q9
 addvttATM3oa8IBE3Rb4E/4zk9UH4uxgyrIDm2TKl6VohIyqbZ5XOkNvL6TwbAW8Gb0zYrzOuU7
 QThxkNLSG4Klnsf5NmSX7x8N18Ii0BQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX910V8dXMhNDf
 ZsoyxHpSr+3ZKOVAQkd6CXq/mQM4GQd6DmcJqdoNgSU3egDUGIuYW7KHV5uAaV+fmBJZ0y6SD4+
 Xfl22BRggSixig3gNrl0FuWTbutJ+Oovd3o3x6Nf0yPn7/WdCrThF3ggG4Z3gPfUYayKkak2c92
 /IB4S9uElfLoqOwGDMIvPd1Fgl82JgFO2QPBi2C2OPKHEo913IyN3mgbZLI1uXgw2gvlb6bir/k
 pMxJk3uDvuzZ2V19MzdkFp/Pjf89hFwiBsdBJh8bjN2+q+1u6B+qnJRCPF84rTBiYH2Ei1/FwUT
 jQm4Orcvu6/l4qrhgnXPZUluKbLYLhmWvQH3OEbQbOzu2YbXY+jVVc1zAXOhomgm3QgW8fPoPo6
 1do6lSe6cRwkrNZSw9K+R1TR1rRIkYikFyLPuu6yB7kAPKPgdYLjYMlAxo9RcOkW4Ousqsm+kwf
 gxk9LDjdwJFkeBrYZsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

These were just magic numbers before, give them proper definitions
and use those in code.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c83f6a4d4b097..fd92fb75d2025 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -31,6 +31,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/property.h>
+#include <linux/bitfield.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -97,8 +98,10 @@ enum {
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
 #define OMAP_I2C_BUF_RDMA_EN	BIT(15)	/* RX DMA channel enable */
 #define OMAP_I2C_BUF_RXFIF_CLR	BIT(14)	/* RX FIFO Clear */
+#define OMAP_I2C_BUF_RXTRSH	GENMASK(13, 8)	/* RX FIFO Threshold */
 #define OMAP_I2C_BUF_XDMA_EN	BIT(7)	/* TX DMA channel enable */
 #define OMAP_I2C_BUF_TXFIF_CLR	BIT(6)	/* TX FIFO Clear */
+#define OMAP_I2C_BUF_TXTRSH	GENMASK(5, 0)	/* TX FIFO Threshold */
 
 /* I2C Configuration Register (OMAP_I2C_CON): */
 #define OMAP_I2C_CON_EN		BIT(15)	/* I2C module enable */
@@ -602,12 +605,14 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *omap, u8 size, bool is_rx)
 
 	if (is_rx) {
 		/* Clear RX Threshold */
-		buf &= ~(0x3f << 8);
-		buf |= ((omap->threshold - 1) << 8) | OMAP_I2C_BUF_RXFIF_CLR;
+		buf &= ~OMAP_I2C_BUF_RXTRSH;
+		buf |= FIELD_PREP(OMAP_I2C_BUF_RXTRSH, (omap->threshold - 1));
+		buf |= OMAP_I2C_BUF_RXFIF_CLR;
 	} else {
 		/* Clear TX Threshold */
-		buf &= ~0x3f;
-		buf |= (omap->threshold - 1) | OMAP_I2C_BUF_TXFIF_CLR;
+		buf &= ~OMAP_I2C_BUF_TXTRSH;
+		buf |= FIELD_PREP(OMAP_I2C_BUF_TXTRSH, (omap->threshold - 1));
+		buf |= OMAP_I2C_BUF_TXFIF_CLR;
 	}
 
 	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, buf);
-- 
2.39.2

