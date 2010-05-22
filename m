From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
Date: Sat, 22 May 2010 20:25:21 +0300
Message-ID: <1274549122-26521-2-git-send-email-felipe.contreras@gmail.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50783 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab0EVRZj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:25:39 -0400
Received: by bwz7 with SMTP id 7so385453bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:25:36 -0700 (PDT)
In-Reply-To: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Only OMAP3 would work.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/devices.c              |  103 +++++----------------------
 arch/arm/mach-omap2/mailbox.c              |   14 +---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   45 ++++++++++++
 arch/arm/plat-omap/include/plat/mailbox.h  |    4 +
 4 files changed, 72 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d9ac853..89f6cbc 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -20,12 +20,14 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap_device.h>
 #include <plat/control.h>
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
+#include <plat/mailbox.h>
 
 #include "mux.h"
 
@@ -137,95 +139,28 @@ static inline void omap_init_camera(void)
 #endif
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
+static inline void omap_init_mbox(void)
+{
+	struct omap_hwmod *hwmod;
+	struct omap_device *odev;
+	struct omap_mbox_platform_data pdata;
 
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
-		.name		= "dsp",
-	},
-	{
-		.start		= INT_24XX_MAIL_U3_MPU,
-		.flags		= IORESOURCE_IRQ,
-		.name		= "iva",
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
-		.name		= "dsp",
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
-		.name		= "mbox",
-	},
-};
-static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
-#else
-#define omap4_mbox_resources		NULL
-#define omap4_mbox_resources_sz		0
-#endif
+	hwmod = omap_hwmod_lookup("mailbox");
+	if (!hwmod) {
+		pr_err("%s: unable to find hwmod\n", __func__);
+		return;
+	}
 
-static struct platform_device mbox_device = {
-	.name		= "omap-mailbox",
-	.id		= -1,
-};
+	pdata.base_addr = hwmod->_rt_va;
 
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
+	odev = omap_device_build("omap-mailbox", -1, hwmod,
+			&pdata, sizeof(pdata),
+			NULL, 0,
+			0);
+	if (!odev) {
+		pr_err("%s: could not build device\n", __func__);
 		return;
 	}
-	platform_device_register(&mbox_device);
 }
 #else
 static inline void omap_init_mbox(void) { }
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index d46e439..baaaa5a 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <plat/mailbox.h>
+#include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
 
 #define MAILBOX_REVISION		0x000
@@ -388,11 +389,9 @@ struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	int ret;
 	struct omap_mbox **list;
-
-	res = pdev->resource;
+	struct omap_mbox_platform_data *pdata = pdev->dev.platform_data;
 
 	if (false);
 #if defined(CONFIG_ARCH_OMAP3430)
@@ -423,15 +422,11 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
-	if (!mbox_base)
-		return -ENOMEM;
+	mbox_base = pdata->base_addr;
 
 	ret = omap_mbox_register(&pdev->dev, list);
-	if (ret) {
-		iounmap(mbox_base);
+	if (ret)
 		return ret;
-	}
 	return 0;
 
 	return ret;
@@ -440,7 +435,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 {
 	omap_mbox_unregister();
-	iounmap(mbox_base);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ed60840..62b8fa8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -164,12 +164,57 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* mailbox */
+
+static struct omap_hwmod_class omap3xxx_mailbox_hwmod_class = {
+	.name = "mailbox",
+};
+
+static struct omap_hwmod omap3xxx_mailbox_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_mailbox_irqs[] = {
+	{ .name = "dsp", .irq = 26 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mailbox_addrs[] = {
+	{
+		.pa_start	= 0x48094000,
+		.pa_end		= 0x48094120,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* L4_CORE -> mailbox */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__mailbox = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_mailbox_hwmod,
+	.addr		= omap3xxx_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mailbox_slaves[] = {
+	&omap3xxx_l4_core__mailbox,
+};
+
+static struct omap_hwmod omap3xxx_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap3xxx_mailbox_hwmod_class,
+	.main_clk	= "mailboxes_ick",
+	.mpu_irqs	= omap3xxx_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mailbox_irqs),
+	.slaves		= omap3xxx_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_hwmod,
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
+	&omap3xxx_mailbox_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 9976565..78060bd 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -59,6 +59,10 @@ struct omap_mbox {
 	void			*priv;
 };
 
+struct omap_mbox_platform_data {
+	void __iomem *base_addr;
+};
+
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
-- 
1.7.1

