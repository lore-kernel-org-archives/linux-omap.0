Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7A2405EC;
	Thu,  5 Feb 2026 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770275420; cv=fail; b=fCRDOHNBVx5edHrW3Uu17pBm408kI1Dq9jrP6uxJOUb+irFY4EgzAaQv2k0l4ZSDz4+ZAiYIJNfmLMjq2X2D1Ik/9JcoG5o8EfaayexaQPGBtDWrjKrYVTTQodfhFAw3p+qw3SL+mDSN4BsdyMk618OE1x43Y2sRkcf6C6+j3M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770275420; c=relaxed/simple;
	bh=AOSHeRUknMOdEAcwdl/qNXBAf/XbQr5118tarWrF4Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTgr5sF3JeaczbfQlJ27sxL3is7uTj99HWC1z7FMzKAAddVzFJEXF4SeZ4ljvxzYesgS3tmD9yVogEumY7uazfwb06k7eggr9FUCplM5z3v0eyqNecZKbnJ96zpgVEqDLngwqGeIXgAArZmDnJwpUtdgmRizbeT7gP+wDCpMggQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LHn9Nz/Z; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LHn9Nz/Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt6VcLomasYk/1l6jRnj8t9khQ105UNsQclK2HxqxP5sYd5IFggCoQYQnbfanhlzZ/sBz1JZthcqlOT+C3vLJUzmALtsD+LgMQblrbBiPxeApdC8P1n/j8wmfcO1RCPijpVT/FfQlmnO4cuY5/NBHDRkAh0trbPzp+I4LyRGgJ6z14sUTKJgw5cvkBzfyCN0OVtm2/xABb6a6koVunuw72XS5FLegPrJbMZGlMeHxQ3mhnRww7oT/dC66hzh8H7DX3BD3RV1YjF9PUrNkZElRTiTNXZKTtA90swxoPV1M1h2E4OIQpFi8nza6JUW/LBbUt3jtoHLGfB9HSfwuGu3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLgbHQ2iXHVFLVYSCS3ziQQOUY7k/c2zKQ365W4zpNU=;
 b=ecBD4pgGcCl1Y51gP0E+HF6FfxdNB5n8070PiFj2yyu1Z84JsAwjPr9YcJe2xybbq1wUFYHHxDyywSv1L7KtRhDLOtwkwPSrxMNQvMF4H4MQVvvk90IhTIcs7N0xHTNsAdyqWjvhZzGh8NvLZQksNmoE8UXL6GNsdxv0QkBXYD0FruSPJuh2I7ioip9VW2OfzRmRWnfhaNw9Oc2JkXVAXQUiZn1XiLs+skmfHIEvsBNDAofgJvXfaK8UF5xhYFJTU9MzD6FGHYQs9n2HYYyY/19c2TYvBVGsfdXoXakOAABKUtN5Uy6RpLfrCXdKsO0ajUvMUH9t6qjuZFW7r0AEgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLgbHQ2iXHVFLVYSCS3ziQQOUY7k/c2zKQ365W4zpNU=;
 b=LHn9Nz/ZsdUPBGF1L91tT5XE8ZZW1I+lreGt5O2CDsw+paChqc6fWaQMt7eniWlgJSgB5EBfze86nFp5eEchGF7yAtLkKXOwUK3rSaPsCYgsv6ujwCBvabtVaa59euIduvO/fYSL86E7yd8ll2IsIWeqHmpGz6KV7J6N3oDx3ww=
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by SA2PR10MB4649.namprd10.prod.outlook.com (2603:10b6:806:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 07:10:18 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::28) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 07:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 07:10:16 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:10:08 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:10:08 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 01:10:07 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6157A6iC2991801;
	Thu, 5 Feb 2026 01:10:07 -0600
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
Subject: [PATCH net 2/2] net: ethernet: ti: cpsw_ale: Update multicast entry handling in ALE Table
Date: Thu, 5 Feb 2026 12:39:51 +0530
Message-ID: <20260205070951.3170631-3-c-vankar@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SA2PR10MB4649:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ee5b0c-f811-47a2-f4ca-08de64859d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iSPDacYBkHminb0W4rAenBhGJjF4Dix5rcFWKOKT3zKZwaKiCHLrRNXxx+ix?=
 =?us-ascii?Q?+K9ibdTq3qgUwMvrouRCIBYbzKTieWN1A4h8hfXF0xQaFJIch5qzvZe0P1YQ?=
 =?us-ascii?Q?psmtraLlG3KeQwl0NNkmVJEHBrKYKPVxyREgxHbT+mOcT4ogBJqCRiLYVyS1?=
 =?us-ascii?Q?EbvVi7QDh7x0iWFSzXvgfnLYZcccxToFsCarXHvNmftpEd7gk3z/FeDn5TI+?=
 =?us-ascii?Q?EcqYjZ2/mAEA12/Drgy9SQlpaSEoBTWxgNGSwxuoz/W75uuDZp1WYv66f9WJ?=
 =?us-ascii?Q?bdoyzqNERqelGzK3W5B/BW3itU8Llf6ZmgcMPAKw7zbXMBKqBrzBTH/UPz/j?=
 =?us-ascii?Q?ALblwWQ2J12qnej4bwBALRKV1ZIckaU8JhOEIPcr+PRXh1A+H+AoLTGzh6u5?=
 =?us-ascii?Q?M80R3VP8DFJ4NlxStq0S6m3dbP3eb/eYsLZmelrmGPNp4Ozpsq7UkFN0DZge?=
 =?us-ascii?Q?byjwGpExyEL0Yxi9HjZqg8DKHw7snVJdpknG1KVnqzJVJ4awvFKKjEQSy0qc?=
 =?us-ascii?Q?0N9/bStm2PTOsREhqKJBk7Gte2VHQK4pBQGbKxZlXrs9ixVTmAWQjerRtDoa?=
 =?us-ascii?Q?1Z+ZYnViHB3ZOsmA8llQ73TmZHCg4ZIzpQ69pfdecuSfH2ARumGWw47KgtSp?=
 =?us-ascii?Q?NvwZz7hI+niYgi4e+Tq9uuBpHaYE7yHDe4CHwKOQ6WtqWs1gfGfc9YXPRjpW?=
 =?us-ascii?Q?twKCZNhIz/vgY0w77eHeKHYQxp9+bqMyj+qsEtwLKCl5mJdGq1koGVdPO0UO?=
 =?us-ascii?Q?GbBc5SDuD/6MttvceinPFbpQA7wUD4Sl66LBzdHHjaHOSRzZNLB0p9P6hLgP?=
 =?us-ascii?Q?7XmQaOK9w/bEEP63PAdiEdxZEWrkJ+BhuFlCFt8sTm3+sU7CoaDgoxWBjfBF?=
 =?us-ascii?Q?4pU4L6eA2ghBadPVs8ZjzjZH7ceRpUEp4FKNKjCPSHLoJIGGM8TbIKX2iA35?=
 =?us-ascii?Q?8Kwpi1D42Upqf3FN5V5cyIVgM57jyDYje7hYGMDzKdlMUCb9e9TG7qgzueI+?=
 =?us-ascii?Q?oBrU24xK4Qs/dkjooI5tGzU+fccTshXwEEavZoSgIRI9qszM0i6ke1fwYePx?=
 =?us-ascii?Q?AqmLhaWKOHsNGYNpuGig7yO6eM6BFCUxY9wsxiK4NvQ2vrzZcj0nphSNrWIH?=
 =?us-ascii?Q?zxVXWEEhI80Y9KiOKv1C2LQv8u2MdXuLV4PYQqfbNksrRGlxWfxtt91clp6g?=
 =?us-ascii?Q?yJSibx9L4Wb3Ff17XsirXYLVunAkajRubTMpRC5ys3KpFnqwWlWRrpFO6ljn?=
 =?us-ascii?Q?3wQJ/oHXo/5u+hyUCDSIrLAiBTFdCK97SQungki58XShV0uXPrMWCGhhK6fq?=
 =?us-ascii?Q?xIsq+MqXBrARSyBkb9LKMBAIZlzkGNT0gYTsyowf+kgdAeWU1Tt9ylrJH848?=
 =?us-ascii?Q?zDGnaepEKiLqasSWYPYTyF1JC+cNx3kD1rAQuo6TUnT7PmX9FqFnqhNw74km?=
 =?us-ascii?Q?Zhsq7wxFZv8YmQJ4gIZnieaXa7ABpRVsScs0AH9FavMytymMsOw5WzADtTq0?=
 =?us-ascii?Q?RxguKQ5tqHGcjjHyJBpN/pFDKx4WhxBGMdX7fZ4VzR0lZUqyzM6lhH+axQMB?=
 =?us-ascii?Q?Uu1kkiwGCaF/UDq5wgUzZIAOuBuGckbUYE4TTccn2Qfv8vKKLIFgL/n3QDfz?=
 =?us-ascii?Q?dKWFUtFAxFsGjehXEJpVXsDg0BpGBHpOIro75WvhRR2lswzzmz5F4DQr+VF8?=
 =?us-ascii?Q?Z8gKZQcCfoKD16irnLN7pTIAsRw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AbrGpDb1Rm97R9mJGGOscAtME07XKJZbswyY6ZEadSdG9mJwjfxjdu8tXqA1M7nkc67v+gRq4StFB9YhRI1QcCQasck1dAGhPVx/0t/1TdfIFKN8/q2WP5JCSbEiqMQyi9I7uNxD0OrN8xVkuWxx7Iq7lrXRUmggRdCK0LKuZJ3yj1T0bFBneRKKiDD2jUqYODS/ajFBcpf9BDikMynYyjLTBug9E7i89gFpKKb68w23yYpjaKskvBvSwg5UmMa8b7xNtk0ZZv89fy4Z7D6rx91DpTcfx03+UALP10erNExlW5GXN6WslA/nE/5yiQUUtKM19ExogBTUvZeYW/gU025awp8sCvRTnqCKRr9U75I+DM0HDHZpSyR0BAhgAme2FNrjZY9qKLmbWrwkid9jzhAMcg0XjSvG3kOQWpd4E8OkGKqWloawNwUjXhqRbPVp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:10:16.5532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ee5b0c-f811-47a2-f4ca-08de64859d5d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4649

The current implementation of multicast entry flushing marks all multicast
entries as free whenever any interface adds, deletes, or modifies
multicast entry. It then re-adds the entries, which disrupts existing
multicast connection for other interfaces associated with that entry.

Update multicast flushing API to handle above case by clearing out a bit
in port_mask for that specific interface.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index fbe35af615a6..9632ad3741de 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -455,14 +455,13 @@ static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
 				      ale->port_mask_bits);
 	if ((mask & port_mask) == 0)
 		return; /* ports dont intersect, not interested */
-	mask &= ~port_mask;
+	mask &= (~port_mask | ALE_PORT_HOST);
 
-	/* free if only remaining port is host port */
-	if (mask)
+	if (mask == 0x0 || mask == ALE_PORT_HOST)
+		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
+	else
 		cpsw_ale_set_port_mask(ale_entry, mask,
 				       ale->port_mask_bits);
-	else
-		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
 }
 
 int cpsw_ale_flush_multicast(struct cpsw_ale *ale, int port_mask, int vid)
-- 
2.34.1

