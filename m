Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7C49365C;
	Tue,  8 Sep 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882193; cv=fail; b=mdxWTT1seZp3bD/iqt65ENua3XfhE/NXw4bXAT5RXS0vztEHOPHg444vDvm1Lv6xNix4c6z4ysLm27gUzcd1uojULYaxgT5qJh51pF6I9WJpPIjyuBCaohueEBb1VuGIEHghChTe37XYA0SFiYx06trwtC8hMRszmNSzUhFcvEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882193; c=relaxed/simple;
	bh=ZrCc1gcWNacZb+POfeYK99JH79xugcmevydTqlbdg4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py7qgrWP/VlIMD8kCyXIr/dicAINusHHbvb+WVUQm0dsy07rZq90dCzHWfhRkoIvTfLisTf9aYyHnVZnYv992skfqbmq9FPHyH1gyGc/DMXGpCN9cEj5calyZ3//PUbpj9u0x/KKdpJMpt/Re6aL2N4v/33G9UI+nrZxQAb3RPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=RRh1cgr2; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KEEvhHGX; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="RRh1cgr2";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KEEvhHGX"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688ElUBf1845098;
	Tue, 8 Sep 2026 10:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vPwoOeeVYXkOm95zJLw/3AUi6/evQS2lJN6KFGBIc
	HA=; b=RRh1cgr2fNzhH+C5j4f+gr8F3ADV+H9+UpUhboxH3BUkLd7xKXPvoJVtd
	jjukV1RuT8CnQs/mFdJMn43eMpXo5sqlbPuVWLSu42rj34fWDeFfzQv44SaidqrI
	NRQNPYHMfzkMbAxNip0zW0Nu8o5/gWxYBDrH7j8BNI6L4ARkPuzjfIpteVmm7AGA
	8Og+1VNsIwOj7VDcytLbopV4/HShFCIg/0fz7U5W2k17zA0XqLAwn51J7XE6liJm
	z7ptqXwvHkS1jVE5e1k7HrFrByNkk7MEYxAYKgRk8t7AxyA/wft1DXZs3xd9O0+N
	wnYMMIL3xYBWs+vNqjan0D4GuH4Uw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940mxyu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:42:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3Ro90SBUYDV+oSrEpN8zta/vPCwlH+u69JqcpOo2wfPGKKIReki+tW81ly6juNNn1JbEjyLtZeYAePZb0+raluHLk1giX+ZA2Onvw68/YLyCrra4yci0mbfAYeJUPWyELPnLPdh5dtbdbXzXU+VV3GZvFAmagkPgTM0BdXYkDq+SOx2ZlXhEFSgMuInpueEaLU3ucUoTSB7zh9D7Ko/4VkwMmvAclG8RHekncVDXfuv2dDHRlHiDMt6Ag2N5x2xUTPrqn/ltr2fnLmbIoPGSXFFeytS8RTLaZGKOjuhOS9gTr9g2+FnRPdNg7uRrFduy+9OJLWfs/B04g3X6ILGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPwoOeeVYXkOm95zJLw/3AUi6/evQS2lJN6KFGBIcHA=;
 b=y1BhafDU948wKb34BUxHAWpKSC54tOzGuSlA1kW7TtRGn1YK9san0gkq3Fz1n2EHZDxDGq4Qmw7I7p3i12kZTf35rbbGatxULRgZy7Pmz0gPVUaJf7MRY3UFFVuEo42SWJhp4vUsZ7GRwEynonqC7oOtcqi7hkwa8O8jIcwKmpMJgFrjligTzXqCxhxSzcyANHw0AXVoQY0lnJQHe5bdajupBeDmLBZAfV9i9u6Yg1RPQiFRf1mIUjm+ljnKAnp0MlUGBVFBYN019uBnrYllWpddsbWT/5sK4YHuBKf5txKZz7z7pxSSMf2xC4DUgGKtSDe/Nf0dkMWT+JT14xf6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPwoOeeVYXkOm95zJLw/3AUi6/evQS2lJN6KFGBIcHA=;
 b=KEEvhHGXOpD1vNE9LBGiA9jcmx6lIk6WNzni7HomN9VrHuqzND3bwPi8AnRGfWYLbo+0TP6OCtu6L5Ju57xukdtIDYq17kMEkNM4JjNvD4tQh9cCbqFnp7G6ff/3LYVuDebfG4VGvWtqDNN3TUb6g1gtn/fAviM/CCGzSSaBb9I=
Received: from BY1P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::15)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:42:39 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::7a) by BY1P220CA0049.outlook.office365.com
 (2603:10b6:a03:59e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 15:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:42:39 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:26 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:26 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWf3725209;
	Tue, 8 Sep 2026 10:42:26 -0500
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
Subject: [PATCH v2 5/8] i2c: omap: Use bool for flag values
Date: Tue, 8 Sep 2026 10:42:20 -0500
Message-ID: <20260908154223.116074-6-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d65466-454f-4d62-4c35-08df0dbfd06a
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AU1SWpr9OyrXCYMU/tSMwfJmlh+2/tZOf6R0ocVOedglgyg+fcATPXKwSGtcYXAvNDPLxri47Dvysw4CpVeJKAMUDyMytwuJzSKM8cmPclK2IUdzPPET+HmGVcNERsxs8vO7y4W8LLUR584fR4MrEBAIx7Engh8d9X+lIiqQGpmcEeBKXlInry9DHw4FcL5z9Sg4fZGzBOo6AESOIEULH2/jMLyOe+MCZbjn0QeUNB6NTrqibmPDyM5WqSz4Kl8XN0NN67y76Ai5p/XwLf3hD39lKUmT1v2KQzJH2Fz6lBRR8LwWxiaroIB3ESyU08MOfqHeigZrxbLvPJdhW2s0AgDMisbfO3QPFEuuNyNCU4qBZ5TL4HQ6IUu4Fp1Jts8S1do4OZnDpeTDGBVzVqMKZQX5Md0x17+MAC8q6WABzuQEwyTFla2ZBHUtoA9dNlj3MONdi4qihs+6au2SG/fqkmkWDMpmI3oCJdew/EjQ7y/2OPf2UhnJWut9tojql3NunQuV+o9vfPACb0Thaq7Dkmxy4GWFLzUN6qTcQ8QpX/svP7v7E9ArDytk1M+54ib4IanYxHP9Hoa9q8FVfcViXX75ng19G8MgsGyMriD6GW0btfjEJINID4e2DPfcCGNIvA626Q4l+3+hzTdZbI+eRa0udCO8lmVpdUYd2Ayj5LSGKAKorETHOQiddhu8ycg4TpQYY36+W9L46IJUENVvRw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pt/xYmLS55CRWfvnlACWDL0QeN9ATpVRU9gffReNGFAujMydaXumM7BES9B+z9J7Cek75xmLU7czfS4LYOBcDexOCJeujl6mweVupBo0CTxvlQJfqjaFn5pMQC/b1Sx6qiPBUqa6D2atw6e7jxFk28/JEDZgl2cvTogG+8ipHUPQJ3D8S/SQdrRYB3xHwBVyIu6r9a+wo+nfgQlaR7NR8Lt+he0jgjwkYU8V4YjMasDLPg4+kB0wZb2QXkmZMDvi6T0xSL/R4UVNzULXyaVvWacQ/kIFdq+napeCFng+Zkow6EBK2+PanAP6oh4MYgZX8bd6perAooO1j1lR1i2ItUfsUzQSBL9GD5SxzBnfCTR7EOukwUH0y7nsQDXTtfBgZhDIaTcCahAtjRETJF0rqEibkHScV2pG6nl0l2zN9E0zAKnvrTxtXCHtUVcjgLhh
X-Exchange-RoutingPolicyChecked:
	M+PNRWciA6d5i/8A5TvreAbnni/zQpH77r+5uSjtoZ9QC3Nck57TQKhylLHsEDFh9CgviM276v3HmrOuWLD2HPgTyO3Ui4c0BsgjEinvxS1hREVVMKqZtblbNi/0o+KRXXpwGHXMmAJS9wPIKENniAcQh+4uBibVQML0xLGRqxHivGLz4O9bz9s1Q5XA/7UZ62jPUV20IWoeqlOkq3inelmpMaJTEjgNdO409eyHeprbXxImpA2COEsu7Plan1xT1/puNP8JIztvXiM/CoP4omOM8EiOw3lxkVAXSkDOJJFiwSi2T6ro679ya8GKlf+4efvXDYZ0BxHN9IgSpRD7Yg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:42:39.5762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d65466-454f-4d62-4c35-08df0dbfd06a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-ORIG-GUID: utOXRxPsb7T6KvFOpjsUMWxxJXVbvOE7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX4uAB4/7rCFkv
 LJyjI3uxzZdp+5I1quyS9EQCXnY5o0wqdR128JX8NUQpzE/OZZBPzGaDokSIfo+NCchC5BDY6ew
 kzUWl+KxFXEEx6wEoT4//QxN/j1aHUmKZyNcnxC2WEYLtY+7adgWT1Dp6vf5RMG0FcxRsIAHvaU
 jxVg8arOfXJdesLIRQQAS4r6WrDc0EQ2KbAsd3WITvG414ckdgLcfNUrJZwpTGGVcVYVN8AUTFX
 cT9yzmpKVKG+BS5wZF8miDCYstmgP0ZTevhdCTg+GTrxcxYgYVNukKTKX8UVVSIXFB00NpEOqpA
 KhN1qfeOJkii8bEY+A5EX2CiOgM3/bIHwoLKh+kQxzVhAeaX1OGo2hdPh6lh8GByEkXq3IGwQKZ
 Z2wSxvTCCb5ji4hmdg0dZvIgpAc20xqWXXubXFm6XbydidQeO4I+E7/w04dGwozOdxWT9yiypm/
 /uVT8uxdIAUMVh7p3lQ==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6aa02cf8 cx=c_pps
 a=4Gx/Bq66bxzCWlClXrtOjA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=vVWVvIjhg91t4kWa_skA:9
X-Proofpoint-GUID: utOXRxPsb7T6KvFOpjsUMWxxJXVbvOE7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfXzCjcXOv6KdCc
 hy6Ozpv/e4RvBEFAlWVjXdhm7t3/d1obRm/jegmWm5GixIR2YT1JHW2v6BsZFeBQvHjFmrCV+Ix
 Z+1y+IRuxom5ItgIn2CwphAoiRJJCnM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080169

C bit fields are weird, use bool for single bit flags. The compiler will
set these to an aligned size in the structs in either case.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index cc65dc90770d1..dc75780f76c96 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -174,11 +174,11 @@ struct omap_i2c_dev {
 						 * if set, should be trsh+1
 						 */
 	u32			rev;
-	unsigned		b_hw:1;		/* bad h/w fixes */
-	unsigned		bb_valid:1;	/* true when BB-bit reflects
+	bool			b_hw;		/* bad h/w fixes */
+	bool			bb_valid;	/* true when BB-bit reflects
 						 * the I2C bus state
 						 */
-	unsigned		receiver:1;	/* true when we're in receiver mode */
+	bool			receiver;	/* true when we're in receiver mode */
 	u16			iestate;	/* Saved interrupt register */
 	u16			pscstate;
 	u16			scllstate;
@@ -313,7 +313,7 @@ static int omap_i2c_reset(struct omap_i2c_dev *omap)
 
 		if (omap->rev > OMAP_I2C_REV_ON_3430_3530) {
 			/* Schedule I2C-bus monitoring on the next transfer */
-			omap->bb_valid = 0;
+			omap->bb_valid = false;
 		}
 	}
 
@@ -458,7 +458,7 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 
 	if (omap->rev <= OMAP_I2C_REV_ON_3430_3530) {
 		/* Not implemented */
-		omap->bb_valid = 1;
+		omap->bb_valid = true;
 	}
 
 	__omap_i2c_init(omap);
@@ -531,7 +531,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 {
 	unsigned long bus_free_timeout = 0;
 	unsigned long timeout;
-	int bus_free = 0;
+	bool bus_free = false;
 	u16 stat, systest;
 
 	if (omap->bb_valid)
@@ -558,7 +558,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 			if (!bus_free) {
 				bus_free_timeout = jiffies +
 					OMAP_I2C_BUS_FREE_TIMEOUT;
-				bus_free = 1;
+				bus_free = true;
 			}
 
 			/*
@@ -569,7 +569,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 			if (time_after(jiffies, bus_free_timeout))
 				break;
 		} else {
-			bus_free = 0;
+			bus_free = false;
 		}
 
 		if (time_after(jiffies, timeout)) {
@@ -585,7 +585,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 		msleep(1);
 	}
 
-	omap->bb_valid = 1;
+	omap->bb_valid = true;
 	return 0;
 }
 
@@ -620,7 +620,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *omap, u8 size, bool is_rx)
 	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, buf);
 
 	if (omap->rev < OMAP_I2C_REV_ON_3630)
-		omap->b_hw = 1; /* Enable hardware fixes */
+		omap->b_hw = true; /* Enable hardware fixes */
 
 	/* calculate wakeup latency constraint for MPU */
 	if (omap->set_mpu_wkup_lat != NULL)
@@ -644,7 +644,7 @@ static void omap_i2c_wait(struct omap_i2c_dev *omap)
  * Low level master read/write transaction.
  */
 static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
-			     struct i2c_msg *msg, int stop, bool polling)
+			     struct i2c_msg *msg, bool stop, bool polling)
 {
 	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
 	unsigned long time_left;
@@ -684,7 +684,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w |= OMAP_I2C_CON_OPMODE_HS;
 
 	if (msg->flags & I2C_M_STOP)
-		stop = 1;
+		stop = true;
 	if (msg->flags & I2C_M_TEN)
 		w |= OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
@@ -1423,7 +1423,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		omap->fifo_size = (omap->fifo_size / 2);
 
 		if (omap->rev < OMAP_I2C_REV_ON_3630)
-			omap->b_hw = 1; /* Enable hardware fixes */
+			omap->b_hw = true; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
 		if (omap->set_mpu_wkup_lat != NULL)
-- 
2.39.2

