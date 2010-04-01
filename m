From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Thu, 01 Apr 2010 14:26:29 +0300 (EEST)
Message-ID: <20100401.142629.226796472.Hiroshi.DOYU@nokia.com>
References: <20100329.120856.59654379.Hiroshi.DOYU@nokia.com>
	<20100401095203.GL31200@atomide.com>
	<20100401.132336.193692763.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42268 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab0DAL0n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 07:26:43 -0400
In-Reply-To: <20100401.132336.193692763.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: felipe.balbi@nokia.com, x0095840@ti.com, linux-omap@vger.kernel.org, ameya.palande@nokia.com, felipe.contreras@nokia.com

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Thu, 01 Apr 2010 13:23:36 +0300 (EEST)

> From: ext Tony Lindgren <tony@atomide.com>
> Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
> Date: Thu, 1 Apr 2010 11:52:04 +0200
> 
>> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100329 02:05]:
>>> From: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
>>> Subject: Re: [PATCH] OMAP3: mailbox initialization for all omap versions
>>> Date: Mon, 29 Mar 2010 09:01:45 +0200
>>> > 
>>> > in that case, wouldn't it be better to split that into 
>>> > arch/arm/omap1/mbox.c arch/arm/omap2/mbox24xx.c 
>>> > arch/arm/omap2/mbox34xx.c arch/arm/omap2/mbox44xx.c ??
>>> > 
>>> > that way we don't need ifdefs on the code and we will only compile what 
>>> > we really need.
>>> 
>>> This is feasible.
>>> But I'm not so sure whether adding 4 new files with around only 10
>>> lines code is acceptable or not.
>>> 
>>> Tony, any comment on the above?
>>> 
>>> Basically there could be the case we need all resources if we want to
>>> support omap1, 2, 3 and 4 at the same time, and the appropriate one
>>> will be chosen at run time by CPUID. I'm not sure how mature "omap
>>> multi arch" support is practically, but it's better to keep it as much
>>> as possbile.
>> 
>> I like Felipe's suggestion of adding devices2420.c, devices34xx.c,
>> devices44xx.c or similar. Then do the device init from those with
>> a arch_initcall that returns immediately if not running on the right
>> soc.
> 
> Ok, let's procced with this. I'll post something later.
> 

Something like the following?

>From cfd9eae083478da16d1f8b910ab7d04b6869ba9b Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Thu, 1 Apr 2010 14:14:08 +0300
Subject: [PATCH 1/1] [RFC] omap: add arch specific device initialization files

TBA, Not tested.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/Makefile      |    4 ++
 arch/arm/mach-omap2/devices.c     |   74 -------------------------------------
 arch/arm/mach-omap2/devices24xx.c |   63 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices34xx.c |   59 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices44xx.c |   60 ++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm/mach-omap2/devices24xx.c
 create mode 100644 arch/arm/mach-omap2/devices34xx.c
 create mode 100644 arch/arm/mach-omap2/devices44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 048faa0..94fa938 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -17,6 +17,10 @@ obj-$(CONFIG_ARCH_OMAP4) += $(omap-3-4-common) prcm.o clock.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
+obj-$(CONFIG_ARCH_OMAP24xx)		+= devices24xx.o
+obj-$(CONFIG_ARCH_OMAP34xx)		+= devices34xx.o
+obj-$(CONFIG_ARCH_OMAP44xx)		+= devices44xx.o
+
 # SMP support ONLY available for OMAP4
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index a622b6e..359f0ce 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -169,79 +169,6 @@ static inline void omap_init_camera(void)
 }
 #endif
 
-#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
-
-#define MBOX_REG_SIZE   0x120
-
-#ifdef CONFIG_ARCH_OMAP2
-static struct resource omap_mbox_resources[] = {
-	{
-		.start		= OMAP24XX_MAILBOX_BASE,
-		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= INT_24XX_MAIL_U0_MPU,
-		.flags		= IORESOURCE_IRQ,
-	},
-	{
-		.start		= INT_24XX_MAIL_U3_MPU,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct resource omap_mbox_resources[] = {
-	{
-		.start		= OMAP34XX_MAILBOX_BASE,
-		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= INT_24XX_MAIL_U0_MPU,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-
-#define OMAP4_MBOX_REG_SIZE	0x130
-static struct resource omap_mbox_resources[] = {
-	{
-		.start          = OMAP44XX_MAILBOX_BASE,
-		.end            = OMAP44XX_MAILBOX_BASE +
-					OMAP4_MBOX_REG_SIZE - 1,
-		.flags          = IORESOURCE_MEM,
-	},
-	{
-		.start          = INT_44XX_MAIL_U0_MPU,
-		.flags          = IORESOURCE_IRQ,
-	},
-};
-#endif
-
-static struct platform_device mbox_device = {
-	.name		= "omap2-mailbox",
-	.id		= -1,
-};
-
-static inline void omap_init_mbox(void)
-{
-	if (cpu_is_omap2420() || cpu_is_omap3430() || cpu_is_omap44xx()) {
-		mbox_device.num_resources = ARRAY_SIZE(omap_mbox_resources);
-		mbox_device.resource = omap_mbox_resources;
-	} else {
-		pr_err("%s: platform not supported\n", __func__);
-		return;
-	}
-	platform_device_register(&mbox_device);
-}
-#else
-static inline void omap_init_mbox(void) { }
-#endif /* CONFIG_OMAP_MBOX_FWK */
-
 #if defined(CONFIG_OMAP_SDTI)
 
 #if defined(CONFIG_ARCH_OMAP2)
@@ -865,7 +792,6 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_hsmmc_reset();
 	omap_init_camera();
-	omap_init_mbox();
 	omap_init_mcspi();
 	omap_hdq_init();
 	omap_init_sti();
diff --git a/arch/arm/mach-omap2/devices24xx.c b/arch/arm/mach-omap2/devices24xx.c
new file mode 100644
index 0000000..22baa8b
--- /dev/null
+++ b/arch/arm/mach-omap2/devices24xx.c
@@ -0,0 +1,63 @@
+/*
+ * omap24xx architecture specific deivce initialization
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <plat/irqs.h>
+
+#include <mach/hardware.h>
+
+#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
+
+#define MBOX_REG_SIZE   0x120
+
+static struct resource omap_mbox_resources[] = {
+	{
+		.start		= OMAP24XX_MAILBOX_BASE,
+		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= INT_24XX_MAIL_U0_MPU,
+		.flags		= IORESOURCE_IRQ,
+	},
+	{
+		.start		= INT_24XX_MAIL_U3_MPU,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_mbox_device = {
+	.name		= "omap2-mailbox",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(omap_mbox_resources),
+	.resource	= omap_mbox_resources,
+};
+
+static inline void omap_mbox_init(void)
+{
+	platform_device_register(&omap_mbox_device);
+}
+#else
+static inline void omap_mbox_init(void) { }
+#endif	/* CONFIG_OMAP_MBOX_FWK */
+
+static int __init omap24xx_init_devices(void)
+{
+	if (!cpu_is_omap24xx())
+		return;
+
+	omap_mbox_init();
+
+	return 0;
+}
+arch_initcall(omap24xx_init_devices);
diff --git a/arch/arm/mach-omap2/devices34xx.c b/arch/arm/mach-omap2/devices34xx.c
new file mode 100644
index 0000000..0de1208
--- /dev/null
+++ b/arch/arm/mach-omap2/devices34xx.c
@@ -0,0 +1,59 @@
+/*
+ * omap34xx architecture specific deivce initialization
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <plat/irqs.h>
+
+#include <mach/hardware.h>
+
+#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
+
+#define MBOX_REG_SIZE   0x120
+
+static struct resource omap_mbox_resources[] = {
+	{
+		.start		= OMAP34XX_MAILBOX_BASE,
+		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= INT_24XX_MAIL_U0_MPU,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_mbox_device = {
+	.name		= "omap2-mailbox",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(omap_mbox_resources),
+	.resource	= omap_mbox_resources,
+};
+
+static inline void omap_mbox_init(void)
+{
+	platform_device_register(&omap_mbox_device);
+}
+#else
+static inline void omap_mbox_init(void) { }
+#endif	/* CONFIG_OMAP_MBOX_FWK */
+
+static int __init omap34xx_init_devices(void)
+{
+	if (!cpu_is_omap34xx())
+		return 0;
+
+	omap_mbox_init();
+
+	return 0;
+}
+arch_initcall(omap34xx_init_devices);
diff --git a/arch/arm/mach-omap2/devices44xx.c b/arch/arm/mach-omap2/devices44xx.c
new file mode 100644
index 0000000..ad98033
--- /dev/null
+++ b/arch/arm/mach-omap2/devices44xx.c
@@ -0,0 +1,60 @@
+/*
+ * omap44xx architecture specific deivce initialization
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <plat/irqs.h>
+
+#include <mach/hardware.h>
+
+#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
+
+#define OMAP4_MBOX_REG_SIZE	0x130
+
+static struct resource omap_mbox_resources[] = {
+	{
+		.start          = OMAP44XX_MAILBOX_BASE,
+		.end            = OMAP44XX_MAILBOX_BASE +
+					OMAP4_MBOX_REG_SIZE - 1,
+		.flags          = IORESOURCE_MEM,
+	},
+	{
+		.start          = INT_44XX_MAIL_U0_MPU,
+		.flags          = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_mbox_device = {
+	.name		= "omap2-mailbox",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(omap_mbox_resources),
+	.resource	= omap_mbox_resources,
+};
+
+static inline void omap_mbox_init(void)
+{
+	platform_device_register(&omap_mbox_device);
+}
+#else
+static inline void omap_mbox_init(void) { }
+#endif	/* CONFIG_OMAP_MBOX_FWK */
+
+static int __init omap44xx_init_devices(void)
+{
+	if (!cpu_is_omap44xx())
+		return;
+
+	omap_mbox_init();
+
+	return 0;
+}
+arch_initcall(omap44xx_init_devices);
-- 
1.6.3.3


