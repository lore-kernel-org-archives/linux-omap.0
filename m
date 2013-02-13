From: Archit Taneja <archit@ti.com>
Subject: [PATCH 06/33] arm: omap: board-apollon: use generic dpi panel's gpio handling
Date: Wed, 13 Feb 2013 19:51:58 +0530
Message-ID: <1360765345-19312-7-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56520 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934073Ab3BMOXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:23:31 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The apollon board file currently configures the LCD_PWR_EN gpio by muxing the
corresponding pin to gpio 11, and configuring it in PULL UP mode.

Remove this muxing from the board file. Add the gpio information to generic dpi
panel's platform data so that it's passed to the panel driver. The panel driver
will take care of requesting and setting the LCD_PWR_EN gpio.

Note: This should be tested to ensure that setting the GPIO is equivalent to
configuring the GPIO in PULL UP mode. Also, this GPIO was just set once during
init, and never cleared, where as now the gpio will toggle everytime the panel
is disabled/enabled. The impact of this needs to be tested.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-apollon.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index d2a83a8..5cc957e 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -55,6 +55,8 @@
 #define APOLLON_ETH_CS		1
 #define APOLLON_ETHR_GPIO_IRQ	74
 
+#define APOLLON_LCD_PWR_EN	11
+
 static struct mtd_partition apollon_partitions[] = {
 	{
 		.name		= "X-Loader + U-Boot",
@@ -252,6 +254,10 @@ out:
 
 static struct panel_generic_dpi_data apollon_panel_data = {
 	.name			= "apollon",
+	.num_gpios		= 1,
+	.gpios			= {
+		APOLLON_LCD_PWR_EN,
+	},
 };
 
 static struct omap_dss_device apollon_lcd_device = {
@@ -306,9 +312,6 @@ static void __init omap_apollon_init(void)
 	/* REVISIT: where's the correct place */
 	omap_mux_init_signal("sys_nirq", OMAP_PULL_ENA | OMAP_PULL_UP);
 
-	/* LCD PWR_EN */
-	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA | OMAP_PULL_UP);
-
 	/* Use Internal loop-back in MMC/SDIO Module Input Clock selection */
 	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	v |= (1 << 24);
-- 
1.7.9.5

