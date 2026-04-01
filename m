Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39773DEAD8;
	Wed,  1 Apr 2026 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042605; cv=fail; b=TUYvZu5+JarHCjdcjK01R0dpYZ73RnvrXt0B29oFjjHELzqE/E82xzQTzeLyf6jPWAcsNEPcZIXWHLfiWQ5lYbbiY6/NenFzenxSCobK/Uhf0yxwwk/I/dvfzaNciL8hQW0ny1SqPv8SbelOWKbDKuNLoXQQ5rtfhxDhqqGJ3iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042605; c=relaxed/simple;
	bh=oI196dXfbbjUeQav4zfRStxuA0FqwhmbeNMSZ6slmL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjrRieLMK+kczcZ1UsvPoWlw9iz9orDhuq4WmB3z1GQL4EObr7QBtDL/bxwVmQA+fBDT4Zg7P75idjbRfhdhMyoPuWvugvMJTDpVA5A3/HjCcdq9UpwtXTybrn7/tqOBtSGSFkPlgMt2Z54qiWZWKR6aZTg+54QQ1LR/o4D9h0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sS5GqRHg; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sS5GqRHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui0MThrcpTSiKpISp4BqmCVEkpxPXFNSFiL2C4F1mprpriNyYgvZ+WDMUaHbZ47vEyDNpggw6XjNllQVGtvkGfoGEzBc8gtmx1ynRn7jPHuZx27mfyRwTVtz2YTZmGee6LB7GPbHx/GCN5nHV85lNu1AytQk69b5tnWjxZB537NwM1HA4g6INspFgBo+BwRYTHMtxzgFHonaVh+9lbgimc/7MtHCxeDPXxhOH3Y+HIO31gBawJA6hIliIRGkH9hL1u+4ybQXxvNJdem+QG6jEj1IXP2r6zJF5u4z5KnAbaQfrOiLI9R8YWs13TaDGRsiI/AzxMyftWL74Q9HrzZHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OERL1EVw3pm57LyHGeKaI02RaVDVsx5RDTbYHes6KPE=;
 b=bD5xpg2GttlBBg3mkUJddpjWzKBSC4RqSu4sxLZYD3WM7tZytoEF9jp8wMAADF88Aeif5GU3n9iUoxRw7DJQVPozfaa4rVGzEpNE2RP3/49l2IbrCuEbMnrKO2GWmF/1dBMmVUJ+hlDdq2aKAb9G8L7LGlh+ay6lPmv/HNAdfa4ot7N3rnxB58k0YMxYDxB52JzD4yvhVtyvS6W8oE+MDEgaCG8gpqvH+k6p9Ye8WHIVX+n4mpOA3m7b+0Ub0Ve59NGl81fb+4CADPC5g2kxSe4OoQYEdS8cCsK25pun2iulJ+fLhpHmMBpaLgQaMUej8xDBtD5JYN7XIw9iuvtt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OERL1EVw3pm57LyHGeKaI02RaVDVsx5RDTbYHes6KPE=;
 b=sS5GqRHgkltE4TyTPNQ3P+Eg1yia5S9y+o4ZWFW9ILK/nKpqFjkcJMHcpF21Ofvuo3z8EJfWZHTcmFdy9SQM1UMGrKMUZea6C3p19ATCXGXMhdNDIHTKchihB+RXHhnXHsoJhf389aIpLn9d23Qz94uDOsKgcKIbTkHKBtGeX1g=
Received: from PH8P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::17)
 by SA1PR10MB997739.namprd10.prod.outlook.com (2603:10b6:806:4bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 11:23:22 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::15) by PH8P220CA0011.outlook.office365.com
 (2603:10b6:510:345::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 11:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 11:23:20 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 06:23:20 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 06:23:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 06:23:20 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631BMxFG4170925;
	Wed, 1 Apr 2026 06:23:14 -0500
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
Subject: [PATCH v3 2/2] mfd: tps65219: Make poweroff handler conditional on system-power-controller
Date: Wed, 1 Apr 2026 16:52:57 +0530
Message-ID: <20260401112257.1248437-3-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401112257.1248437-1-a-kaur@ti.com>
References: <20260401112257.1248437-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA1PR10MB997739:EE_
X-MS-Office365-Filtering-Correlation-Id: 4239f686-9d3e-4898-60d1-08de8fe114b2
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	BisQx8zfMU8h+JOSW5O3kIvSOn1hmPeN24edc74Re0zBRMG9PWBHpIVh/YepOGc/R9NHviaOJnFIOUwZSdzdTHuBwhMcKdNKEbCaFatBUG0f544LtbMeeTFAUwTJA5i7m8ni88tnwogXShdYNE5AaVQIzu0un9hsUOb1ow/E2tHZg7cciw1D35HLSBO91tyrWR0js5cA4A+zQ6qqC2NOEeI/Wi4Xtyycaulr5btXz3RB3G8L2s5Iv1K0BRs1uVO6KiwNpP7gNZH9BsdBHiHsQlt/VmOZui1y8sOR0WSjth1KN9Wm84VTguxH4xOU9l8wJPrP3kD2AFGaLXnXsjJh127nGPOK2osRnfFseVCTxVEqoAYA0ndvAXSeRlkP9F2r3mz1laXvS3BmUXRbOn1g0BdJEc8hWoP70099g9JO+ioIHch1vq9oYmqooAAP7fNvhskGJJw79kjm84fETNVQO7t9BjQ015IxiRTb8caojZovUsdWdjfP5ymO30TN2Bg4tHdx0M3AdzXV4ZYFhk5L5Bz4AMkC5qfreU58tLVFkmHKcJXA9k6rqUMWrdNzFBN4am3hWuxIaOslyi8N0zoaq2XQQLh3mDhMg1z9th20/1daujsK8qfhGO3fCP1lP7jgWICSkjFkgOvkEUPiP87ge7mRpi+4aYq4sesddHb1dLkvEmJRQr4StYnbqCTeKgMW4H8m49Kod+DaEwhccHC1Ri5wCMtVo6QtG/eXihkIf4bdS1gbnDhnDfnF7AQzWVpYi6Ex2MmxVd3Sm52NLDPldmBHBwLE2kGAOoTjIuhWr0apEfE9MmHrg+l5BHNyMTUt
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QUMUGPaostpnclWwO8HJP7Zh02ITfTjXmkTSHchU+eYqB7kexcwbm4QRo4kUVk17K0oEzmLE7AQrr/SclQxAuHse8x52RJwdnqbTYrUt8R1P1YcE5LCo8hY5nxFbizTT8yu0Z2LZRTC6LrrupqEp6l4HRTWd+6dUHuWHOpBjvD5k/x8SscrGwGt+ajgz5/sNJlOyGsnRLRid8r5Tq/7AHJUrfiT9kXTK78NL6QB7uWRE/RvEhZ7EfF/4hHwNQJ2hG4hDMnwGqhppMqvAKCvML4U04buRLu8z4gQsQgNy2Gl66CwcLlk2fQU2gF2PxPfOIOHD3QE+P+xGyrGt0B+N19re/wkw15LcUY5tDiKyC8+vZhXAo3MhCSUI9ARW29dGOrQ9em9h5Ff4U//ye+Pk2v3qEUqfCfI1jlAut6TdKSAZl4D+LLVMc+UyNHbcHHa5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:23:20.9901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4239f686-9d3e-4898-60d1-08de8fe114b2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997739

Currently, the TPS65219 driver unconditionally registers a poweroff
handler. This causes issues on systems where a different component
(such as TF-A firmware) should handle system poweroff instead.

Make the poweroff handler registration conditional based on the
"system-power-controller" device tree property. This follows the
standard kernel pattern where only the designated power controller
registers for system poweroff operations.

On systems where the property is absent, the PMIC will not register
a poweroff handler, allowing other poweroff mechanisms to function.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/mfd/tps65219.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 7275dcdb7c44..e52fbf1481fe 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -541,13 +541,15 @@ static int tps65219_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = devm_register_power_off_handler(tps->dev,
-					      tps65219_power_off_handler,
-					      tps);
-	if (ret) {
-		dev_err(tps->dev, "failed to register power-off handler: %d\n", ret);
-		return ret;
+	if (of_device_is_system_power_controller(tps->dev->of_node)) {
+		ret = devm_register_power_off_handler(tps->dev,
+						      tps65219_power_off_handler,
+						      tps);
+		if (ret)
+			return dev_err_probe(tps->dev, ret,
+					     "Failed to register power-off handler\n");
 	}
+
 	return 0;
 }
 
-- 
2.34.1

