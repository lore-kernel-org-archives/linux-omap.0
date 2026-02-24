Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ADE19E97F;
	Tue, 24 Feb 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956854; cv=fail; b=nlwRHqtWJ9WLqFq/xJR8F/+1jyqz2toKZVPHlHEUn9lfgUobP+9oF7voCn3KwvVZme4BgX11hxPXqHfIFltODaenIQpkEvXaKIB4ytKaW6QXxbCzbLw62Od9UylNmTY9DfcVZWqJ8Sa0TjtB01YDA+e+rkXVBSIgkUV7d71xtHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956854; c=relaxed/simple;
	bh=CkS6F0s77ZgH1kFop8W5HVLYLccN63jicBIsFEmX7VA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMpjSlwWQugjS34de/tv/az++N5ZEHKt1KZuS9Dr9xckfLxyYIzKyCq6UWFiYxQ1kc9zZz8mI92OyLpNYIKXccqnYctCCcs1KB0I2uy1NaAEi0eKkJNYvFVKjKgKFSOA/iD37RVe7FKUPqQ9S+vJG5kcB6ptttMKAuadD/V98B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KIGb4oIB; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KIGb4oIB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jc2Lcz4TYa/0fYLPSWC0IRMGyW++l1vSt+05teMaymi3v2i3FCdjOT7SgJ5K0zWcNiWP5D798Bln7b2nyhnYnL4FiF0h/a8GwslyRvYQslVps5OP1JCf7RC81pt2nXWu2IDzR9AK+7Ztn95L1pudgpnEgEiOpV0yQL1vgB21s6SD3Goub8paSZ/8smPi7h5Hts3V91ZL7ilM6Z7o5m7kAiJ0QRFPK9toCcnCcW6lzY7cJpBETbrnPLwVllMx+klIA/y7PB4RJVZzkm7CH68p0E36u8ki2/yhMCRTgdDnhOO1fkGrcSHacAhvcQW/3OVct/yemEbfjT3ieXNGh9h1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZpVrSr7xY2T0SlmQw9FpRAEpQD8WcGMPBE532oXY3g=;
 b=cwBy78iIOs1IWvN/jVKJDxfqCgwP8Y87ehYriXpDO/7QEMWWm5Y+IUb+oL9lTYLTwpp57QZr4d+x8HnMY9tO5bOcSLwffWqQphz8e6V7SIOGAIGuyXjEcD0qElYklAOXp5NURLYBB1H4sW5yCzOcor1sZlGdrJOFNyZIkg7B0rTpLNclTdQ63LR+kIo10NJXzgH2bNKVsVHCvA0BpAbx32kzstGpxsSlMLygDyVuvtgt8Nd0+ugHJjl7V4vz42PRjsa5GRaLs4DpT08VUUDqgFEbeVtSSAYT4j0KQzbjEvFD4Z3E0ZT2TKg5aFTtTHvYV3X0Q8jUaM0Vw6oDivM3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZpVrSr7xY2T0SlmQw9FpRAEpQD8WcGMPBE532oXY3g=;
 b=KIGb4oIBvyLNYIB4Ibsf0q4ZdTC5h3xbrhUNpC0HU+z20Rt+Uxfuy7lfS1ISJzubnEdm151hbRZqhI+tHEstWLA2UDEPpZP33arGVT2xu9hRbSSHrOJKSXirwSpP98bquRzbTT5C7ixyYs6XP3Y2/GB6W80DbhNMIOOXdB3WUqA=
Received: from BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::31)
 by IA0PR10MB7382.namprd10.prod.outlook.com (2603:10b6:208:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:14:08 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::a8) by BLAP220CA0026.outlook.office365.com
 (2603:10b6:208:32c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 18:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 18:14:06 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 12:14:06 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 12:14:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 12:14:03 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OIE2JV2700432;
	Tue, 24 Feb 2026 12:14:02 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Mugunthan V N <mugunthanvnm@ti.com>, Richard Cochran
	<richardcochran@gmail.com>, Stefan Wiehler <stefan.wiehler@nokia.com>,
	"Thomas Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>, Vishnu
 Singh <v-singh1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias
 Schiffer <matthias.schiffer@ew.tq-group.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Nishanth Menon <nm@ti.com>, Chintan Vankar
	<c-vankar@ti.com>, Michael Walle <mwalle@kernel.org>, Simon Horman
	<horms@kernel.org>, Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix multicast entry handling in ALE table
Date: Tue, 24 Feb 2026 23:43:59 +0530
Message-ID: <20260224181359.2055322-1-c-vankar@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|IA0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd8b51b-8ca6-4433-e35a-08de73d07fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1RxpsBdjeMXox2Ig7ndHD2J5aITgHuPM1OO6XNPxldQlJZykVBMXZrSelNgl?=
 =?us-ascii?Q?ZjSMIBWAu36rx5tkSCuISq/qqRkxEq9jZ03qnLBFb1xGjyZ57zTRpqumq80D?=
 =?us-ascii?Q?smbs049OhVlNf0A0xdiKA5F7K68iwiAZuNYKObXzk8wCmT5MuKL9f1aMV6n8?=
 =?us-ascii?Q?enN25FKsccMCJ99YVMt3XZMvTyue8agTGtijw65TFmwSSyN6nkQafPcfHjjb?=
 =?us-ascii?Q?OsckVjnNGKVY1AImMYErNaIFyKdN7bEXWukapTBC7rtYjadHcZVaY5suvUNV?=
 =?us-ascii?Q?805MxuNOd79mpLhciowdRWlLS284jm6LFa1IZbrNyB1BAKBMFGCOuX1OoEht?=
 =?us-ascii?Q?EUKybsl1qvyXaKn0QEvD3jt635kRwrqwCGM7/nDoykfhLgjA1Yf9IRC/WtT1?=
 =?us-ascii?Q?dD1Wi8qgNUSo+R2+nPQTzkQz24CHpyZtcVwdZ4bJd+CfWi9kUCAf/EVJ6Tz6?=
 =?us-ascii?Q?lyfO/PCk+qa/NMpDg9nbUVJJG4SIN0PfVQcbbvtukS5QKaNpgYR10Z0MuHOQ?=
 =?us-ascii?Q?KlLLWWRVqM2G5j5mP7cA65+aWWMAYOoDT8OdZV4yW5FvOC/UJc6ttTpHxJOJ?=
 =?us-ascii?Q?rD3MZdGhUJ6JGCSqSUjElEyPhbTDT+Ql6bkNqQ1LzRrbcJB6yB0krI2KdLQo?=
 =?us-ascii?Q?KL+487Rxo/awI1nzEutqnPGB4b7w8l08gBSqPQLEcI9UTJ55QN2AMI+ZkOP0?=
 =?us-ascii?Q?GqP9gKvyd2YvwfVWB+I3YXRNAQMZp9bB6v6lkaWhWOHXpD5IHkjfOe56jLO2?=
 =?us-ascii?Q?Wf/K6SJL3rFj4PY3rX1C38tCYqrwi4GvdJasjF51m/LA7zOKFeUads5KYRoH?=
 =?us-ascii?Q?SnfnTW2jIkKVr3hLldxftHwXoZL1SPy7AxTMTlhvdJ6bObH9qYTu27+35cot?=
 =?us-ascii?Q?UabrDUNwmjSVQRYtFVoxrGqUxyTHyXwhYg2hqJefK19tAdZPbB12oBM4ONEt?=
 =?us-ascii?Q?Ws55Ki53IAV0et6MhFVCZtGKJd/5NP7JFVeA/zz7JbcJOnHBEO0iti48Afwu?=
 =?us-ascii?Q?sxU7msBvV0efu9p5/ZzwmlCCacs22eo/GGp9h/7DeqXEDtOoUQcjD1RyMCzb?=
 =?us-ascii?Q?J0GtFbyVMkyWNkm9cK0lX+H7UKJSsXKKgrf39nMR/9VTG/TNGoOWTbMNGRpi?=
 =?us-ascii?Q?XTc/wtUaxwLweSgXGnucIgjIDD/BQ0WvmJexni4MVr0tjpKm4wgxKFIK+dYD?=
 =?us-ascii?Q?akP/b2RBou81V+nBbf9LbAHepCijTm9Wugs1wzH23ZiPCIYtBR5q5LEgh4uU?=
 =?us-ascii?Q?ohV62ZUsWOpMGdF8QE4UK0ssaSsze2qHK2kptCvSKThxldRBC7MbbsZYe++J?=
 =?us-ascii?Q?1fxnydWBaKMnOFyTwbNOQgkb/CeY/vmboMQAZ5XSY7BvcGt22omLE5cEg7Ko?=
 =?us-ascii?Q?FccGiMQj8inZ1OZsWe2wplSUm+LBJwkDghfVZA2Wi/JkV2lmqtJFBlqGygTi?=
 =?us-ascii?Q?UlOnmGRp5s9dXC6khnEHZw84ev/wbjcgWH1AGH1sDbOIOJI+MH3VRxqToYKS?=
 =?us-ascii?Q?d+pbdzUFLfhglC55AmGPpmV6+PgDvXk/BuX+KKGG/Jj/eojU60c5SLO/pso6?=
 =?us-ascii?Q?dksLD2+w+zB0esTMHZ/pnEoO4MKTd8zgC86KGDWPJhpc8tE5lxYBBbU+3LDV?=
 =?us-ascii?Q?rCqKD1LTP/KJItclua1kIbEY6m1W3n2kEOn9a5x/TnrfPjkQSvK6TKowlDit?=
 =?us-ascii?Q?UzgSYhB40jQDfKAaxreqvuoxko8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ySGKTIO33R0e35EopesMsnlljfQ0opJj8CjOldXa8nPFibX3XQz/jpOfaIHYEQdSqqBLsD1Z7ENFPxGL/Z+zuRZ9r1K1NncbwoypCfY2OCbx8MN/+J6wHnYIZ+DxTgOkQ8VJSuKtQF1xQVmYOmyvFElVI9JcIntGc1Gvgw0CCoBEsgZSog10nrMxFY59EAaq7uCYygYG1tDXxQ+EQgaAbccchwgT7STpiChDAQUExHXtM8apXDE1ZhTrqYLC2t+dpz8VW+kqWVJGDOotv+cWLy2g95xjhvPhl8244CHmKVTSkTImgfxXPGkc0es5DHyXfF/lA5PxDxSWKbn72i8nii7q/dp1Qj8Iy7RiVKLruJMUuwU/Kujmx1CGw3cy45syh4SmsfeJ5O3qJkfgsNlFerhnDtgXcePtTEjOQm8e41D2jWzvokvMNjjEmdvftuLr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:14:06.9822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd8b51b-8ca6-4433-e35a-08de73d07fff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7382

In the current implementation, flushing multicast entries in MAC mode
incorrectly deletes entries for all ports instead of only the target port,
disrupting multicast traffic on other ports. The cause is adding multicast
entries by setting only host port bit, and not setting the MAC port bits.

Fix this by setting the MAC port's bit in the port mask while adding the
multicast entry. Also fix the flush logic to preserve the host port bit
during removal of MAC port and free ALE entries when mask contains only
host port.

Fixes: 5c50a856d550 ("drivers: net: ethernet: cpsw: add multicast address to ALE table")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on commit 'd4f687fbbce4' of origin/main branch of
Linux net repo.

Link to v1:
https://lore.kernel.org/r/20260205070951.3170631-1-c-vankar@ti.com/

Changes from v1 to v2:
- Squashed two patches into one as a fix of the older implementation.
- Added "Fixes" tag in the commit.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 drivers/net/ethernet/ti/cpsw_ale.c       | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

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
 
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index bb969dd435b4..be7b69319221 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -450,14 +450,13 @@ static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
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

