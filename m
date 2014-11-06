From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 11/11] ARM: OMAP2+: igep00x0: Add pdata-quirks for the btwilink device.
Date: Thu,  6 Nov 2014 13:01:51 +0100
Message-ID: <1415275311-6857-12-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34469 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaKFMCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:36 -0500
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add btwilink device for IGEPv2 Rev. F and IGEP COM MODULE Rev. G.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index c95346c..e72f0fc 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/ti_wilink_st.h>
 #include <linux/wl12xx.h>
 
 #include <linux/platform_data/pinctrl-single.h>
@@ -139,8 +140,38 @@ static void __init omap3_sbc_t3530_legacy_init(void)
 	omap_ads7846_init(1, 57, 0, NULL);
 }
 
-static void __init omap3_igep0020_legacy_init(void)
+struct ti_st_plat_data wilink_pdata = {
+	.nshutdown_gpio = 137,
+	.dev_name = "/dev/ttyO1",
+	.flow_cntrl = 1,
+	.baud_rate = 300000,
+};
+
+static struct platform_device wl18xx_device = {
+	.name	= "kim",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &wilink_pdata,
+	}
+};
+
+static struct platform_device btwilink_device = {
+	.name	= "btwilink",
+	.id	= -1,
+};
+
+static void __init omap3_igep0020_rev_f_legacy_init(void)
+{
+	legacy_init_wl12xx(0, 0, 177);
+	platform_device_register(&wl18xx_device);
+	platform_device_register(&btwilink_device);
+}
+
+static void __init omap3_igep0030_rev_g_legacy_init(void)
 {
+	legacy_init_wl12xx(0, 0, 136);
+	platform_device_register(&wl18xx_device);
+	platform_device_register(&btwilink_device);
 }
 
 static void __init omap3_evm_legacy_init(void)
@@ -393,7 +424,8 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "nokia,omap3-n900", nokia_n900_legacy_init, },
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
-	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
+	{ "isee,omap3-igep0020-rev-f", omap3_igep0020_rev_f_legacy_init, },
+	{ "isee,omap3-igep0030-rev-g", omap3_igep0030_rev_g_legacy_init, },
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
-- 
1.9.1

