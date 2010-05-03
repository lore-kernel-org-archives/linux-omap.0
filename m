From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 5/8] omap: mailbox: reorganize omap2 platform_device
Date: Mon,  3 May 2010 03:02:44 +0300
Message-ID: <1272844967-25441-1-git-send-email-felipe.contreras@gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51880 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0ECACx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:02:53 -0400
Received: by bwz19 with SMTP id 19so1033152bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:02:52 -0700 (PDT)
In-Reply-To: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Makes more sense to register in the mach file, plus it will allow more
functionality later on.

Also, this probably enables multi-omap for real.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/devices.c |   74 ------------------------------------
 arch/arm/mach-omap2/mailbox.c |   83 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 18ad931..bc7ac38 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -136,79 +136,6 @@ static inline void omap_init_camera(void)
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
 #if defined(CONFIG_OMAP_STI)
 
 #if defined(CONFIG_ARCH_OMAP2)
@@ -772,7 +699,6 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_hsmmc_reset();
 	omap_init_camera();
-	omap_init_mbox();
 	omap_init_mcspi();
 	omap_hdq_init();
 	omap_init_sti();
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 8603464..e9a803c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -370,6 +370,46 @@ EXPORT_SYMBOL(mbox_2_info);
 
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info };
 
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
+
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
+
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
+
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -402,10 +442,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		list.mbox[0]->irq = res[1].start;
 		list.mbox[1]->irq = res[1].start;
 	}
-	else {
-		pr_err("%s: platform not supported\n", __func__);
-		return -ENODEV;
-	}
 
 	for (i = 0; i < list.num; i++) {
 		struct omap_mbox *mbox = list.mbox[i];
@@ -443,7 +479,46 @@ static struct platform_driver omap2_mbox_driver = {
 
 static int __init omap2_mbox_init(void)
 {
+	int err;
+	struct platform_device *pdev;
+	struct resource *res;
+	unsigned num;
+
+	if (cpu_is_omap3430()) {
+		res = omap3_mbox_resources;
+		num = ARRAY_SIZE(omap3_mbox_resources);
+	}
+	else if (cpu_is_omap2420()) {
+		res = omap2_mbox_resources;
+		num = ARRAY_SIZE(omap2_mbox_resources);
+	}
+	else if (cpu_is_omap44xx()) {
+		res = omap4_mbox_resources;
+		num = ARRAY_SIZE(omap4_mbox_resources);
+	}
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

