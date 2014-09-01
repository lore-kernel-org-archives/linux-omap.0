From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 24/26] ARM: OMAP4: PRM: make PRCM interrupt handler related functions static
Date: Mon, 1 Sep 2014 21:09:13 +0300
Message-ID: <1409594955-1476-25-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35732 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbaIASK0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:26 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These are not needed outside the PRM driver, so make them static and
remove the prototypes from the public header.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c      |   13 +++++++++----
 arch/arm/mach-omap2/prm44xx_54xx.h |    6 ------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 15b4646..bfcc356 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -32,6 +32,11 @@
 
 /* Static data */
 
+static void omap44xx_prm_read_pending_irqs(unsigned long *events);
+static void omap44xx_prm_ocp_barrier(void);
+static void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
+static void omap44xx_prm_restore_irqen(u32 *saved_mask);
+
 static const struct omap_prcm_irq omap4_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("io",     9,      1),
 };
@@ -207,7 +212,7 @@ static inline u32 _read_pending_irq_reg(u16 irqen_offs, u16 irqst_offs)
  * MPU IRQs, and store the result into the two u32s pointed to by @events.
  * No return value.
  */
-void omap44xx_prm_read_pending_irqs(unsigned long *events)
+static void omap44xx_prm_read_pending_irqs(unsigned long *events)
 {
 	events[0] = _read_pending_irq_reg(OMAP4_PRM_IRQENABLE_MPU_OFFSET,
 					  OMAP4_PRM_IRQSTATUS_MPU_OFFSET);
@@ -224,7 +229,7 @@ void omap44xx_prm_read_pending_irqs(unsigned long *events)
  * block, to avoid race conditions after acknowledging or clearing IRQ
  * bits.  No return value.
  */
-void omap44xx_prm_ocp_barrier(void)
+static void omap44xx_prm_ocp_barrier(void)
 {
 	omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
 				OMAP4_REVISION_PRM_OFFSET);
@@ -241,7 +246,7 @@ void omap44xx_prm_ocp_barrier(void)
  * interrupts reaches the PRM before returning; otherwise, spurious
  * interrupts might occur.  No return value.
  */
-void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
+static void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
 {
 	saved_mask[0] =
 		omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
@@ -270,7 +275,7 @@ void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
  * No OCP barrier should be needed here; any pending PRM interrupts will fire
  * once the writes reach the PRM.  No return value.
  */
-void omap44xx_prm_restore_irqen(u32 *saved_mask)
+static void omap44xx_prm_restore_irqen(u32 *saved_mask)
 {
 	omap4_prm_write_inst_reg(saved_mask[0], OMAP4430_PRM_OCP_SOCKET_INST,
 				 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index 96477e7..faa7411 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -47,12 +47,6 @@ static inline void omap44xx_prm_reconfigure_io_chain(void)
 }
 #endif
 
-/* PRM interrupt-related functions */
-extern void omap44xx_prm_read_pending_irqs(unsigned long *events);
-extern void omap44xx_prm_ocp_barrier(void);
-extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
-extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
-
 extern int __init omap44xx_prm_init(void);
 extern u32 omap44xx_prm_get_reset_sources(void);
 
-- 
1.7.9.5

