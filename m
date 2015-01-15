From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Thu, 15 Jan 2015 13:42:57 +0000
Message-ID: <8761c8i2hq.fsf@approximate.cambridge.arm.com>
References: <20150114221407.GS2419@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:34710 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbbAONnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 08:43:07 -0500
In-Reply-To: <20150114221407.GS2419@atomide.com> (Tony Lindgren's message of
	"Wed, 14 Jan 2015 22:14:08 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jan 14 2015 at 10:14:08 pm GMT, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> Looks like the legacy IRQ numbers are now all wrong at least for omap4
> since commit 9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain.").
>
> Instead of this:
>
> # cat /proc/interrupts 
>             CPU0       CPU1       
>  29:       1124        981       GIC  29  twd
>  39:          0          0       GIC  39  TWL6030-PIH
>  41:          0          0       GIC  41  l3-dbg-irq
>  42:          0          0       GIC  42  l3-app-irq
>  44:          0          0       GIC  44  DMA
>  45:       7854          0       GIC  45  omap-dma-engine
>  52:          0          0       GIC  52  gpmc
> ...
>
>
> We now have:
>
> # cat /proc/interrupts 
>             CPU0       CPU1       
>  16:        343          0       GIC  69  gp_timer
>  17:       1160       1017       GIC  29  twd
>  18:          0          0       GIC  41  l3-dbg-irq
>  19:          1          0       GIC  42  l3-app-irq
>  22:       7850          0       GIC  45  omap-dma-engine
>  44:          0          0  4a310000.gpio  18  DMA
>  61:       2730          0  48055000.gpio   2  eth0
> 223:          0          0       GIC  52  gpmc
> ...
>
> So the DMA interrupt using the legacy mapping with something like
> irq = 12 + OMAP44XX_IRQ_GIC_START now is wrong and unfortunately
> at least omaps still have a bunch of the legacy interrupts still
> around.

Holy crap. How much of this do we have hanging around?

> And that naturally produces all kinds of strange errors like:
>
> WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Idle): Data Access in Supervisor mode during Functional access
> ...
> [<c05f21e4>] (__irq_svc) from [<c05f1974>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [<c05f1974>] (_raw_spin_unlock_irqrestore) from [<c00914a8>] (__setup_irq+0x244/0x530)
> [<c00914a8>] (__setup_irq) from [<c00917d4>] (setup_irq+0x40/0x8c)
> [<c00917d4>] (setup_irq) from [<c0039c8c>] (omap_system_dma_probe+0x1d4/0x2b4)
> [<c0039c8c>] (omap_system_dma_probe) from [<c03b2200>] (platform_drv_probe+0x44/0xa4)
> ...
>
> Looks like the logic changed from:
>
> if (of_property_read_u32(node, "arm,routable-irqs", &nr_routable_irqs))
>
> to just
>
> if (node)
>
> Which now causes irq_domain_add_linear() to be called instead of
> irq_domain_add_legacy(), which causes the breakage.
>
> Anybody got a sane fix in mind for the -rc series, or should we just
> revert it for now?

Reverting it is going to kill other platforms, and I'd rather have a
workaround, short of fixing it for good (which seems ambitious at -rc4).

How about something along these lines:

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 377eea8..b664494 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -211,6 +211,7 @@ extern struct device *omap2_get_iva_device(void);
 extern struct device *omap2_get_l3_device(void);
 extern struct device *omap4_get_dsp_device(void);
 
+unsigned int omap4_xlate_irq(unsigned int hwirq);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index b7cb44a..cc30e49 100644
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
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cbb908d..9025fff 100644
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
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 35ca6ef..5b42faf 100644
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
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c314b3c..f5e68a7 100644
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

It seems to make my Panda-ES happy enough, but there is of course some
more to fix (prm44xx.c and twl_common.c). OMAP5 can be worked around the
same way.

Of course, this is in no way a proper fix, but I suppose the OMAP DT is
still missing a few bits...

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny.
