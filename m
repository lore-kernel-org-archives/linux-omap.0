From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] fix a pile of OMAP issues
Date: Mon, 1 Dec 2008 16:05:07 +0000
Message-ID: <20081201160507.GC18592@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53504 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbYLAQF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 11:05:26 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

This patch fixes a number of sillies, from missing 'const' to using
'return' in void functions, to functions with no arguments not even
'void' and a cast which isn't required.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

--
I want to merge this for the next ARM kernel pull by Linus.  Please
ack the patch.

 arch/arm/mach-omap1/io.c                 |    2 +-
 arch/arm/plat-omap/include/mach/omapfb.h |    4 ++--
 arch/arm/plat-omap/sram.c                |    8 ++++----
 drivers/video/omap/omapfb_main.c         |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index b3bd8ca..4c3e582 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -128,7 +128,7 @@ void __init omap1_map_common_io(void)
  * Common low-level hardware init for omap1. This should only get called from
  * board specific init.
  */
-void __init omap1_init_common_hw()
+void __init omap1_init_common_hw(void)
 {
 	/* REVISIT: Refer to OMAP5910 Errata, Advisory SYS_1: "Timeout Abort
 	 * on a Posted Write in the TIPB Bridge".
diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index ec67fb4..7b74d12 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -353,8 +353,8 @@ struct omapfb_device {
 	u32			pseudo_palette[17];
 
 	struct lcd_panel	*panel;			/* LCD panel */
-	struct lcd_ctrl         *ctrl;			/* LCD controller */
-	struct lcd_ctrl		*int_ctrl;		/* internal LCD ctrl */
+	const struct lcd_ctrl	*ctrl;			/* LCD controller */
+	const struct lcd_ctrl	*int_ctrl;		/* internal LCD ctrl */
 	struct lcd_ctrl_extif	*ext_if;		/* LCD ctrl external
 							   interface */
 	struct device		*dev;
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 9f9a921..dcd9d16 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -255,7 +255,7 @@ void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl)
 	if (!_omap_sram_reprogram_clock)
 		omap_sram_error();
 
-	return _omap_sram_reprogram_clock(dpllctl, ckctl);
+	_omap_sram_reprogram_clock(dpllctl, ckctl);
 }
 
 int __init omap1_sram_init(void)
@@ -282,8 +282,8 @@ void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 	if (!_omap2_sram_ddr_init)
 		omap_sram_error();
 
-	return _omap2_sram_ddr_init(slow_dll_ctrl, fast_dll_ctrl,
-				    base_cs, force_unlock);
+	_omap2_sram_ddr_init(slow_dll_ctrl, fast_dll_ctrl,
+			     base_cs, force_unlock);
 }
 
 static void (*_omap2_sram_reprogram_sdrc)(u32 perf_level, u32 dll_val,
@@ -294,7 +294,7 @@ void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val, u32 mem_type)
 	if (!_omap2_sram_reprogram_sdrc)
 		omap_sram_error();
 
-	return _omap2_sram_reprogram_sdrc(perf_level, dll_val, mem_type);
+	_omap2_sram_reprogram_sdrc(perf_level, dll_val, mem_type);
 }
 
 static u32 (*_omap2_set_prcm)(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 5a5e407..1a49519 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -392,7 +392,7 @@ static void set_fb_fix(struct fb_info *fbi)
 	int bpp;
 
 	rg = &plane->fbdev->mem_desc.region[plane->idx];
-	fbi->screen_base	= (char __iomem *)rg->vaddr;
+	fbi->screen_base	= rg->vaddr;
 	fix->smem_start		= rg->paddr;
 	fix->smem_len		= rg->size;
 
