From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH]PM: Initialization of SDRC params for DVFS on Zoom2
Date: Wed, 7 Oct 2009 14:27:27 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A3327C7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38027 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932927AbZJGI6K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 04:58:10 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

>From ba898041224fc496f6694b0ebca9afa77190abf0 Mon Sep 17 00:00:00 2001
From: Teerth Reddy <teerth@ti.com>
Date: Wed, 9 Sep 2009 10:38:30 +0530
Subject: [PATCH] ARM: OMAP3: PM: Initialize SDRC params for DVFS for Zoom2

This patch initializes the SDRC params for DVFS.

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/board-zoom2.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom2.c
+++ linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
@@ -26,6 +26,7 @@
 
 #include "mmc-twl4030.h"
 #include "omap3-opp.h"
+#include "sdram-micron-mt46h32m32lf-6.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -214,8 +215,9 @@ static void __init omap_zoom2_init_irq(v
 {
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
-	omap2_init_common_hw(NULL, NULL, omap3_mpu_rate_table,
-	                     omap3_dsp_rate_table, omap3_l3_rate_table);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+				mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
+				omap3_dsp_rate_table, omap3_l3_rate_table);
 	omap_init_irq();
 	omap_gpio_init();
 }
