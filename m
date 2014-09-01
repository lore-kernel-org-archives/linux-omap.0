From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 23/26] ARM: OMAP3: PRM: make PRCM interrupt handler related functions static
Date: Mon, 1 Sep 2014 21:09:12 +0300
Message-ID: <1409594955-1476-24-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44850 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbaIASKY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:24 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These are not needed outside the PRM driver, so make them static and
remove the prototypes from the public header.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm3xxx.c |   13 +++++++++----
 arch/arm/mach-omap2/prm3xxx.h |    6 ------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 5c1bb25..f21fd76 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -30,6 +30,11 @@
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 
+static void omap3xxx_prm_read_pending_irqs(unsigned long *events);
+static void omap3xxx_prm_ocp_barrier(void);
+static void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
+static void omap3xxx_prm_restore_irqen(u32 *saved_mask);
+
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
 	OMAP_PRCM_IRQ("io",	9,	1),
@@ -147,7 +152,7 @@ void omap3xxx_prm_dpll3_reset(void)
  * MPU IRQs, and store the result into the u32 pointed to by @events.
  * No return value.
  */
-void omap3xxx_prm_read_pending_irqs(unsigned long *events)
+static void omap3xxx_prm_read_pending_irqs(unsigned long *events)
 {
 	u32 mask, st;
 
@@ -166,7 +171,7 @@ void omap3xxx_prm_read_pending_irqs(unsigned long *events)
  * block, to avoid race conditions after acknowledging or clearing IRQ
  * bits.  No return value.
  */
-void omap3xxx_prm_ocp_barrier(void)
+static void omap3xxx_prm_ocp_barrier(void)
 {
 	omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_REVISION_OFFSET);
 }
@@ -182,7 +187,7 @@ void omap3xxx_prm_ocp_barrier(void)
  * returning; otherwise, spurious interrupts might occur.  No return
  * value.
  */
-void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask)
+static void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask)
 {
 	saved_mask[0] = omap2_prm_read_mod_reg(OCP_MOD,
 					       OMAP3_PRM_IRQENABLE_MPU_OFFSET);
@@ -202,7 +207,7 @@ void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask)
  * barrier should be needed here; any pending PRM interrupts will fire
  * once the writes reach the PRM.  No return value.
  */
-void omap3xxx_prm_restore_irqen(u32 *saved_mask)
+static void omap3xxx_prm_restore_irqen(u32 *saved_mask)
 {
 	omap2_prm_write_mod_reg(saved_mask[0], OCP_MOD,
 				OMAP3_PRM_IRQENABLE_MPU_OFFSET);
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index bc37d42..5d993d2 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -152,12 +152,6 @@ static inline void omap3xxx_prm_reconfigure_io_chain(void)
 }
 #endif
 
-/* PRM interrupt-related functions */
-extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
-extern void omap3xxx_prm_ocp_barrier(void);
-extern void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
-extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
-
 extern void omap3xxx_prm_dpll3_reset(void);
 
 extern int __init omap3xxx_prm_init(void);
-- 
1.7.9.5

