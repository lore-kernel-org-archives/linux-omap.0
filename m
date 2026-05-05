Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27BA2741B6;
	Tue,  5 May 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989730; cv=fail; b=oHTiBn6EzkB8PHoLNtNmeW6ymCi7Wo7Hr0rmH/ohvwrJ2cNGeC1TCKx+S5dQLczkLbH01aRs07LYxpSjLXFfZTO97s9SM8F+cr27TAy0AtGq4Ya9ldbcHTEygXOwWyDe9RU71S5uV3GnsqFptfg35jG978TAOf9YSMIPg+WmbY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989730; c=relaxed/simple;
	bh=RznnyhqzpfAUnmuezWGPbxqKm0d0jbZFCtN9NVwtOto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhtH+4XLKrV5uZf6tn9nybaU8XzuKuAClgWklgHGxFwMgFxfrqrew5WG7fAUpjxkjU3L4h7+ULDGsi/PEOqONj4TaM6XicvI/Xjcpb/6ryVsp/Ft33nc5tXIjVonyN8DtzZTt7nWkGmr9nBuwcJzdGhJ+vB4Vy04mU1IVYbZ8Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ScRCUPtV; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ScRCUPtV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEu1fsoi+PYDuKx1wYaxe/R2QQFf75oH3eqVOK07UTh2h27+x0fVeFZMse56MiFg4Wmdj9hxH6KjsE2+VAILF0E2DjY8LvPOxhtKqzFXsbijN3nzV9tzdTH6gnElVAappYPpsPR/7WA7vhJES3C9YPKqMNB066fA9grmOtf1pV1bHbJtBVX+aNylypp5AJhKsFggG+PcTeL+3qqgFv0eiHI/DrPsbFmz0GDgiKMcbRmszo+AiT/rlKl///LQQMMTgY/OZl85rmf8lvetiyw9oEpZY/FUxTvYdIsEd5fyjnn/T217wEwVgx4wl3usBpkoUjiOXgQJWMJp97U/DhExMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwNedwhuJQqBsP8A9QzLT2Rjvgm73LPVr/ygvKUP6ug=;
 b=bYXnVcv5B8TaRzn0QPgXFYrK9PNeP+XlmDgtfthgs/4ouRO73C3tYEuWcBrUlCcC2QyNfOn/BE65WCqiFlzH7xfTpaXbRNG3jnsPL3k1lQ6f1/hmwwss+P9/wKa8cBXrNV+Xo+mWt6ak1o3a0YyTXw3YjpPMyuLw7dKnoujA0aF865VnNEBJuPwkZwRkvP8DB/HA6Zt0z4rYpAsXUBNjjOvT0Ofpg8Yyc0VP0zig2NHCOyvHrFNBLZ1WJx6Kto+LWVyePVFN4WY/W5TJbkcdZY9qmTXB6BYzAyktYbZxsSjt53Vi/l+LJ8cyCt2KE7jFxPTvZqrGkTRjviuR/q3F5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwNedwhuJQqBsP8A9QzLT2Rjvgm73LPVr/ygvKUP6ug=;
 b=ScRCUPtVlECp6I6xEDxgHNvaVcf141+gjMv5M+rdxkXbQLGvpaStdg/S1T41s2fKQyCKuUFcyy6bNXXDKq6InEeIp3o3iX7A1LRFpR0DMJkt/0vLiAf8NtWe0YrVDvzQegk9TIIjBVZvaLKwtaYoYMaMhUeyXV2fPF2trf1MTK0=
Received: from DS7P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::17) by
 DM4PR10MB5941.namprd10.prod.outlook.com (2603:10b6:8:ab::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.27; Tue, 5 May 2026 14:02:06 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:223:cafe::5c) by DS7P220CA0028.outlook.office365.com
 (2603:10b6:8:223::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 14:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Tue, 5 May 2026 14:02:05 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 09:02:02 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 09:02:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 09:02:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645E21bt3393388;
	Tue, 5 May 2026 09:02:01 -0500
From: Nishanth Menon <nm@ti.com>
To: <lee@kernel.org>, <praneeth@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <aaro.koskinen@iki.fi>, <andreas@kemnade.info>,
	<khilman@baylibre.com>, <rogerq@kernel.org>, <tony@atomide.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<s-ramamoorthy@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
CC: Nishanth Menon <nm@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
	<d-gole@ti.com>, <k-willis@ti.com>
Subject: Re: (subset) [PATCH v3 0/2] Make TPS65219 poweroff handler conditional
Date: Tue, 5 May 2026 09:02:00 -0500
Message-ID: <177798970953.337994.15466154838231930413.b4-ty@b4>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260401112257.1248437-1-a-kaur@ti.com>
References: <20260401112257.1248437-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DM4PR10MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7c2f50-5e5c-4fd2-77e4-08deaaaee3d3
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Bu9ScZJ0XOJeP4lRjiiZuMh5e9Q1j6c+3IvOAD/FpsmRaYGBZIM7vtvnDmjzGEXVz5W9knMY7eqLtu8whakY6PzIvFTnwYpk2RS662mhGcizXySNNFIOD7I25xEtIhywxBWmEvGB4h21BHp5s7vHUTyygKfFwYeNCqBGU6WPkjv/UtPs1P7GqVksIUzaP21+/hUvG4QCdGWURVnTCcdM3virXriNuWRvnRxG4VST0Pf3ZM84ytHxZ4AidmyQ+i2hSN7vBdEECVoGPxNsN5RvmeOpIqnGZK9Xm/B5ETXFltYcucg2EK2oql9p/oIDHsTRjvX2TIyOdkYcxJ81/4Nc+EUPnbZAvLlAMmEvGDo3rlIIw/WHmT69wDjiMbDWCJAHCQLCqPXmBXJekKr6ERRV3Ba19ijw3uLpg03FVKchSnhhvqK/VSJ7NweP9XhG3zZQVQQ2Njq+gqlD0ThiFbkG0xb/FJWVta7XvFIs3/WSSruqQFnNSuVo9neGAaG7v/3q9aULlGyUSDchGxAfEGEDjrJonJUmW30PCO8Ls8U6kHiNL9C2mtzjDXZcE+VSgPXjj6DWT8RdrOMl1iB8H5ueavB0lDh0yhKdiLCdhgid4k2czHLZR5qGuOSSIenWPyF3z1jGiY5vr7HlmATc6fKKrZUzbCJeL57qvB17HfOTn0AaFHZwD0+E0os9WW0u0NfodPLSTFavhwOWlyojC2ETBkk+6RNY0Fn0ugfMDlgroc6u2r3SgKsRUuOmy8lNfXMSyO5CmlhArzmotHZcWBGVvhnQRkG4D9HHod3pvRFoFF4=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CvgWwsPuxbVc7twLgVEYwB/06FnPtc4KXnHd0K8luB8dgfSMTJWA9oqOgiEkqY9zv3aIyQEKPdeSBBvVzLnMJVXhkSWJDDFL3NlSu5S6Fy/qIEsDQbsw/hB/qSLCilffB9mJYPOCU/FXye3QGtocZ5VdWX1oCauscnCNhnrHakuCCbfJakkn0V/MrUtFTsb8CILHb0oNZ/0FTKGJJa6V3NlBdL1F3I4EPwPZ6i2byrlU7RBq2PAMc8chwaaLw4/M/ercrEdmwCXSM999wYR3CUMtsEoDQvnFuqopQ21+XU8zvIJreEg94fTLYIhLN3LQJOM+l1PSCN+E6YSKw2+GyQ7zjBqGYSeiIgZIvdWiNDJ0NUgOZKhQ27yM4y6jcn7BEEFa47bYTcBAHg52M6MMtE17WTKQUULQPXpDAvXZyfgSXhYPfBtgX09/huBp16aX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 14:02:05.5090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7c2f50-5e5c-4fd2-77e4-08deaaaee3d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5941

Hi Akashdeep Kaur,

On Wed, 01 Apr 2026 16:52:55 +0530, Akashdeep Kaur wrote:
> This series makes the TPS65219 PMIC poweroff handler registration
> conditional based on device tree configuration, following standard
> kernel patterns.
> 
> Currently, the TPS65219 driver unconditionally registers as the system
> poweroff handler. This creates conflicts on platforms where alternative
> poweroff mechanisms (such as TF-A firmware or other power controllers)
> should handle system shutdown instead.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62-lp-sk: Add system-power-controller
      commit: abbc2a8235944a78f0a0003fb95cdf6ec5a150a1

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

