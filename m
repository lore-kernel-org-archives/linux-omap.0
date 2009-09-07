From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH]PM: Initialization of SDRC params for DVFS on Zoom2
Date: Mon, 7 Sep 2009 19:19:26 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A007938@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55290 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565AbZIGNtd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 09:49:33 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

This patch initializes the SDRC params for DVFS on Zoom2.

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/board-zoom2.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom2.c
+++ linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
@@ -23,6 +23,7 @@
 
 #include "mmc-twl4030.h"
 #include "omap3-opp.h"
+#include "sdram-micron-mt46h32m32lf-6.h"
 
 static struct omap_uart_config zoom2_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
@@ -36,8 +37,9 @@ static void __init omap_zoom2_init_irq(v
 {
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
-	omap2_init_common_hw(NULL, NULL, omap3_mpu_rate_table,
-	                     omap3_dsp_rate_table, omap3_l3_rate_table);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
+		omap3_mpu_rate_table, omap3_dsp_rate_table,
+					omap3_l3_rate_table);
 	omap_init_irq();
 	omap_gpio_init();
 }
