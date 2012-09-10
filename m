From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 1/8] ARM: OMAP3: Add debugss HWMOD data
Date: Mon, 10 Sep 2012 10:23:39 -0500
Message-ID: <1347290626-21164-2-git-send-email-jon-hunter@ti.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44913 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab2IJPXx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 11:23:53 -0400
In-Reply-To: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

To enable PMU with runtime PM support on OMAP3 devices we need to be able to
dynamically enable and disable the debug sub-system at runtime. By adding HWMOD
data for the debug sub-system for OMAP3, we can build the PMU device using the
debug sub-system HWMOD and control this power domain using runtime PM.

Reviewed-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c9e3820..78a0c2d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -114,6 +114,24 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.main_clk	= "iva2_ck",
 };
 
+/*
+ * 'debugss' class
+ * debug and emulation sub system
+ */
+
+static struct omap_hwmod_class omap3xxx_debugss_hwmod_class = {
+	.name	= "debugss",
+};
+
+/* debugss */
+static struct omap_hwmod omap3xxx_debugss_hwmod = {
+	.name		= "debugss",
+	.class		= &omap3xxx_debugss_hwmod_class,
+	.clkdm_name	= "emu_clkdm",
+	.main_clk	= "emu_src_ck",
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 /* timer class */
 static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
 	.rev_offs	= 0x0000,
@@ -2093,6 +2111,13 @@ static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
 	.user	= OCP_USER_MPU,
 };
 
+/* l3 -> debugss */
+static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_debugss = {
+	.master		= &omap3xxx_l3_main_hwmod,
+	.slave		= &omap3xxx_debugss_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
 /* DSS -> l3 */
 static struct omap_hwmod_ocp_if omap3430es1_dss__l3 = {
 	.master		= &omap3430es1_dss_core_hwmod,
@@ -3272,6 +3297,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l3_main__l4_core,
 	&omap3xxx_l3_main__l4_per,
 	&omap3xxx_mpu__l3_main,
+	&omap3xxx_l3_main__l4_debugss,
 	&omap3xxx_l4_core__l4_wkup,
 	&omap3xxx_l4_core__mmc3,
 	&omap3_l4_core__uart1,
-- 
1.7.9.5

