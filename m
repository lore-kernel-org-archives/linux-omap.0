From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 1/8] arm: omap: rename board-rx51-sdram.c to sdram-nokia.c
Date: Thu,  9 Dec 2010 18:39:17 +0200
Message-ID: <1291912764-12823-2-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:32305 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab0LIQig (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 11:38:36 -0500
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rename the file and functions so that it can be reused by future Nokia
boards. Based on patches by Juha Keski-Saari.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/Makefile                       |    2 +-
 arch/arm/mach-omap2/board-rx51.c                   |    4 +-
 .../{board-rx51-sdram.c => sdram-nokia.c}          |   34 ++++++++++----------
 3 files changed, 20 insertions(+), 20 deletions(-)
 rename arch/arm/mach-omap2/{board-rx51-sdram.c => sdram-nokia.c} (85%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fbc8739..3a71d19 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -141,7 +141,7 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   board-flash.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
-					   board-rx51-sdram.o \
+					   sdram-nokia.o \
 					   board-rx51-peripherals.o \
 					   board-rx51-video.o \
 					   hsmmc.o
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 6635142..b7df8e3 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -35,7 +35,7 @@
 
 #define RX51_GPIO_SLEEP_IND 162
 
-struct omap_sdrc_params *rx51_get_sdram_timings(void);
+struct omap_sdrc_params *nokia_get_sdram_timings(void);
 extern void rx51_video_mem_init(void);
 
 static struct gpio_led gpio_leds[] = {
@@ -105,7 +105,7 @@ static void __init rx51_init_irq(void)
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
-	sdrc_params = rx51_get_sdram_timings();
+	sdrc_params = nokia_get_sdram_timings();
 	omap2_init_common_hw(sdrc_params, sdrc_params);
 	omap_init_irq();
 }
diff --git a/arch/arm/mach-omap2/board-rx51-sdram.c b/arch/arm/mach-omap2/sdram-nokia.c
similarity index 85%
rename from arch/arm/mach-omap2/board-rx51-sdram.c
rename to arch/arm/mach-omap2/sdram-nokia.c
index a43b2c5..690202b 100644
--- a/arch/arm/mach-omap2/board-rx51-sdram.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -1,7 +1,7 @@
 /*
- * SDRC register values for RX51
+ * SDRC register values for Nokia boards
  *
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008, 2010 Nokia Corporation
  *
  * Lauri Leukkunen <lauri.leukkunen@nokia.com>
  *
@@ -43,9 +43,9 @@ struct sdram_timings {
 	u32 tWTR;
 };
 
-static struct omap_sdrc_params rx51_sdrc_params[4];
+static struct omap_sdrc_params nokia_sdrc_params[4];
 
-static const struct sdram_timings rx51_timings[] = {
+static const struct sdram_timings memory_timings[] = {
 	{
 		.casl = 3,
 		.tDAL = 33000,
@@ -110,12 +110,12 @@ static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
 #ifdef DEBUG
 #define SDRC_SET_ONE(reg, st, end, field, rate) \
 	if (set_sdrc_timing_regval((reg), (st), (end), \
-			rx51_timings->field, (rate), #field) < 0) \
+			memory_timings->field, (rate), #field) < 0) \
 		err = -1;
 #else
 #define SDRC_SET_ONE(reg, st, end, field, rate) \
 	if (set_sdrc_timing_regval((reg), (st), (end), \
-			rx51_timings->field) < 0) \
+			memory_timings->field) < 0) \
 		err = -1;
 #endif
 
@@ -148,14 +148,14 @@ static int set_sdrc_timing_regval_ps(u32 *regval, int st_bit, int end_bit,
 #ifdef DEBUG
 #define SDRC_SET_ONE_PS(reg, st, end, field, rate) \
 	if (set_sdrc_timing_regval_ps((reg), (st), (end), \
-			rx51_timings->field, \
+			memory_timings->field, \
 			(rate), #field) < 0) \
 		err = -1;
 
 #else
 #define SDRC_SET_ONE_PS(reg, st, end, field, rate) \
 	if (set_sdrc_timing_regval_ps((reg), (st), (end), \
-			rx51_timings->field, (rate)) < 0) \
+			memory_timings->field, (rate)) < 0) \
 		err = -1;
 #endif
 
@@ -184,7 +184,7 @@ static int sdrc_timings(int id, long rate)
 	SDRC_SET_ONE(&actim_ctrlb, 16, 17, tWTR, l3_rate);
 
 	ticks_per_ms = l3_rate;
-	rfr = rx51_timings[0].tREF * ticks_per_ms / 1000000;
+	rfr = memory_timings[0].tREF * ticks_per_ms / 1000000;
 	if (rfr > 65535 + 50)
 		rfr = 65535;
 	else
@@ -197,18 +197,18 @@ static int sdrc_timings(int id, long rate)
 	l = rfr << 8;
 	rfr_ctrl = l | 0x1; /* autorefresh, reload counter with 1xARCV */
 
-	rx51_sdrc_params[id].rate = rate;
-	rx51_sdrc_params[id].actim_ctrla = actim_ctrla;
-	rx51_sdrc_params[id].actim_ctrlb = actim_ctrlb;
-	rx51_sdrc_params[id].rfr_ctrl = rfr_ctrl;
-	rx51_sdrc_params[id].mr = 0x32;
+	nokia_sdrc_params[id].rate = rate;
+	nokia_sdrc_params[id].actim_ctrla = actim_ctrla;
+	nokia_sdrc_params[id].actim_ctrlb = actim_ctrlb;
+	nokia_sdrc_params[id].rfr_ctrl = rfr_ctrl;
+	nokia_sdrc_params[id].mr = 0x32;
 
-	rx51_sdrc_params[id + 1].rate = 0;
+	nokia_sdrc_params[id + 1].rate = 0;
 
 	return err;
 }
 
-struct omap_sdrc_params *rx51_get_sdram_timings(void)
+struct omap_sdrc_params *nokia_get_sdram_timings(void)
 {
 	int err;
 
@@ -216,6 +216,6 @@ struct omap_sdrc_params *rx51_get_sdram_timings(void)
 	err |= sdrc_timings(1, 83000000);
 	err |= sdrc_timings(2, 166000000);
 
-	return &rx51_sdrc_params[0];
+	return &nokia_sdrc_params[0];
 }
 
-- 
1.5.6.5

