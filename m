Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766734D393;
	Thu,  5 Feb 2026 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770275410; cv=fail; b=Safhhx6sFy2JCmaxH9+xQl8AtfX2mO/x50hh+tQEzkcRu7Rxz/rKSU6aizBHMa5ekMDujw21MtNoCwmB6qIq8uKhvU95ectnc8n/Al1qdk62xejWsRgI+myDdsxLxOsDdHvMdC5kN59pvTG7a1eO8MNaKAmCa5bVCOBVw68lwNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770275410; c=relaxed/simple;
	bh=1CKM58bPZr6fOkuPu5dJe/rOwUHWUo/WSHL7AlZmVes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1Ft7FHP8OHGDDQe11OPiqzsR0PrsA6DGXMgd+YjRHtJz2oWzb+X51DKA5/kwodYFCgu9C9U8Z/uPVxYEvJs4zg5cKNUw7dpC+f7EkEUEMTfWc4/qWYnTvZGHRwh1iunXBFWLc0Kf+dUoVDrb4MkihBt/FZTTZ4NWlxDrFdYTsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fFhKZllw; arc=fail smtp.client-ip=52.101.56.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fFhKZllw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9FPynr98/fqwmtVG8RX9BpCczQdpRXKp67zMPMtVt6a/12UfiqpFSlp2CePKpTv16nQUUPgqN/vLtjU33kcuOutTrfMEf45QtD/NJrihK5uPqaSZ2KgDTdiazzm7oEhg3IEx+veCujNd/FftFbMV+yDPrFgB3i9gYhuVqC+L3lb3NzGzbZBuDT9PttxsJmdjpRUk6b+5dmhpkGVE35gRPPuT1QdSIjxXcUkqinzUtmKLsmjkEfNicT7O3Ocupam0OcihbFt9ad3rC7VmRyRNPPVHq4Jlp+AUAOTfwdbacbZL75Vi6k3Rw60L1e001dzyu4yBal6B9WdH3380oJDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6eCfctRrD0cfR/8oXSq4oAQptAOPN+4KoLJcSFeVfo=;
 b=USiqA0fuThCvjiRycyHixE8sLHvDoiHKHPnSCjrU38tm62KNWMw7DLLUZ14UXVCcG/TRwTrkRpC88lV9DicRUWkCFuDNHU5G8ag2VLQj3e3rFgVhkB/o/bTy7zq03TSiQrpMNvMtVddo7vPJk7JmK24fyt+HkWlL0/2OwyoaqXSKqd1ZPDL/fZA34hF8961WbNgqE7OQs0hOs04LC6nDpF09rM0uX6KxZ8exw/bv5NFVXfstYv7+O2QzgmYu2p92J+bXmyIhaCj9oGXKVa4nJaElmnQH+n1nHnLbCzqb6xo7/e+DSrsDMAxeMLa4Lc5A1/h3NDoXONhSYjf0jb7s+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6eCfctRrD0cfR/8oXSq4oAQptAOPN+4KoLJcSFeVfo=;
 b=fFhKZllwQLT98sGYDn08+Us7NGcXEBpqiDREVjjr7OeMno0x6C6Hsg2EunZ3pfxRzoWMCl6IzuQhbpusTdg4VjZKh/3EUl8bhud4WnxWgbSE58srbHnV7uTQt+9BkzPDnI6zrEetAV+OjG5EyUYDMRfJ5f3HFadnvcusebVNYKg=
Received: from BYAPR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:c0::38)
 by PH7PR10MB5816.namprd10.prod.outlook.com (2603:10b6:510:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 07:10:07 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:a03:c0:cafe::95) by BYAPR05CA0025.outlook.office365.com
 (2603:10b6:a03:c0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 07:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 5 Feb 2026 07:10:06 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:10:04 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:10:04 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 01:10:04 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6157A32J2564873;
	Thu, 5 Feb 2026 01:10:04 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Vignesh Raghavendra" <vigneshr@ti.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>, Nishanth Menon <nm@ti.com>, Chintan
 Vankar <c-vankar@ti.com>, Michael Walle <mwalle@kernel.org>, Simon Horman
	<horms@kernel.org>, Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH net 1/2] net: ethernet: ti: am65-cpsw-nuss: Update port_mask while adding multicast entry
Date: Thu, 5 Feb 2026 12:39:50 +0530
Message-ID: <20260205070951.3170631-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205070951.3170631-1-c-vankar@ti.com>
References: <20260205070951.3170631-1-c-vankar@ti.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|PH7PR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6f4e36-c149-46e0-7ac1-08de6485978d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VRrL4GohMQp2450hEzzjlnJW2BDSOTC9oz/Ybx42cCHGiIB7SRcs5+sdORVb?=
 =?us-ascii?Q?2ET3sLKx0Jl074VNmIrwAq1CChIjOO2HtVL2y+MZi7nZeh77T/ud+rVi8eCU?=
 =?us-ascii?Q?oLheXd6EALeBzEMOu/OZxepxX90rAGC3Kbv2S7GXDhI34CirXIX3qVYGUC6f?=
 =?us-ascii?Q?U7r4ncpqXWfkvIovJGAKfMKeaYMi7UTSTChtVc1b75f4vscFElPKVEwsCf44?=
 =?us-ascii?Q?+82KG7IxvN/uKaiL/LcZlUe/T4At2JMyw0g2R+7CaESWsLgRUhgXGuaI9on7?=
 =?us-ascii?Q?TxLYWEFliHOi0037XDtSVGc4X9njw9+UTqZ3+MOdqNf6M3kKk+H8au9XVrAF?=
 =?us-ascii?Q?oGjjB7g50kZmvoFs91sU05W9SxXl0Njkj73oZ3RwG6JZVBsH2pyDdIZUucMw?=
 =?us-ascii?Q?+4Pknj++DpZG6HeIXSSQLFEl3pPAiZnvLB5US5MzWa23kkSEVDlVkbRkZ5Qr?=
 =?us-ascii?Q?7imG43zH8NRFP3awxGK6002hsB3TJfKWfdCV9RyrGoNznIAWauUl3hMPbgwo?=
 =?us-ascii?Q?B8f3efP4yZAItwumJKgJV+PvDFTEA0jmHhZN8qhiQjSo+//6tpjoRr90cesv?=
 =?us-ascii?Q?i3H2soXKAPry3/SOKXI7IrQb6k/JCRgylQMmhdXbNv2NGL8M/jXIs17UP2tz?=
 =?us-ascii?Q?L4ybruqTxdENBbvTFGwLjjnNCl2Sr3Tecq7MYVq3AqNowA5/X0lzOhrSd6bn?=
 =?us-ascii?Q?nS9sI1209Fo78STUZXTZclJrUMuKXCGk9LT2twdkkHiVnYAYL1x2E4ZhtZQ8?=
 =?us-ascii?Q?lTGIOJwt1bTOZ28ap3URIy8jAwJX8XvWcNzBTGKdfv0dxQ5czhBBXa50sXbO?=
 =?us-ascii?Q?Dhp9Vcr2TZV7BJkBa/IMCr2D0OJcxCipuAaAI+gu9Lv0QRJtVRl6l8zHxva0?=
 =?us-ascii?Q?uqNyttKhP0ZU4pA6DVu6TFq94VMFzLVAoYW0Kh7u4QXohsdH+aDo7Oj6ex8B?=
 =?us-ascii?Q?Ce4x5I5m6zaunIwXAbCP84v3mgN9xR8avPL76TTBaYMEZrzwVKnYSBL3onUA?=
 =?us-ascii?Q?+mb04yEgV7VKLgB8m61DsVVAiOTAWm5K1mSh8zY5jS+f85XoKENILoSWt4jB?=
 =?us-ascii?Q?+vgNu/20MfeyBQKLTbSQlc/zJwjmFVeP1qeVvtP6Ol2q0kulWjGVl4S6HQvA?=
 =?us-ascii?Q?ZvrWdmuPvEfY6blQLHRgl9nOThMg751B+Hb7RaGly4ke0LxDIdp0m0RwQ1O1?=
 =?us-ascii?Q?P1a3f8NxNnW7OfN2w+uqswFl+waX1pA7N1t1206JS/OwT4eRe0MNTQm50NUV?=
 =?us-ascii?Q?p3a16tfTaoHAjBN/5iVfXJP2qtzReIq8Ym0gE73AOCZ+8I3Bd9FDgVlFWES5?=
 =?us-ascii?Q?Jv1zWeLagB7t+0v/d/wr/z2dr/nC72UXLe9dx7w38i1hyD5gzpdjJqiQt7CP?=
 =?us-ascii?Q?5mEOlxscJOXXZS0O1qGaDJvQZW/iFTOFmsglNpy2DApvjOkCrF7aCav715zh?=
 =?us-ascii?Q?VfxKabriYYVYjef6hUSEtPhCdMO/KELucKisPj1K6SPkOB7TXMok/T0UCt/x?=
 =?us-ascii?Q?6I3yGG+9+hUZGcu/VLtqSlOX3g3Pk6oMTJjWmzgSJLOU5nIv6HhRe2IKSFuH?=
 =?us-ascii?Q?Itlql0HgfulFhV12se+72pKKpgdnMXY2g7pCbtw8oeNNXPaY1bG2Blc6AcSz?=
 =?us-ascii?Q?Ovbx9aY7x0N05gJI8zGw1NFiZYKz9c9lXusBJo+S9iK+XzAE3OzY3ptA2g1S?=
 =?us-ascii?Q?tLtYbbhLn1dvgxrCoeFPqqfIRe0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RCiO5eMe2juObZmEzvqWnUbdqdaqX4K+s/zZZt3oMtSRLx9xQMw9LS5vW25rExaLTsHTI0zLr8p9KGEqxpgv31LC9NI5NgDY1o9qEk41RSglwvg/H30vWKACOm9BHEv0/qbHT4NPg9bmbTYhoVv9i8Z9oiMcKb0bnKSB10k1HqFcXKLWCKHiwO4krX2e8Rq/W3rvR2j8/6+UZRmFe9EoOAqCk81vS9h4ppbsOu35gkaf1qFrbMDJ1tz6dogtHiOq5bWNHvu+mUvgXGcjlmqE55UVO3ww05SrBGiL1ELEE1pgFDoOlgDHdUMR5emrGBQ39OTH1a33mTFSkn1n5h9ihEWOm4p+hEj5LqbTbgCrBzAzuXhYnaTkx3EAgmgHrLUEn8zWLkqMCjBxJMw5KoyEoxF/yiqHFWJCZNinSWui1IOLVTtc0rOWo7IN1lrNNZ2n
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:10:06.7842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6f4e36-c149-46e0-7ac1-08de6485978d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816

Multicast entry rules are mainly evaluated for receiving traffic and do not
require MAC ports to be explicitly associated with them. However, setting
associated MAC port's bit to the port_mask of the ALE entry ensures
technical correctness and helps maintaining ALE entries linked to MAC
ports.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5924db6be3fe..967918050433 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -391,7 +391,7 @@ static void am65_cpsw_nuss_ndo_slave_set_rx_mode(struct net_device *ndev)
 	cpsw_ale_set_allmulti(common->ale,
 			      ndev->flags & IFF_ALLMULTI, port->port_id);
 
-	port_mask = ALE_PORT_HOST;
+	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
 	/* Clear all mcast from ALE */
 	cpsw_ale_flush_multicast(common->ale, port_mask, -1);
 
-- 
2.34.1

