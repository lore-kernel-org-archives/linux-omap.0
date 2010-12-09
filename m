From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 2/8] arm: omap: add sdram-nokia.h
Date: Thu,  9 Dec 2010 18:39:18 +0200
Message-ID: <1291912764-12823-3-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:45549 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab0LIQif (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 11:38:35 -0500
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add a header file for Nokia SDRAM functions. Based on patches by Juha
Keski-Saari.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/board-rx51.c  |    2 +-
 arch/arm/mach-omap2/sdram-nokia.c |    1 +
 arch/arm/mach-omap2/sdram-nokia.h |   12 ++++++++++++
 3 files changed, 14 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-nokia.h

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index b7df8e3..7362c91 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -32,10 +32,10 @@
 
 #include "mux.h"
 #include "pm.h"
+#include "sdram-nokia.h"
 
 #define RX51_GPIO_SLEEP_IND 162
 
-struct omap_sdrc_params *nokia_get_sdram_timings(void);
 extern void rx51_video_mem_init(void);
 
 static struct gpio_led gpio_leds[] = {
diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 690202b..261efc8 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -22,6 +22,7 @@
 #include <plat/clock.h>
 #include <plat/sdrc.h>
 
+#include "sdram-nokia.h"
 
 /* In picoseconds, except for tREF (ns), tXP, tCKE, tWTR (clks) */
 struct sdram_timings {
diff --git a/arch/arm/mach-omap2/sdram-nokia.h b/arch/arm/mach-omap2/sdram-nokia.h
new file mode 100644
index 0000000..ee63da5
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-nokia.h
@@ -0,0 +1,12 @@
+/*
+ * SDRC register values for Nokia boards
+ *
+ * Copyright (C) 2010 Nokia
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+struct omap_sdrc_params *nokia_get_sdram_timings(void);
+
-- 
1.5.6.5

