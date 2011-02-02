From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v5 4/5] OMAP: mailbox: build device using omap_device/omap_hwmod
Date: Wed,  2 Feb 2011 13:27:22 -0600
Message-ID: <1296674843-12718-5-git-send-email-omar.ramirez@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60475 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab1BBTij (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Feb 2011 14:38:39 -0500
In-Reply-To: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, Felipe Contreras <felipe.contreras@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Felipe Contreras <felipe.contreras@gmail.com>

Remove static platform_device and resource data within
omap mailbox driver; use the one defined in the hwmod
database along with omap_device framework for device
build and registration.

Add device latency functions to be used, so clock can be
enabled and sysconfig is configured.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/devices.c |   98 +++++++----------------------------------
 1 files changed, 16 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2c9c912..826bea0 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -142,95 +142,29 @@ static inline void omap_init_camera(void)
 #endif
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
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
+static struct omap_device_pm_latency mbox_latencies[] = {
+	[0] = {
+		.activate_func = omap_device_enable_hwmods,
+		.deactivate_func = omap_device_idle_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
 };
-static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
-#else
-#define omap4_mbox_resources		NULL
-#define omap4_mbox_resources_sz		0
-#endif
-
-static struct platform_device mbox_device = {
-	.name		= "omap-mailbox",
-	.id		= -1,
-};
 
 static inline void omap_init_mbox(void)
 {
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
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+
+	oh = omap_hwmod_lookup("mailbox");
+	if (!oh) {
+		pr_err("%s: unable to find hwmod\n", __func__);
 		return;
 	}
-	platform_device_register(&mbox_device);
+
+	od = omap_device_build("omap-mailbox", -1, oh, NULL, 0,
+				mbox_latencies, ARRAY_SIZE(mbox_latencies), 0);
+	WARN(IS_ERR(od), "%s: could not build device, err %ld\n",
+						__func__, PTR_ERR(od));
 }
 #else
 static inline void omap_init_mbox(void) { }
-- 
1.7.1

