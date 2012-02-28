From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/9] ARM: OMAP3: hwmod data: fix interfaces for the MMC hwmods
Date: Tue, 28 Feb 2012 04:10:52 -0700
Message-ID: <20120228111051.808.77655.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35171 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965150Ab2B1LLd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:33 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Commit a52e2ab66d4a9305e1ba64d9b9d25754b6c70895 ("ARM: OMAP3: hwmod
data: disable multiblock reads on MMC1/2 on OMAP34xx/35xx <= ES2.1")
didn't link the MMC hwmods to the interconnects correctly.  Future
patches will register hwmods by interface, so if this is not fixed,
the MMC IP blocks won't be registered.  Update the interface data
records to point to the correct IP blocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   38 ++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 536d0c6..a432618 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -70,8 +70,10 @@ static struct omap_hwmod omap34xx_mcspi1;
 static struct omap_hwmod omap34xx_mcspi2;
 static struct omap_hwmod omap34xx_mcspi3;
 static struct omap_hwmod omap34xx_mcspi4;
-static struct omap_hwmod omap3xxx_mmc1_hwmod;
-static struct omap_hwmod omap3xxx_mmc2_hwmod;
+static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod;
+static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod;
+static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod;
+static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod;
 static struct omap_hwmod omap3xxx_mmc3_hwmod;
 static struct omap_hwmod am35xx_usbhsotg_hwmod;
 
@@ -192,9 +194,18 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 };
 
 /* L4 CORE -> MMC1 interface */
-static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc1 = {
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__pre_es3_mmc1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
-	.slave		= &omap3xxx_mmc1_hwmod,
+	.slave		= &omap3xxx_pre_es3_mmc1_hwmod,
+	.clk		= "mmchs1_ick",
+	.addr		= omap2430_mmc1_addr_space,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__es3plus_mmc1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_es3plus_mmc1_hwmod,
 	.clk		= "mmchs1_ick",
 	.addr		= omap2430_mmc1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -202,9 +213,18 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc1 = {
 };
 
 /* L4 CORE -> MMC2 interface */
-static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc2 = {
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__pre_es3_mmc2 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_pre_es3_mmc2_hwmod,
+	.clk		= "mmchs2_ick",
+	.addr		= omap2430_mmc2_addr_space,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__es3plus_mmc2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
-	.slave		= &omap3xxx_mmc2_hwmod,
+	.slave		= &omap3xxx_es3plus_mmc2_hwmod,
 	.clk		= "mmchs2_ick",
 	.addr		= omap2430_mmc2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -3141,7 +3161,8 @@ static struct omap_hwmod_opt_clk omap34xx_mmc1_opt_clks[] = {
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_mmc1_slaves[] = {
-	&omap3xxx_l4_core__mmc1,
+	&omap3xxx_l4_core__pre_es3_mmc1,
+	&omap3xxx_l4_core__es3plus_mmc1,
 };
 
 static struct omap_mmc_dev_attr mmc1_dev_attr = {
@@ -3216,7 +3237,8 @@ static struct omap_hwmod_opt_clk omap34xx_mmc2_opt_clks[] = {
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_mmc2_slaves[] = {
-	&omap3xxx_l4_core__mmc2,
+	&omap3xxx_l4_core__pre_es3_mmc2,
+	&omap3xxx_l4_core__es3plus_mmc2,
 };
 
 /* See 35xx errata 2.1.1.128 in SPRZ278F */


