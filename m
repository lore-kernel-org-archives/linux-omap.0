From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/28] ARM: OMAP: AM3517EVM: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:13 +0200
Message-ID: <1364474962-20439-20-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44571 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728Ab3C1MuJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:09 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 1d7d0d8..c545981 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -200,20 +200,20 @@ static void __init am3517_evm_display_init(void)
 }
 
 static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
 	.power_down_gpio	= -1,
 	.i2c_bus_num		= -1,
 };
 
-static struct omap_dss_device am3517_evm_dvi_device = {
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.name			= "dvi",
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct platform_device am3517_evm_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
 };
 
 static struct omap_dss_device *am3517_evm_dss_devices[] = {
-	&am3517_evm_dvi_device,
 	&am3517_evm_tv_device,
 };
 
@@ -359,6 +359,9 @@ static void __init am3517_evm_init(void)
 	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
 	/* DSS */
 	am3517_evm_display_init();
+#if defined(CONFIG_MACH_OMAP3517EVM_EXPANSION_DVI)
+	platform_device_register(&am3517_evm_dvi_device);
+#endif
 
 	/* RTC - S35390A */
 	am3517_evm_rtc_init();
-- 
1.7.10.4

