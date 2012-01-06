From: Stephane Eranian <eranian@googlemail.com>
Subject: [BUG] perf_event: no PMU interrupt on OMAP4 with 3.2.0 (Pandaboard)
Date: Fri, 6 Jan 2012 14:48:12 +0100
Message-ID: <20120106134812.GB5122@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57802 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab2AFNsR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 08:48:17 -0500
Received: by werm1 with SMTP id m1so1122168wer.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 05:48:15 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: will.deacon@arm.com, ming.lei@canonical.com, b-cousson@ti.com, paul@pwsan.com

Hi,

I am trying to get perf_event to work properly on my OMAP4 Pandabaord
running the 3.2.0 kernel. I am the developer on libpfm4 and a regular
contributor to the perf_event subsystem and perf tool. I want to use
a Pandaboard to test libpfm4 ARM support.

I have been talking with Will Deacon and he suggested I post to this list.

I know that the off-the-shelf 3.2.0 does not have working PMU interrupts.
I have integrated additional patches from both Ming Lei and Linaro. It
seems some parts of those patches were integrated into 3.2.0.

I have attached my 3.2.0 changes to this message. With that, I get perf_event
to register PMU interrupts 33 and 34. However, they don't fire when I count
therefore the counts are bogus (counters wrap around).

I suspect I am missing something in the patch I put together. But I don't know
what's missing. I am not an ARM platform expert. I am hoping someone on this
list may shed some light on this problem.

It would be really nice to have perf_event running out of the box on Pandaboard
for 3.3. It would go a long way into making performance monitoring usable on ARM.

Thanks.
---

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 0bda22c..b5a5be2 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -27,13 +27,22 @@ enum arm_pmu_type {
 /*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
- * @handle_irq: an optional handler which will be called from the interrupt and
- * passed the address of the low level handler, and can be used to implement
- * any platform specific handling before or after calling it.
+ * @handle_irq: an optional handler which will be called from the
+ *	interrupt and passed the address of the low level handler,
+ *	and can be used to implement any platform specific handling
+ *	before or after calling it.
+ * @enable_irq: an optional handler which will be called after
+ *	request_irq and be used to handle some platform specific
+ *	irq enablement
+ * @disable_irq: an optional handler which will be called before
+ *	free_irq and be used to handle some platform specific
+ *	irq disablement
  */
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
+	void (*enable_irq)(int irq);
+	void (*disable_irq)(int irq);
 };
 
 #ifdef CONFIG_CPU_HAS_PMU
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 88b0941..24e001f 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -380,6 +380,8 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
 {
 	int i, irq, irqs;
 	struct platform_device *pmu_device = armpmu->plat_device;
+	struct arm_pmu_platdata *plat =
+		dev_get_platdata(&pmu_device->dev);
 
 	irqs = min(pmu_device->num_resources, num_possible_cpus());
 
@@ -387,8 +389,11 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
 		if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
 			continue;
 		irq = platform_get_irq(pmu_device, i);
-		if (irq >= 0)
+		if (irq >= 0) {
+			if (plat->disable_irq)
+				plat->disable_irq(irq);
 			free_irq(irq, armpmu);
+		}
 	}
 
 	release_pmu(armpmu->type);
@@ -449,6 +454,8 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 			armpmu_release_hardware(armpmu);
 			return err;
 		}
+		if (plat->enable_irq)
+			plat->enable_irq(irq);
 
 		cpumask_set_cpu(i, &armpmu->active_irqs);
 	}
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c15cfad..6caf31a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -17,12 +17,14 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
+#include <asm/cti.h>
 
 #include <plat/tc.h>
 #include <plat/board.h>
@@ -404,14 +406,136 @@ static struct platform_device omap_pmu_device = {
 	.num_resources	= 1,
 };
 
-static void omap_init_pmu(void)
+static struct arm_pmu_platdata omap4_pmu_data;
+static struct cti omap4_cti[2];
+static struct platform_device *pmu_dev;
+
+static void omap4_enable_cti(int irq)
 {
-	if (cpu_is_omap24xx())
+	pm_runtime_get_sync(&pmu_dev->dev);
+
+	if (irq == OMAP44XX_IRQ_CTI0)
+		cti_enable(&omap4_cti[0]);
+	else if (irq == OMAP44XX_IRQ_CTI1)
+		cti_enable(&omap4_cti[1]);
+}
+
+static void omap4_disable_cti(int irq)
+{
+	if (irq == OMAP44XX_IRQ_CTI0)
+		cti_disable(&omap4_cti[0]);
+	else if (irq == OMAP44XX_IRQ_CTI1)
+		cti_disable(&omap4_cti[1]);
+	pm_runtime_put(&pmu_dev->dev);
+}
+
+static irqreturn_t omap4_pmu_handler(int irq, void *dev, irq_handler_t handler)
+{
+	if (irq == OMAP44XX_IRQ_CTI0)
+		cti_irq_ack(&omap4_cti[0]);
+	else if (irq == OMAP44XX_IRQ_CTI1)
+		cti_irq_ack(&omap4_cti[1]);
+
+	return handler(irq, dev);
+}
+
+static void omap4_configure_pmu_irq(void)
+{
+	void __iomem *base0;
+	void __iomem *base1;
+
+	base0 = ioremap(OMAP44XX_CTI0_BASE, SZ_4K);
+	base1 = ioremap(OMAP44XX_CTI1_BASE, SZ_4K);
+	if (!base0 && !base1) {
+		pr_err("ioremap for OMAP4 CTI failed\n");
+		return;
+	}
+
+	/*configure CTI0 for pmu irq routing*/
+	cti_init(&omap4_cti[0], base0, OMAP44XX_IRQ_CTI0, 6);
+	cti_unlock(&omap4_cti[0]);
+	cti_map_trigger(&omap4_cti[0], 1, 6, 2);
+
+	/*configure CTI1 for pmu irq routing*/
+	cti_init(&omap4_cti[1], base1, OMAP44XX_IRQ_CTI1, 6);
+	cti_unlock(&omap4_cti[1]);
+	cti_map_trigger(&omap4_cti[1], 1, 6, 2);
+
+	omap4_pmu_data.handle_irq = omap4_pmu_handler;
+	omap4_pmu_data.enable_irq = omap4_enable_cti;
+	omap4_pmu_data.disable_irq = omap4_disable_cti;
+}
+
+static struct arm_pmu_platdata omap4_pmu_data;
+static struct omap_device_pm_latency omap_pmu_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static struct platform_device* __init omap4_init_pmu(void)
+{
+	int id = -1;
+	const char *hw;
+	struct platform_device *pd;
+	struct omap_hwmod* oh[3];
+	char *dev_name = "arm-pmu";
+
+	hw = "l3_main_3";
+	oh[0] = omap_hwmod_lookup(hw);
+	if (!oh[0]) {
+		pr_err("Could not look up %s hwmod\n", hw);
+		return NULL;
+	}
+	hw = "l3_instr";
+	oh[1] = omap_hwmod_lookup(hw);
+	if (!oh[1]) {
+		pr_err("Could not look up %s hwmod\n", hw);
+		return NULL;
+	}
+	hw = "emu";
+	oh[2] = omap_hwmod_lookup(hw);
+	if (!oh[2]) {
+		pr_err("Could not look up %s hwmod\n", hw);
+		return NULL;
+	}
+
+	pd = omap_device_build_ss(dev_name, id, oh, 3, &omap4_pmu_data,
+			sizeof(omap4_pmu_data),
+			omap_pmu_latency,
+			ARRAY_SIZE(omap_pmu_latency), 0);
+	WARN(IS_ERR(pd), "Can't build omap_device for %s.\n",
+			dev_name);
+	return pd;
+}
+
+static void __init omap_init_pmu(void)
+{
+	if (cpu_is_omap24xx()) {
 		omap_pmu_device.resource = &omap2_pmu_resource;
-	else if (cpu_is_omap34xx())
+	} else if (cpu_is_omap34xx()) {
 		omap_pmu_device.resource = &omap3_pmu_resource;
-	else
+	} else if (cpu_is_omap44xx()) {
+		struct platform_device *pd;
+
+		pd = omap4_init_pmu();
+		if (!pd)
+			return;
+{ int i;
+  for (i = 0 ; i < 2; i++)
+		printk("RES:%d IRQ:%d\n", i, platform_get_irq(pd, i));
+}
+		pmu_dev = pd;
+		pm_runtime_enable(&pd->dev);
+		pm_runtime_get_sync(&pd->dev);
+		omap4_configure_pmu_irq();
+		pm_runtime_put(&pd->dev);
+		return;
+	} else {
 		return;
+	}
 
 	platform_device_register(&omap_pmu_device);
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index daaf165..dd4e1c2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5276,6 +5276,30 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
 };
 
+static struct omap_hwmod_class omap44xx_emu_hwmod_class = {
+	.name	= "emu",
+};
+
+static struct omap_hwmod_irq_info omap44xx_emu_irqs[] = {
+	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+/*emu hwmod*/
+static struct omap_hwmod omap44xx_emu_hwmod = {
+	.name		= "emu",
+	.class		= &omap44xx_emu_hwmod_class,
+	.clkdm_name	= "emu_sys_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_EMU_CLKSTCTRL_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+	.mpu_irqs	= omap44xx_emu_irqs,
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* dmm class */
@@ -5422,6 +5446,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_wd_timer2_hwmod,
 	&omap44xx_wd_timer3_hwmod,
 
+	/*emu class*/
+	&omap44xx_emu_hwmod,
+
 	NULL,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index ea2b8a6..b127a16 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -57,5 +57,7 @@
 #define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
 #define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
 
+#define OMAP44XX_CTI0_BASE		0x54148000
+#define OMAP44XX_CTI1_BASE		0x54149000
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
