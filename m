From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/9] ARM: OMAP36xx: hwmod data: fix SmartReflex interface data
Date: Tue, 28 Feb 2012 04:10:54 -0700
Message-ID: <20120228111054.808.16941.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35177 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965099Ab2B1LLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:34 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

Commit d34427267186827dfd62bd8cf726601fffb22534 ("OMAP3: PM: Adding
smartreflex hwmod data") added OMAP36xx-specific SmartReflex IP block
data, but attempted to share the interface data with the OMAP34xx IP
blocks.  This causes some problems - for example, the 36xx IP blocks
won't be registered when the hwmod subsystem is modified to register
links, since they aren't connected to the rest of the data.  So,
modify the OMAP36xx SmartReflex IP block data to use separate
interface data structures from the OMAP34xx SmartReflex IP blocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   54 +++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 417a007..e6b4e76 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -66,6 +66,8 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod;
 static struct omap_hwmod omap3xxx_gpio6_hwmod;
 static struct omap_hwmod omap34xx_sr1_hwmod;
 static struct omap_hwmod omap34xx_sr2_hwmod;
+static struct omap_hwmod omap36xx_sr1_hwmod;
+static struct omap_hwmod omap36xx_sr2_hwmod;
 static struct omap_hwmod omap34xx_mcspi1;
 static struct omap_hwmod omap34xx_mcspi2;
 static struct omap_hwmod omap34xx_mcspi3;
@@ -413,7 +415,7 @@ static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
 	{ }
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_core__sr1 = {
+static struct omap_hwmod_ocp_if omap34xx_l4_core__sr1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_sr1_hwmod,
 	.clk		= "sr_l4_ick",
@@ -421,6 +423,14 @@ static struct omap_hwmod_ocp_if omap3_l4_core__sr1 = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_ocp_if omap36xx_l4_core__sr1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap36xx_sr1_hwmod,
+	.clk		= "sr_l4_ick",
+	.addr		= omap3_sr1_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
 /* L4 CORE -> SR1 interface */
 static struct omap_hwmod_addr_space omap3_sr2_addr_space[] = {
 	{
@@ -431,7 +441,7 @@ static struct omap_hwmod_addr_space omap3_sr2_addr_space[] = {
 	{ }
 };
 
-static struct omap_hwmod_ocp_if omap3_l4_core__sr2 = {
+static struct omap_hwmod_ocp_if omap34xx_l4_core__sr2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_sr2_hwmod,
 	.clk		= "sr_l4_ick",
@@ -439,6 +449,14 @@ static struct omap_hwmod_ocp_if omap3_l4_core__sr2 = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_ocp_if omap36xx_l4_core__sr2 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap36xx_sr2_hwmod,
+	.clk		= "sr_l4_ick",
+	.addr		= omap3_sr2_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
 /*
 * usbhsotg interface data
 */
@@ -2713,8 +2731,8 @@ static struct omap_hwmod_class omap36xx_smartreflex_hwmod_class = {
 };
 
 /* SR1 */
-static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] = {
-	&omap3_l4_core__sr1,
+static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
+	&omap34xx_l4_core__sr1,
 };
 
 static struct omap_hwmod omap34xx_sr1_hwmod = {
@@ -2731,11 +2749,15 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 			.idlest_idle_bit = OMAP3430_EN_SR1_SHIFT,
 		},
 	},
-	.slaves		= omap3_sr1_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.slaves		= omap34xx_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
+static struct omap_hwmod_ocp_if *omap36xx_sr1_slaves[] = {
+	&omap36xx_l4_core__sr1,
+};
+
 static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.name		= "sr1",
 	.class		= &omap36xx_smartreflex_hwmod_class,
@@ -2750,13 +2772,13 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 			.idlest_idle_bit = OMAP3430_EN_SR1_SHIFT,
 		},
 	},
-	.slaves		= omap3_sr1_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.slaves		= omap36xx_sr1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap36xx_sr1_slaves),
 };
 
 /* SR2 */
-static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
-	&omap3_l4_core__sr2,
+static struct omap_hwmod_ocp_if *omap34xx_sr2_slaves[] = {
+	&omap34xx_l4_core__sr2,
 };
 
 static struct omap_hwmod omap34xx_sr2_hwmod = {
@@ -2773,11 +2795,15 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 			.idlest_idle_bit = OMAP3430_EN_SR2_SHIFT,
 		},
 	},
-	.slaves		= omap3_sr2_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.slaves		= omap34xx_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
+static struct omap_hwmod_ocp_if *omap36xx_sr2_slaves[] = {
+	&omap36xx_l4_core__sr2,
+};
+
 static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.name		= "sr2",
 	.class		= &omap36xx_smartreflex_hwmod_class,
@@ -2792,8 +2818,8 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 			.idlest_idle_bit = OMAP3430_EN_SR2_SHIFT,
 		},
 	},
-	.slaves		= omap3_sr2_slaves,
-	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.slaves		= omap36xx_sr2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap36xx_sr2_slaves),
 };
 
 /*


