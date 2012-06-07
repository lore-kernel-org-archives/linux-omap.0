From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 06/10] ARM: OMAP4: Route PMU IRQs to CTI IRQs
Date: Thu, 7 Jun 2012 16:22:08 -0500
Message-ID: <1339104132-26885-7-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58354 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932933Ab2FGVXB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 17:23:01 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Ming Lei <ming.lei@canonical.com>, Woodruff Richard <r-woodruff2@ti.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Ming Lei <ming.lei@canonical.com>

For OMAP4430 there are no dedicate PMU interrupts, however, PMU events can be
routed to via the CTI IRQs. This allows tools such as PERF and OPROFILE to work
on OMAP4430.

The idea is from Woodruff Richard in the disscussion about "Oprofile on
Pandaboard / Omap4" on pandaboard@googlegroups.com.

Ming's original patch was called "arm: omap4: support pmu" [1] and has been
renamed and modified by Jon Hunter. There main differences from the original
patch are ...

1. Instead of only configuring the CTI interrupt once during boot, the
   interrupts are configured everytime the the PMU is used. The reason for this
   is because during power transitions the CTI logic state will be lost and so
   we will need to configure the interrupts everytime they are used. This is
   accomplished by using the PM runtime callbacks which will be called whenever
   the PMU is used.
2. Assign the PMU events to different cross triggering channels. This prevents
   a single PMU event generating interrupts to both CPUs and hence can cause
   spurious interrupts to occur. Reported by Ming [2].

[1] http://marc.info/?l=linux-arm-kernel&m=132227620816504&w=2
[2] http://permalink.gmane.org/gmane.linux.linaro.devel/10532

Acked-by: Jean Pihet <j-pihet@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Woodruff Richard <r-woodruff2@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c                  |   92 +++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 1b36eda..228e247 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -16,11 +16,14 @@
 #include <linux/pm_runtime.h>
 
 #include <asm/pmu.h>
+#include <asm/cti.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
+static struct arm_pmu_platdata omap_pmu_data;
 static struct platform_device *omap_pmu_dev;
+static struct cti omap4_cti[2];
 
 /*
  * omap2_init_pmu - creates and registers PMU platform device
@@ -54,6 +57,84 @@ static int __init omap2_init_pmu(void)
 }
 
 /*
+ * omap4_pmu_runtime_resume - PMU runtime resume callback
+ *
+ * Platform specific PMU runtime resume callback for OMAP4430 devices to
+ * configure the cross trigger interface for routing PMU interrupts. This
+ * is called by the PM runtime framework.
+ */
+static int omap4_pmu_runtime_resume(struct device *dev)
+{
+	/* configure CTI0 for PMU IRQ routing */
+	cti_unlock(&omap4_cti[0]);
+	cti_map_trigger(&omap4_cti[0], 1, 6, 2);
+	cti_enable(&omap4_cti[0]);
+
+	/* configure CTI1 for PMU IRQ routing */
+	cti_unlock(&omap4_cti[1]);
+	cti_map_trigger(&omap4_cti[1], 1, 6, 3);
+	cti_enable(&omap4_cti[1]);
+
+	return 0;
+}
+
+/*
+ * omap4_pmu_runtime_suspend - PMU runtime suspend callback
+ *
+ * Platform specific PMU runtime suspend callback for OMAP4430 devices to
+ * disable the cross trigger interface interrupts. This is called by the
+ * PM runtime framework.
+ */
+static int omap4_pmu_runtime_suspend(struct device *dev)
+{
+	cti_disable(&omap4_cti[0]);
+	cti_disable(&omap4_cti[1]);
+
+	return 0;
+}
+
+/*
+ * omap4_pmu_handle_irq - PMU IRQ Handler
+ *
+ * Platform specific PMU IRQ handler for OMAP4430 devices that route PMU
+ * interrupts via cross trigger interface. This is called by the PMU driver.
+ */
+static irqreturn_t
+omap4_pmu_handle_irq(int irq, void *dev, irq_handler_t handler)
+{
+	if (irq == OMAP44XX_IRQ_CTI0)
+		cti_irq_ack(&omap4_cti[0]);
+	else if (irq == OMAP44XX_IRQ_CTI1)
+		cti_irq_ack(&omap4_cti[1]);
+
+	return handler(irq, dev);
+}
+
+/*
+ * omap4_init_cti - initialise cross trigger interface instances
+ *
+ * Initialises two cross trigger interface (CTI) instances in preparation
+ * for routing PMU interrupts to the OMAP interrupt controller. Note that
+ * this does not configure the actual CTI hardware but just the CTI
+ * software structures to be used.
+ */
+static int __init omap4_init_cti(void)
+{
+	omap4_cti[0].base = ioremap(OMAP44XX_CTI0_BASE, SZ_4K);
+	omap4_cti[1].base = ioremap(OMAP44XX_CTI1_BASE, SZ_4K);
+
+	if (!omap4_cti[0].base || !omap4_cti[1].base) {
+		pr_err("ioremap for OMAP4 CTI failed\n");
+		return -ENOMEM;
+	}
+
+	cti_init(&omap4_cti[0], omap4_cti[0].base, OMAP44XX_IRQ_CTI0, 6);
+	cti_init(&omap4_cti[1], omap4_cti[1].base, OMAP44XX_IRQ_CTI1, 6);
+
+	return 0;
+}
+
+/*
  * omap4430_init_pmu - creates and registers PMU platform device
  *
  * Uses OMAP HWMOD framework to create and register an ARM PMU device.
@@ -69,6 +150,9 @@ static int __init omap4430_init_pmu(void)
 	char *oh_name;
 	char *dev_name = "arm-pmu";
 
+	if (omap4_init_cti())
+		return -ENOMEM;
+
 	oh_name = "l3_main_3";
 	oh[0] = omap_hwmod_lookup(oh_name);
 	if (!oh[0]) {
@@ -88,8 +172,12 @@ static int __init omap4430_init_pmu(void)
 		return -ENODEV;
 	}
 
-	omap_pmu_dev = omap_device_build_ss(dev_name, id, oh, 3, NULL,
-				0, NULL, 0, 0);
+	omap_pmu_data.handle_irq = omap4_pmu_handle_irq;
+	omap_pmu_data.runtime_resume = omap4_pmu_runtime_resume;
+	omap_pmu_data.runtime_suspend = omap4_pmu_runtime_suspend;
+
+	omap_pmu_dev = omap_device_build_ss(dev_name, id, oh, 3, &omap_pmu_data,
+				sizeof(omap_pmu_data), NULL, 0, 0);
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 				dev_name);
 
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index c0d478e..1800a9b 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -58,5 +58,8 @@
 #define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
 #define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
 
+#define OMAP44XX_CTI0_BASE		(L4_EMU_44XX_BASE + 0x148000)
+#define OMAP44XX_CTI1_BASE		(L4_EMU_44XX_BASE + 0x149000)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.7.9.5

