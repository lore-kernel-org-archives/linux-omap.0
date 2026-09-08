Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15809563FC1;
	Tue,  8 Sep 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882202; cv=fail; b=juFFKWjjAmZt2w3tMfII5XD5pUR61HDaeQnmcJe+JyllavkVts6DWInSBKmnNNOzNafw6JHIxsZjmqDxx/mOWnb6lsT244loFmwm+/dgsly1J3t6fMS3E8coVr5I9+yzIgN71gxJu056PnL+WUTWyrQ5RYcRghJi44hs2+s4Sgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882202; c=relaxed/simple;
	bh=zRdXX2S7cfFWaed8buWY1oJSQQ+1NNUG+ZARWvgYeJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtHahEMkOtH98dV66fCaP6bjp7ut3axIc7xKnMkZv2EgJF3ScKY60JRbHzXR/OhhnTvK2X9rd5PymOpezkv2V3+xrV0lR5u/yjlB7myrARmyjCuq/e82Xh1gPP3EK9AM+lfzYvhSeYMu+V8NbWlDHqIuw14FYePvKLUyS7+FZZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=j1yiVcBf; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iwGbschn; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="j1yiVcBf";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iwGbschn"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 688Ejwf62032955;
	Tue, 8 Sep 2026 10:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=K7POOkoENI7pBO6nO+goDRRn5n4Glh+Ta45eXMG4r
	N4=; b=j1yiVcBfqzce6x8Jmv8vUHg10P2ruFPTrC3lbz+FwAVQ2+LMMeQ67bpcx
	N/kTfS74sN3Tds3jlnkG8XqLDmP3rEJQiOtnbiqFcSekG9CcqLLWCcXsmjXypZZ+
	e6aXs0qXprnnPU9BsTPh1jhHPPIF1w3vVZX3MQ0OQhGuQafjIv4fovQykemR8i4v
	CYN9NfD+5j2CrEG4Qbq9Gv8jtiaQqzxygeO8IJcfrkj5HMRM9PQ6Z4FiP839SygD
	gwswq2Oz4YopoSFoYHJnkki7vZXqAfeyWPByfUYwfxe+n3XPBr/FJKUFY3mfVAHs
	VhV05SdNXZkmoz9Gww2POBDMZrhOQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gjffmtbg6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:43:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQmlgm7fq18x+HU+PzslJ3/OUFmOpA23pQ9zDv/xxT7vHHBPEQd1gf3dP1/NgayWIolAUOdPzCAuLkmJHqsYhAM6Wz+UkWvagJC6YTSVHdfAQvB29iqsTNb4Qvx7eWfJrvdpiHgkO0dc6V0/10wk4mpK9CSQB9bPOLEFHoxnVcS+bdIOjzQaV3cmbIstcbaO6PlxXlkeODGSvTksRVgGzE+ldcIspXeh5uUb1fWewtwP4quN0CKEIbxLbXnmqrLLHWKSuEwc5GTwMDaU2/L3Dlg911Wo5Nb/6zjUyDaP4vVYGLefMmN4x66x9HGPB3t4zNvHr1S4hROjQEXTrpIWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7POOkoENI7pBO6nO+goDRRn5n4Glh+Ta45eXMG4rN4=;
 b=ntFLmo1kvP/iW5ilfRaie/vBx+VH09P6ynJYNU3w9Qur3KWwMLiioe8kJMv5JAbq9jYd8850ec+bJ1zedA3KOl0rmiJMuQCT9dVKcJztUpnIS3NBq+N2l6ETQL9gllKB/NtkAs0YKqUnmMRfsypXTqi+rZlZAClhg8dbyML8gp5DFVTZP4Re0aknYtRrldAfNDXx2XoTOZ8vUUP59zxbB597diLHowo/R9sHNqNtHYmGhehU5OMe/ewtxfwctrLFCM4/hr8jsjbWfHO+M07sr/jpQ8FM6NhVsygmU4wzO6iIOmD0xptU10ZEQoYsv4wM7d/NfDjeAcABm/2/vACXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7POOkoENI7pBO6nO+goDRRn5n4Glh+Ta45eXMG4rN4=;
 b=iwGbschnYQjOm0ZClzN8LQycSezdRN1RTEN9bqo2lFWBIu3Ehz+anoOcEskpbpRQ0QmVirue4uCvdOqMx96LGNEYgtlbv8cUve3cOmOPy8Tp9sLGPxEr/o2otkVII5Ne3kMQXq3QIPelj4I40QWyB5lkeQJg3RkwrIyw/NYwP+s=
Received: from CH0P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::24)
 by BY5PR10MB4225.namprd10.prod.outlook.com (2603:10b6:a03:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:43:06 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::6f) by CH0P221CA0038.outlook.office365.com
 (2603:10b6:610:11d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 15:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:43:05 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:26 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:26 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWe3725209;
	Tue, 8 Sep 2026 10:42:25 -0500
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
Subject: [PATCH v2 4/8] i2c: omap: Combine event flags register definitions
Date: Tue, 8 Sep 2026 10:42:19 -0500
Message-ID: <20260908154223.116074-5-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|BY5PR10MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 3707c6d9-3f4d-4d6c-e4b5-08df0dbfdfc9
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CpRoDRSTZQXFKBrIxV+8dc/SLKgqZste5wTpWdxyFzw4MdK6pfxDUAC3CG+rm3UCtLygw56ND2AxxaO3YnUW0nriFMbPe8hGgsitlwjdMJkvX+KS0L6+v/rJs1goW9/onqp46VEG34j3yRM3+vvYLSmM6xsIFyS++s+WoKpyYjRlqA9THkZt075P7t5da/U+1MJb2ZdsYoJ65nUuAxGA0H2R/6NiEFvyk/RpGe/9YGG7t8SUXZC9WzE0v8b5nKvFTUtUoSicaqodOBypJfEuCwL3kcuvp8JmXMjaHCsPWNrXIJKt0wryGsbAnpYQqHEfkjqMQMWnOLIc42NfVQj/gzBUk+lO2ZBBhQh1BGte4rSTa5lAFEcLUAuQZddGJ3CKA836+TJXLp12twHSmX2VY8PLvseN2keJmZDqA0R4qOhGqSoLmCURfS1kY62e5eNeVHesPG0dtEhhgniBJoV+221Jh0fe1rqet0/rKnoelDhNh4vqt8iDov4h/LBrj/yhQ0/jQfh9TNUa7DU5B9PJ4s/WSU1X27DodX4Iq7I3c9tbckzfO+CkF7Y3vQESRIOVwkEoGKXOnxZQYVEqUtOAXysXgyDy8WfhaD+ePRCveL3DTa/9mTLndR3h1iq6ZdzanH1RE8QPEVbN1zInh5Ycln/KamxokvSsg/3dROtsym3gDVZvWQgNrOzTx8bHvqfEIiLY84fVCMJywHQ8RZg23A==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ku1jF7m5bbJir8rQY6KYXVwxLWAR3RLGhTod9RAg+3ByliU/OXdyR8sSEr3F8I/inCDg3NlhGggo32V7Rmh1G9B2/T5MPYv9+yFjZv8DcvBfjhmC9ixWaizClD35mNdAzKySgY0LPiu0TAIz501sSlIMoqOJ8D03M4SR6eG25uiCIRN3tCbt3rbINGl+DOa5DLt0hNbPBkREEdTPQ3yZyEpCR9YVSEJzyEX8eGmbhgMX4g9QiYnQIKR/itZuzBrUk/7SvWFHTbiNXVsSAJhlOYqbxA7jQSYsUBz2NBPzC3kWNv/8XY/Ni9PW3vPQ/Q9gAYGbHtb+uYX7ouebp14lqO1j7f2UpfF7FMT9r498PaS/Q3VmJCta/GNzaQW3Mn9P64WGXuLtMTE8r3fYg1DKzcDin9QRmcT3aYXyzhOGos/YZZ58sOfHgXWdFeHkwbKk
X-Exchange-RoutingPolicyChecked:
	aMz7rczu9ES9nb5hx4mxp8vw9eJsvzrSTPX5ntYQNG7dYMvwrCrbgOPYM5HtFzjCijxsPPsEM/H3OfR0bNLpMwUdT26ur8QQgp/SVZoLq39dcFSjAI4SAPX1bISOmDaLPjJ67k9JSe3axopZkR46oec9e9U956OawAVX/SpNYpZ6PvLxgBCkS0tub1sUjv01zPUYwkfdUzvzpmu0h4qtEdPP5D4kaEmS8+x1hKFwwY0SxEtaXKJtf6f3vy4fqMQ5VR6M+iHWSGJBnp9jLBRrVjzNiRVo35LJlBCve1iumPthzk13zyRsWwsltuyknDDiC6Q4I+rwNzTOK+H/7c3h1Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:43:05.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3707c6d9-3f4d-4d6c-e4b5-08df0dbfdfc9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4225
X-Authority-Analysis: v=2.4 cv=FewHAp+6 c=1 sm=1 tr=0 ts=6aa02d0d cx=c_pps
 a=u5a0R1DJIqwdmu/eAz29vw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=-VTgE4bae0sfXoRtrj0A:9
X-Proofpoint-ORIG-GUID: 3zT3d2WV8oVOskw_KvtoQylD8GBeXtRi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX0e7tyJ+gEeiP
 TX5cHRCV4itVCTVNuUs8MDAUzei3/4PKO87Y/AuNR7jY5Rno5j9lxOWCa6W0CtvYlYwpBqVZQea
 MRPfQDGKgPslNSYopWSlntdZMWUUoWowU20wcD8YHf3Y8G04HiLKpgScZLuOom2s7GmCcAVZfdR
 Rrjz7JJ90GDB48OYIEfDnbmbGlOG7ZE0snrLhlV5/lMCbPLS3HqUJyCIFuzN41SXSL32sf9y+1h
 CevaVInWS5ePRaUFZxtgr4e6h0lpE+VvJttuoVudnjZGBR8nRGR9vrmj88jcomhE0uJ4zm9+8MV
 RJVXT3bvaU0aWugS7vk/9p9maA1wy7XPRqtfDCQinExJnjO4ynNmeLo04u3+efDQs+fTN5RG95k
 0dm/aqC6h4jqOY4fvm7D82pdGmjBGP3IoZcku5WXd36ouTjU4bbAPGr/+vXn4tq3SWMk08MnvpW
 AP6S0qYR41srIpBfNGg==
X-Proofpoint-GUID: 3zT3d2WV8oVOskw_KvtoQylD8GBeXtRi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX8jFxBw5LjLp1
 DzoN6LjjdJCggclVZ/EPpIaEYmpuExbyWBzX6wlS9cegn+wf3sdDe/R2nfU+NL6/UxyjoroBQX+
 9Nc8gKKNe4PPuPIre1i8HjkDGz3488s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080169

The position of the status, interrupt enable, and wakeup enable bits for
each event are the same in each of their respective registers. We only
need one set of offset definitions that can be shared.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 58 ++++++++++++++---------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e03519d939755..cc65dc90770d1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -78,16 +78,7 @@ enum {
 	OMAP_I2C_IP_V2_IRQENABLE_CLR,
 };
 
-/* I2C Interrupt Enable Register (OMAP_I2C_IE): */
-#define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
-#define OMAP_I2C_IE_RDR		(1 << 13)	/* RX Buffer drain int enable */
-#define OMAP_I2C_IE_XRDY	(1 << 4)	/* TX data ready int enable */
-#define OMAP_I2C_IE_RRDY	(1 << 3)	/* RX data ready int enable */
-#define OMAP_I2C_IE_ARDY	(1 << 2)	/* Access ready int enable */
-#define OMAP_I2C_IE_NACK	(1 << 1)	/* No ack interrupt enable */
-#define OMAP_I2C_IE_AL		(1 << 0)	/* Arbitration lost int ena */
-
-/* I2C Status Register (OMAP_I2C_STAT): */
+/* I2C Status bits (OMAP_I2C_IE, OMAP_I2C_STAT, OMAP_I2C_WE) */
 #define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
 #define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
 #define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
@@ -95,29 +86,13 @@ enum {
 #define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
 #define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
 #define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
+#define OMAP_I2C_STAT_STC	(1 << 6)	/* Start condition */
+#define OMAP_I2C_STAT_GC	(1 << 5)	/* General call */
 #define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
 #define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
 #define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
-#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack interrupt enable */
-#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
-
-/* I2C WE wakeup enable register */
-#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
-#define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
-#define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
-#define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
-#define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
-#define OMAP_I2C_WE_GC_WE	(1 << 5)	/* General call wakeup */
-#define OMAP_I2C_WE_DRDY_WE	(1 << 3)	/* TX/RX data ready wakeup */
-#define OMAP_I2C_WE_ARDY_WE	(1 << 2)	/* Reg access ready wakeup */
-#define OMAP_I2C_WE_NACK_WE	(1 << 1)	/* No acknowledgment wakeup */
-#define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
-
-#define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
-				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
-				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
-				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
-				OMAP_I2C_WE_NACK_WE | OMAP_I2C_WE_AL_WE)
+#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack */
+#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost */
 
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
 #define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
@@ -360,7 +335,16 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 		 * WFI instruction.
 		 * REVISIT: Some wkup sources might not be needed.
 		 */
-		omap->westate = OMAP_I2C_WE_ALL;
+		omap->westate = (OMAP_I2C_STAT_XDR |
+				 OMAP_I2C_STAT_RDR |
+				 OMAP_I2C_STAT_AAS |
+				 OMAP_I2C_STAT_BF |
+				 OMAP_I2C_STAT_STC |
+				 OMAP_I2C_STAT_GC |
+				 OMAP_I2C_STAT_RRDY |
+				 OMAP_I2C_STAT_ARDY |
+				 OMAP_I2C_STAT_NACK |
+				 OMAP_I2C_STAT_AL);
 	}
 
 	if (omap->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
@@ -459,10 +443,14 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 		sclh = fclk_rate / (omap->speed * 2) - 7 + psc;
 	}
 
-	omap->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			OMAP_I2C_IE_AL)  | ((omap->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
+	omap->iestate = (OMAP_I2C_STAT_XRDY |
+			 OMAP_I2C_STAT_RRDY |
+			 OMAP_I2C_STAT_ARDY |
+			 OMAP_I2C_STAT_NACK |
+			 OMAP_I2C_STAT_AL);
+
+	if (omap->fifo_size)
+		omap->iestate |= (OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_XDR);
 
 	omap->pscstate = psc;
 	omap->scllstate = scll;
-- 
2.39.2

