From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod data: Fix the wrong clkdm assigned to PRCM modules
Date: Mon, 11 Jun 2012 18:47:04 +0200
Message-ID: <1339433225-30042-2-git-send-email-b-cousson@ti.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58838 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab2FKQrn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 12:47:43 -0400
In-Reply-To: <1339433225-30042-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The following commit (794b480a37e3d284d6ee7344d8a737ef60476ed5) was adding
the PRCM IPs data for PRCM, CM, PRCM_MPU and SCRM.
The clkdm entry are not the correct ones and does not exist in the system.

Replace them with the proper wkup, l4_ao and l4_cfg.

Fix as well the wrong OCP port used by the cm_core_aon. It uses the
l4_cfg interconnect and not the l4_wkup.

Re-order the entries by address value.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   52 ++++++++++++++--------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 950454a..03fc705 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2529,27 +2529,6 @@ static struct omap_hwmod_class omap44xx_prcm_hwmod_class = {
 	.name	= "prcm",
 };
 
-/* prcm_mpu */
-static struct omap_hwmod omap44xx_prcm_mpu_hwmod = {
-	.name		= "prcm_mpu",
-	.class		= &omap44xx_prcm_hwmod_class,
-	.clkdm_name	= "l4_wkup_clkdm",
-};
-
-/* cm_core_aon */
-static struct omap_hwmod omap44xx_cm_core_aon_hwmod = {
-	.name		= "cm_core_aon",
-	.class		= &omap44xx_prcm_hwmod_class,
-	.clkdm_name	= "cm_clkdm",
-};
-
-/* cm_core */
-static struct omap_hwmod omap44xx_cm_core_hwmod = {
-	.name		= "cm_core",
-	.class		= &omap44xx_prcm_hwmod_class,
-	.clkdm_name	= "cm_clkdm",
-};
-
 /* prm */
 static struct omap_hwmod_irq_info omap44xx_prm_irqs[] = {
 	{ .irq = 11 + OMAP44XX_IRQ_GIC_START },
@@ -2564,12 +2543,33 @@ static struct omap_hwmod_rst_info omap44xx_prm_resets[] = {
 static struct omap_hwmod omap44xx_prm_hwmod = {
 	.name		= "prm",
 	.class		= &omap44xx_prcm_hwmod_class,
-	.clkdm_name	= "prm_clkdm",
+	.clkdm_name	= "l4_wkup_clkdm",
 	.mpu_irqs	= omap44xx_prm_irqs,
 	.rst_lines	= omap44xx_prm_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
 };
 
+/* cm_core */
+static struct omap_hwmod omap44xx_cm_core_hwmod = {
+	.name		= "cm_core",
+	.class		= &omap44xx_prcm_hwmod_class,
+	.clkdm_name	= "l4_cfg_clkdm",
+};
+
+/* cm_core_aon */
+static struct omap_hwmod omap44xx_cm_core_aon_hwmod = {
+	.name		= "cm_core_aon",
+	.class		= &omap44xx_prcm_hwmod_class,
+	.clkdm_name	= "l4_ao_clkdm",
+};
+
+/* prcm_mpu */
+static struct omap_hwmod omap44xx_prcm_mpu_hwmod = {
+	.name		= "prcm_mpu",
+	.class		= &omap44xx_prcm_hwmod_class,
+	.clkdm_name	= "l4_wkup_clkdm",
+};
+
 /*
  * 'scrm' class
  * system clock and reset manager
@@ -5305,10 +5305,10 @@ static struct omap_hwmod_addr_space omap44xx_cm_core_aon_addrs[] = {
 };
 
 /* l4_wkup -> cm_core_aon */
-static struct omap_hwmod_ocp_if omap44xx_l4_wkup__cm_core_aon = {
-	.master		= &omap44xx_l4_wkup_hwmod,
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__cm_core_aon = {
+	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_cm_core_aon_hwmod,
-	.clk		= "l4_wkup_clk_mux_ck",
+	.clk		= "l4_div_ck",
 	.addr		= omap44xx_cm_core_aon_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -6101,7 +6101,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l3_main_2__ocmc_ram,
 	&omap44xx_l4_cfg__ocp2scp_usb_phy,
 	&omap44xx_mpu_private__prcm_mpu,
-	&omap44xx_l4_wkup__cm_core_aon,
+	&omap44xx_l4_cfg__cm_core_aon,
 	&omap44xx_l4_cfg__cm_core,
 	&omap44xx_l4_wkup__prm,
 	&omap44xx_l4_wkup__scrm,
-- 
1.7.0.4

