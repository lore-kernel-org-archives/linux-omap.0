Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC92566C62;
	Tue,  8 Sep 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882206; cv=fail; b=WwHrKP5CG+cH9+0amE55jmtOHr15PGHiokzktWTmmuvRt2IAMk0osb1aFoTJtHUgnpEFiBOSjXugr/0G74AvZwXJgHOrR88TzL2UkEzSO+6fBBuIVJgvJ5+J8wNseQeDUexi/BHVhlQwTQnS4Yy0/CrXcFyw4ERsPro0YK6KWXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882206; c=relaxed/simple;
	bh=LoHYzUm33+DhlSubiLgNm/sQPDqd9gekmtuKygzQ07o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMFN3UIYHlTKFVRrId+45WnRN6G1NHODDcw7FlhgMG/klVR4+y0XkQ2VLrijrfiKymeHrw/pWAVHi081OBfRw1VQszuHUDuVZedaY4SeQMmg4v6BqtS7pbOP+ukD5O6TcMDeH0oxqwzmDxFd/1pAIjUKItpuRf60nX8qpsxFYtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=eNbmuEsD; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H3BZtnzG; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="eNbmuEsD";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H3BZtnzG"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 688EjsxR2032914;
	Tue, 8 Sep 2026 10:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ZfAsMKRts3q8ehU1gxlKbE3P3wSPL4Yyd8AJfmA4p
	+Y=; b=eNbmuEsD30f3EuE04G2pwgYrP8ZGabliuvVt231Va/tlloRyAQ8FU1rEH
	aRwQ/2EyZPC4W7sTwWbaw8KMEfKGcgq93KqCVeAoPCMtDLW+4PjsOSG6KoSoyhej
	Hi5qWXJeBloVqzLtG/0oF7rX5TWAm/8BV533Q1tjHq4BafM0aR8VgmkKOOKKZnU4
	yrwp56plyaGSgynahoJ6Tuegwh++8kBm1yaAh6AWRZiiPPmDCQbLvzd8l8gsTNsv
	dJSgUoRLQsHhpwZSYhZze35jLtnxHZvgGVffpvn9Ari6KLxca92cU4RnNYijKZ9n
	+nhUlZfhieXik/OL5jeHor56dK2zA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gjffmtbgk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:43:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxUVLJ4R+uvzVk6oDvEX4iWvsVzVyUnzshGyjcqpGzeIeztuwr3Bx5pGsBvfr1fh4D01Tn5A01AjXXRFodJ0gH/I2iIiAz0v3dP91YbHLPdFYH0hnmsFEVqjEQCDq4UR5GAKKN5pSAtZhUQV6pEx/wpNcjhR47SZIrOwS2J6Uqo/M2RFXa45xetkd3TUGzSdmTTKHFq80axgEgBniN+VXze+iBmqB+mFe2DW5MbUofDY4g6lA7u8Xgjfq/p/dMl9QpLTXM0gcISnz9c4bQJjECkE6hrU5lBDyahr8xbn0ANSKqLylpcj15XsdSJcq04cA8+AjSKy80hWYh/R7IE5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfAsMKRts3q8ehU1gxlKbE3P3wSPL4Yyd8AJfmA4p+Y=;
 b=t7LE45jlBCQFdZp/U5oirsDfrZsWeUEn8K+SFEpR5lLeFXSroWp6S2KtNNO9HbeKcj74HG6eRt0zcd7YP76AHM8PuLI9wy8al5U2w0f82eCtsLyUHfb0luMl3gOMEBAZ3Hhy+S29Je9anfNj+6cF5Q+VukjxA3SdtL7p42aaCLzfg00pYLUWYmVAOvYqT+FoGFxnjRHdn7iGmeLcaCe3H/t+LjcKFefWbCPGHiPsUbCe9AXF69N3NY212yGyP/niNkdkZDjtArQUUabC0vr9udfwFykSvn8OYxhdb2PqsF0IcFFPG11S3QdMShJjIoaShnKUQ+7bWKMGMTKbw1Z+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfAsMKRts3q8ehU1gxlKbE3P3wSPL4Yyd8AJfmA4p+Y=;
 b=H3BZtnzGiECtgCPZH4c41yqTa3won0VhBSy/2vtea9l0kbubD4NeU1ldbOLzmx4BCR555fPphUUsxEd9anQjlf49v1d/TfUq/Bav7CL7B9erWEs46Hl9aVj0XJ+SrVb3RN31DZb4K/O0WKoCa9wtDVHHjuMLj1WNsQBVE9sfvVo=
Received: from DS1PR03CA0018.namprd03.prod.outlook.com (2603:10b6:8:233::15)
 by CH3PR10MB7307.namprd10.prod.outlook.com (2603:10b6:610:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:43:09 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:233:cafe::8a) by DS1PR03CA0018.outlook.office365.com
 (2603:10b6:8:233::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 15:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:43:08 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:28 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:27 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWi3725209;
	Tue, 8 Sep 2026 10:42:27 -0500
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
Subject: [PATCH v2 8/8] i2c: omap: Add OMAP_I2C_BUF_{TX,RX}TRSH definitions
Date: Tue, 8 Sep 2026 10:42:23 -0500
Message-ID: <20260908154223.116074-9-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260908154223.116074-1-afd@ti.com>
References: <20260908154223.116074-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH3PR10MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: b05971bc-fa9a-4c1f-af29-08df0dbfe199
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	APkPiA2xYY6EcsYtthvOWMicRazYnqFhiIOETF/6CddDTbC1z0orch5OJSO3lJzojBCY7gODk44R4kyu5YKGUrHBZgKr4QsCYeOGNTeOga2/3NPwrIabaAJwxah8jqSFLZ4/d8qAyEc52urz79KAjFwU5eaoG0btwXgC1lrM8h67QS2HpS5y9RXIMKgngf6S+TQx46v0ALoSpPNtz3Wv4vq1nZOnFQgbAFY+DoXWxqPgF8PVlWxMJIm8PZdrJIAh9tokdnQtK8bNw56cCFzdIC43LbcMNYJ2zerp9Pga4CbcO4MHZj9aUn0o5Ynx0NwTTgJp8YDJ1EpBgAMTffteIglr6p0DQ9u7R2dr4JBY0AU7jZ7hyBS3K1Qxl6kZ2GNaMOl4vMyNphhqw4Ck0ytsyQNJmHsk5iteY6P0GKLWXPOLqUrmBMSPCogfOVLgI0FveYInmgakd9FG/Z2MeScuyECNzFXFN5CVnUeRg7km33Ewm5BFZgPNRXYWrHnqxASGtgBVQpyr8m2wfAnNKz87NGPNjGytQCZmyQXyGfjc87AkYEbCas4GejOBdAFByC/rCzX1oeVhrEw2uAYD3t86I/YTDwFtvgIOwGbMpfwFD8JDUqGsBSt+lNdSw1gB+4JCoSy8fCXDMVNGweeqrx4yfZ++6tcQfmDEogqRQPT46+rDXLTa6q2/uQfLUOiFXzfaKhslBaXKWPamFnV0e5muBg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t1RD1/JUV3czFMKIEHPv+GLmQdS6lsYYVBcaaJbNrfQDz8EvKoakx/c74KVy8ezfhEpWR+W2YTQ9Tt6wyFUntWCzznaIDKlyxpaeAEbUvMSmlZYMaHspZ2Qzrp5naYiWWiC8T6dUVtqXf5egkyUNmp4rNmwnhp5333ebHtKrq13Q7FeAXFNbPgZPCSLrCNmSP6+e+hqYZhh9vludqenxE5/x95pPxXpuwV4/pLp8nLXbFdgZBYkKBt0zEqMX/ofufDKZuPcLWJ462XttZQ2WcIUvZK7abLqqmSMoGBmfKmI+MYsxtq80iEvxKM+RDSwha7sqsFPauaDftMPgydnta+/UVHsPlLrA1L/OU0xzMrlfawch8KnUYPjFAybYdjiWzR7ZJtg1Sq437sqOhaYzTwcYacLorWa5g67mKXyqh4D+FFR3A/oMjW8qONw1exO0
X-Exchange-RoutingPolicyChecked:
	hHlQKoN2vkSQIEdNYPIGyHUquaXcNwzlafhmyzzPO8SUYJ2/+os1aMhHw2DmMsXu3tOVrLubF3W4ezaxb1ZLB7TbdJG1RpVV38QuSAt5fmQB9AA6380ckDWoAVa8/nmRWJEN9MFvh55tgUlSSvsqjGldNebJEcej+ryEOQov9+/ednVEwixK68V9kzqIOL1IZP7C5Kw2Gm70JOCdAdu6/vk+APUoTGVkhW4hjTtMkye+pwYKFVybVX+RGoBqWBZ1udq9/DmXpTepXbdbOq15Xx2A3EdwccmY32l1ssNGWU4j53rlDkAn8d0aZy+do8rcOQZN78G/xeKXwOI1XZQfEg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:43:08.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05971bc-fa9a-4c1f-af29-08df0dbfe199
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7307
X-Authority-Analysis: v=2.4 cv=FewHAp+6 c=1 sm=1 tr=0 ts=6aa02d10 cx=c_pps
 a=r+591f3cnXeovruRxJw0Jg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=9kDT9J43iM3-Rq2zlG0A:9
X-Proofpoint-ORIG-GUID: jLO7EJyM5J3XXQDMKE0fGdOFCb0eFv1X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX56rDq4XiLWDc
 oJxTcGASGMmZTvoZAUx5Db5FPW/Ifyp9F/HjXAvMqHQtsldHbb8rEoxyPjSAeZYI9UEd7dYso0N
 9B6PdIWHCxsoUJQ3Q4tl3+OSTTImt9Sm9xf3D91P9g3B1WPUMI9+MomsS9elg+KASu+MaeAgnt+
 Ipo282qim4ntqFH+gJhznoz+LzXEpoz+fx1JhpQh/xLL5YsiJV3LANlZnGcnemEqYbof73BxSd+
 5I2+Z42pALdw0LUyx6xJzlcbuAqIYs7hRl3E4fxWGIG6Ivji4bPQHnjFFqoLWQWg5e6BgPmiOpM
 1CIX/CnAHIOFgovf1jNYchUpXf7RlCp/SIP3OAF3yMawOYaqpxfvKODjT5KllxEswHn22zBV8NB
 PMGtdKveuRckB8/oswVt7rZhHGEL6FwpIVop22bv7xjFJmc8j9GZqidLVolVwqlV/auNxVcDXz7
 /kK0jVOljJqnuDSwtUA==
X-Proofpoint-GUID: jLO7EJyM5J3XXQDMKE0fGdOFCb0eFv1X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX1fBodRzmT04D
 5KIoe0RXS3qwd2sLxqbFmLFQCWGqtOROd20FLBctHa4IxPr7c7q3raCNXq/aQQIdu8GelkqQREa
 iTQsgWU4e5ADCpK1htpSZe8+C/FAd58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080169

These were just magic numbers before, give them proper definitions
and use those in code.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 41464f92da046..e3c23234056b4 100644
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

