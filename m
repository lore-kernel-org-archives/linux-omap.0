Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620E3F7A85;
	Wed,  1 Apr 2026 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042598; cv=fail; b=RM8ckeKPiyZZb9CdalaeRaKtP6pPS0yf/O7FAi4eRQkjAEXW1hhBhYuIv+ta8ASZqho76Fb7LFBLUOo75oxWm/elLNKlPf7ao90dMlwz74LsDk0FEWdF+1pw0F+eccjhRDL3WZVyWXsfc7j985TP+reA9qwCpnIRovF0bmLHy2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042598; c=relaxed/simple;
	bh=AYkUWsKea+7gqtiyFsVVW/ypw7xCd2qpJEO7DkNFYpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdMY3M5GI/sMCVBHR7tKL4/gp1XQYal6GSuxdvTY8q9Rc+L5eAP0WvKMwRQ8ieDptm5ky7ne1yev/ZadiF+vBRor24L0sTJD9yLV/2KJB15rHKfYGCx1qHMTgmfwC9mSWgbPnLAceo/1XbzC91uR/ptiOPNuiCIURnaAjoXgeRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cJJw3huQ; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cJJw3huQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6YEIYN0np7M4zv1hwdWl2WbTZK1nu4QiM7nMQKdd5IkYqSuMltfqzBYK0AWfYMNqdCvwHvkvCICbLGM5XfkmI71tlfY0raA4AVbmVA+3KyixNOU5RH8CTtWi7R47BvOfUHwD2CGbmtmgS/SZaH4h+0atoK2t7O6wsHBUk7lTDyXdemaZjq7WRugfIss5OJsoHT6lO2KFRu6PGAmDk2686p+FYuWVfAyEpFLss9cMf9yEDsmrfKjQJNfhLqBSlA01CeLAjvy26aHNxJVVYLbnoAfdJiHHjUicEzsdmLuOFwa4zlKWW47qpQ91vaasVj1G1oDBHWsOlVYPKjQZVR3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLqsjdzmuooo7CLedHC7AqpuPSTNFUGZmAR0YC8RY7s=;
 b=b4lbvLZHqxI+Wo7yUnzp8afpUuYsPBL1XwqvsOc/mtQZPhL1+Z1/i/hsJ9cGQdv+7S0ILBszJZbuHd3mRZWfAHhC8gz9NYs0LbsRWT2Ojvvib7FPWRQqf5JBoW1HkaKJo4sXALmMbBGH+upPtEElNdB7ZBK3yAXtItzfKA5MrC3xN4JY3Kz7wtz3MStLWYnnWrIQyaI0uLWgHSzJOdT31g2dQqtmYCyxFzjNXgXlYGL2eH+hkMo9dB4GEQwN4WMZ42kXbfnw2ROKFM+r/IrOONxJLHOvOIcGy/0NISz4kC/ekLckT66MmlXS9kBUOe66Ay+6CyScINAh9YFXLyjhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLqsjdzmuooo7CLedHC7AqpuPSTNFUGZmAR0YC8RY7s=;
 b=cJJw3huQ5gG3r33kQ228wsULnDp4MXy71kDtzmoeTE9qvUiv1Fve7zgPheLimPz1HFwDkNdxDeshZdryDSCf2qiHvomE+8dWkt0m8LqFYKa3G10M2OqMzyQ2qG+jO7QbZjjMBiyTvcZOkJGkOzHeiyhhSkE8v9w2HZGIjwuzGdE=
Received: from PH8P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::8)
 by SA2PR10MB4810.namprd10.prod.outlook.com (2603:10b6:806:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 11:23:15 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::c4) by PH8P220CA0027.outlook.office365.com
 (2603:10b6:510:348::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 11:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 11:23:14 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 06:23:13 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 06:23:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 06:23:13 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631BMxFF4170925;
	Wed, 1 Apr 2026 06:23:07 -0500
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
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-am62-lp-sk: Add system-power-controller
Date: Wed, 1 Apr 2026 16:52:56 +0530
Message-ID: <20260401112257.1248437-2-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SA2PR10MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2768c8cc-1451-4288-c25e-08de8fe1109a
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|22082099003|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jFplZudBKYdfg/1e0+ciRGQCThEQ21TFEkykxmZYYunayLxNrIOZxjbHAtGOLVuK9ORclqMUS1vjE06BmwAPKkGWMDdJ8Pk/u3euDlpv0t3DlB0eUKgqGBYdnpZmLaBU9kV0o/Yt87alAzFBHRW2l+FjKOEks6rD9n2Bn683wWw+tkrmbuXkwpjMQh+hxlrjnAwLgFBtxSelk8Ikp+yjqruikMbZTMFSf2+h4TkjKh/iRR+/7JFiu20tb27pm3diy6yfnYogiv+r2xmhACmf0yCZ+/aobmXZksyeQR/A6vPh+eCCfp/kWKWLBT+q5R8dp9QIHLd1EHoEDXijQWARuEnQl0fA1NVwDAb1HzAXSMvPpA+EegpRXF9KTqPLheEj6GYwKEc1F3KYcIqLKsEFV5/NgYXLXLjNWOCqgr+XrqxGd+jYikpAwhQsLI9GkcKCPvZop8MDLAl+KrLxU+pauodfbxhpktVClWWeYvKs1hoAxcUlLuZVtfFiE4pfCE0kKLo3MP3+j6gQyu+Dr7spHV7x5QOLtl5UiWeX8Uph9ooq69+lX3NXNOeKwduzfRHPBsOT5LmZFz6OxM11nr6txqPM+BXU5xwi/Vm3StjRIRrjUtXWxO/AjRj0tKPp7xwCI8E+RP0Mtv+U/rV4bzq14B0/Sdd1qHG6LyCMW+5SvplW7rX0dNLtHOpWaq5v0Pg4ePzzEhI9f+ITsrHz2Y+/Vo610v750ZD+E3Ym9yBAphLfneZGasXlzxyWEZttIH6YYYWcgHq2QRMcTMpdy0GezX2fx5hYasY/+63PDhZtd9fGmltM9EIBR16iufbvBQfb
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(22082099003)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zRLzdTGH67JDARXMHwbRR6pNsq4I5IFbme+hyiKoRwYT45NV4dSal/o1og+FGweL0eMZWFM18ejlddLsBwJLux28ZVH6JiSESBo6loazB5pqOIg7lU7DeLNJCZfaTJqVmq2Hin/7GpeytIGwKdZ4aFptLengYtrEPVZupaLghznvjzDsEVfm0WW8B7Tt9/D9NhpFgslNCh9iWRZ6rEFkhwrsLlVTtNb6GaVn3RfNdWRkiO3Ql8YupeJEesv22LtDNHYcEGUDQeG9vZ3wc3NMGBdBXq3Y/djfXpX1gH9WFYl/0adwHHAFVwZP3ylR0SKTrg3JmrkbrzBQdSxR9wJdW8TDhpeQ19k2v72y3qQCri2k3awmfziHJjCybkx3hZRjmmgscvSp1YWYB14k2zlUxJfrtS4+TJOXMpcs4bOvMKSxpS8StIATNzuK1qdOHWq9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:23:14.1277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2768c8cc-1451-4288-c25e-08de8fe1109a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4810

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

