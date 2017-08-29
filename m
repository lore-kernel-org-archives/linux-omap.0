From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] ARM: OMAP4: Remove legacy IRQ for PRM
Date: Tue, 29 Aug 2017 10:29:58 -0700
Message-ID: <20170829173001.20358-4-tony@atomide.com>
References: <20170829173001.20358-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829173001.20358-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We have the PRM IRQ mapped in device tree and this legacy code
is no longer needed.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prcm-common.h |  1 -
 arch/arm/mach-omap2/prm.h         |  2 --
 arch/arm/mach-omap2/prm44xx.c     | 21 +++------------------
 arch/arm/mach-omap2/prm_common.c  | 12 +++---------
 4 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -506,7 +506,6 @@ struct omap_prcm_irq_setup {
 	u8 nr_irqs;
 	const struct omap_prcm_irq *irqs;
 	int irq;
-	unsigned int (*xlate_irq)(unsigned int);
 	void (*read_pending_irqs)(unsigned long *events);
 	void (*ocp_barrier)(void);
 	void (*save_and_clear_irqen)(u32 *saved_mask);
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -29,11 +29,9 @@ int omap2_prcm_base_init(void);
  *
  * PRM_HAS_IO_WAKEUP: has IO wakeup capability
  * PRM_HAS_VOLTAGE: has voltage domains
- * PRM_IRQ_DEFAULT: use default irq number for PRM irq
  */
 #define PRM_HAS_IO_WAKEUP	BIT(0)
 #define PRM_HAS_VOLTAGE		BIT(1)
-#define PRM_IRQ_DEFAULT		BIT(2)
 
 /*
  * MAX_MODULE_SOFTRESET_WAIT: Maximum microseconds to wait for OMAP
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -50,8 +50,6 @@ static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
 	.nr_regs		= 2,
 	.irqs			= omap4_prcm_irqs,
 	.nr_irqs		= ARRAY_SIZE(omap4_prcm_irqs),
-	.irq			= 11 + OMAP44XX_IRQ_GIC_START,
-	.xlate_irq		= omap4_xlate_irq,
 	.read_pending_irqs	= &omap44xx_prm_read_pending_irqs,
 	.ocp_barrier		= &omap44xx_prm_ocp_barrier,
 	.save_and_clear_irqen	= &omap44xx_prm_save_and_clear_irqen,
@@ -743,23 +741,10 @@ static int omap44xx_prm_late_init(void)
 		return 0;
 
 	irq_num = of_irq_get(prm_init_data->np, 0);
-	/*
-	 * Already have OMAP4 IRQ num. For all other platforms, we need
-	 * IRQ numbers from DT
-	 */
-	if (irq_num <= 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
-		if (irq_num == -EPROBE_DEFER)
-			return irq_num;
-
-		/* Have nothing to do */
-		return 0;
-	}
+	if (irq_num == -EPROBE_DEFER)
+		return irq_num;
 
-	/* Once OMAP4 DT is filled as well */
-	if (irq_num > 0) {
-		omap4_prcm_irq_setup.irq = irq_num;
-		omap4_prcm_irq_setup.xlate_irq = NULL;
-	}
+	omap4_prcm_irq_setup.irq = irq_num;
 
 	omap44xx_prm_enable_io_wakeup();
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -218,10 +218,7 @@ void omap_prcm_irq_cleanup(void)
 	kfree(prcm_irq_setup->priority_mask);
 	prcm_irq_setup->priority_mask = NULL;
 
-	if (prcm_irq_setup->xlate_irq)
-		irq = prcm_irq_setup->xlate_irq(prcm_irq_setup->irq);
-	else
-		irq = prcm_irq_setup->irq;
+	irq = prcm_irq_setup->irq;
 	irq_set_chained_handler(irq, NULL);
 
 	if (prcm_irq_setup->base_irq > 0)
@@ -307,10 +304,7 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 				1 << (offset & 0x1f);
 	}
 
-	if (irq_setup->xlate_irq)
-		irq = irq_setup->xlate_irq(irq_setup->irq);
-	else
-		irq = irq_setup->irq;
+	irq = irq_setup->irq;
 	irq_set_chained_handler(irq, omap_prcm_irq_handler);
 
 	irq_setup->base_irq = irq_alloc_descs(-1, 0, irq_setup->nr_regs * 32,
@@ -671,7 +665,7 @@ static struct omap_prcm_init_data omap4_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = OMAP4430_PRM_DEVICE_INST,
-	.flags = PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE | PRM_IRQ_DEFAULT,
+	.flags = PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE,
 };
 #endif
 
-- 
2.14.1
