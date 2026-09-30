Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3C457E5F;
	Wed, 30 Sep 2026 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807725; cv=fail; b=lQTtvC61Hu0v+Z8WHU+eHPKAG2Fyjo1F/SMc3KDrH2XzZoNDeVhiPPVqhBnvTK3MLqqQngrJLUQw5lQJ8sOfXZcDDWO8n5SdkkqkYRrYuWv5xKXPEpcUG0jsPNbQ70kZweHU3tOTqrLcQN2dsAzOnupckM6qFQ13uxTVo9TXoyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807725; c=relaxed/simple;
	bh=KCIKtfrS8pRt/03wm3J2L7GOX6ttxLmKOI88G0+K+RQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkBga/UZXms7eKLd6V3jJJj0wozB5y/llfBQc0/50NNbyv83a2ePQdThapdFB0vGnhDo4KqgQvmnTdkoaC5gPgH2aQG1JJ+oAAdBSdSBJuk2yI8pHn9cdUaIMVaz/Aeep4TtihNt2yLVM7aawnJ6c+OHoDOV3+Idg2rs2C/sBJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=hmd3LpaJ; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=Qz+3S6vd; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="hmd3LpaJ";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="Qz+3S6vd"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68UKkQoL4104973;
	Wed, 30 Sep 2026 17:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=IxksHBLbXKK+0UkaLyuFS+Rba7IAndPUUE6RO/8pb
	qQ=; b=hmd3LpaJBWodwBuDHUEMPJK2BuGhHahiM1O+K4AIBuqZGqzQJS3JwlQD9
	hITeY50c3dN5EozRlqzEWpEyck8PAr6x4JnZJL1PBgcZB5FR7m3g5aYm4PkM4pYO
	stEhIAiOiqa4sOB8mwjSfOc85BA0rRi7ieoKjno/B6KF6mSi0Z6uyo8dajYMLkOm
	TyYRpFKLRe30co7KbD68AEnuwG8wVo95V4k0lRdE+zjIvsMALC8S7Pp9lE9WhzQ9
	Tvz8h5i5DCAMrAriGhhRenxhZdRAE5CSqE+EgQ30wRKKi0hJnqOoes9H/m4ilK14
	RvzihM00clAmxqbLK7Dv28nuuW+nw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	by m0380145.ppops.net (PPS) with ESMTPS id 4h10t1uve2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMfw1TMSGwOPm/kmINsDAsDurE7chZlYxaiyEZwLf7ww055JFjGOCgAif3WTx5/Y8IbEZpsJb6W515Sa8Vv6JAF6LTv0r0O+RLrWfKgsMoFLI+1mEoX0ciUUaXREvIZqgTnp3XqqaX14hyh7QPBzBzsOmSUHs2+qlT6VbyCJC6MNqnc1+gT0AeZAb0oZyD7UMOZagKJ5qV/N5KoWqL8Za90QCRAHk2p1vlP8fOFKO7tCi/NUyPLP+MRKMFqv5TwdzVL62zSSxzLNv9Aj1mCaPOJyRBW9KPQowbD6j/b/gfTfaL+sG2ZUsm57qdbl+HNz9dYwRpEq5cN+YcUdVaJwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxksHBLbXKK+0UkaLyuFS+Rba7IAndPUUE6RO/8pbqQ=;
 b=FOFUd2yJ4DyxH3eq1SCgsOjWt5x0Ja9kRS6htoWaCb1XvoP3s3MZSdLnSQfCrxwCJVLLWT80WRYwxHjuWJAYbBSwVvXbXsCd9HEvR+XbiDVPhrY+HDKfuvvi2+rCBQngXS5lYZjmValTQ8XVHvO2T04RVkQvyUhQM4jiNFetojKiDiOkB1qVOzX8fopHBVFDqtu7nLA9LubLx/YRWiMgTGqmUhzSqXQB6ZkyGsJ0t/wTsDvXqQqA+h3dtKBJYuSOqq06D0ZhoX1SesXg9mIusE9w54E6ZfkW/I0dJGsu90VT1OvhheJsRanEs3uimFHtZEymKCW1TVEGRd+29KFIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxksHBLbXKK+0UkaLyuFS+Rba7IAndPUUE6RO/8pbqQ=;
 b=Qz+3S6vdgcKixSyEsPYmiaM69RK/ngQxq63h3Z0//fPPuD1r3LKakeqGUqWWbrRmCg8JaftQ4sVHuBC8aGlsE+QNj46nF7dXaY91liGW5Iyxza40cCMX7OXaoY/fq4tgeMxYrFykqYe4YQ9OtlIz8dbibSmVNpcJjY8CUOnnSyU=
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by LV3PR10MB8012.namprd10.prod.outlook.com (2603:10b6:408:28a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 22:35:09 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:106:cafe::73) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 22:35:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 22:35:09 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:07 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:06 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3Tx3969567;
	Wed, 30 Sep 2026 17:35:06 -0500
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
Subject: [uL RFC PATCH v3 7/8] i2c: omap: Switch to using BIT and GENMASK
Date: Wed, 30 Sep 2026 17:35:02 -0500
Message-ID: <20260930223503.616776-8-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|LV3PR10MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 002687f2-5463-4081-4332-08df1f431593
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|10067099003|56012099006|3023799007|6133799003|10086099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M7HBIEykQD3DDLJs9JLMeozCMCsO2OMZRjOvIuwOQiYEdJ3musoaaeAlaStvdXnb1bvNWcCRVnj++pGGmrsrogRfWqic4kVylx6++Y7GwCZecvXTUrPKHo2AFyImY6dfEyr3l8gBB4VgsKi6bdbZ7rB5MtORakatUWIYOrA75iyVHaadoJKh2oK+n+t8cHgiU3BvifXPcoywvzf3cCGf5VrzUfMAJ9ZAKBPfyR1j3TkuFrUEvLmM6gPDQSkB+MH6D4BAmQxGqS+faLE8QTZyVSyxPztjFd5OLKEqd6/eAvlN8PGxhznGro+9WAhAft+BI6rJHTUNfPAdY25Qs+FHPl+7ZVogs2bK8lLxZmnCBh9N7/ZJOs14uLC+L2qmIWmnpHSkaz/AGCWSJVUSnBVaSyd/zBuoXNDk6fVLwVDmjws50xK8T8sztXSHgA0zcmNXb0Uz7r5ao2OcgBhrxrcT7k3xLlt4qXD8f5hyEJZdCr6FUs/ppmZky6xFj0h7kLQSQB13KOF8fL/K4qNp4WXpYuplpQIiyeh/ArzGvUJZPYJm1QtJWBQ5N2omhfVB/QsbfjaaiZ8bX3vP87iU7F+IeCpEX//3DlswCSo0jg1dPRNa4frCZiNBESkzgua2Wo2fvmU1gY58zTo5X+u0nbqnXJnpESlM1IHFqcebu9N5Ozxsr94Wmub64aij9jy+zlUtrCjpz7RNM4S95QbFcOieEQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(10067099003)(56012099006)(3023799007)(6133799003)(10086099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mP86QGcy4HISNf1FmZaiH1T8181YlO47h5K8p7BBFepsycJoALPLy6s+4pws29UR42uE7bmXizuB3J9kM44fSGvTX095tvF3ObKRsUDdikV1Ys/lBn4WucF6FDQNbWmW7crTnigCDGPhj2FRwghzA+YYF3nG47+Kc9PSOu6qKArFo7auPEj4x9VazV1LeOicHQZysAMRs+q70iQoGrsUKkLRtVAk48nxhhYeDinHwqv97VGkfzOrtk6Oiof8gCHw9+Kp+E1lTBTLrnmgOTd180NELSoGjOkYtR7PsA4p20YheFhFNYWQvBPx6dYkUQGhZ+NxwKy+7e4QPDZStQRsdSxqari6H3CYXKs3EZCu9W10LJ44MaE+aRvvaNSmW7eEmauL98i8GD0yCTNMWT6E6uj2llLQM4L24vEVoJyQ8q5hziDSp87AaTqzaSWBg7gT
X-Exchange-RoutingPolicyChecked:
	3/ljkGna7EgQUqCg7puztFl4KXEcb792OFV7e95+PlCyYX7GL3o4A6vNna96FyIMhuVOgaPdACRSvXHklm9R4mMOXGcimclRO5hF4AlXFvTAnoksNd0MpzcgGVwBj8bR6ONrooi7bQ6pCGiHCztuQ4HhLOdQAXp3GHOekkyf4PsN4Cogycu0bYBSVpRr0DUQDnUMg83owoBOhPr0Wj0RTuNwPVsvud+5XPC8V969/1lkhiKAX+Qml13xD4cC6DlIFU1oirV41xSPSZR7vquCo6xBRX/zraiGLJs9vQ6UvXlpFaB0I47gyLc3+TV05Ctn3a6NoMPEBj5C44+H7cXEog==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:09.3901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002687f2-5463-4081-4332-08df1f431593
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8012
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX59lhCiyp02nT
 kIl7pbQktKZBtH6xvQpLbItPWp88L6pTNc8/o0MTka6fbAm8NWMEN/dgRv27AQ7BlqBMo8pHDKN
 xP2PjoRSg4y3EA7jF1IblUylOgoKnSk=
X-Proofpoint-ORIG-GUID: NuiTzqXFuzVGecOEt85RBWzec8oC-YOM
X-Authority-Analysis: v=2.4 cv=C7R8WgP+ c=1 sm=1 tr=0 ts=6abd8ea1 cx=c_pps
 a=8AG4s+rqopmfoFde1j+oJg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=nc86A_OknvlbK2ZPRX4A:9
X-Proofpoint-GUID: NuiTzqXFuzVGecOEt85RBWzec8oC-YOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfXw0j0WPiTdjJm
 md9wIsWfWsMecKjXzZDTfT6St5T2+Iaga9E8lV1nlwD79U5nyUbVcDMlKHJHrLo5eV9xiQCTl9s
 s4ZbkLLiUWyrfAsu7s6g807+DRDha4ux2YejJi+/VT9umxoAnTmzVZVmkrn1BNPy2DMXapGnNmO
 AIOHgZ6MuCdpxa6Z839oRQXQENnw/ZTBwoh706Qha0eWp7Ow6qnHZ1gSsA5UXE24h8tiV3RrUdM
 Mkt6XdWcl4VblxtYwlL7dM66TZECZS3TmWnCffH2briaOF/QD6f7a6ZmC84HoefaeUSUA1bRQVH
 7txzBujC3QmH+EWoScb+XVJ0vf0cdfyschHo0D4sAS04ms/QiZfwUM0Ti9eOpdTwCbGqKeqOJt/
 wNabn4jZ3IzzZRY92+FJFUsD6tTNw9Ie89UbnSK+NDlaPszJwmTDmSf23C6/XNM5jmU47fkweXT
 0DLvTHR462PYvNwsr3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

We have helpers for setting bit values and masks. Use them.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 82 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5d5a237c07a5e..c83f6a4d4b097 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -79,64 +79,64 @@ enum {
 };
 
 /* I2C Status bits (OMAP_I2C_IE, OMAP_I2C_STAT, OMAP_I2C_WE) */
-#define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
-#define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
-#define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
-#define OMAP_I2C_STAT_ROVR	(1 << 11)	/* Receive overrun */
-#define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
-#define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
-#define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
-#define OMAP_I2C_STAT_STC	(1 << 6)	/* Start condition */
-#define OMAP_I2C_STAT_GC	(1 << 5)	/* General call */
-#define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
-#define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
-#define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
-#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack */
-#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost */
+#define OMAP_I2C_STAT_XDR	BIT(14)	/* TX Buffer draining */
+#define OMAP_I2C_STAT_RDR	BIT(13)	/* RX Buffer draining */
+#define OMAP_I2C_STAT_BB	BIT(12)	/* Bus busy */
+#define OMAP_I2C_STAT_ROVR	BIT(11)	/* Receive overrun */
+#define OMAP_I2C_STAT_XUDF	BIT(10)	/* Transmit underflow */
+#define OMAP_I2C_STAT_AAS	BIT(9)	/* Address as slave */
+#define OMAP_I2C_STAT_BF	BIT(8)	/* Bus Free */
+#define OMAP_I2C_STAT_STC	BIT(6)	/* Start condition */
+#define OMAP_I2C_STAT_GC	BIT(5)	/* General call */
+#define OMAP_I2C_STAT_XRDY	BIT(4)	/* Transmit data ready */
+#define OMAP_I2C_STAT_RRDY	BIT(3)	/* Receive data ready */
+#define OMAP_I2C_STAT_ARDY	BIT(2)	/* Register access ready */
+#define OMAP_I2C_STAT_NACK	BIT(1)	/* No ack */
+#define OMAP_I2C_STAT_AL	BIT(0)	/* Arbitration lost */
 
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
-#define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
-#define OMAP_I2C_BUF_RXFIF_CLR	(1 << 14)	/* RX FIFO Clear */
-#define OMAP_I2C_BUF_XDMA_EN	(1 << 7)	/* TX DMA channel enable */
-#define OMAP_I2C_BUF_TXFIF_CLR	(1 << 6)	/* TX FIFO Clear */
+#define OMAP_I2C_BUF_RDMA_EN	BIT(15)	/* RX DMA channel enable */
+#define OMAP_I2C_BUF_RXFIF_CLR	BIT(14)	/* RX FIFO Clear */
+#define OMAP_I2C_BUF_XDMA_EN	BIT(7)	/* TX DMA channel enable */
+#define OMAP_I2C_BUF_TXFIF_CLR	BIT(6)	/* TX FIFO Clear */
 
 /* I2C Configuration Register (OMAP_I2C_CON): */
-#define OMAP_I2C_CON_EN		(1 << 15)	/* I2C module enable */
-#define OMAP_I2C_CON_BE		(1 << 14)	/* Big endian mode */
-#define OMAP_I2C_CON_OPMODE_HS	(1 << 12)	/* High Speed support */
-#define OMAP_I2C_CON_STB	(1 << 11)	/* Start byte mode (master) */
-#define OMAP_I2C_CON_MST	(1 << 10)	/* Master/slave mode */
-#define OMAP_I2C_CON_TRX	(1 << 9)	/* TX/RX mode (master only) */
-#define OMAP_I2C_CON_XA		(1 << 8)	/* Expand address */
-#define OMAP_I2C_CON_RM		(1 << 2)	/* Repeat mode (master only) */
-#define OMAP_I2C_CON_STP	(1 << 1)	/* Stop cond (master only) */
-#define OMAP_I2C_CON_STT	(1 << 0)	/* Start condition (master) */
+#define OMAP_I2C_CON_EN		BIT(15)	/* I2C module enable */
+#define OMAP_I2C_CON_BE		BIT(14)	/* Big endian mode */
+#define OMAP_I2C_CON_OPMODE_HS	BIT(12)	/* High Speed support */
+#define OMAP_I2C_CON_STB	BIT(11)	/* Start byte mode (master) */
+#define OMAP_I2C_CON_MST	BIT(10)	/* Master/slave mode */
+#define OMAP_I2C_CON_TRX	BIT(9)	/* TX/RX mode (master only) */
+#define OMAP_I2C_CON_XA		BIT(8)	/* Expand address */
+#define OMAP_I2C_CON_RM		BIT(2)	/* Repeat mode (master only) */
+#define OMAP_I2C_CON_STP	BIT(1)	/* Stop cond (master only) */
+#define OMAP_I2C_CON_STT	BIT(0)	/* Start condition (master) */
 
 /* I2C SCL time value when Master */
 #define OMAP_I2C_SCLL_HSSCLL	8
 #define OMAP_I2C_SCLH_HSSCLH	8
 
 /* I2C System Test Register (OMAP_I2C_SYSTEST): */
-#define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
-#define OMAP_I2C_SYSTEST_FREE		(1 << 14)	/* Free running mode */
-#define OMAP_I2C_SYSTEST_TMODE_MASK	(3 << 12)	/* Test mode select */
+#define OMAP_I2C_SYSTEST_ST_EN		BIT(15)	/* System test enable */
+#define OMAP_I2C_SYSTEST_FREE		BIT(14)	/* Free running mode */
+#define OMAP_I2C_SYSTEST_TMODE_MASK	GENMASK(13, 12)	/* Test mode select */
 #define OMAP_I2C_SYSTEST_TMODE_SHIFT	(12)		/* Test mode select */
 /* Functional mode */
-#define OMAP_I2C_SYSTEST_SCL_I_FUNC	(1 << 8)	/* SCL line input value */
-#define OMAP_I2C_SYSTEST_SCL_O_FUNC	(1 << 7)	/* SCL line output value */
-#define OMAP_I2C_SYSTEST_SDA_I_FUNC	(1 << 6)	/* SDA line input value */
-#define OMAP_I2C_SYSTEST_SDA_O_FUNC	(1 << 5)	/* SDA line output value */
+#define OMAP_I2C_SYSTEST_SCL_I_FUNC	BIT(8)	/* SCL line input value */
+#define OMAP_I2C_SYSTEST_SCL_O_FUNC	BIT(7)	/* SCL line output value */
+#define OMAP_I2C_SYSTEST_SDA_I_FUNC	BIT(6)	/* SDA line input value */
+#define OMAP_I2C_SYSTEST_SDA_O_FUNC	BIT(5)	/* SDA line output value */
 /* SDA/SCL IO mode */
-#define OMAP_I2C_SYSTEST_SCL_I		(1 << 3)	/* SCL line sense in */
-#define OMAP_I2C_SYSTEST_SCL_O		(1 << 2)	/* SCL line drive out */
-#define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
-#define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
+#define OMAP_I2C_SYSTEST_SCL_I		BIT(3)	/* SCL line sense in */
+#define OMAP_I2C_SYSTEST_SCL_O		BIT(2)	/* SCL line drive out */
+#define OMAP_I2C_SYSTEST_SDA_I		BIT(1)	/* SDA line sense in */
+#define OMAP_I2C_SYSTEST_SDA_O		BIT(0)	/* SDA line drive out */
 
 /* OCP_SYSSTATUS bit definitions */
-#define OMAP_I2C_SYSS_RESETDONE		(1 << 0)
+#define OMAP_I2C_SYSS_RESETDONE		BIT(0)
 
 /* OCP_SYSCONFIG bit definitions */
-#define OMAP_I2C_SYSC_SOFTRESET		(1 << 1)
+#define OMAP_I2C_SYSC_SOFTRESET		BIT(1)
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
-- 
2.39.2

