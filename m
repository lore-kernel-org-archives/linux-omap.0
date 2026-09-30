Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC3470444;
	Wed, 30 Sep 2026 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807789; cv=fail; b=HKT8o9gREqxBSknep+rwIsIhzK12aqUT7psWnxmo91eDzo+TAQKuBvjGfboI4v2mJ+7YaC6MeQMq4acX8TM0ZeeAXfGHWABYGV/f3v8k6cYBw/jnQS3CrY7HJjDPsXpj3Tan08pmehaRiTPyabuMTxKTMjFrVJ9srJb+NkSZSZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807789; c=relaxed/simple;
	bh=uBK9lZC+yt8g2E2BpKjKYoo2s7yrFCQAj76bITCUplw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H94dQQdzmZWS5ZZCajJeVwP40zXVIqgfnvyJNBh0G51zTpqkn4YOSUQZ39shlpygzOMITzLYOGzuSo8+SX2erkIO6v99fmj//mF4eol3ivw3hnJybdf+5//fixl8XZDsjE5Z76DwnlQ94PEv0w67NyVQVi5wWp0CaHP9n4LOR5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=l29RPmhV; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=k76hEk/c; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="l29RPmhV";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="k76hEk/c"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68UKkE174104472;
	Wed, 30 Sep 2026 17:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=o0/6rZEs3QT63dLFfYRFps+2s2jygrC+CtWN602Nf
	yQ=; b=l29RPmhV+YchCyIFYpt+RWJ11M4oVlF5HsDicREJ6rEETzKl+ouFVnAvw
	jQ83+UzkD8hMxnIR1h50WyK9CVzaGwn6IrUsh3CbhqEuxwlj6MTIjpFqgtGQKuJM
	AYqOwylpcK1Tqk+d6XrnQeneUJBqN/TV2R065dKSjWI5fjoUyuotXuHflkLvLuUX
	RAi4QmMJlPu7lfC3/QTsBr03kUaRqIbMpziHUAVQ2iw6DcfSD4lqnLWcQDngyRdO
	I2f+ifgH8YgOnUe6dsu2HMq5FY39qDLGcumwlY4X25ygLa22F1tjEHudwcjqmO64
	m9zVrXvRzggTKNOmfIDLzrpwOiHmw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	by m0380145.ppops.net (PPS) with ESMTPS id 4h10t1uvhq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:36:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUU9jT9/NRNlROW8p+mw8BzSFXVodebwEh5Zy0+JkqPPoGZoymYps/88VqfFz7qiGc+NiFJwPCMV+VXIqiUVyPKHhvxicA/kIJ2idx5lVaDeQHs4txysr5Ou+1TuVd1g9Q8QUvkamhtiWwL6HSTYC2FcZF8ZDufkEGlSPpgEbQCuNPhci9u4VLmiF5XDQgWbh+tY54YjDVzLo6d+RrikzQmMg9HRf/4H5IPjXY8TEDyv2aXzkXowLw4xrYi9DyIZN0k0YQV/wrI/qUdIM63yscaXg51/CU8I8Lyz4SzTWI5ALh2kddoNQj8+oHA3elfvM8JWjboGM8hJlaZ15rLUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0/6rZEs3QT63dLFfYRFps+2s2jygrC+CtWN602NfyQ=;
 b=VRLhSpd3VbCESMZ3mgXlIqov8iz8CvPFjvQTjK8Yf6yNXAil4Y966pOLh1gJF+D6OE91CDXt6oUKtC/0k+EN8+amCoR3UwqkjbnZ6CUGyXUndiu71xopk4Vx/llzRmF9TjkPUnF3T5DhWtNZd2saBw+KCrCLuQRhtnDfEqqu9b1x92TacN4Q5A4ILI+QIlS0tijj+9luKV/Ne3EA1XU+9DmrabOUAVLVxD352NjFKijjOyU7twkHLhosJe3IDYtwyMVeQ54Fzoj2BG7qF4rHU3YWQsUwTVz9Zg3F16mkLYhDWqX/tDA8/WHcK22rwBt6+YJOThaJIWU3TLskoUvSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0/6rZEs3QT63dLFfYRFps+2s2jygrC+CtWN602NfyQ=;
 b=k76hEk/ciEZxfaF6gV393EibY2Az+I5PHHay288tBPLYBUWcYJiRvTO7VuXZXx3IwmHzWQRuCWvMx166eUTqDRovbutVgBOB1ql6Nmluhzh02txgDArZgLhY1dtK/IITLi9VyjOIKpFnWjchCTu+1Dk8VJwaTiVj4w9SW2JPApc=
Received: from CH2PR18CA0036.namprd18.prod.outlook.com (2603:10b6:610:55::16)
 by CY8PR10MB7121.namprd10.prod.outlook.com (2603:10b6:930:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.13; Wed, 30 Sep
 2026 22:35:40 +0000
Received: from BN5PEPF0004698C.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::98) by CH2PR18CA0036.outlook.office365.com
 (2603:10b6:610:55::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 22:35:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF0004698C.mail.protection.outlook.com (10.167.245.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:35:38 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:06 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:06 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3Tv3969567;
	Wed, 30 Sep 2026 17:35:05 -0500
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
Subject: [uL RFC PATCH v3 5/8] i2c: omap: Use bool for flag values
Date: Wed, 30 Sep 2026 17:35:00 -0500
Message-ID: <20260930223503.616776-6-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698C:EE_|CY8PR10MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 338c67c7-8a21-4e48-ad49-08df1f432707
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KzI57IXX6BCS7VP+yQrgeEe5bf+3wo7duRlp7983TypZMeL86/iT6tx64H3KRF4TicKh4E4XlCQ9W6bKAcoRfS5cvQannzm7r4z6bUSM0/jm+FvFfjRUHFrgt2LK4xUdC2MPR1z/9feQ5adv/2KFa2Kd+vtiHEpr+XlyyXCOt16tA8MX4yHXZEjr1ccZ94JukYrIQZ/uTixVjXcFjmmkCfX6XbFgAzHBMy4Q84Y9qfu0yJ98EB2+URR2PL3qT9K8ZkqqWB9yQT5CrfoQm1Ssi7hPVrBZCN5ovFzoQgGx8SorzR/H/zFQO+DW0B05lz2JRlCQDMOYR6atQ2/42Sfnh8g4YoRMNmWgZZ+YzLkkjI3VNQPZLaSZIADjDAAibHrCG9/FOxXcftTueXuAJMYGQJROVJYLR9Q7bDf4R42ds1JLJxGmPKi9AKi4NMKjukzkvumg+yqzdNgy9QklmNdGJo8m/Y5U5EfQoV9C/nqgCsTUBdM/aEDpDOZcPPzNEuytcs79tLDdkje+rNN0Mu01k5+n6O+dLaf/L2FtBtzDt/3DKdIWa92zqYNCtT6cqYwB521qrI2drQ8vZApQs3o3zswBO9s5f/KknU7KyLsep7Mr6DFT6Xhk3Kx8A5cKwwxWV0MGfpde+G9i/VFqyMoNYE9TM8yyvwBDJp9rK+LkCsPQLPwLRn0bS2R0ha8+nrDEQom6QpR+lezMTxypKAMMNA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tvOJpMvWMxLxrgKv+ESiOL1WWnWcenEdJCcy1/hqi5LVge3ZA/O0/wpBSOXi6DIckH/0u9EJPVS/qEtFExA9SR9Y7Q0Fe2t8Rk0piHNKuuw2xwZU5oBYaD7w0SLt5speIuSi/xbWTL9ys5r6SPW3eL0kIbjfc49j6ZSylwsIhh1EMfc8CC5t7Ed6rrQjGoK7qIkomfa0qHE3VVt3Npb32mSoDCGWQ8sZ6YDIEmzplSnBs/p1EVtqVLKjRjCfjKnHgIVdBYawR6FjkKMBCcywBZdTynI9pCkZX+/p0x1f4vPxjxJArfoj+Xwql1wB/8MeE+vArzqvDPWktsWXTTyrqTq2clk/FYMwmO8G6WoofTdwfBwIqMEgGAFL0iF4PV2C/9gM17PueC5UhMizGGbWcyHBayNwP5K/kerhjDjM07FTZ2KapXh9F3BL8WcxgfAp
X-Exchange-RoutingPolicyChecked:
	E8h/RcCFlt+rvWXElRu5toafD92N3WcLtSCQ4LYmBV/IvmIX9Q7UedyBzPj5ORrG6bB8UkjG4B/V9pnNXSdDqu99y7Hw47EfKY+o17V2QLM7KfGmNC50SyvihIWAqUg5yYikrze5lhOTyWUkPMTRBgherZ28QaZ2U/i+9IDVgl6iomFUh1wAzUqgULUHQ3kEbIZ9gtyGdtzDYmlqRhNCh6xtMOjgo4oZGs+fV8QkLFRk/tU5c9ervi+5TDYmRwWMmnRBM1W7CslEqA77Il4wLDK8Xojtfv+6WcjS0HVsCMYfhRDNqp+cz5usFSjY82byYlc7aZKiI2nY8lHxTPB7zw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:38.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 338c67c7-8a21-4e48-ad49-08df1f432707
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7121
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX7npBpryKK/0T
 w5L7POHCYwfBmQ5e3OHTBfpYpTZswfHpLwJ0v8lfnUU3J47jfl7ZH0X5up5ybuzA7VMW1B12adG
 G0mjSFaIL853yuPajZiyaetfw9Nz09I=
X-Proofpoint-ORIG-GUID: _OfUUPm10ZuFZD-vsMPKzjP5wGqhEGm_
X-Authority-Analysis: v=2.4 cv=C7R8WgP+ c=1 sm=1 tr=0 ts=6abd8ee0 cx=c_pps
 a=R4qMYQySjg0trGpnu7oNJw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=vVWVvIjhg91t4kWa_skA:9
X-Proofpoint-GUID: _OfUUPm10ZuFZD-vsMPKzjP5wGqhEGm_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX2XGxZIrGRlTP
 vEvN6hfgn3f6UMmAIbQ8OauCV0U4JZmAtCZcEfAF/qCpD+E9GJovNJEdHkl7bKs5TvxB0tEaZYs
 cl5iwk2pxFtyJ7vk68vfz8OLlmZFR/uBUu0US/7aWKAHuMAzWO/vt1n3SVZwXZOYYhUTXtE34kZ
 M1Dw1vCIH+dBoaoxXCSSTzfouXimxN6xxwfLb/UnSz5CyRyKpJIg9D8MTDHTnGqqdlVpMpoSqQx
 3s46FZO2sykKvfYJcy9fBR0DfPVJav9aW8wxLeoKpWsaLWibyY0yo3V9UYV/MLgtJ2yDt2nkqCG
 EIMYhCW+qdMQ0t/YeeTZjjvPR1zmb2UxSdbbU9XiYtf+mOgW/qQZpGcDb1Q3sbVNWsBNjixMGqs
 80X9kjkQRA6+RHEE0lt5u2wTpoXAVz+WBRYObZdTGKoL1ZWYys6HL3o6/Lt020GS/e50YHVRkpk
 dUbcelEbpGCvUhJHhEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

C bit fields are weird, use bool for single bit flags. The compiler will
set these to an aligned size in the structs in either case.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 61e0dce168067..c28dedd640741 100644
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

