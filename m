From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] onenand_init: Clean-up for checkpatch.pl
Date: Mon, 04 May 2009 17:27:05 -0700
Message-ID: <20090505002705.2894.14127.stgit@localhost>
References: <20090505002144.2894.25201.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbZEEA1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 20:27:07 -0400
In-Reply-To: <20090505002144.2894.25201.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, juha.yrjola@solidboot.com, linux-omap@vger.kernel.org, adrian.hunter@nokia.com

Clean-up for checkpatch.pl

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c        |   15 +++++++++------
 arch/arm/plat-omap/include/mach/onenand.h |    5 ++---
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index d243228..71fc05a 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -1,8 +1,9 @@
 /*
- * linux/arch/arm/mach-omap2/board-n800-flash.c
+ * linux/arch/arm/mach-omap2/gpmc-onenand.c
  *
- * Copyright (C) 2006 Nokia Corporation
- * Author: Juha Yrjola
+ * Copyright (C) 2006 - 2009 Nokia Corporation
+ * Contacts:	Juha Yrjola
+ *		Tony Lindgren
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,7 +15,7 @@
 #include <asm/mach/flash.h>
 #include <linux/mtd/onenand_regs.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <mach/onenand.h>
 #include <mach/board.h>
 #include <mach/gpmc.h>
@@ -122,7 +123,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	const int t_wph  = 30;
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
 	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
-	int err, ticks_cez, sync_read = 0, sync_write = 0, first_time = 0, hf = 0;
+	int first_time = 0, hf = 0 sync_read = 0, sync_write = 0;
+	int err, ticks_cez;
 	int cs = cfg->cs;
 	u32 reg;
 
@@ -267,7 +269,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 			t.wr_access = t.access;
 		}
 	} else {
-		t.adv_wr_off = gpmc_round_ns_to_ticks(max_t(int, t_avdp, t_cer));
+		t.adv_wr_off = gpmc_round_ns_to_ticks(max_t(int,
+							t_avdp, t_cer));
 		t.we_on  = t.adv_wr_off + gpmc_round_ns_to_ticks(t_aavdh);
 		t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
 		t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
index bb66d0b..94cde73 100644
--- a/arch/arm/plat-omap/include/mach/onenand.h
+++ b/arch/arm/plat-omap/include/mach/onenand.h
@@ -27,11 +27,10 @@ struct omap_onenand_platform_data {
 	u8			flags;
 };
 
-int omap2_onenand_rephase(void);
-
 #define ONENAND_MAX_PARTITIONS 8
 
-#if defined(CONFIG_MTD_ONENAND_OMAP2) || defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 
 extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
 

