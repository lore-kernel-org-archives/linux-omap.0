From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 06/15] ARM: OMAP2+: hwmod: Enable OCMCRAM registration in AM33XX
Date: Fri, 2 Nov 2012 18:02:37 +0530
Message-ID: <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39682 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760983Ab2KBMec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:32 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

The hwmod data for OCMCRAM in AM33XX was commented out.
This data is needed by the power management code, hence
uncomment the same and register the OCP interface for it.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 2e470ce..ec3fbb2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -415,7 +415,6 @@ static struct omap_hwmod am33xx_adc_tsc_hwmod = {
  *    - cEFUSE (doesn't fall under any ocp_if)
  *    - clkdiv32k
  *    - debugss
- *    - ocmc ram
  *    - ocp watch point
  *    - aes0
  *    - sha0
@@ -481,6 +480,7 @@ static struct omap_hwmod am33xx_debugss_hwmod = {
 		},
 	},
 };
+#endif
 
 /* ocmcram */
 static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
@@ -501,6 +501,7 @@ static struct omap_hwmod am33xx_ocmcram_hwmod = {
 	},
 };
 
+#if 0
 /* ocpwp */
 static struct omap_hwmod_class am33xx_ocpwp_hwmod_class = {
 	.name		= "ocpwp",
@@ -3331,6 +3332,13 @@ static struct omap_hwmod_ocp_if am33xx_l3_s__usbss = {
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
@@ -3401,6 +3409,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__tptc0,
 	&am33xx_l3_main__tptc1,
 	&am33xx_l3_main__tptc2,
+	&am33xx_l3_main__ocmc,
 	&am33xx_l3_s__usbss,
 	&am33xx_l4_hs__cpgmac0,
 	&am33xx_cpgmac0__mdio,
-- 
1.7.0.4

