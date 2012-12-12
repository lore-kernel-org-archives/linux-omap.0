From: Jon Hunter <jon-hunter@ti.com>
Subject: [RFC 3/5] ARM: CTI: Convert CTI helpers to AMBA bus driver
Date: Wed, 12 Dec 2012 15:43:06 -0600
Message-ID: <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47062 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129Ab2LLVox (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 16:44:53 -0500
In-Reply-To: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>, Jon Hunter <jon-hunter@ti.com>

Convert the Cross Trigger Interface (CTI) helpers in cti.h into a
AMBA bus driver so that we can use device-tree to look-up the hardware
specific information such as base address and interrupt number during
the device probe. This also add APIs to request, cti_get() and release,
cti_put(), a CTI module so that drivers can allocate a module at
runtime.

Currently, the driver only supports looking-up the CTI hardware
information via device-tree, however, the driver could be extended to
support non-device-tree configurations if needed for a particular
architecture.

The CTI driver only currently supports CTI modules that have a single
CPU interrupt, however, could be extended in the future to support more
interrupts if a device requires this.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/include/asm/cti.h |  153 ------------------------
 drivers/Kconfig            |    2 +
 drivers/amba/Kconfig       |   20 ++++
 drivers/amba/Makefile      |    1 +
 drivers/amba/cti.c         |  284 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/amba/cti.h   |   82 +++++++++++++
 6 files changed, 389 insertions(+), 153 deletions(-)
 delete mode 100644 arch/arm/include/asm/cti.h
 create mode 100644 drivers/amba/Kconfig
 create mode 100644 drivers/amba/cti.c
 create mode 100644 include/linux/amba/cti.h

diff --git a/arch/arm/include/asm/cti.h b/arch/arm/include/asm/cti.h
deleted file mode 100644
index 00add00..0000000
--- a/arch/arm/include/asm/cti.h
+++ /dev/null
@@ -1,153 +0,0 @@
-#ifndef __ASMARM_CTI_H
-#define __ASMARM_CTI_H
-
-#include	<asm/io.h>
-#include	<asm/hardware/coresight.h>
-
-/* The registers' definition is from section 3.2 of
- * Embedded Cross Trigger Revision: r0p0
- */
-#define		CTICONTROL		0x000
-#define		CTISTATUS		0x004
-#define		CTILOCK			0x008
-#define		CTIPROTECTION		0x00C
-#define		CTIINTACK		0x010
-#define		CTIAPPSET		0x014
-#define		CTIAPPCLEAR		0x018
-#define		CTIAPPPULSE		0x01c
-#define		CTIINEN			0x020
-#define		CTIOUTEN		0x0A0
-#define		CTITRIGINSTATUS		0x130
-#define		CTITRIGOUTSTATUS	0x134
-#define		CTICHINSTATUS		0x138
-#define		CTICHOUTSTATUS		0x13c
-#define		CTIPERIPHID0		0xFE0
-#define		CTIPERIPHID1		0xFE4
-#define		CTIPERIPHID2		0xFE8
-#define		CTIPERIPHID3		0xFEC
-#define		CTIPCELLID0		0xFF0
-#define		CTIPCELLID1		0xFF4
-#define		CTIPCELLID2		0xFF8
-#define		CTIPCELLID3		0xFFC
-
-/**
- * struct cti - cross trigger interface struct
- * @base: mapped virtual address for the cti base
- * @irq: irq number for the cti
- * @trig_out_for_irq: triger out number which will cause
- *	the @irq happen
- *
- * cti struct used to operate cti registers.
- */
-struct cti {
-	void __iomem *base;
-	int irq;
-	int trig_out_for_irq;
-};
-
-/**
- * cti_init - initialize the cti instance
- * @cti: cti instance
- * @base: mapped virtual address for the cti base
- * @irq: irq number for the cti
- * @trig_out: triger out number which will cause
- *	the @irq happen
- *
- * called by machine code to pass the board dependent
- * @base, @irq and @trig_out to cti.
- */
-static inline void cti_init(struct cti *cti,
-	void __iomem *base, int irq, int trig_out)
-{
-	cti->base = base;
-	cti->irq  = irq;
-	cti->trig_out_for_irq = trig_out;
-}
-
-/**
- * cti_map_trigger - use the @chan to map @trig_in to @trig_out
- * @cti: cti instance
- * @trig_in: trigger in number
- * @trig_out: trigger out number
- * @channel: channel number
- *
- * This function maps one trigger in of @trig_in to one trigger
- * out of @trig_out using the channel @chan.
- */
-static inline void cti_map_trigger(struct cti *cti,
-	int trig_in, int trig_out, int chan)
-{
-	void __iomem *base = cti->base;
-	unsigned long val;
-
-	val = __raw_readl(base + CTIINEN + trig_in * 4);
-	val |= BIT(chan);
-	__raw_writel(val, base + CTIINEN + trig_in * 4);
-
-	val = __raw_readl(base + CTIOUTEN + trig_out * 4);
-	val |= BIT(chan);
-	__raw_writel(val, base + CTIOUTEN + trig_out * 4);
-}
-
-/**
- * cti_enable - enable the cti module
- * @cti: cti instance
- *
- * enable the cti module
- */
-static inline void cti_enable(struct cti *cti)
-{
-	__raw_writel(0x1, cti->base + CTICONTROL);
-}
-
-/**
- * cti_disable - disable the cti module
- * @cti: cti instance
- *
- * enable the cti module
- */
-static inline void cti_disable(struct cti *cti)
-{
-	__raw_writel(0, cti->base + CTICONTROL);
-}
-
-/**
- * cti_irq_ack - clear the cti irq
- * @cti: cti instance
- *
- * clear the cti irq
- */
-static inline void cti_irq_ack(struct cti *cti)
-{
-	void __iomem *base = cti->base;
-	unsigned long val;
-
-	val = __raw_readl(base + CTIINTACK);
-	val |= BIT(cti->trig_out_for_irq);
-	__raw_writel(val, base + CTIINTACK);
-}
-
-/**
- * cti_unlock - unlock cti module
- * @cti: cti instance
- *
- * unlock the cti module, or else any writes to the cti
- * module is not allowed.
- */
-static inline void cti_unlock(struct cti *cti)
-{
-	coresight_unlock(cti->base);
-}
-
-/**
- * cti_lock - lock cti module
- * @cti: cti instance
- *
- * lock the cti module, so any writes to the cti
- * module will be not allowed.
- */
-static inline void cti_lock(struct cti *cti)
-{
-	coresight_lock(cti->base);
-}
-#endif
diff --git a/drivers/Kconfig b/drivers/Kconfig
index dbdefa3..e857075 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -2,6 +2,8 @@ menu "Device Drivers"
 
 source "drivers/base/Kconfig"
 
+source "drivers/amba/Kconfig"
+
 source "drivers/bus/Kconfig"
 
 source "drivers/connector/Kconfig"
diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
new file mode 100644
index 0000000..b97ea23
--- /dev/null
+++ b/drivers/amba/Kconfig
@@ -0,0 +1,20 @@
+#
+# AMBA Devices
+#
+
+menu "AMBA devices"
+
+config ARM_AMBA_CTI
+	bool "Cross-Trigger Interface"
+	depends on ARM && OF
+	select ARM_AMBA
+	help
+	  The ARM Cross Trigger Interface provides a way to route events
+	  between processor modules. For example, debug events from one
+	  processor can be broadcasted to other processors. The events that
+	  can be routed between processors are specific to the device.
+	  Currently, the driver only supports looking-up the CTI hardware
+	  information (base address and interrupts) from device-tree (and
+	  hence, is dependent upon CONFIG_OF).
+
+endmenu
diff --git a/drivers/amba/Makefile b/drivers/amba/Makefile
index 66e81c2..f74abe9 100644
--- a/drivers/amba/Makefile
+++ b/drivers/amba/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARM_AMBA)		+= bus.o
+obj-$(CONFIG_ARM_AMBA_CTI)	+= cti.o
 obj-$(CONFIG_TEGRA_AHB)		+= tegra-ahb.o
diff --git a/drivers/amba/cti.c b/drivers/amba/cti.c
new file mode 100644
index 0000000..04debe7
--- /dev/null
+++ b/drivers/amba/cti.c
@@ -0,0 +1,284 @@
+/*
+ * ARM Cross Trigger Interface (CTI) Driver
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *  Jon Hunter <jon-hunter@ti.com>
+ *
+ * Based upon CTI Helpers by Ming Lei <ming.lei@canonical.com>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <asm/hardware/coresight.h>
+
+#include <linux/amba/bus.h>
+#include <linux/amba/cti.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+/* The registers' definition is from section 3.2 of
+ * Embedded Cross Trigger Revision: r0p0
+ */
+#define		CTICONTROL		0x000
+#define		CTISTATUS		0x004
+#define		CTILOCK			0x008
+#define		CTIPROTECTION		0x00C
+#define		CTIINTACK		0x010
+#define		CTIAPPSET		0x014
+#define		CTIAPPCLEAR		0x018
+#define		CTIAPPPULSE		0x01c
+#define		CTIINEN			0x020
+#define		CTIOUTEN		0x0A0
+#define		CTITRIGINSTATUS		0x130
+#define		CTITRIGOUTSTATUS	0x134
+#define		CTICHINSTATUS		0x138
+#define		CTICHOUTSTATUS		0x13c
+#define		CTIPERIPHID0		0xFE0
+#define		CTIPERIPHID1		0xFE4
+#define		CTIPERIPHID2		0xFE8
+#define		CTIPERIPHID3		0xFEC
+#define		CTIPCELLID0		0xFF0
+#define		CTIPCELLID1		0xFF4
+#define		CTIPCELLID2		0xFF8
+#define		CTIPCELLID3		0xFFC
+#define		CTI_MAX_CHANNELS	15
+#define		CTI_MAX_TRIGGERS	7
+
+#define cti_writel(v, c, x) (__raw_writel((v), (c)->base + (x)))
+#define cti_readl(c, x) (__raw_readl((c)->base + (x)))
+
+static DEFINE_SPINLOCK(cti_lock);
+static LIST_HEAD(cti_list);
+
+/**
+ * cti_map_trigger - use the @chan to map @trig_in to @trig_out
+ * @cti:	CTI instance
+ * @trig_in:	trigger in number
+ * @trig_out:	trigger out number
+ * @chan:	channel number
+ *
+ * Maps one trigger in of @trig_in to one trigger out of @trig_out
+ * using the channel @chan. The CTI module must not be enabled when
+ * calling this function.
+ */
+int cti_map_trigger(struct cti *cti, int trig_in, int trig_out, int chan)
+{
+	u32 v;
+
+	if (!cti)
+		return -EINVAL;
+
+	if (cti->enabled)
+		return -EBUSY;
+
+	if (chan > CTI_MAX_CHANNELS)
+		return -EINVAL;
+
+	if ((trig_in > CTI_MAX_TRIGGERS) || (trig_out > CTI_MAX_TRIGGERS))
+		return -EINVAL;
+
+	coresight_unlock(cti->base);
+
+	v = cti_readl(cti, CTIINEN + trig_in * 4);
+	v |= BIT(chan);
+	cti_writel(v, cti, CTIINEN + trig_in * 4);
+	v = cti_readl(cti, CTIOUTEN + trig_out * 4);
+	v |= BIT(chan);
+	cti_writel(v, cti, CTIOUTEN + trig_out * 4);
+	cti->trig_out = trig_out;
+
+	coresight_lock(cti->base);
+
+	return 0;
+}
+
+/**
+ * cti_enable - enable the CTI module
+ * @cti: CTI instance
+ *
+ * Unlocks and enables the CTI module. The CTI module cannot be
+ * programmed again until it has been disabled.
+ */
+int cti_enable(struct cti *cti)
+{
+	if (!cti || cti->enabled)
+			return -EINVAL;
+
+	coresight_unlock(cti->base);
+	cti_writel(1, cti, CTICONTROL);
+	cti->enabled = true;
+
+	return 0;
+}
+
+/**
+ * cti_disable - disable the CTI module
+ * @cti: CTI instance
+ *
+ * Disables and locks the CTI module.
+ */
+int cti_disable(struct cti *cti)
+{
+	if (!cti || !cti->enabled)
+		return -EINVAL;
+
+	cti_writel(0, cti, CTICONTROL);
+	cti->enabled = false;
+	coresight_lock(cti->base);
+
+	return 0;
+}
+
+/**
+ * cti_irq_ack - acknowledges the CTI trigger output
+ * @cti: CTI instance
+ *
+ * Acknowledges the CTI trigger output by writting to the appropriate
+ * bit in the CTI interrupt acknowledge register.
+ */
+int cti_irq_ack(struct cti *cti)
+{
+	u32 v;
+
+	if (!cti || !cti->enabled)
+		return -EINVAL;
+
+	v = cti_readl(cti, CTIINTACK);
+	v |= BIT(cti->trig_out);
+	cti_writel(v, cti, CTIINTACK);
+
+	return 0;
+}
+
+/**
+ * cti_get - acquire a CTI module
+ * @name: name of CTI instance
+ *
+ * Acquires a CTI module from a list of CTI modules by name. If the CTI
+ * module is already in use then return NULL, otherwise return a valid
+ * handle to the CTI module.
+ */
+struct cti *cti_get(const char *name)
+{
+	struct cti *cti = NULL;
+	unsigned long flags;
+
+	if (!name)
+		return NULL;
+
+	spin_lock_irqsave(&cti_lock, flags);
+
+	if (list_empty(&cti_list))
+		goto out;
+
+	list_for_each_entry(cti, &cti_list, node) {
+		if (!strcmp(cti->name, name) && (!cti->reserved)) {
+			cti->reserved = true;
+			goto out;
+		}
+	}
+
+out:
+	spin_unlock_irqrestore(&cti_lock, flags);
+
+	if (cti)
+		pm_runtime_get_sync(cti->dev);
+
+	return cti;
+}
+
+/**
+ * cti_put - release handle to CTI module
+ * @cti: CTI instance
+ *
+ * Releases a handle to CTI module that was previously acquired.
+ */
+void cti_put(struct cti *cti)
+{
+	if (!cti || !cti->reserved)
+		return;
+
+	cti->reserved = false;
+
+	pm_runtime_put(cti->dev);
+}
+
+static int cti_probe(struct amba_device *dev, const struct amba_id *id)
+{
+	struct cti *cti;
+	struct device_node *np = dev->dev.of_node;
+	int rc;
+
+	if (!np) {
+		dev_err(&dev->dev, "device-tree not found!\n");
+		return -ENODEV;
+	}
+
+	cti = devm_kzalloc(&dev->dev, sizeof(struct cti), GFP_KERNEL);
+	if (!cti) {
+		dev_err(&dev->dev, "memory allocation failed!\n");
+		return -ENOMEM;
+	}
+
+	rc = of_property_read_string_index(np, "arm,cti-name", 0, &cti->name);
+	if (rc) {
+		dev_err(&dev->dev, "no name found for CTI!\n");
+		return rc;
+	}
+
+	if (!dev->irq[0]) {
+		dev_err(&dev->dev, "no CTI interrupt found!\n");
+		return -ENODEV;
+	}
+
+	cti->irq = dev->irq[0];
+	cti->base = of_iomap(np, 0);
+	if (!cti->base) {
+		dev_err(&dev->dev, "unable to map CTI registers!\n");
+		return -ENOMEM;
+	}
+
+	cti->dev = &dev->dev;
+	amba_set_drvdata(dev, cti);
+	list_add_tail(&cti->node, &cti_list);
+
+	/*
+	 * AMBA bus driver has already enabled RPM and incremented
+	 * use-count, so now we can safely decrement the use-count
+	 * and allow the CTI driver to manage RPM for the device.
+	 */
+	pm_runtime_put(&dev->dev);
+
+	dev_info(&dev->dev, "ARM CTI driver");
+
+	return 0;
+}
+
+static const struct amba_id cti_ids[] = {
+	{
+		.id	= 0x003bb906,
+		.mask	= 0x00ffffff,
+	},
+	{ 0, 0 },
+};
+
+static struct amba_driver cti_driver = {
+	.drv		= {
+		.name	= "cti",
+	},
+	.id_table	= cti_ids,
+	.probe		= cti_probe,
+};
+
+static int __init cti_init(void)
+{
+	return amba_driver_register(&cti_driver);
+}
+subsys_initcall(cti_init);
diff --git a/include/linux/amba/cti.h b/include/linux/amba/cti.h
new file mode 100644
index 0000000..a82ae76
--- /dev/null
+++ b/include/linux/amba/cti.h
@@ -0,0 +1,82 @@
+/*
+ * ARM Cross Trigger Interface Platform Driver
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *  Jon Hunter <jon-hunter@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef AMBA_CTI_H
+#define AMBA_CTI_H
+
+#include <linux/io.h>
+
+/**
+ * struct cti - Cross Trigger Interface (CTI) struct
+ *
+ * @node:	Connects CTI instance to list of CTI instances
+ * @dev:	Pointer to device structure
+ * @base:	Mapped virtual address of the CTI module
+ * @name:	Name associated with CTI instance
+ * @irq:	Interrupt associated with CTI instance
+ * @trig_out:	Trigger output associated with interrupt (@irq)
+ * @reserved:	Used to indicate if CTI instance has been allocated
+ * @enabled:	Used to indicate if CTI instance has been enabled
+ */
+struct cti {
+	struct list_head node;
+	struct device *dev;
+	void __iomem *base;
+	const char *name;
+	int irq;
+	int trig_out;
+	bool reserved;
+	bool enabled;
+};
+
+#ifdef CONFIG_ARM_AMBA_CTI
+
+int cti_map_trigger(struct cti *cti, int trig_in, int trig_out, int chan);
+int cti_enable(struct cti *cti);
+int cti_disable(struct cti *cti);
+int cti_irq_ack(struct cti *cti);
+struct cti *cti_get(const char *name);
+void cti_put(struct cti *cti);
+
+#else
+
+static inline int cti_map_trigger(struct cti *cti, int trig_in, int trig_out,
+				  int chan)
+{
+	return 0;
+}
+
+static inline int cti_enable(struct cti *cti)
+{
+	return 0;
+}
+
+static inline int cti_disable(struct cti *cti)
+{
+	return 0;
+}
+
+static inline int cti_irq_ack(struct cti *cti)
+{
+	return 0;
+}
+
+static inline struct cti *cti_get(const char *name)
+{
+	return NULL;
+}
+
+static inline void cti_put(struct cti *cti) {}
+
+#endif /* ARM_AMBA_CTI */
+
+#endif /* AMBA_CTI_H */
-- 
1.7.10.4

