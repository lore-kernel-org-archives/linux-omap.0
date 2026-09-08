Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC87566C4B;
	Tue,  8 Sep 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882189; cv=fail; b=KqiyxT5mU5oagmOW6YbNz6EJSITeASBqMwm8v75xeLwAmXiXcEZruI9saQ6J81NaRTZ37BFGasIAk5FojpFvBwKCSuTwRBIpP7uTqPvE1bJJ2Qaz8CYpFfLwrkk1/4s4L2ZMZMbqw+2Ti70u7pYizuNrloEEKlnHTqAAyTOZWZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882189; c=relaxed/simple;
	bh=p2e0L6BJd3eYaXNKxlq07c/fzPpFlLTGlrZWwVdbo1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwbY9IxSgTBrvTShevZzVjcmu482ARr41mHv8vHUs1TQZ9c/Q1/Wlwt8Ci/mUb/lqp/tlGE4+44esJJ+gCEI2U/eIyZADChii/b+MngmXFokCzEOtiPpXwM5HEm6R2P5RWI/bzTWLk9X3gVtBBJl2VlZ+sYH667wwzN5mD4psOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GfgJMAJx; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HKSJ3QWI; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GfgJMAJx";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HKSJ3QWI"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688ElZLZ1845196;
	Tue, 8 Sep 2026 10:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=3VEJ9S51As+8i4RFTYMsWN+iJA9+Vwrcx8aSerRNm
	30=; b=GfgJMAJxQdD01ovEsB6A1JPgQGpmcrCBKHxAEwUctTYZ9Ko4S5P9r/hDc
	zLJ/+wudJkIsPoJ1BJq/ShVMuW5ZEbeO+WJFfnuS0FSKlBj8HpWQVFLlbx1bxwQI
	8edfcYpZxnuma8XIUxbE4+gE5ERhw9RNBKRfAP9bC9lk7Jn6YOWL7coy7y5ApCJ3
	f2QAPzebVbMnsfO/o0oFxmHGz1JrBSAVRfMieL8tXUg8npTasu3e8HyhbR/Gn0DE
	WQIJX0SX02undEiSnaXI+ocODnsjuooZ1RJMODgnEUOBVaXJT6WEHkLRCT0bFkMd
	LCn9fJU5KF1AOU3Vuh5UyrnHjCPUQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940mxx7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:42:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiLL/A6RhqRRLK9fynYaZRi6z+ekX3rxAkQV8hFJWucTvEEMVmTgt+Rvo3TUGYXAwLqWOol2yebMqJaIdTFAz5PRSWOQfhRGahCOg/FOWEZaKy5G8iZ/qb9KsbIkj2ASux/0zFYxsHkdohLLQj21sPwxm4/aRYrHUXPLMFPWJg85NEDD0ho34RLr4NCJnqn4H8nWBHW+VZySJtZ1LIBMfZZo2vtclzihBDW/vrRO7kTyvX4VlpHwR5gPTyuoh3eAbYKT38Z+kR1jZsgCv3ow7pgA1t8hDilQpusd0CMSbHrcdgyXXgMvLURCYVDVFcG7shpYtnmSceWCjQeNumWKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VEJ9S51As+8i4RFTYMsWN+iJA9+Vwrcx8aSerRNm30=;
 b=xz++nbdT6rlCmjKj4f1WfapByvGtB+Gy7nWf9bFkG6xhtQKpzFK8MR7S4lUpdFsnaHw1pTVk/LGzevQ+WrygJj70IkeZtc529Ya+SkkFASidLt5WIBLYBqh2UaB22lg2C9poxSdJK7bw8R0vIQ4NlPipoIgQJ7I/jTC3yj0Ow5ab+Xd5GhMH7pda3PFH5tvLZ0NPs6bo5KnrsgiSuqWjjkHGGBexBBKndV8OKi9WYE7xdG2YDguy7P4Sa64r3LFpHzqT/sgywUl1oisc0Mf54RGhCO8KSYPpxSFc3GsI8Z2mGCUJISYAm4S8ua4Q90Ue3sou2WOHdalPtDNS7xuuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VEJ9S51As+8i4RFTYMsWN+iJA9+Vwrcx8aSerRNm30=;
 b=HKSJ3QWIjx2+Mmy2jLFXaja9CVghF58QuzsYB4XP4AmcmH64mIKtnT3V+H/GK6hpB93a5VA35SQRd0PhM9kaILzulL4bqSNRxeNj1IDocjrVbI8JjADQGILgD9Vrx4BumIa/jTZBb1qfdQ7ZRgB0xXipuqjt/VQe6C1s/UoanFw=
Received: from CH2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:610:4d::25)
 by PH8PR10MB998088.namprd10.prod.outlook.com (2603:10b6:510:40c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:42:38 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::50) by CH2PR19CA0015.outlook.office365.com
 (2603:10b6:610:4d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 15:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:42:37 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:27 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:27 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWg3725209;
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
Subject: [PATCH v2 6/8] i2c: omap: Make reset bit name match register name
Date: Tue, 8 Sep 2026 10:42:21 -0500
Message-ID: <20260908154223.116074-7-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH8PR10MB998088:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a14810-6ba6-4f51-a60a-08df0dbfcf3d
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	WgDnT8vnH+kiapnMt4BAp/SZ0KNUBRNi1YuPxLeNpxs1fzufljsL1rkFK0UB37yAN7V6PxZKP/1YcuQrANbOEx3tpBB9roH9rnHbbL9ZuLG5q/sPEkA6Z6AkPjADuzzGQBhIb2zgE6aLv5+9/FDFzCKzzWIRVPFwrqJOthD1ZjkcP0lD7T/d6tM/ereDbjpyBuOongoJubfDzCr342VysChAn1uuKbchBUWJJW6hrH8bP+3DpikX2SSmeLg8/ijpMb9s6nbRL2m6ydiXGZNPBIIlJ5ovs5I15zaXzLbn2Mjtw+7xhuiWZVoRNEk2u1KsgV24c+ua+45fHOIhJzOrggIX5Y/0kw9aUsWy9FPniLuyh0JZpyfBfRynPjARVfl6HxdyOtcQrmyMU0ChJ5S+xPSdVD/ZDQN4I8pKBzNoXU0CEy4EUkCMGvqABAhIlrgj+sTl1ju05Y2ZVXIVui2ETXnNq2CJRz94niJr7oeB/WJEQXzpgYjqUJpjEHJJCslxTPF5RoD4NDQRNlimv+qFAfP3hXCmjeMWQ/1EMCrUWfSB2SAwn+5uuotDYb+CNu/iYgTmrcwoRAOw2ZcwYKydyWkCAUWntivOHJ1VRBI0ArD3VESZuS2+be2QlkDV1WtSdx03+S0Z/dafOWz0qd++jjc8P8i2CliKKTRqPOnxMWwi8OebKLflE5z7EPxfSK94h27FYh0xcZ4yq8Thlg/9LA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yi9GH4iBhnuhT4NqMcCuHs0vB5TPwjbAziWd8saWA/lXm5n2PjXRvJ66wdC7RNpDcwUt2l+XF7o2e1kPy33aRF6FcSrreP5ok6wtuxIY6fUP9zm3JvNEyLYRibWDb5UFDLfi7imhHYToMBSmTTUvO0D7foH4m5//vq9zh7REIEjDKQemqWiv3l18o+EDBQbJw6KdF2NnsqUX2D81Q7Or9+wyZyUGimuSqbaWxXHV0vbULQUbXV8iFgtsk0qYs4xEfc/e3ujeuMyKp/DnQB8yXi6A9oeFYOBmEA80txesS5JwnFs/vdvo7aWJ7WWefDgVhV9/ymeEkfbwrVF9tBwTN7jW91CCB078SIq/Dyf0QOSdl5hGdVyLmhhTMPko27CgwGxSnc+79j5uuD1/Zje8qLnek97oTH1+i4HCbZteghxBQWThbTjktHCfbjzjLZqT
X-Exchange-RoutingPolicyChecked:
	S2YGP2h/Ylw0vF+GtLS2YT5im7weMou6hYbESFZ/aJ+vmQlnEQYBUkS/M+KZjp7GY9qyPgYd03FZmtF4xgaYHVjHUmuDnJ29rTDBgL0byMsbSEnW12uEiraUFhepHN54HKhtYi4wa1TIO1ZkJggPh9PsIjf2wknKKK+GVUtSElND39M1XyPdapxL+3pnkdFTfZjS79q7M2M/PnAEtJFWQ8N0wT/m4whZWxUBD5GyobTUHrartzJOyxYGOVE2EUjOAo02i/2x13uWGeL8qq29s2uxNCl3dJ8O3rvgXHUr/BvC8hu2uSqLBFv6nLelWqki3JL+UH10rGRrgx547Yj2YQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:42:37.6315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a14810-6ba6-4f51-a60a-08df0dbfcf3d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB998088
X-Proofpoint-ORIG-GUID: VeGDNFaGV7IMuHEuLauA4E-EyMM0-TCg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX8/5XiQHZUbnI
 NfGEjUm/cyJWCWCuhbFs7jliIf7pDInr+nSBSKATl5Eiemlj26RChdre9tjH4WosH0DyEdkW4tc
 L3HjhCvyERR2LwuWxgvtJspBFVlHxH6/YrORPuH9qzEDJZehHWVQTtlDLJL9DVghW9AaCWTbL4M
 thuwWZN/oIKa9ucMt3i0dHXsdK3xDZ57O/MIFW7gz6PINTyjHkqPVuxvFhF1FmrlAB3EmGgwawR
 /97iDx8U35FTJdxozz8VCJulStDMJF7+XD1dDw+e0izmERCR3Fnk2wbe/dyxi4qlUuP5YnmgtdP
 SzZDKmbW3kHPbpW0xWQFGNJltCoVobhc6DFYntuIEhtUJufdkd6PzihO1B6L6wCHtkipBf4VFEo
 HbkR3+6pAXYYdIXDOTNRht22o53tO/WzuAt2m9oKNQi+dyRcxnNFwLB77ZXfwGOw7jF/laNczw8
 3rcJTlk0JHA3j3RJ6jQ==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6aa02cf2 cx=c_pps
 a=8SlpipC/tMUw4p3hnqM13g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=jiVZLek5lCiKkj7Mo_QA:9
X-Proofpoint-GUID: VeGDNFaGV7IMuHEuLauA4E-EyMM0-TCg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfXyl7d2jmh2C5K
 zqnl3rAluHv8rDNsCdEORsgpGntWIHA6QOF7A5R0PiU9eCbOS2xirqCCZW67uC20zk219+MRrMu
 PiGbuH4paxDH5mIK8bfUukewjVAUPZQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080169

The bit definitions usually match the register name definition to make
matching bits to registers more clear. Do this for the bits inside
OMAP_I2C_SYSS_REG and OMAP_I2C_SYSC_REG registers. Remove unused bits.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index dc75780f76c96..a50cf195c28cf 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -133,17 +133,10 @@ enum {
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
 
 /* OCP_SYSSTATUS bit definitions */
-#define SYSS_RESETDONE_MASK		(1 << 0)
+#define OMAP_I2C_SYSS_RESETDONE		(1 << 0)
 
 /* OCP_SYSCONFIG bit definitions */
-#define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
-#define SYSC_SIDLEMODE_MASK		(0x3 << 3)
-#define SYSC_ENAWAKEUP_MASK		(1 << 2)
-#define SYSC_SOFTRESET_MASK		(1 << 1)
-#define SYSC_AUTOIDLE_MASK		(1 << 0)
-
-#define SYSC_IDLEMODE_SMART		0x2
-#define SYSC_CLOCKACTIVITY_FCLK		0x2
+#define OMAP_I2C_SYSC_SOFTRESET		(1 << 1)
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
@@ -293,13 +286,13 @@ static int omap_i2c_reset(struct omap_i2c_dev *omap)
 			omap_i2c_read_reg(omap, OMAP_I2C_CON_REG) &
 				~(OMAP_I2C_CON_EN));
 
-		omap_i2c_write_reg(omap, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
+		omap_i2c_write_reg(omap, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SOFTRESET);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
 		timeout = jiffies + OMAP_I2C_TIMEOUT;
 		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 		while (!(omap_i2c_read_reg(omap, OMAP_I2C_SYSS_REG) &
-			 SYSS_RESETDONE_MASK)) {
+			 OMAP_I2C_SYSS_RESETDONE)) {
 			if (time_after(jiffies, timeout)) {
 				dev_warn(omap->dev, "timeout waiting "
 						"for controller reset\n");
-- 
2.39.2

