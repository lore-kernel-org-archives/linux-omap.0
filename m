Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFED47206F;
	Wed, 30 Sep 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807757; cv=fail; b=Pjrr5bwsWv/gdGltiNiNiOHhXLlATPLDxiYWT0Is7nUhzmn4UoLRe+IRbunrHuW/nENKQ4Ot3crV5UMdqQT+ofBs+I0R5+M9xg0ZbX3odABaZ1YeWzmuBhz6LVYVgyrjR+kDKCn1V0HWZm1wiXMZzRbR4rwCBG6u9q0wniy6vTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807757; c=relaxed/simple;
	bh=xImmwrQaZEmOMPPXD+Q8vjfajyRfeizIokliPmWF/L0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgCjfkzYJv5Ef+xRP1E2lXV4gof50i8G+zToe0F71ABV8jm2HYpTMxbws7vYwZF3g1pjk/s31jhU9uX+ngiqno6M4DvfPLeC/hAPqkkmRPdaYaX4u3HZAUpouJQPshz1cxj46l+Jpvt2CjveGcO2ODxrgJ+SliGj/A/LZvNhZkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ZLZqdvUE; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=qcamWg74; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ZLZqdvUE";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="qcamWg74"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68UKkGwc442992;
	Wed, 30 Sep 2026 17:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=31FtpfwVwzLD0ict8s7Xlxjmf0MpGO0qQ6jQtSv6H
	CI=; b=ZLZqdvUEoDW6ta1qHd/O5DL6cE/hsSigsymhGvt0/fCxahZ+oJp7Bk7Xu
	ONId0DS+HwzrBXNDEbCd6Tz0nSmJd+ERVk/nN8sqYXuZzoGWODZUHNt2EHld4Zou
	oTKbwtuy8YZt+56SCU0nR19Hy5QEpTqoqQ+zfePBK6KlEyMqs4fz6bxg4O13h8zn
	HwlhFzRWVaF2zT0wWknkhqcZPZbCmsDXMgG+0WRUSS0iOimIf3q8Ck7SCKm+lNqX
	Jujl+oVlX3s8s8uJi6cbxDTpBwoZ074XPCmiE0CLjkN1K1U0tLC6O5o2aYWKqC2c
	Ycx365prOL4MC8lgRJjZQvO8gwA6Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	by m0384305.ppops.net (PPS) with ESMTPS id 4h10s23y1e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqBHawKzjDH6eVDYEuOVGkc7YTAxeqDybXSA1XKc/taiol2O9ONTGytV51SEegMAoNd671E96eTJApqso9xEQa9A05Zmkdwlkx89BUXNo80UtaXR3nTu/3hly6DJhHMelLtS+YhHgPYkfYBYDolpsjoBODpYtGYlT2LxvImgwVzhG5bTiO6wsKdztblvPGRxhb5l8TMljKlaKmLe31HZeKbeKz3YraenQEVII+gxNJhdIOP2zhbIXEs/Y5agcpMaRuttoK1zrouL94LUukvc9ECepvfq8w+ulSTIx+zHwQlum06+wBScFQqhrfIQB2wHW77p359uXm5PclPmFqSHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31FtpfwVwzLD0ict8s7Xlxjmf0MpGO0qQ6jQtSv6HCI=;
 b=Qg6jeO6bzFkCArx0Hrr4SUAciyp2s4hoL8Y+eBQRxbsAN5NeHM8dAn/qSDth8UMk7wmELoTETNdxPTG8YOqEynHhvDPv+Tuk8SMR2Du5ZS2HyHEi4BgDME3/0MB6M8+Zb0tKbK5mj/lQGa8Zorum/RCO8JSb2OAuUQGPLHfm9J3fFnddrGpbuUN3yNld+HP+UW5lIi5/y3293XromSOBF9UHuwXC9OrfMBG5yFW6GJh8858VJzTdfcdq+dKpZfUtbXMSIk7qH559HvabZVaKR6oi7CnIiCOWgDMpRb/lhGJ2eAW6bcSZgiIfYOMU0TrjHcNSQNnTZ7V8f0IYf0U21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31FtpfwVwzLD0ict8s7Xlxjmf0MpGO0qQ6jQtSv6HCI=;
 b=qcamWg74w/k4+OpnBegGmjxxshjyny4Nj0SqcgYJK2C9nFQrR+n7NzzV70JWl12MraawrKXGAqQnQgsuq0yxbl81Qv977NjiCYKpzDgT1WTNXVkgE0q2DOoRT0Vt5sS6X/2hvvZBgUbBc5uAdPCUFNkOmtqmJZziLnm0y+hZ7Ho=
Received: from CH0PR03CA0327.namprd03.prod.outlook.com (2603:10b6:610:118::20)
 by SA1PR10MB997653.namprd10.prod.outlook.com (2603:10b6:806:4b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 22:35:36 +0000
Received: from BN5PEPF0004698D.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::85) by CH0PR03CA0327.outlook.office365.com
 (2603:10b6:610:118::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 22:35:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF0004698D.mail.protection.outlook.com (10.167.245.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:35:33 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:04 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:04 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3Tr3969567;
	Wed, 30 Sep 2026 17:35:04 -0500
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
Subject: [uL RFC PATCH v3 1/8] i2c: omap: Drop bit shift for I2C register addresses
Date: Wed, 30 Sep 2026 17:34:56 -0500
Message-ID: <20260930223503.616776-2-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698D:EE_|SA1PR10MB997653:EE_
X-MS-Office365-Filtering-Correlation-Id: ef19d44b-82aa-4e2a-858b-08df1f432429
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3znZVLJXzeE9xGxbsTeQ5fOZjKEly0DHbzjrSwDgyZqUWGYBVZDkJLswRuG0HpmWNSIhhAw+3sckP3eaubHCwpyMfcIoNRXnHywRINv4zYS9h++2vsIHybRCzpycvFe0hgS5ktLZ2yJYQwsjAAwZUc3EW6annj4cafldVYQgX+2HkGWRQzRSIuCBj2AV4t3PSuGU01kLGSFktFbdyu8eUq2FXabKayaSn9zUDjXAwtYumDjX9lM6wQboa2g9vgfhS8dpY7hGd78DpEA/8+XqN5FokpaOt/+7fCFwthRrNjKtpVZmsJzkFUwaI3R34kAgO5Nwd3EcKReUZ2DXE0R/08XuAbScNeVu6hp0yRd1uO3Jg8NEytv4Ev+6cSq85KasAs+I7BENqY3WwXK/8zs+2WktElir/QOJ9PlzZ5XCxZigds2VFxj3FkQVshHxOSa3lo57l8k/hgMBVsCJM9IcjDOTVXCWUETfIt9KPjSKFSzsZrYuqu9QZhAXBNPKIhCVxFR9eB8M8o5CybQWpeml5B1039XDLDcQuSffdWKbxsdidqh1qZOdIuEkSXquBPlT0mZk5B8WTjW1E/qHeL9xbqHVZJs0R7JB/7sF9u4SwREoP3lIvmvckTFBgKwwlc4VVSeUPA/LEyJYXewz+665MkyRRv2dE1mXIPu7RzNeoOfWTtxcAT6owoGJcATSnqwhosBjQiyTp3F0SfK7ttTWrA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WbDAPY5+Uj47TOhCQvbBHpkZx72A3JVLNAXViK3bpzyp3CosmlUsNcG/VKkL/KWR5E3BfUHiKI3ux6X3Smbno4ODguV2A/XO9P4dxpj5ulUs14eKI3K9kVHhH1OK5pY9n2vAdcl4HcrlxnqvVeH84nNS9L8Zgct7D2y4QLRYaxKK2JOnqhD2gypL4wzyh1VF10uhoM9HYbzyH93bmal5CPL8sNnXJUnpuzEmC3px+9ELfdz0bzsxwCFApaAw9SIu4QTMJFYgesegJT4mAA80UN5PieKZ2Ex0oOVV8PFJKy+h5ucHGlX0ToxX3ggu7Dnfd6lxngb3WUoNH1DUGUyZ5xsOoEM5v4q+xwvDXRuSYRZNrcuxaJ5Oi1FrqG2t2PCQfa1DXO+G3BvUxNbQTerZ1nWSExarC+bYNL9G/aLk3rn6M0h0LDmP8WiVG3wsKU69
X-Exchange-RoutingPolicyChecked:
	tCB2VuelakU3KlDK56WwhnaGt/O61YbtW+CGFv3Tm6rXwzPJwo2ymEZgvt1LZ/+QbNtXGZjnAjVK44aOldoeXncolfNUkGb1Ew+SrGJezCQVFv7uIFpgjSG/0FTDc9C2M/oCcWsbEGV6P4Sq3LcfE/xMZSR+Za4OsgB9z9I/EzwwQvECftZ52xI2ZRxkHtLT0VJ4ZDnsJWPY5j+JdzRNBunFYoXRxxIgnA0Z955wMIZEym574m+gKJ7NUZ4mNb0sz0PPO8G45l0jL4iXLmLsQZ0VLQWfaXSMcDQpMEH8/eIka4VNo4W8wbxILd2XH2fhL9nWoRuF+ZzqzgGpHXbqCg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:33.8657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef19d44b-82aa-4e2a-858b-08df1f432429
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997653
X-Proofpoint-GUID: TSd_G4WF41BUMz6g_Cai7p7EBKiy_VC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX2i9DXZ86rQ/d
 66XpFep1MIm0V/a4v4Hjs3t3iwVN3dky7E9wA1F1pju51vKKCY3B2XkLTmElTKQzZ8c2HIZEn5L
 JyURKJHafC+CqZUBul25oYuiGUjuiYBLmjWgU4EzVo5+/NrQzqn0LT4p1+2hLCVQFehvcrHfBLW
 N5rnnWF25lqAAavvS0sKNs1jMLS4eFhqZ0pXIICFmsR8k2XuaxxnT1XN8l84gLPTo+C7GXTlQlc
 1C7cjFIrcsiVccHL8o4I1wC1MVCxtt/PxORSMwbpEoTfeK6NmmBYNtprDAEqOn92v6b3aA5y9TA
 qWp5O8vptBHimwTDdedWa7MD7T/dtj6NYu30J2KtQFMabqOJ7LB2ptt+dgl8r6rzWZP8WcpLt7K
 2z7Tm+Ullyud8Kizo/5y3zdNOgdZgCGknErlG2FyYOV8Vpn0uKacKCZUXU7BDqEU2rs0yJTqEwr
 OuqvjRoL5ufMgQGG0gg==
X-Proofpoint-ORIG-GUID: TSd_G4WF41BUMz6g_Cai7p7EBKiy_VC8
X-Authority-Analysis: v=2.4 cv=G6aJgNk5 c=1 sm=1 tr=0 ts=6abd8ebb cx=c_pps
 a=w8e6fJRD9yN2bKWo9pBaJQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=50gAi1W1AAAA:8 a=IpJZQVW2AAAA:8 a=miE_aGblqCwIs2vhnBUA:9
 a=bIAsa0K8HJLRn3BBPJ--:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfXyuXgvVqIxGmH
 SLSc0JgB+cHFvMhI4SlEVtUed4afKZxoUlcuXWKQetX85/MygBzgE3iSe6mFJn0hd2blK5g5Al4
 WlvT1XNfUcjrzFnv/24X/I8BVr79u4s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

The OMAP7xx devices used a register address shift of 1, but this device
has long since been removed from the kernel. So now no remaining board
device uses a shift other than 2, and no DT supported platform ever did.
We can drop this flag and use the pre-shifted register addresses. This
simplifies the register access.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-omap1/i2c.c              |  4 ---
 drivers/i2c/busses/i2c-omap.c          | 50 +++++++++++---------------
 include/linux/platform_data/i2c-omap.h |  5 ---
 3 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 94d3e7883e027..bc7828a858941 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -61,10 +61,6 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
 		       OMAP_I2C_FLAG_16BIT_DATA_REG |
 		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
 
-	/* how the cpu bus is wired up differs for 7xx only */
-
-	pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_2;
-
 	pdev->dev.platform_data = pdata;
 
 	return platform_device_register(pdev);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f02d294db42a6..c443f88267d6e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -180,7 +180,6 @@ struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
-	int			reg_shift;      /* bit shift for I2C register addresses */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
@@ -217,23 +216,23 @@ struct omap_i2c_dev {
 
 static const u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_REV_REG] = 0x00,
-	[OMAP_I2C_IE_REG] = 0x01,
-	[OMAP_I2C_STAT_REG] = 0x02,
-	[OMAP_I2C_IV_REG] = 0x03,
-	[OMAP_I2C_WE_REG] = 0x03,
-	[OMAP_I2C_SYSS_REG] = 0x04,
-	[OMAP_I2C_BUF_REG] = 0x05,
-	[OMAP_I2C_CNT_REG] = 0x06,
-	[OMAP_I2C_DATA_REG] = 0x07,
-	[OMAP_I2C_SYSC_REG] = 0x08,
-	[OMAP_I2C_CON_REG] = 0x09,
-	[OMAP_I2C_OA_REG] = 0x0a,
-	[OMAP_I2C_SA_REG] = 0x0b,
-	[OMAP_I2C_PSC_REG] = 0x0c,
-	[OMAP_I2C_SCLL_REG] = 0x0d,
-	[OMAP_I2C_SCLH_REG] = 0x0e,
-	[OMAP_I2C_SYSTEST_REG] = 0x0f,
-	[OMAP_I2C_BUFSTAT_REG] = 0x10,
+	[OMAP_I2C_IE_REG] = 0x04,
+	[OMAP_I2C_STAT_REG] = 0x08,
+	[OMAP_I2C_IV_REG] = 0x0c,
+	[OMAP_I2C_WE_REG] = 0x0c,
+	[OMAP_I2C_SYSS_REG] = 0x10,
+	[OMAP_I2C_BUF_REG] = 0x14,
+	[OMAP_I2C_CNT_REG] = 0x18,
+	[OMAP_I2C_DATA_REG] = 0x1c,
+	[OMAP_I2C_SYSC_REG] = 0x20,
+	[OMAP_I2C_CON_REG] = 0x24,
+	[OMAP_I2C_OA_REG] = 0x28,
+	[OMAP_I2C_SA_REG] = 0x2c,
+	[OMAP_I2C_PSC_REG] = 0x30,
+	[OMAP_I2C_SCLL_REG] = 0x34,
+	[OMAP_I2C_SCLH_REG] = 0x38,
+	[OMAP_I2C_SYSTEST_REG] = 0x3c,
+	[OMAP_I2C_BUFSTAT_REG] = 0x40,
 };
 
 static const u8 reg_map_ip_v2[] = {
@@ -267,14 +266,12 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap);
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *omap,
 				      int reg, u16 val)
 {
-	writew_relaxed(val, omap->base +
-			(omap->regs[reg] << omap->reg_shift));
+	writew_relaxed(val, omap->base + omap->regs[reg]);
 }
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *omap, int reg)
 {
-	return readw_relaxed(omap->base +
-				(omap->regs[reg] << omap->reg_shift));
+	return readw_relaxed(omap->base + omap->regs[reg]);
 }
 
 static void __omap_i2c_init(struct omap_i2c_dev *omap)
@@ -1214,19 +1211,16 @@ static struct omap_i2c_bus_platform_data omap2420_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
 	.flags = OMAP_I2C_FLAG_NO_FIFO |
 			OMAP_I2C_FLAG_SIMPLE_CLOCK |
-			OMAP_I2C_FLAG_16BIT_DATA_REG |
-			OMAP_I2C_FLAG_BUS_SHIFT_2,
+			OMAP_I2C_FLAG_16BIT_DATA_REG,
 };
 
 static struct omap_i2c_bus_platform_data omap2430_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2 |
-			OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
+	.flags = OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };
 
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_i2c_bus_platform_data omap4_pdata = {
@@ -1384,8 +1378,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, omap);
 	init_completion(&omap->cmd_complete);
 
-	omap->reg_shift = (omap->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
-
 	pm_runtime_enable(omap->dev);
 	pm_runtime_set_autosuspend_delay(omap->dev, OMAP_I2C_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(omap->dev);
diff --git a/include/linux/platform_data/i2c-omap.h b/include/linux/platform_data/i2c-omap.h
index 3444265ee8ee7..fe6753cd17bf5 100644
--- a/include/linux/platform_data/i2c-omap.h
+++ b/include/linux/platform_data/i2c-omap.h
@@ -23,11 +23,6 @@
 #define OMAP_I2C_FLAG_16BIT_DATA_REG		BIT(2)
 #define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK	BIT(5)
 #define OMAP_I2C_FLAG_FORCE_19200_INT_CLK	BIT(6)
-/* how the CPU address bus must be translated for I2C unit access */
-#define OMAP_I2C_FLAG_BUS_SHIFT_NONE 0
-#define OMAP_I2C_FLAG_BUS_SHIFT_1		BIT(7)
-#define OMAP_I2C_FLAG_BUS_SHIFT_2		BIT(8)
-#define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
 
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
-- 
2.39.2

