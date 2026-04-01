Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E33F99FE;
	Wed,  1 Apr 2026 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042591; cv=fail; b=YBSBn0F/POkyFPe+joDOzxjPHZGIgGGjUJ3MQRX4iFdC7vPnZhmE6IqsCvoINLdxidaWS6hSuDVSYHGe6Vg/uJ9zuWVgBbF1fiy1SqQTZRV+olEysPSmgouhx3OD4VElv8KkAJC081QVd7BWeXDWR9CDjZX8VYIWnGYCj+fI0w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042591; c=relaxed/simple;
	bh=C/muQq1IipJK0j3hr16HR5eNEkjCACqfsZrZ6R0WhZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpyWvGaAN9LrMeW3EjjYaC9G1gCZqVntructqloFdSgiGh/FGhi6lXGMTFDJ3CI3HqiS9aRBbI5hf0it1Ld8kyHOdrGFRfpOzHRu1+CmJQjkApbjZ7ljXvs712MBKx7PdpEGo/uZ0wAVm3CdXLvFCfU4j8cR8P25sw5WdyJiPgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oBvUBX74; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oBvUBX74"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD5PTlnZ9xz/X88Kf2hdK3hE/eUivI17zGbl4EnULcVIGTb/zwqJqACV/HuJJuqIFL1iJS75PnJoIA2hJE6klLhrdwBcvlwf5sQfDZ0OIHOKGZKD+c5VVKduZEz0DRScBeZE/IEj+prDXbBvZ1QVPWdc9wzZhdmOgnI16UtXpXil6xi862kWiA0+i+Zli+w0oVul/fYqmIjyPumzmva4fzg79WLUIsi+s2s7Wvjtey0nVN/zsqUpSIyObU2REZRbtOAL8lvLWRiZB6sBGlqfbEi2dQnQbNsJJ6d22+j4KA+2WGJybMDdAmo/w2HwcwknKUfPlP+gQ93Xe6WcATRnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km5i2wtNc8TsgFAg/Vbz98+rxNsuFNhnc1JeB67kh4M=;
 b=jyAzSxUk5tP6KyzoooVai+2tt0QdmzYZO93qOXkmrq+dFBzWEWOcsNtyPbfC3/taX55Rs8uslxWyHQb6vIoohJe3O+paXucqRLHy4S2cpq580gEepXGzM9dIlmhM4yuWc/oiKraFyfMb3ME7A1oZDBmoXlhIl5d9pddfOe68O1qQiPoEVyxa39/OmGgZctfpXjRbWr9SWCXqVKDlC9jLdqsnLS39n/NICKoO+O87Ia2BmMwb2R222iCNv4eeKX87rKOowdRGyBapbBMVjkGxgQFPABXkkbTir+54Je1NKci8jOZUqUWtIB1tvEof0ScfS0V299el7rw64hrfJTosKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km5i2wtNc8TsgFAg/Vbz98+rxNsuFNhnc1JeB67kh4M=;
 b=oBvUBX74k+raqChC33NLq1EAWhhg8u22jnZ69q2X06pLf4yl5KCQQ0W6e3dpN9y3h8JofxeROsNxYwMPAqMr5VKwbHNN44k0t9sC1SBD088xTK/QCs9MGhBXdxbHKfTdktQIHougO/A1nY0WsAdT6kOW26AasaMsYMIKUJ8phzI=
Received: from CH2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:610:51::34)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 11:23:07 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::34) by CH2PR15CA0024.outlook.office365.com
 (2603:10b6:610:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 11:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 11:23:07 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 06:23:06 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 06:23:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 06:23:06 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631BMxFE4170925;
	Wed, 1 Apr 2026 06:23:00 -0500
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
Subject: [PATCH v3 0/2] Make TPS65219 poweroff handler conditional
Date: Wed, 1 Apr 2026 16:52:55 +0530
Message-ID: <20260401112257.1248437-1-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: e591561f-60dc-4a53-be46-08de8fe10c65
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6cJ8+9RTKvsnd/i1R6LTJ8VEfFar4/QovOeNp0q3+IbtdUuUxTVNTZezrCs2Z734W1sXNGs5E5jhmyXiz+aqESDirgK/HCRB6GDoChhH7uElv4vPRE6TuUZ5xb4/QAiE7HOjZnDKCvHP0Z6+GgTs0MhVv6ze4UjD7A2vHQkBdFGV3l3eHvpqP2xCC94ZZevPskgwthVh7W2eU4eT8SAJheJg2YoB8sx2n9m+E3iikkjHX+5W8jDt5dl9VoIuicKg1yqZikLdGmi6qKw7ojs7wuNmlPU8oT2I2rDq4Qa+YPbhJ50ppwRLhu5l56sexb6zwr5+h1oL1LkiYnW3jDJmu6/RN4QNxkAOV5bkWvzenI4DkFxRNxC2AjxszOZS3hc3xrdzR7ZJ2p2zP9x31L3TzEFUIVIeCGH94FzmdL3Kt+fUVtY0O1pybi+Q/mgCZFuyhme2jyLKRg3ncLhDMdkY7fkvha6We/S8vxFnoTzQnjmeXxhCLIi9m26BsS83a1/YjLtSrjvBFvSd7kZPiHKHq5rGRQiNeoQn9rxBJEIOQ969UP/pxs/S5iITCg/vzLJvkeb1MdHQQJRX6g627w46vCHLbGCqjfzIeOR9JSxndafZgWXyxNt2l/rqfvmaPCKAG2OCqACzXLZZ9y9Cd4OxSy/y9oFO1yv7DCj9dTc8IgMXizEj3OMxreZ/20w4z2wOFViLxGT9QULgOKN6tcZhZgZp67ft7aGBT8MtLei6fCZtCpcAXJ0dqHgNOOSteOjYrEHY41EU0a1m4vEztuBruWgcqRi7OSBSRCc7PmErYMN3/VG8eSpVtZjV2m03HzAXYZzOTsmYpHZZ5r4088ayVQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k9zLuA42xtfbf1tHG6LqKyhxf6q7Uo97ZdcR5qXol+jnKzjLt0/s4witxkCSCnigmMZQOqEelERxAb97r2MW67j7uB62lon/GxghS9S9MJsOn3HaAhUKBRVtEGSdedKd6zUHgJb+U85eNx48nVC1DsRYTrtusfBKCCAKKnkNgVIuS923TpR8MtS/5dEx4w6zEx2T5gkimgmgP2Y/5PhX6N/Com5goxFT75qQcWBfw1Lum/VDsqAGpHmZMIFXC0aAgFTQi7Psc8ape/UpJorLDKEsJ//nFLvZ+8ycP1NQx3HurHgef/gdvOMWL+odyMRx1Saowq4h1+ESxKziPAzTmztEEBa34wVOAubHAHnVsI9d3uEAdMUfD7YJKqPPQwkMH13FNVhzSM6A7jqitQ/Z3tVjgQKuY3ZMPM1aqQijLJDilzir5BdzlTGx5WfvZ6yD
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:23:07.0528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e591561f-60dc-4a53-be46-08de8fe10c65
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644

This series makes the TPS65219 PMIC poweroff handler registration
conditional based on device tree configuration, following standard
kernel patterns.

Currently, the TPS65219 driver unconditionally registers as the system
poweroff handler. This creates conflicts on platforms where alternative
poweroff mechanisms (such as TF-A firmware or other power controllers)
should handle system shutdown instead.

The standard kernel approach is to use the "system-power-controller"
device tree property to explicitly designate which component is
responsible for system poweroff operations.

Patch 1: Add "system-power-controller" property to AM62-LP-SK device
         tree, explicitly designating the TPS65219 PMIC as the system
         power controller for this platform. This property was missing
         only on AM62-LP-SK among all in-tree TPS65219-based devices.

Patch 2: Update TPS65219 driver to only register poweroff handler when
         "system-power-controller" property is present. This allows
         other systems using this PMIC to use alternative poweroff
         mechanisms.

Impact:
- AM62-LP-SK: No functional change (property added, handler still
  registers)
- Other TPS65219-based systems: Poweroff handler registration becomes
  opt-in via DT property

Tested on AM62-LP-SK - system poweroff works correctly.

Changes in v3:
- Fixed minor formatting issues in PMIC driver
- Link to v2: https://lore.kernel.org/all/20260324101419.95616-1-a-kaur@ti.com/

Changes in v2:
- Addressed review feedback by removing comment on self explanatory code
- Link to v1: https://lore.kernel.org/all/20260310111846.1084623-1-a-kaur@ti.com/

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>

---

Akashdeep Kaur (2):
  arm64: dts: ti: k3-am62-lp-sk: Add system-power-controller
  mfd: tps65219: Make poweroff handler conditional on
    system-power-controller

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts |  1 +
 drivers/mfd/tps65219.c                   | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.34.1

