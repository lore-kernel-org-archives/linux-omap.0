From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RESEND PATCH V2 2/2] ARM: AM33xx: hwmod: Add RNG module data
Date: Thu, 29 Aug 2013 18:22:10 +0530
Message-ID: <1377780731-3648-3-git-send-email-lokeshvutla@ti.com>
References: <1377780731-3648-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47572 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995Ab3H2Mwq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 08:52:46 -0400
In-Reply-To: <1377780731-3648-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: paul@pwsan.com, tony@atomide.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, lokeshvutla@ti.com

Add RNG hwmod data for AM33xx SoC.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
* Made am33xx_l4_per__rng structure as static to fix sparse warning

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 215894f..3e32f45 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -2480,6 +2480,41 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__aes0 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* rng */
+static struct omap_hwmod_class_sysconfig am33xx_rng_sysc = {
+	.rev_offs	= 0x1fe0,
+	.sysc_offs	= 0x1fe4,
+	.sysc_flags	= SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class am33xx_rng_hwmod_class = {
+	.name		= "rng",
+	.sysc		= &am33xx_rng_sysc,
+};
+
+static struct omap_hwmod am33xx_rng_hwmod = {
+	.name		= "rng",
+	.class		= &am33xx_rng_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.main_clk	= "rng_fck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM33XX_CM_PER_RNG_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_ocp_if am33xx_l4_per__rng = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_rng_hwmod,
+	.clk		= "rng_fck",
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__emif,
 	&am33xx_mpu__l3_main,
@@ -2559,6 +2594,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_cpgmac0__mdio,
 	&am33xx_l3_main__sha0,
 	&am33xx_l3_main__aes0,
+	&am33xx_l4_per__rng,
 	NULL,
 };
 
-- 
1.7.9.5

