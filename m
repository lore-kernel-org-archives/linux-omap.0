From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/17] omap: mailbox: reorganize omap platform_device
Date: Fri, 14 May 2010 18:01:42 +0300
Message-ID: <1273849310-32169-10-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:44846 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab0ENPCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:02:22 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so902320ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 08:02:21 -0700 (PDT)
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Makes more sense to register in the mach file, plus it will allow more
functionality later on.

Also, this probably enables multi-omap for real.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/devices.c |   38 ----------------
 arch/arm/mach-omap1/mailbox.c |   56 ++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c |   92 ---------------------------------------
 arch/arm/mach-omap2/mailbox.c |   96 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 148 insertions(+), 134 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index da796f2..093dd13 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -63,43 +63,6 @@ static void omap_init_rtc(void)
 static inline void omap_init_rtc(void) {}
 #endif
 
-#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
-
-#if defined(CONFIG_ARCH_OMAP15XX)
-#  define OMAP1_MBOX_SIZE	0x23
-#  define INT_DSP_MAILBOX1	INT_1510_DSP_MAILBOX1
-#elif defined(CONFIG_ARCH_OMAP16XX)
-#  define OMAP1_MBOX_SIZE	0x2f
-#  define INT_DSP_MAILBOX1	INT_1610_DSP_MAILBOX1
-#endif
-
-static struct resource mbox_resources[] = {
-	{
-		.start		= OMAP16XX_MAILBOX_BASE,
-		.end		= OMAP16XX_MAILBOX_BASE + OMAP1_MBOX_SIZE,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= INT_DSP_MAILBOX1,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device mbox_device = {
-	.name		= "omap1-mailbox",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(mbox_resources),
-	.resource	= mbox_resources,
-};
-
-static inline void omap_init_mbox(void)
-{
-	platform_device_register(&mbox_device);
-}
-#else
-static inline void omap_init_mbox(void) { }
-#endif
-
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
@@ -293,7 +256,6 @@ static int __init omap1_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 
-	omap_init_mbox();
 	omap_init_rtc();
 	omap_init_spi100k();
 	omap_init_sti();
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index d81b238..25f1f89 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -147,6 +147,20 @@ EXPORT_SYMBOL(mbox_dsp_info);
 
 struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
+#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
+static struct resource omap1_mbox_resources[] = {
+	{
+		.start		= OMAP16XX_MAILBOX_BASE,
+		.end		= OMAP16XX_MAILBOX_BASE, /* to be updated */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= 10,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+#endif
+
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -198,7 +212,49 @@ static struct platform_driver omap1_mbox_driver = {
 
 static int __init omap1_mbox_init(void)
 {
+	int err;
+	struct platform_device *pdev;
+	struct resource *res;
+	unsigned num;
+
+	if (false);
+#if defined(CONFIG_ARCH_OMAP15XX)
+	else if (cpu_is_omap15xx()) {
+		res = omap1_mbox_resources;
+		num = ARRAY_SIZE(omap1_mbox_resources);
+		res[1].end += 0x23;
+	}
+#endif
+#if defined(CONFIG_ARCH_OMAP16XX)
+	else if (cpu_is_omap16xx()) {
+		res = omap1_mbox_resources;
+		num = ARRAY_SIZE(omap1_mbox_resources);
+		res[1].end += 0x2f;
+	}
+#endif
+	else {
+		pr_err("%s: platform not supported\n", __func__);
+		return -ENODEV;
+	}
+
+	pdev = platform_device_alloc("omap1-mailbox", -1);
+	if (!pdev) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = platform_device_add_resources(pdev, res, num);
+	if (err)
+		goto err_out;
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto err_out;
+
 	return platform_driver_register(&omap1_mbox_driver);
+
+err_out:
+	return err;
 }
 
 static void __exit omap1_mbox_exit(void)
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2271b9b..eac0e0f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -136,97 +136,6 @@ static inline void omap_init_camera(void)
 }
 #endif
 
-#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
-
-#define MBOX_REG_SIZE   0x120
-
-#ifdef CONFIG_ARCH_OMAP2
-static struct resource omap2_mbox_resources[] = {
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
-static int omap2_mbox_resources_sz = ARRAY_SIZE(omap2_mbox_resources);
-#else
-#define omap2_mbox_resources		NULL
-#define omap2_mbox_resources_sz		0
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct resource omap3_mbox_resources[] = {
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
-static int omap3_mbox_resources_sz = ARRAY_SIZE(omap3_mbox_resources);
-#else
-#define omap3_mbox_resources		NULL
-#define omap3_mbox_resources_sz		0
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-
-#define OMAP4_MBOX_REG_SIZE	0x130
-static struct resource omap4_mbox_resources[] = {
-	{
-		.start          = OMAP44XX_MAILBOX_BASE,
-		.end            = OMAP44XX_MAILBOX_BASE +
-					OMAP4_MBOX_REG_SIZE - 1,
-		.flags          = IORESOURCE_MEM,
-	},
-	{
-		.start          = OMAP44XX_IRQ_MAIL_U0,
-		.flags          = IORESOURCE_IRQ,
-	},
-};
-static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
-#else
-#define omap4_mbox_resources		NULL
-#define omap4_mbox_resources_sz		0
-#endif
-
-static struct platform_device mbox_device = {
-	.name		= "omap2-mailbox",
-	.id		= -1,
-};
-
-static inline void omap_init_mbox(void)
-{
-	if (cpu_is_omap24xx()) {
-		mbox_device.resource = omap2_mbox_resources;
-		mbox_device.num_resources = omap2_mbox_resources_sz;
-	} else if (cpu_is_omap34xx()) {
-		mbox_device.resource = omap3_mbox_resources;
-		mbox_device.num_resources = omap3_mbox_resources_sz;
-	} else if (cpu_is_omap44xx()) {
-		mbox_device.resource = omap4_mbox_resources;
-		mbox_device.num_resources = omap4_mbox_resources_sz;
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
 #if defined(CONFIG_OMAP_STI)
 
 #if defined(CONFIG_ARCH_OMAP2)
@@ -795,7 +704,6 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_hsmmc_reset();
 	omap_init_camera();
-	omap_init_mbox();
 	omap_init_mcspi();
 	omap_hdq_init();
 	omap_init_sti();
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 04b70ba..59e85fd 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -394,6 +394,52 @@ EXPORT_SYMBOL(mbox_2_info);
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 #endif
 
+#ifdef CONFIG_ARCH_OMAP2420
+static struct resource omap2_mbox_resources[] = {
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
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3430
+static struct resource omap3_mbox_resources[] = {
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
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+static struct resource omap4_mbox_resources[] = {
+	{
+		.start          = OMAP44XX_MAILBOX_BASE,
+		.end            = OMAP44XX_MAILBOX_BASE + OMAP4_MBOX_REG_SIZE - 1,
+		.flags          = IORESOURCE_MEM,
+	},
+	{
+		.start          = INT_44XX_MAIL_U0_MPU,
+		.flags          = IORESOURCE_IRQ,
+	},
+};
+#endif
+
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -430,10 +476,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		list[1]->irq = res[1].start;
 	}
 #endif
-	else {
-		pr_err("%s: platform not supported\n", __func__);
-		return -ENODEV;
-	}
 
 	for (i = 0; list[i]; i++) {
 		ret = omap_mbox_register(&pdev->dev, list[i]);
@@ -470,7 +512,53 @@ static struct platform_driver omap2_mbox_driver = {
 
 static int __init omap2_mbox_init(void)
 {
+	int err;
+	struct platform_device *pdev;
+	struct resource *res;
+	unsigned num;
+
+	if (false);
+#if defined(CONFIG_ARCH_OMAP3430)
+	else if (cpu_is_omap3430()) {
+		res = omap3_mbox_resources;
+		num = ARRAY_SIZE(omap3_mbox_resources);
+	}
+#endif
+#if defined(CONFIG_ARCH_OMAP2420)
+	else if (cpu_is_omap2420()) {
+		res = omap2_mbox_resources;
+		num = ARRAY_SIZE(omap2_mbox_resources);
+	}
+#endif
+#if defined(CONFIG_ARCH_OMAP4)
+	else if (cpu_is_omap44xx()) {
+		res = omap4_mbox_resources;
+		num = ARRAY_SIZE(omap4_mbox_resources);
+	}
+#endif
+	else {
+		pr_err("%s: platform not supported\n", __func__);
+		return -ENODEV;
+	}
+
+	pdev = platform_device_alloc("omap2-mailbox", -1);
+	if (!pdev) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = platform_device_add_resources(pdev, res, num);
+	if (err)
+		goto err_out;
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto err_out;
+
 	return platform_driver_register(&omap2_mbox_driver);
+
+err_out:
+	return err;
 }
 
 static void __exit omap2_mbox_exit(void)
-- 
1.7.1

