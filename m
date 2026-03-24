Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA44296BB6;
	Tue, 24 Mar 2026 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347285; cv=fail; b=mYyAFNlgD89pkhjZLKOw5UanLlYf6GnBrKX2TYMjMa8hncT3DYQJFeuoVNHl418Zt8anNze+yvrMn1kHWFBb3eYMTBkDLq1TIJD/rmPKD1POQHmkaae3VCw6PBgS92j5r+DuR+l2p+UzPCrbEMN+nI29gmEpaufM8oFaC40nW7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347285; c=relaxed/simple;
	bh=AYkUWsKea+7gqtiyFsVVW/ypw7xCd2qpJEO7DkNFYpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3wprghA9/nMh9ue4SVX3BKKA4Mo5ZxkrZqYtQ2Tz7k6iBEKc9nRSWglxiGU5dKFwbbDrBblfRKRbCRaR1LVJX2xyAcNa2reAHFzBggrEq0xlvJG8Wr4W2cpJtsY2r/ut1xJtOrrrYAu9cEdjInKFldfSOc1Fu3m5dKGfi6zDS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r2gWht6l; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r2gWht6l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGoy9kuevw8WpQ3Sdf8wuhNan4Z512EZZGNw58Xx9GDHzUnnvYB0RqzqOQLh1T7ZYEsf1FZyBpmc39arXSv1VyIwc9oMMOkRhUaerzkfbnYZSeBqYMbnJzY6btnL4O47ouxVRAPeF3ZZl3ZY28/jReQ1URDBv7zXzManE3+aRjdPqiCtRSU6lzRaIrgh1QVabuUmoKUqugqBpdKP4qo7rxJNCzKq4+++l0Pb0n8AwUn3DKsvRdZN+k6CUQjm/rHlXrgbvczB1qKbuDMOo8ouPXgTrXWnWhz6mm5F4w8qsHkmX2krnnxmGB8aTP+P0repo49THwCfmMHjg9HORBYzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLqsjdzmuooo7CLedHC7AqpuPSTNFUGZmAR0YC8RY7s=;
 b=h/kIneb3ZjJRa96doI+KfOI+cuz168U6aTNEaqjEs9NVq4/bvy4zU+kiEsZylvcQBZSSNHAQyZJRdCmCxHMvTsEnnJIfCxD/J3OBNdjhvpZSWjfgrt3BejS7baKX2VPZgpPD+HyERaLxwtNAIEfQZg9pcT+ep0B1yFSvzZUDh+6uHRQkNSSvGtehMQaBenYTGmmW0h/aZvOI/YZox63HZAjr3MMCUcD1nJmtaf0ylKBmEOaZTLK6MbY6NNLes+DHoUByV9Wvi5calbRG3v0161s7xB/Jnz+utsjeuSAk8Mr/KP2BBJ0dotMHV6xy9I3nwfBc61F6dGf3ZEo64uVQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLqsjdzmuooo7CLedHC7AqpuPSTNFUGZmAR0YC8RY7s=;
 b=r2gWht6l32Dp8C5NOVfkEZBLXI9rqO/4tASDSlkkXhTwd4ZBEcFh+thRq5A555Ma5U/W+I6nbiuNPexXxhbd3gmGHUCpTPgW/GjZhuGKaHeXdtY+BwuBzh3M+lS3lMxOBiASiG9TQpQEJAnDCeQLJRx++s5J7Yoe5dCffNyO2lo=
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by PH0PR10MB5755.namprd10.prod.outlook.com (2603:10b6:510:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 10:14:42 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::da) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend
 Transport; Tue, 24 Mar 2026 10:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 10:14:40 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:14:36 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:14:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 05:14:35 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OAELRo2446022;
	Tue, 24 Mar 2026 05:14:29 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <lee@kernel.org>, <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>,
	<vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <aaro.koskinen@iki.fi>,
	<andreas@kemnade.info>, <khilman@baylibre.com>, <rogerq@kernel.org>,
	<tony@atomide.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <s-ramamoorthy@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <d-gole@ti.com>,
	<k-willis@ti.com>, <a-kaur@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am62-lp-sk: Add system-power-controller
Date: Tue, 24 Mar 2026 15:44:18 +0530
Message-ID: <20260324101419.95616-2-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324101419.95616-1-a-kaur@ti.com>
References: <20260324101419.95616-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|PH0PR10MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: a41500ca-e3d7-4d43-178a-08de898e291c
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KYxH+jmUCf63Zdou9BdCxIGV+dC3ujQms3c4pN7VnnSRqd0Lwib4uWOZPbx8taAWHYqwFMj2Q4o8+TmzyHxOYCXU5Vqlk9K5BkpSdltATHa3hsDtNNlqqEjFBdxrOlAeD6DPDfszueOBbf7zB0AP01QHJNJFs1QctjoqaDVJd7tO93c9GgF3j62eKsQ1t1PNdtmehy06YcdIUGaAbaStDjVsA2s2WptnccgoK+k16NCDuutJjJj8eXlDdh+05KjJfmD80nt/IXSJckmU2J7yVr4uj0ht3ap0CRIunn9av+o03/XIg8zeWoN5KLfS75ycCith7+v3A9qi/exxzw9CjHK+7myZ9UyGGaDrCtj5fcnKnXAf8axiirT9978XN32pblWd8f7f9AGM+BZWrPo56PAHt5KcnowMevsM8eaq96CPk4qdDzuh7A6IXMKepvWvT17VrakF5Jjlm+gM14Um7Xj+GcAY+dm0EBVFfAV/Kx4TnMbp6cnBfnYlu+DOCWBfSL32bg2XynhRiLDQzBVrSOP/NAkHAulDgtju1Otmq0B9gDVN2A4HPZqkJV72izli2dh8xwpLXKGyXAfhm4Sun6sqeYsylfpq639mYSCDohfF8cI2LeYw3XqP5jjAgE7L1T9yY4hFCtPy0UuMuRuBTx8WSEdGEx4IsWuDp9eEtTugD/4omRI1oq/8p1aJssLRCYglcEqLrb9X20z801kKk+fD+L4AGcKNpSg6IjkC6TeutFv7bl3XQediDELqGRUPoO3MqJDb8iOIpWE/5FWJpw4Pj9TcXnsm7rQhAPPJTmUIDy//9X9fQG4alNqJAU4h
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5BFg5kp7WW/umumrYzQF7Th+1EKPJ1c4/MNzG1ro8NltGhccIoIWYBfa3OBxoSWDWHtIJff6QZXYLceDOy+TXz2xelkeqrbFWAbTXTBIA/JSxBAGAtnbagNH05/lCBWGJ3Q5GULZO06GzOIXxKdKUxkYAG3W7Vz2gHV3AxB4aiQ/58d2wBBL9PWWVT+yIzmTwVNldYCOrcUXBvWk4jP25Ygd5LtkmXSY7P0iOeGqlnDPEUAWT2TETyyLXe6T3QmRW4PK9Jg7TeYG8tP1OckB55Ny4/AI+UsTjk42wGKoLY61UWXD42No2op1Ph7jO4WNqG6mEiph2xP6g4kExulkw/Pej3w4NqEC8pC54hfinCwnc5q2nh2QnE4Egmculfxq3A7LEflvL3HPwAg2Md1IuA3Spz+pTno4We2ZEZvtO5QzNRMnlmf+2ZCRCQHEgbw6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:14:40.0306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41500ca-e3d7-4d43-178a-08de898e291c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5755

On AM62-LP-SK, the TPS65219 PMIC is the system power controller
responsible for handling system poweroff. Add the "system-power-controller"
property to the PMIC node to explicitly designate it as such.

Among all in-tree device trees using the TPS65219 PMIC (verified via
compatible string), AM62-LP-SK was the only one missing this property.
This patch corrects that omission.

This property will be used by the PMIC driver to conditionally register
the poweroff handler, ensuring only the designated power controller
registers for system poweroff operations.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 3e2d8f669535..786a7d695b33 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -206,6 +206,7 @@ tps65219: pmic@30 {
 
 		interrupt-parent = <&gic500>;
 		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		system-power-controller;
 
 		regulators {
 			buck1_reg: buck1 {
-- 
2.34.1

