From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] omap: Fix functions for dynamic remuxing of pins
Date: Wed, 20 Jan 2010 13:23:38 -0800
Message-ID: <20100120212338.25335.92846.stgit@baageli.muru.com>
References: <20100120212248.25335.55761.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63656 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab0ATVX0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 16:23:26 -0500
In-Reply-To: <20100120212248.25335.55761.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Make the omap_mux_read and write available for board code,
and rename omap_mux_set_board_signals into omap_mux_write_array.
Also add the related prototypes and comments into mux.h.

In some cases we want to change the signals dynamically,
mostly for power management.

Note that we cannot use the signal names as they are set
__init to save memory.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |   22 +++++++++++-----------
 arch/arm/mach-omap2/mux.h |   24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 40ea9fd..3f59bd1 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -51,7 +51,7 @@ struct omap_mux_entry {
 static unsigned long mux_phys;
 static void __iomem *mux_base;
 
-static inline u16 omap_mux_read(u16 reg)
+u16 omap_mux_read(u16 reg)
 {
 	if (cpu_is_omap24xx())
 		return __raw_readb(mux_base + reg);
@@ -59,7 +59,7 @@ static inline u16 omap_mux_read(u16 reg)
 		return __raw_readw(mux_base + reg);
 }
 
-static inline void omap_mux_write(u16 val, u16 reg)
+void omap_mux_write(u16 val, u16 reg)
 {
 	if (cpu_is_omap24xx())
 		__raw_writeb(val, mux_base + reg);
@@ -67,6 +67,14 @@ static inline void omap_mux_write(u16 val, u16 reg)
 		__raw_writew(val, mux_base + reg);
 }
 
+void omap_mux_write_array(struct omap_board_mux *board_mux)
+{
+	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
+		omap_mux_write(board_mux->value, board_mux->reg_offset);
+		board_mux++;
+	}
+}
+
 #if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_OMAP_MUX)
 
 static struct omap_mux_cfg arch_mux_cfg;
@@ -833,14 +841,6 @@ static void __init omap_mux_set_cmdline_signals(void)
 	kfree(options);
 }
 
-static void __init omap_mux_set_board_signals(struct omap_board_mux *board_mux)
-{
-	while (board_mux->reg_offset !=  OMAP_MUX_TERMINATOR) {
-		omap_mux_write(board_mux->value, board_mux->reg_offset);
-		board_mux++;
-	}
-}
-
 static int __init omap_mux_copy_names(struct omap_mux *src,
 					struct omap_mux *dst)
 {
@@ -1004,7 +1004,7 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 
 #ifdef CONFIG_OMAP_MUX
 	omap_mux_set_cmdline_signals();
-	omap_mux_set_board_signals(board_mux);
+	omap_mux_write_array(board_mux);
 #endif
 
 	return 0;
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index d8b4d5a..f8c2e7a 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -147,6 +147,30 @@ u16 omap_mux_get_gpio(int gpio);
 void omap_mux_set_gpio(u16 val, int gpio);
 
 /**
+ * omap_mux_read() - read mux register
+ * @mux_offset:		Offset of the mux register
+ *
+ */
+u16 omap_mux_read(u16 mux_offset);
+
+/**
+ * omap_mux_write() - write mux register
+ * @val:		New mux register value
+ * @mux_offset:		Offset of the mux register
+ *
+ * This should be only needed for dynamic remuxing of non-gpio signals.
+ */
+void omap_mux_write(u16 val, u16 mux_offset);
+
+/**
+ * omap_mux_write_array() - write an array of mux registers
+ * @board_mux:		Array of mux registers terminated by MAP_MUX_TERMINATOR
+ *
+ * This should be only needed for dynamic remuxing of non-gpio signals.
+ */
+void omap_mux_write_array(struct omap_board_mux *board_mux);
+
+/**
  * omap3_mux_init() - initialize mux system with board specific set
  * @board_mux:		Board specific mux table
  * @flags:		OMAP package type used for the board

