From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: Work around hardcoded interrupts
Date: Mon, 19 Jan 2015 13:21:20 -0800
Message-ID: <20150119212119.GH18552@atomide.com>
References: <1421490068-20385-1-git-send-email-marc.zyngier@arm.com>
 <20150119201404.GA18738@kahuna>
 <20150119201253.GF18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63582 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751180AbbASVZC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 16:25:02 -0500
Content-Disposition: inline
In-Reply-To: <20150119201253.GF18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150119 12:26]:
> * Nishanth Menon <nm@ti.com> [150119 12:17]:
> > On 10:21-20150117, Marc Zyngier wrote:
> > > Commit 9a1091ef0017 (irqchip: gic: Support hierarchy irq domain)
> > should have been
> > Commit 9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain")
> > 
> > > changed the GIC driver to use a non-legacy IRQ domain on DT
> > > platforms. This patch assumes that DT-driven systems are getting
> > > all of their interrupts from device tree.
> > > 
> > > Turns out that OMAP has quite a few hidden gems, and still uses
> > > hardcoded interrupts despite having fairly complete DTs.
> > > 
> > > This patch attempts to work around these by offering a translation
> > > method that can be called directly from the hwmod code, if present.
> > > The same hack is sprinkled over PRCM and TWL.
> > > 
> > > It isn't pretty, but it seems to do the job without having to add
> > > more hacks to the interrupt controller code.
> > > 
> > > Tested on OMAP4 (Panda-ES) and OMAP5 (UEVM5432).
> > > 
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Other than that, This looks good to me.
> > Acked-by: Nishanth Menon <nm@ti.com>
> 
> OK thanks applying into omap-for-v3.19/fixes and will send out a
> pull request later on today after some make randconfig builds.

Looks like we need to now have omap4_pmic_init() wrapped with
ifdef CONFIG_ARCH_OMAP4 to avoid make randconfig errors. I've also
added the missing commit quotes Nishanth mentioned.

Planning to apply the following after some more randconfig build
testing.

Regards,

Tony

8< -----------------
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Sat, 17 Jan 2015 10:21:08 +0000
Subject: [PATCH] ARM: OMAP: Work around hardcoded interrupts

Commit 9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain")
changed the GIC driver to use a non-legacy IRQ domain on DT
platforms. This patch assumes that DT-driven systems are getting
all of their interrupts from device tree.

Turns out that OMAP has quite a few hidden gems, and still uses
hardcoded interrupts despite having fairly complete DTs.

This patch attempts to work around these by offering a translation
method that can be called directly from the hwmod code, if present.
The same hack is sprinkled over PRCM and TWL.

It isn't pretty, but it seems to do the job without having to add
more hacks to the interrupt controller code.

Tested on OMAP4 (Panda-ES) and OMAP5 (UEVM5432).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Nishanth Menon <nm@ti.com>
[tony@atomide.com: updated to fix make randconfig issue]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index db57741..64e44d6 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -211,6 +211,7 @@ extern struct device *omap2_get_iva_device(void);
 extern struct device *omap2_get_l3_device(void);
 extern struct device *omap4_get_dsp_device(void);
 
+unsigned int omap4_xlate_irq(unsigned int hwirq);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -256,6 +256,38 @@ static int __init omap4_sar_ram_init(void)
 }
 omap_early_initcall(omap4_sar_ram_init);
 
+static struct of_device_id gic_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", },
+	{ .compatible = "arm,cortex-a15-gic", },
+	{ },
+};
+
+static struct device_node *gic_node;
+
+unsigned int omap4_xlate_irq(unsigned int hwirq)
+{
+	struct of_phandle_args irq_data;
+	unsigned int irq;
+
+	if (!gic_node)
+		gic_node = of_find_matching_node(NULL, gic_match);
+
+	if (WARN_ON(!gic_node))
+		return hwirq;
+
+	irq_data.np = gic_node;
+	irq_data.args_count = 3;
+	irq_data.args[0] = 0;
+	irq_data.args[1] = hwirq - OMAP44XX_IRQ_GIC_START;
+	irq_data.args[2] = IRQ_TYPE_LEVEL_HIGH;
+
+	irq = irq_create_of_mapping(&irq_data);
+	if (WARN_ON(!irq))
+		irq = hwirq;
+
+	return irq;
+}
+
 void __init omap_gic_of_init(void)
 {
 	struct device_node *np;
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3534,9 +3534,15 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 
 	mpu_irqs_cnt = _count_mpu_irqs(oh);
 	for (i = 0; i < mpu_irqs_cnt; i++) {
+		unsigned int irq;
+
+		if (oh->xlate_irq)
+			irq = oh->xlate_irq((oh->mpu_irqs + i)->irq);
+		else
+			irq = (oh->mpu_irqs + i)->irq;
 		(res + r)->name = (oh->mpu_irqs + i)->name;
-		(res + r)->start = (oh->mpu_irqs + i)->irq;
-		(res + r)->end = (oh->mpu_irqs + i)->irq;
+		(res + r)->start = irq;
+		(res + r)->end = irq;
 		(res + r)->flags = IORESOURCE_IRQ;
 		r++;
 	}
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -676,6 +676,7 @@ struct omap_hwmod {
 	spinlock_t			_lock;
 	struct list_head		node;
 	struct omap_hwmod_ocp_if	*_mpu_port;
+	unsigned int			(*xlate_irq)(unsigned int);
 	u16				flags;
 	u8				mpu_rt_idx;
 	u8				response_lat;
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -479,6 +479,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.class		= &omap44xx_dma_hwmod_class,
 	.clkdm_name	= "l3_dma_clkdm",
 	.mpu_irqs	= omap44xx_dma_system_irqs,
+	.xlate_irq	= omap4_xlate_irq,
 	.main_clk	= "l3_div_ck",
 	.prcm = {
 		.omap4 = {
@@ -640,6 +641,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.class		= &omap44xx_dispc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.mpu_irqs	= omap44xx_dss_dispc_irqs,
+	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -693,6 +695,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.mpu_irqs	= omap44xx_dss_dsi1_irqs,
+	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -726,6 +729,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.mpu_irqs	= omap44xx_dss_dsi2_irqs,
+	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -784,6 +788,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	 */
 	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
+	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -288,6 +288,7 @@ static struct omap_hwmod omap54xx_dma_system_hwmod = {
 	.class		= &omap54xx_dma_hwmod_class,
 	.clkdm_name	= "dma_clkdm",
 	.mpu_irqs	= omap54xx_dma_system_irqs,
+	.xlate_irq	= omap4_xlate_irq,
 	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -498,6 +498,7 @@ struct omap_prcm_irq_setup {
 	u8 nr_irqs;
 	const struct omap_prcm_irq *irqs;
 	int irq;
+	unsigned int (*xlate_irq)(unsigned int);
 	void (*read_pending_irqs)(unsigned long *events);
 	void (*ocp_barrier)(void);
 	void (*save_and_clear_irqen)(u32 *saved_mask);
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -49,6 +49,7 @@ static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
 	.irqs			= omap4_prcm_irqs,
 	.nr_irqs		= ARRAY_SIZE(omap4_prcm_irqs),
 	.irq			= 11 + OMAP44XX_IRQ_GIC_START,
+	.xlate_irq		= omap4_xlate_irq,
 	.read_pending_irqs	= &omap44xx_prm_read_pending_irqs,
 	.ocp_barrier		= &omap44xx_prm_ocp_barrier,
 	.save_and_clear_irqen	= &omap44xx_prm_save_and_clear_irqen,
@@ -751,8 +752,10 @@ static int omap44xx_prm_late_init(void)
 		}
 
 		/* Once OMAP4 DT is filled as well */
-		if (irq_num >= 0)
+		if (irq_num >= 0) {
 			omap4_prcm_irq_setup.irq = irq_num;
+			omap4_prcm_irq_setup.xlate_irq = NULL;
+		}
 	}
 
 	omap44xx_prm_enable_io_wakeup();
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -187,6 +187,7 @@ int omap_prcm_event_to_irq(const char *name)
  */
 void omap_prcm_irq_cleanup(void)
 {
+	unsigned int irq;
 	int i;
 
 	if (!prcm_irq_setup) {
@@ -211,7 +212,11 @@ void omap_prcm_irq_cleanup(void)
 	kfree(prcm_irq_setup->priority_mask);
 	prcm_irq_setup->priority_mask = NULL;
 
-	irq_set_chained_handler(prcm_irq_setup->irq, NULL);
+	if (prcm_irq_setup->xlate_irq)
+		irq = prcm_irq_setup->xlate_irq(prcm_irq_setup->irq);
+	else
+		irq = prcm_irq_setup->irq;
+	irq_set_chained_handler(irq, NULL);
 
 	if (prcm_irq_setup->base_irq > 0)
 		irq_free_descs(prcm_irq_setup->base_irq,
@@ -259,6 +264,7 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 	int offset, i;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	unsigned int irq;
 
 	if (!irq_setup)
 		return -EINVAL;
@@ -298,7 +304,11 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 				1 << (offset & 0x1f);
 	}
 
-	irq_set_chained_handler(irq_setup->irq, omap_prcm_irq_handler);
+	if (irq_setup->xlate_irq)
+		irq = irq_setup->xlate_irq(irq_setup->irq);
+	else
+		irq = irq_setup->irq;
+	irq_set_chained_handler(irq, omap_prcm_irq_handler);
 
 	irq_setup->base_irq = irq_alloc_descs(-1, 0, irq_setup->nr_regs * 32,
 		0);
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -66,19 +66,24 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
 }
 
+#ifdef CONFIG_ARCH_OMAP4
 void __init omap4_pmic_init(const char *pmic_type,
 		    struct twl4030_platform_data *pmic_data,
 		    struct i2c_board_info *devices, int nr_devices)
 {
 	/* PMIC part*/
+	unsigned int irq;
+
 	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
 	omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);
-	omap_pmic_init(1, 400, pmic_type, 7 + OMAP44XX_IRQ_GIC_START, pmic_data);
+	irq = omap4_xlate_irq(7 + OMAP44XX_IRQ_GIC_START);
+	omap_pmic_init(1, 400, pmic_type, irq, pmic_data);
 
 	/* Register additional devices on i2c1 bus if needed */
 	if (devices)
 		i2c_register_board_info(1, devices, nr_devices);
 }
+#endif
 
 void __init omap_pmic_late_init(void)
 {
