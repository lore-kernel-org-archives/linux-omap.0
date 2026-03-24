Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E0296BB6;
	Tue, 24 Mar 2026 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347275; cv=fail; b=eutFNQ+D78mapPIvyEpgsbckUG3rN1D2gBWAZnwFOg0bXNi2TlBNw8EXN//My5kRlohUlEvdRDGwrNKKuU+v6UQPvVzoOdl/AHzQD9THLKFZLCTFzKtsYyEElRO5/DiycFeRoBPLbIsBlsVsE61GdW5jVBLRku6Q/07ZGBLzaVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347275; c=relaxed/simple;
	bh=Ru+IzlDslWGqY26wT1+qALVQgI67Tk9LkVrqiVmhxfQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FWovezxbYjfJ4LIgsk2x+Hcdq1OKUXPPBshH8vT1iRxHMAZ6U/uOLBQM92T5iW/okAihJpmcWUzQ/8RGqfTo2IlfalMI6VEP2M96FzYQuozBC3wQK9nViaXhkVzphzrVYLg7ETwZsHw7/WFu8KBPRPF3v0HPuY7cWCUZPCDhxiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=beH9YHEe; arc=fail smtp.client-ip=40.107.200.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="beH9YHEe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPzq/fJWw7x+NVLQ1tIRkWXhvNCr3nGe6fLW+7GTYCtIjpoqxFx8uulqm5oFu/9ipRdPblT92Ca3fzNJvoIF8xPjYd0wQ6sKvavsqZqTK2Tb2HohdIqoKMmoLTHeyVsDuw0QmEqh5f8o56Nk1bnFrKxCvXPNzgizPI2M5xR3Om5Qnn8WWWcNg7OxpKjzXeSHRNRWqq+jrsihS3OpFLciNG0XGqrUu1YtAUUmFbpHrvLbVV3rln5xKquyP484eK7wqjDBrLs+35+C0AfuE7MS+Be7QKcfGK0ifiMt6rIgdEoHXncq5yJnm0lSp2wij5oVPgHicEXPM+M24xdE1rjF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPqCxDwKNuZFSOyEhul/CcWlJAbocDCIegm3rkkSdDk=;
 b=fatjVWXpZLLvNlB6DHxPj3ofWlT/S6bZTpAJZLK8K0sUDAMr8Fol40jEn69dxzjkq1IBGW/8Wp+wNX+LukY+EQOZpfxGqzTZTSZyXbjU9uP857LUE9jFaZoA5Yoow5L+/ShNCmfp2sWBdeswbA0nPezI9MmKoB/NUEdjG+/PUIcDAqND3hcNMQiAxyKW9SwlXy3aKl+HOXkIYAqNqjhUMLIriOwksRpECz9+6tSyO1oKicKXF7ksfl3KE2HVO1b6KnQqjoTZDR2v42TRrDpMDV9GY7i+IByZjT4Icad7WU1XTn4Fp/JB9PYQAq5sEAvto5ru885Uz7ti/fHOZ2iNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPqCxDwKNuZFSOyEhul/CcWlJAbocDCIegm3rkkSdDk=;
 b=beH9YHEeHa9ZYktofT9OAib2zV/z9nhtml6PZrzc5YWc6exPJe8pcN3+hdsC9cZVemU66Fayeu7yotPommpTfmLNUAIOosgYg9PsfWMqSQY/uQD98wVFGnnOfynEvPoNZnwYtDWPOBwMJ8mvcvn7SXf6aDc7ef8jmaMQeq/MZD0=
Received: from SJ0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:a03:333::11)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 10:14:30 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::78) by SJ0PR03CA0096.outlook.office365.com
 (2603:10b6:a03:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 10:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 10:14:28 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:14:27 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:14:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 05:14:27 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OAELRn2446022;
	Tue, 24 Mar 2026 05:14:21 -0500
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
Subject: [PATCH v2 0/2] Make TPS65219 poweroff handler conditional
Date: Tue, 24 Mar 2026 15:44:17 +0530
Message-ID: <20260324101419.95616-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b226eb-07ff-4569-1e70-08de898e2247
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0VmiaB6QaZfx0id/Owiy5gZvGd0MbLVXAOdYX9Liy+qjEUK5frhRvTsw3bjw7/0ahEbpL1L6SelTfEm3NYlYLlb/gwfB5rpVeGVoQCskJGLGxlf56/w9iS3ZdK2A9LIUYPfeDdzIBKdqJHfKx/qJghLzNaDAX1qSh/VqTlO12GuRQGS7jIEJbwTSEbGwdCM2AZGYDbpLmN37gkmk3BblLZorAYWg+9hO+CgkVLSpEdn37Y0V0hCyAM1389nuVMHIdtP561dIQlo1CwIUd7qty4PI3wb/ATVss0Mj1qUS+7bH+zOQuyyNt8ZeRXfgbrD1we301NKEtom4mlZoSf8E4cgPoEZFBsCFYUejo8OdHIRaz1Us1tYEi3lPGQAALlXfOL9j2IYl3mfrL3rZYR5J2zDjERK/k04zRFn302nNMBsdIhHxkiRoN4R+t10YwWxoY+VqcinAynfZHGYylpv1BoOfRXVW+9IqWb9aLrfxjQwG8Zd6Qrn1hTyPIJZlHVuFt4O9BdryivJp0pwTOVLkbhvwE3OFcO2X3dc0L8oZYHOsMmthhCPsR3Sh9j/1jmexzohPIVsIEEZsHy5LW3mwt5EAkL703nFOwp3MJI372JMYRbgRvkeMT22g/uzVS1BQTYcIUWIK6jDb6v77JdflHeSPZJn3rRwFw70w0v6IuzPJQ/slIFUki/LFuKxNW0uyAkSj56l0dddG1uhT6Z/aunHcR3rgMTfavmCfqN5p/mWJCYaW7r5A9oIWzzaeOpvFkcCBDkEGnL20gWybSMugFxyg6DO6t/S5PNtsb37n1GEQlMJ8aykfrQOuwlozNEnp
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CtrllC46WfI2tDDvbWs3wcjDYV77lg4kUU0QhptCwsT0tXwqXWzibZrM6g4ujWKWV7rLVvSFo4GCN6a9h1v3JMDbNhqUnoPNNZheuSP30kqAiNcG6oD3I65L3RoyRZH8uF0m5rrqTyMXB/XCa0gAHkId/BsntO9d9m9dQU5Lr/gSxxE3LApx8CsK+LwQnRh97whMM5Q+GqJ0Aq2d99LS56/kb9hhywNOI3cM9uTghW0llXRWt+x2vbWSP1e+i5DB5Ndmg4DoC6fdlutIaktGy6KJx2AgJWAQR5Kb2p72GvwXQMt25YATQeHD+tlaXJMyHFuJlmkrAtL5/pP/tRXTIH2dWuqnijvLv6OTSqCLErSOIjF/TwSsv0EsUf+Oz0Se4VQNOFee2gUtL1f+jUtUxaOUcqdkFDV9oJVpEUt8JUWYq/hYLqnRUCI+3XMtBb4o
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:14:28.5324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b226eb-07ff-4569-1e70-08de898e2247
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424

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

