From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ARM: OMAP: sram: fix BUG in dpll code for !PM case
Date: Sat,  7 Apr 2012 00:53:21 +0300
Message-ID: <1333749201-23255-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33607 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2DFVx2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 17:53:28 -0400
Received: by wejx9 with SMTP id x9so1663326wej.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Apr 2012 14:53:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

_omap3_sram_configure_core_dpll is called when SDRC is reprogrammed,
which is done regardless of CONFIG_PM setting, so we always need it's
setup code too. Without this, we hit a BUG() on OMAP3 when kernel is
built without CONFIG_PM:

Reprogramming SDRC clock to 332000000 Hz
------------[ cut here ]------------
kernel BUG at arch/arm/plat-omap/sram.c:342!
Internal error: Oops - BUG: 0 [#1] ARM
...
[<c001c694>] (omap3_configure_core_dpll+0x68/0x6c) from [<c001b2dc>] (omap3_core_dpll_m2_set_rate+0x1)
[<c001b2dc>] (omap3_core_dpll_m2_set_rate+0x138/0x1b0) from [<c001a478>] (omap2_clk_set_rate+0x14/0x2)
[<c001a478>] (omap2_clk_set_rate+0x14/0x20) from [<c001c9dc>] (clk_set_rate+0x54/0x74)
[<c001c9dc>] (clk_set_rate+0x54/0x74) from [<c022b9c8>] (omap_sdrc_init+0x70/0x90)
[<c022b9c8>] (omap_sdrc_init+0x70/0x90) from [<c022f178>] (omap3pandora_init+0x11c/0x164)
[<c022f178>] (omap3pandora_init+0x11c/0x164) from [<c022849c>] (customize_machine+0x20/0x28)
[<c022849c>] (customize_machine+0x20/0x28) from [<c0225810>] (do_one_initcall+0xa0/0x16c)
[<c0225810>] (do_one_initcall+0xa0/0x16c) from [<c02259e0>] (kernel_init+0x104/0x1ac)
[<c02259e0>] (kernel_init+0x104/0x1ac) from [<c0009cec>] (kernel_thread_exit+0x0/0x8)

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/plat-omap/sram.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index eec98af..f9a8c53 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -348,7 +348,6 @@ u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
 			sdrc_actim_ctrl_b_1, sdrc_mr_1);
 }
 
-#ifdef CONFIG_PM
 void omap3_sram_restore_context(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
@@ -358,17 +357,18 @@ void omap3_sram_restore_context(void)
 			       omap3_sram_configure_core_dpll_sz);
 	omap_push_sram_idle();
 }
-#endif /* CONFIG_PM */
-
-#endif /* CONFIG_ARCH_OMAP3 */
 
 static inline int omap34xx_sram_init(void)
 {
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 	omap3_sram_restore_context();
-#endif
 	return 0;
 }
+#else
+static inline int omap34xx_sram_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_ARCH_OMAP3 */
 
 static inline int am33xx_sram_init(void)
 {
-- 
1.7.0.4

