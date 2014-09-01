From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 25/26] ARM: OMAP3+: PRM: add generic API for reconfiguring I/O chain
Date: Mon, 1 Sep 2014 21:09:14 +0300
Message-ID: <1409594955-1476-26-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44852 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbaIASKZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:25 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This adds a generic API for reconfiguring the I/O chain. The implementation
will call the SoC specific function registered during init time. The SoC
specific reconfigure functions are also made static, as they don't need
to be accessed outside the PRM driver itself.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c   |    5 +----
 arch/arm/mach-omap2/prm.h          |    2 ++
 arch/arm/mach-omap2/prm3xxx.c      |    3 ++-
 arch/arm/mach-omap2/prm3xxx.h      |    8 --------
 arch/arm/mach-omap2/prm44xx.c      |    3 ++-
 arch/arm/mach-omap2/prm44xx_54xx.h |    9 ---------
 arch/arm/mach-omap2/prm_common.c   |   16 ++++++++++++++++
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1de87a7..1bfc504 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1983,10 +1983,7 @@ static void _reconfigure_io_chain(void)
 
 	spin_lock_irqsave(&io_chain_lock, flags);
 
-	if (cpu_is_omap34xx() && omap3_has_io_chain_ctrl())
-		omap3xxx_prm_reconfigure_io_chain();
-	else if (cpu_is_omap44xx())
-		omap44xx_prm_reconfigure_io_chain();
+	prm_reconfigure_io_chain();
 
 	spin_unlock_irqrestore(&io_chain_lock, flags);
 }
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 0dd8d83..7efe14c 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -157,6 +157,8 @@ extern u32 prm_read_reset_sources(void);
 extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
 extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
 
+void prm_reconfigure_io_chain(void);
+
 #endif
 
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index f21fd76..1a739de 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -34,6 +34,7 @@ static void omap3xxx_prm_read_pending_irqs(unsigned long *events);
 static void omap3xxx_prm_ocp_barrier(void);
 static void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
 static void omap3xxx_prm_restore_irqen(u32 *saved_mask);
+static void omap3xxx_prm_reconfigure_io_chain(void);
 
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
@@ -383,7 +384,7 @@ void __init omap3_prm_init_pm(bool has_uart4, bool has_iva)
  * deasserting WUCLKIN and clearing the ST_IO_CHAIN WKST bit.  No
  * return value.
  */
-void omap3xxx_prm_reconfigure_io_chain(void)
+static void omap3xxx_prm_reconfigure_io_chain(void)
 {
 	int i = 0;
 
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 5d993d2..321568b 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -144,14 +144,6 @@ extern u32 omap3_prm_vcvp_read(u8 offset);
 extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
-#ifdef CONFIG_ARCH_OMAP3
-void omap3xxx_prm_reconfigure_io_chain(void);
-#else
-static inline void omap3xxx_prm_reconfigure_io_chain(void)
-{
-}
-#endif
-
 extern void omap3xxx_prm_dpll3_reset(void);
 
 extern int __init omap3xxx_prm_init(void);
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index bfcc356..e7ac7e2 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -36,6 +36,7 @@ static void omap44xx_prm_read_pending_irqs(unsigned long *events);
 static void omap44xx_prm_ocp_barrier(void);
 static void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
 static void omap44xx_prm_restore_irqen(u32 *saved_mask);
+static void omap44xx_prm_reconfigure_io_chain(void);
 
 static const struct omap_prcm_irq omap4_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("io",     9,      1),
@@ -292,7 +293,7 @@ static void omap44xx_prm_restore_irqen(u32 *saved_mask)
  * deasserting WUCLKIN and waiting for WUCLKOUT to be deasserted.
  * No return value. XXX Are the final two steps necessary?
  */
-void omap44xx_prm_reconfigure_io_chain(void)
+static void omap44xx_prm_reconfigure_io_chain(void)
 {
 	int i = 0;
 	s32 inst = omap4_prmst_get_prm_dev_inst();
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index faa7411..f751251 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -38,15 +38,6 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
-	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
-void omap44xx_prm_reconfigure_io_chain(void);
-#else
-static inline void omap44xx_prm_reconfigure_io_chain(void)
-{
-}
-#endif
-
 extern int __init omap44xx_prm_init(void);
 extern u32 omap44xx_prm_get_reset_sources(void);
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index f246bb4..582ed6a 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -487,6 +487,22 @@ int prm_is_hardreset_asserted(u8 shift, u8 part, s16 prm_mod, u16 offset)
 }
 
 /**
+ * prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
+ *
+ * Clear any previously-latched I/O wakeup events and ensure that the
+ * I/O wakeup gaes are aligned with the current mux settings.
+ * Calls SoC specific I/O chain reconfigure function if available,
+ * otherwise does nothing.
+ */
+void prm_reconfigure_io_chain(void)
+{
+	if (!prcm_irq_setup || !prcm_irq_setup->reconfigure_io_chain)
+		return;
+
+	prcm_irq_setup->reconfigure_io_chain();
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
-- 
1.7.9.5

