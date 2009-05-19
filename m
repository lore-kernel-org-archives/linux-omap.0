From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/4] ARM: OMAP: Remove useless omap_sram_error function.
Date: Tue, 19 May 2009 18:58:45 +0530
Message-ID: <1242739725-12275-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36369 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278AbZESN2z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 May 2009 09:28:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch removes fixes omap_sram_error() function and replace the
error paths with BUG_ON.

The proposed fix was suggested by Russell King <rmk+kernel@arm.linux.org.uk>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index fa5297d..e1493d8 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -242,20 +242,13 @@ void * omap_sram_push(void * start, unsigned long size)
 	return (void *)omap_sram_ceil;
 }
 
-static void omap_sram_error(void)
-{
-	panic("Uninitialized SRAM function\n");
-}
-
 #ifdef CONFIG_ARCH_OMAP1
 
 static void (*_omap_sram_reprogram_clock)(u32 dpllctl, u32 ckctl);
 
 void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl)
 {
-	if (!_omap_sram_reprogram_clock)
-		omap_sram_error();
-
+	BUG_ON(!_omap_sram_reprogram_clock);
 	_omap_sram_reprogram_clock(dpllctl, ckctl);
 }
 
@@ -280,9 +273,7 @@ static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 		   u32 base_cs, u32 force_unlock)
 {
-	if (!_omap2_sram_ddr_init)
-		omap_sram_error();
-
+	BUG_ON(!_omap2_sram_ddr_init);
 	_omap2_sram_ddr_init(slow_dll_ctrl, fast_dll_ctrl,
 			     base_cs, force_unlock);
 }
@@ -292,9 +283,7 @@ static void (*_omap2_sram_reprogram_sdrc)(u32 perf_level, u32 dll_val,
 
 void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val, u32 mem_type)
 {
-	if (!_omap2_sram_reprogram_sdrc)
-		omap_sram_error();
-
+	BUG_ON(!_omap2_sram_reprogram_sdrc);
 	_omap2_sram_reprogram_sdrc(perf_level, dll_val, mem_type);
 }
 
@@ -302,9 +291,7 @@ static u32 (*_omap2_set_prcm)(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
 u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass)
 {
-	if (!_omap2_set_prcm)
-		omap_sram_error();
-
+	BUG_ON(!_omap2_set_prcm);
 	return _omap2_set_prcm(dpll_ctrl_val, sdrc_rfr_val, bypass);
 }
 #endif
@@ -360,9 +347,7 @@ static u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
 u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
 			      u32 sdrc_actim_ctrlb, u32 m2)
 {
-	if (!_omap3_sram_configure_core_dpll)
-		omap_sram_error();
-
+	BUG_ON(!_omap3_sram_configure_core_dpll);
 	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
 					       sdrc_actim_ctrla,
 					       sdrc_actim_ctrlb, m2);
-- 
1.5.4.7

