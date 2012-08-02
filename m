From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH RFC] ARM: omap2/am33xx: add hwmod for davinci_mdio
Date: Thu,  2 Aug 2012 21:51:37 +0200
Message-ID: <1343937097-30484-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:57756 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab2HBTvn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Aug 2012 15:51:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: mugunthanvnm@ti.com, hvaibhav@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, koen@dominion.thruhere.net, Daniel Mack <zonque@gmail.com>

Add a hwmod entry for the davinci_mdio hardware block. This aliases the
cpsw_125mhz_clkdm and re-uses am33xx_cpgmac0_hwmod_class.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---

I'm still not totally confident with the hwmod environment, so I'm not
entirely sure whether sharing the hwmod_class is the right thing to do
here. However, I can at least get ethernet to work on my board now.

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 5a4660b..637b6cc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -684,6 +684,19 @@ static struct omap_hwmod am33xx_cpgmac0_hwmod = {
 	},
 };
 
+static struct omap_hwmod am33xx_cpsw_mdio_hwmod = {
+	.name		= "davinci_mdio",
+	.class		= &am33xx_cpgmac0_hwmod_class,
+	.clkdm_name	= "cpsw_125mhz_clkdm",
+	.main_clk	= "cpsw_125mhz_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM33XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /*
  * dcan class
  */
@@ -2501,6 +2514,23 @@ static struct omap_hwmod_ocp_if am33xx_l4_hs__cpgmac0 = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_addr_space am33xx_cpsw_mdio_addr_space[] = {
+	{
+		.pa_start	= 0x4a101000,
+		.pa_end		= 0x4a101000 + SZ_256 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if am33xx_l4_hs__cpsw_mdio = {
+	.master		= &am33xx_l4_hs_hwmod,
+	.slave		= &am33xx_cpsw_mdio_hwmod,
+	.clk		= "cpsw_125mhz_gclk",
+	.addr		= am33xx_cpsw_mdio_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod_addr_space am33xx_elm_addr_space[] = {
 	{
 		.pa_start	= 0x48080000,
@@ -3371,6 +3401,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__tptc2,
 	&am33xx_l3_s__usbss,
 	&am33xx_l4_hs__cpgmac0,
+	&am33xx_l4_hs__cpsw_mdio,
 	NULL,
 };
 
-- 
1.7.11.2

