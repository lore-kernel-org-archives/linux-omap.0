From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 3/9] ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
Date: Fri, 18 Jan 2013 12:49:23 +0530
Message-ID: <1358493569-17142-4-git-send-email-vaibhav.bedia@ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49884 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab3ARHTv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 02:19:51 -0500
In-Reply-To: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

OCMC RAM lies in the PER power domain and this memory
support retention.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Change from RFC version:
	No change

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   47 ++++++++++++++++------------
 1 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 646c14d..8280f11 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -414,7 +414,6 @@ static struct omap_hwmod am33xx_adc_tsc_hwmod = {
  *    - cEFUSE (doesn't fall under any ocp_if)
  *    - clkdiv32k
  *    - debugss
- *    - ocmc ram
  *    - ocp watch point
  *    - aes0
  *    - sha0
@@ -481,25 +480,6 @@ static struct omap_hwmod am33xx_debugss_hwmod = {
 	},
 };
 
-/* ocmcram */
-static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
-	.name = "ocmcram",
-};
-
-static struct omap_hwmod am33xx_ocmcram_hwmod = {
-	.name		= "ocmcram",
-	.class		= &am33xx_ocmcram_hwmod_class,
-	.clkdm_name	= "l3_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
-	.main_clk	= "l3_gclk",
-	.prcm		= {
-		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /* ocpwp */
 static struct omap_hwmod_class am33xx_ocpwp_hwmod_class = {
 	.name		= "ocpwp",
@@ -570,6 +550,25 @@ static struct omap_hwmod am33xx_sha0_hwmod = {
 
 #endif
 
+/* ocmcram */
+static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
+	.name = "ocmcram",
+};
+
+static struct omap_hwmod am33xx_ocmcram_hwmod = {
+	.name		= "ocmcram",
+	.class		= &am33xx_ocmcram_hwmod_class,
+	.clkdm_name	= "l3_clkdm",
+	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.main_clk	= "l3_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* 'smartreflex' class */
 static struct omap_hwmod_class am33xx_smartreflex_hwmod_class = {
 	.name		= "smartreflex",
@@ -3328,6 +3327,13 @@ static struct omap_hwmod_ocp_if am33xx_l3_s__usbss = {
 	.flags		= OCPIF_SWSUP_IDLE,
 };
 
+/* l3 main -> ocmc */
+static struct omap_hwmod_ocp_if am33xx_l3_main__ocmc = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_ocmcram_hwmod,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_fw__emif_fw,
 	&am33xx_l3_main__emif,
@@ -3398,6 +3404,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__tptc0,
 	&am33xx_l3_main__tptc1,
 	&am33xx_l3_main__tptc2,
+	&am33xx_l3_main__ocmc,
 	&am33xx_l3_s__usbss,
 	&am33xx_l4_hs__cpgmac0,
 	&am33xx_cpgmac0__mdio,
-- 
1.7.0.4

