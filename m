From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Fix whitespaces in smartreflex.c
Date: Fri, 10 Oct 2008 19:35:28 +0530
Message-ID: <1223647528-23054-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825AbYJJOFh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 10:05:37 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9AE5UZT008649
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 09:05:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>


Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 33f604d..453569a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -43,10 +43,10 @@ struct omap_sr {
 	int		srid;
 	int		is_sr_reset;
 	int		is_autocomp_active;
-	struct clk 	*clk;
-	u32 		clk_length;
-	u32 		req_opp_no;
-	u32 		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
+	struct clk	*clk;
+	u32		clk_length;
+	u32		req_opp_no;
+	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
 	u32		opp5_nvalue;
 	u32		senp_mod, senn_mod;
 	void __iomem	*srbase_addr;
@@ -55,9 +55,9 @@ struct omap_sr {
 
 /* Custom clocks to enable SR specific enable/disable functions. */
 struct sr_custom_clk {
-	struct clk 	clk;  /* meta-clock with custom enable/disable calls */
-	struct clk 	*fck; /* actual functional clock */
-	struct omap_sr 	*sr;
+	struct clk	clk;  /* meta-clock with custom enable/disable calls */
+	struct clk	*fck; /* actual functional clock */
+	struct omap_sr	*sr;
 };
 
 #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
@@ -136,7 +136,7 @@ static struct omap_sr sr2 = {
 
 static struct sr_custom_clk sr1_custom_clk = {
 	.clk = {
-			.name 		= "sr1_custom_clk",
+			.name		= "sr1_custom_clk",
 			.enable		= sr_clk_enable,
 			.disable	= sr_clk_disable,
 	},
@@ -145,7 +145,7 @@ static struct sr_custom_clk sr1_custom_clk = {
 
 static struct sr_custom_clk sr2_custom_clk = {
 	.clk = {
-			.name 		= "sr2_custom_clk",
+			.name		= "sr2_custom_clk",
 			.enable		= sr_clk_enable,
 			.disable	= sr_clk_disable,
 	},
-- 
1.5.6

