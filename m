From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 2/2 RFC]OMAP3430: hwmod: Adapt GPIO to use HWMOD FW
Date: Fri, 12 Feb 2010 19:09:28 +0530
Message-ID: <1265981968-14696-3-git-send-email-charu@ti.com>
References: <1265981968-14696-1-git-send-email-charu@ti.com>
 <1265981968-14696-2-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55118 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab0BLNj7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Feb 2010 08:39:59 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1CDdtNu007660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 07:39:58 -0600
In-Reply-To: <1265981968-14696-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

HWmod framework is used for OMAP3430 GPIO driver.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |  901 ++++----------------------------
 arch/arm/plat-omap/include/plat/gpio.h |   25 +-
 2 files changed, 123 insertions(+), 803 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index f28900f..7b00a1e 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -31,689 +31,15 @@
 #include <asm/mach/irq.h>
 #include <plat/powerdomain.h>
 #include <plat/mux.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
-/*
- * OMAP242X GPIO1 interface data
- */
-static struct __initdata resource omap242x_gpio1_resources[] = {
-	{
-		.start	= OMAP242X_GPIO1_BASE,
-		.end	= OMAP242X_GPIO1_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap242x_gpio1_config = {
-	.ick_name = "gpios_ick",
-	.fck_name = "gpios_fck",
-	.virtual_irq_start = IH_GPIO_BASE,
-};
-
-static struct __initdata platform_device omap242x_gpio1 = {
-	.name           = "omap-gpio",
-	.id             = 0,
-	.dev            = {
-		.platform_data = &omap242x_gpio1_config,
-	},
-	.num_resources = ARRAY_SIZE(omap242x_gpio1_resources),
-	.resource = omap242x_gpio1_resources,
-};
-
-/*
- * OMAP242X GPIO2 interface data
- */
-static struct __initdata resource omap242x_gpio2_resources[] = {
-	{
-		.start	= OMAP242X_GPIO2_BASE,
-		.end	= OMAP242X_GPIO2_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap242x_gpio2_config = {
-	.ick_name = "gpios_ick",
-	.fck_name = "gpios_fck",
-	.virtual_irq_start = IH_GPIO_BASE + 32,
-};
-
-static struct __initdata platform_device omap242x_gpio2 = {
-	.name           = "omap-gpio",
-	.id             = 1,
-	.dev            = {
-		.platform_data = &omap242x_gpio2_config,
-	},
-	.num_resources = ARRAY_SIZE(omap242x_gpio2_resources),
-	.resource = omap242x_gpio2_resources,
-};
-
-/*
- * OMAP242X GPIO3 interface data
- */
-static struct __initdata resource omap242x_gpio3_resources[] = {
-	{
-		.start	= OMAP242X_GPIO3_BASE,
-		.end	= OMAP242X_GPIO3_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap242x_gpio3_config = {
-	.ick_name = "gpios_ick",
-	.fck_name = "gpios_fck",
-	.virtual_irq_start = IH_GPIO_BASE + 64,
-};
-
-static struct __initdata platform_device omap242x_gpio3 = {
-	.name           = "omap-gpio",
-	.id             = 2,
-	.dev            = {
-		.platform_data = &omap242x_gpio3_config,
+struct omap_device_pm_latency omap_gpio_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
-	.num_resources = ARRAY_SIZE(omap242x_gpio3_resources),
-	.resource = omap242x_gpio3_resources,
-};
-
-/*
- * OMAP242X GPIO4 interface data
- */
-static struct __initdata resource omap242x_gpio4_resources[] = {
-	{
-		.start	= OMAP242X_GPIO4_BASE,
-		.end	= OMAP242X_GPIO4_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK4,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap242x_gpio4_config = {
-	.ick_name = "gpios_ick",
-	.fck_name = "gpios_fck",
-	.virtual_irq_start = IH_GPIO_BASE + 96,
-};
-
-static struct __initdata platform_device omap242x_gpio4 = {
-	.name           = "omap-gpio",
-	.id             = 3,
-	.dev            = {
-		.platform_data = &omap242x_gpio4_config,
-	},
-	.num_resources = ARRAY_SIZE(omap242x_gpio4_resources),
-	.resource = omap242x_gpio4_resources,
-};
-
-/*
- * OMAP243X GPIO1 interface data
- */
-static struct __initdata resource omap243x_gpio1_resources[] = {
-	{
-		.start	= OMAP243X_GPIO1_BASE,
-		.end	= OMAP243X_GPIO1_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap243x_gpio1_config = {
-	.ick_name = "gpios_ick",
-	.fck_name = "gpios_fck",
-	.virtual_irq_start = IH_GPIO_BASE,
-};
-
-static struct __initdata platform_device omap243x_gpio1 = {
-	.name           = "omap-gpio",
-	.id             = 0,
-	.dev            = {
-		.platform_data = &omap243x_gpio1_config,
-	},
-	.num_resources = ARRAY_SIZE(omap243x_gpio1_resources),
-	.resource = omap243x_gpio1_resources,
-};
-
-/*
- * OMAP243X GPIO2 interface data
- */
-static struct __initdata resource omap243x_gpio2_resources[] = {
-	{
-		.start	= OMAP243X_GPIO2_BASE,
-		.end	= OMAP243X_GPIO2_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap243x_gpio2_config = {
-	.ick_name = "gpios_ick",
-	.fck_name = "gpios_fck",
-	.virtual_irq_start = IH_GPIO_BASE + 32,
-};
-
-static struct __initdata platform_device omap243x_gpio2 = {
-	.name           = "omap-gpio",
-	.id             = 1,
-	.dev            = {
-		.platform_data = &omap243x_gpio2_config,
-	},
-	.num_resources = ARRAY_SIZE(omap243x_gpio2_resources),
-	.resource = omap243x_gpio2_resources,
-};
-
-/*
- * OMAP243X GPIO3 interface data
- */
-static struct __initdata resource omap243x_gpio3_resources[] = {
-	{
-		.start	= OMAP243X_GPIO3_BASE,
-		.end	= OMAP243X_GPIO3_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap243x_gpio3_config = {
-	.ick_name = "gpios_ick",
-	.fck_name = "gpios_fck",
-	.virtual_irq_start = IH_GPIO_BASE + 64,
-};
-
-static struct __initdata platform_device omap243x_gpio3 = {
-	.name           = "omap-gpio",
-	.id             = 2,
-	.dev            = {
-		.platform_data = &omap243x_gpio3_config,
-	},
-	.num_resources = ARRAY_SIZE(omap243x_gpio3_resources),
-	.resource = omap243x_gpio3_resources,
-};
-
-/*
- * OMAP243X GPIO4 interface data
- */
-static struct __initdata resource omap243x_gpio4_resources[] = {
-	{
-		.start	= OMAP243X_GPIO4_BASE,
-		.end	= OMAP243X_GPIO4_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK4,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap243x_gpio4_config = {
-	.ick_name = "gpios_ick",
-	.fck_name = "gpios_fck",
-	.virtual_irq_start = IH_GPIO_BASE + 96,
-};
-
-static struct __initdata platform_device omap243x_gpio4 = {
-	.name           = "omap-gpio",
-	.id             = 3,
-	.dev            = {
-		.platform_data = &omap243x_gpio4_config,
-	},
-	.num_resources = ARRAY_SIZE(omap243x_gpio4_resources),
-	.resource = omap243x_gpio4_resources,
-};
-
-/*
- * OMAP243X GPIO5 interface data
- */
-static struct __initdata resource omap243x_gpio5_resources[] = {
-	{
-		.start	= OMAP243X_GPIO5_BASE,
-		.end	= OMAP243X_GPIO5_BASE + OMAP2_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_24XX_GPIO_BANK5,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap243x_gpio5_config = {
-	.ick_name = "gpio5_ick",
-	.fck_name = "gpio5_fck",
-	.virtual_irq_start = IH_GPIO_BASE + 128,
-};
-
-static struct __initdata platform_device omap243x_gpio5 = {
-	.name           = "omap-gpio",
-	.id             = 4,
-	.dev            = {
-		.platform_data = &omap243x_gpio5_config,
-	},
-	.num_resources = ARRAY_SIZE(omap243x_gpio5_resources),
-	.resource = omap243x_gpio5_resources,
-};
-
-/*
- * OMAP3 GPIO1 interface data
- */
-static struct __initdata resource omap3_gpio1_resources[] = {
-	{
-		.start	= OMAP34XX_GPIO1_BASE,
-		.end	= OMAP34XX_GPIO1_BASE + OMAP3_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_34XX_GPIO_BANK1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap3_gpio1_config = {
-	.ick_name = "gpio1_ick",
-	.dbck_name = "gpio1_dbck",
-	.virtual_irq_start = IH_GPIO_BASE,
-};
-
-static struct __initdata platform_device omap3_gpio1 = {
-	.name           = "omap-gpio",
-	.id             = 0,
-	.dev            = {
-		.platform_data = &omap3_gpio1_config,
-	},
-	.num_resources = ARRAY_SIZE(omap3_gpio1_resources),
-	.resource = omap3_gpio1_resources,
-};
-
-/*
- * OMAP3 GPIO2 interface data
- */
-static struct __initdata resource omap3_gpio2_resources[] = {
-	{
-		.start	= OMAP34XX_GPIO2_BASE,
-		.end	= OMAP34XX_GPIO2_BASE + OMAP3_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_34XX_GPIO_BANK2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap3_gpio2_config = {
-	.ick_name = "gpio2_ick",
-	.dbck_name = "gpio2_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 32,
-};
-
-static struct __initdata platform_device omap3_gpio2 = {
-	.name           = "omap-gpio",
-	.id             = 1,
-	.dev            = {
-		.platform_data = &omap3_gpio2_config,
-	},
-	.num_resources = ARRAY_SIZE(omap3_gpio2_resources),
-	.resource = omap3_gpio2_resources,
-};
-
-/*
- * OMAP3 GPIO3 interface data
- */
-static struct __initdata resource omap3_gpio3_resources[] = {
-	{
-		.start	= OMAP34XX_GPIO3_BASE,
-		.end	= OMAP34XX_GPIO3_BASE + OMAP3_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_34XX_GPIO_BANK3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap3_gpio3_config = {
-	.ick_name = "gpio3_ick",
-	.dbck_name = "gpio3_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 64,
-};
-
-static struct __initdata platform_device omap3_gpio3 = {
-	.name           = "omap-gpio",
-	.id             = 2,
-	.dev            = {
-		.platform_data = &omap3_gpio3_config,
-	},
-	.num_resources = ARRAY_SIZE(omap3_gpio3_resources),
-	.resource = omap3_gpio3_resources,
-};
-
-/*
- * OMAP3 GPIO4 interface data
- */
-static struct __initdata resource omap3_gpio4_resources[] = {
-	{
-		.start	= OMAP34XX_GPIO4_BASE,
-		.end	= OMAP34XX_GPIO4_BASE + OMAP3_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_34XX_GPIO_BANK4,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap3_gpio4_config = {
-	.ick_name = "gpio4_ick",
-	.dbck_name = "gpio4_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 96,
-};
-
-static struct __initdata platform_device omap3_gpio4 = {
-	.name           = "omap-gpio",
-	.id             = 3,
-	.dev            = {
-		.platform_data = &omap3_gpio4_config,
-	},
-	.num_resources = ARRAY_SIZE(omap3_gpio4_resources),
-	.resource = omap3_gpio4_resources,
-};
-
-/*
- * OMAP3 GPIO5 interface data
- */
-static struct __initdata resource omap3_gpio5_resources[] = {
-	{
-		.start	= OMAP34XX_GPIO5_BASE,
-		.end	= OMAP34XX_GPIO5_BASE + OMAP3_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_34XX_GPIO_BANK5,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap3_gpio5_config = {
-	.ick_name = "gpio5_ick",
-	.dbck_name = "gpio5_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 128,
-};
-
-static struct __initdata platform_device omap3_gpio5 = {
-	.name           = "omap-gpio",
-	.id             = 4,
-	.dev            = {
-		.platform_data = &omap3_gpio5_config,
-	},
-	.num_resources = ARRAY_SIZE(omap3_gpio5_resources),
-	.resource = omap3_gpio5_resources,
-};
-
-/*
- * OMAP3 GPIO6 interface data
- */
-static struct __initdata resource omap3_gpio6_resources[] = {
-	{
-		.start	= OMAP34XX_GPIO6_BASE,
-		.end	= OMAP34XX_GPIO6_BASE + OMAP3_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_34XX_GPIO_BANK4,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap3_gpio6_config = {
-	.ick_name = "gpio6_ick",
-	.dbck_name = "gpio6_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 160,
-};
-
-static struct __initdata platform_device omap3_gpio6 = {
-	.name           = "omap-gpio",
-	.id             = 5,
-	.dev            = {
-		.platform_data = &omap3_gpio6_config,
-	},
-	.num_resources = ARRAY_SIZE(omap3_gpio6_resources),
-	.resource = omap3_gpio6_resources,
-};
-
-/*
- * OMAP44XX GPIO1 interface data
- */
-static struct __initdata resource omap4_gpio1_resources[] = {
-	{
-		.start	= OMAP44XX_GPIO1_BASE,
-		.end	= OMAP44XX_GPIO1_BASE + OMAP4_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_44XX_GPIO_BANK1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap4_gpio1_config = {
-	.ick_name = "gpio1_ick",
-	.dbck_name = "gpio1_dbck",
-	.virtual_irq_start = IH_GPIO_BASE,
-};
-
-static struct __initdata platform_device omap4_gpio1 = {
-	.name           = "omap-gpio",
-	.id             = 0,
-	.dev            = {
-		.platform_data = &omap4_gpio1_config,
-	},
-	.num_resources = ARRAY_SIZE(omap4_gpio1_resources),
-	.resource = omap4_gpio1_resources,
-};
-
-/*
- * OMAP44XX GPIO2 interface data
- */
-static struct __initdata resource omap4_gpio2_resources[] = {
-	{
-		.start	= OMAP44XX_GPIO2_BASE,
-		.end	= OMAP44XX_GPIO2_BASE + OMAP4_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_44XX_GPIO_BANK2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap4_gpio2_config = {
-	.ick_name = "gpio2_ick",
-	.dbck_name = "gpio2_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 32,
-};
-
-static struct __initdata platform_device omap4_gpio2 = {
-	.name           = "omap-gpio",
-	.id             = 1,
-	.dev            = {
-		.platform_data = &omap4_gpio2_config,
-	},
-	.num_resources = ARRAY_SIZE(omap4_gpio2_resources),
-	.resource = omap4_gpio2_resources,
-};
-
-/*
- * OMAP44XX GPIO3 interface data
- */
-static struct __initdata resource omap4_gpio3_resources[] = {
-	{
-		.start	= OMAP44XX_GPIO3_BASE,
-		.end	= OMAP44XX_GPIO3_BASE + OMAP4_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_44XX_GPIO_BANK3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap4_gpio3_config = {
-	.ick_name = "gpio3_ick",
-	.dbck_name = "gpio3_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 64,
-};
-
-static struct __initdata platform_device omap4_gpio3 = {
-	.name           = "omap-gpio",
-	.id             = 2,
-	.dev            = {
-		.platform_data = &omap4_gpio3_config,
-	},
-	.num_resources = ARRAY_SIZE(omap4_gpio3_resources),
-	.resource = omap4_gpio3_resources,
-};
-
-/*
- * OMAP44XX GPIO4 interface data
- */
-static struct __initdata resource omap4_gpio4_resources[] = {
-	{
-		.start	= OMAP44XX_GPIO4_BASE,
-		.end	= OMAP44XX_GPIO4_BASE + OMAP4_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_44XX_GPIO_BANK4,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap4_gpio4_config = {
-	.ick_name = "gpio4_ick",
-	.dbck_name = "gpio4_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 96,
-};
-
-static struct __initdata platform_device omap4_gpio4 = {
-	.name           = "omap-gpio",
-	.id             = 3,
-	.dev            = {
-		.platform_data = &omap4_gpio4_config,
-	},
-	.num_resources = ARRAY_SIZE(omap4_gpio4_resources),
-	.resource = omap4_gpio4_resources,
-};
-
-/*
- * OMAP44XX GPIO5 interface data
-  */
-static struct __initdata resource omap4_gpio5_resources[] = {
-	{
-		.start	= OMAP44XX_GPIO5_BASE,
-		.end	= OMAP44XX_GPIO5_BASE + OMAP4_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_44XX_GPIO_BANK5,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap4_gpio5_config = {
-	.ick_name = "gpio5_ick",
-	.dbck_name = "gpio5_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 128,
-};
-
-static struct __initdata platform_device omap4_gpio5 = {
-	.name           = "omap-gpio",
-	.id             = 4,
-	.dev            = {
-		.platform_data = &omap4_gpio5_config,
-	},
-	.num_resources = ARRAY_SIZE(omap4_gpio5_resources),
-	.resource = omap4_gpio5_resources,
-};
-
-/*
- * OMAP44XX GPIO6 interface data
-  */
-static struct __initdata resource omap4_gpio6_resources[] = {
-	{
-		.start	= OMAP44XX_GPIO6_BASE,
-		.end	= OMAP44XX_GPIO6_BASE + OMAP4_GPIO_AS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_44XX_GPIO_BANK6,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct __initdata omap_gpio_platform_data omap4_gpio6_config = {
-	.ick_name = "gpio6_ick",
-	.dbck_name = "gpio6_dbck",
-	.virtual_irq_start = IH_GPIO_BASE + 160,
-};
-
-static struct __initdata platform_device omap4_gpio6 = {
-	.name           = "omap-gpio",
-	.id             = 5,
-	.dev            = {
-		.platform_data = &omap4_gpio6_config,
-	},
-	.num_resources = ARRAY_SIZE(omap4_gpio6_resources),
-	.resource = omap4_gpio6_resources,
-};
-
-static struct __initdata platform_device * omap242x_gpio_early_dev[] = {
-	&omap242x_gpio1,
-	&omap242x_gpio2,
-	&omap242x_gpio3,
-	&omap242x_gpio4
-};
-
-static struct __initdata platform_device * omap243x_gpio_early_dev[] = {
-	&omap243x_gpio1,
-	&omap243x_gpio2,
-	&omap243x_gpio3,
-	&omap243x_gpio4,
-	&omap243x_gpio5
-};
-
-static struct __initdata platform_device * omap3_gpio_early_dev[] = {
-	&omap3_gpio1,
-	&omap3_gpio2,
-	&omap3_gpio3,
-	&omap3_gpio4,
-	&omap3_gpio5,
-	&omap3_gpio6
-};
-
-static struct __initdata platform_device * omap4_gpio_early_dev[] = {
-	&omap4_gpio1,
-	&omap4_gpio2,
-	&omap4_gpio3,
-	&omap4_gpio4,
-	&omap4_gpio5,
-	&omap4_gpio6
 };
 
 struct omap3_gpio_regs {
@@ -731,7 +57,7 @@ struct omap3_gpio_regs {
 };
 
 #ifdef CONFIG_ARCH_OMAP3
-static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
+static struct omap3_gpio_regs gpio_context[OMAP_NR_GPIOS];
 #endif
 
 /* GPIO -> PAD init configuration struct */
@@ -785,13 +111,13 @@ struct gpio_pad {
 	u16 save;
 };
 
-#define OMAP34XX_GPIO_AMT	(32 * OMAP34XX_NR_GPIOS)
+#define OMAP34XX_GPIO_AMT	(32 * OMAP_NR_GPIOS)
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct gpio_pad *gpio_pads;
 #endif
 static u16 gpio_pad_map[OMAP34XX_GPIO_AMT];
-static struct gpio_bank gpio_bank[OMAP_MAX_NR_GPIOS];
+static struct gpio_bank gpio_bank[OMAP_NR_GPIOS];
 static int gpio_bank_count;
 
 static inline struct gpio_bank *get_gpio_bank(int gpio)
@@ -1836,7 +1162,7 @@ void omap_gpio_save_context(void)
 	u16 offset, conf;
 	u32 out, pin;
 	struct gpio_pad *pad;
-	u32 tmp_oe[OMAP34XX_NR_GPIOS];
+	u32 tmp_oe[OMAP_NR_GPIOS];
 
 	/* saving banks from 2-6 only since GPIO1 is in WKUP */
 	for (i = 1; i < gpio_bank_count; i++) {
@@ -1978,17 +1304,8 @@ static int __devexit omap_gpio_remove(struct platform_device *pdev)
 		return 0;
 
 	bank = &gpio_bank[id];
-	if (cpu_is_omap24xx()) {
-		clk_disable(bank->fck);
-		clk_put(bank->fck);
-	}
-	clk_disable(bank->ick);
-	clk_put(bank->ick);
-
-	bank->ick = NULL;
-	bank->fck = NULL;
+	bank->device_shutdown(pdev);
 	bank->initialized = 0;
-	iounmap(bank->base);
 
 	return 0;
 }
@@ -1998,7 +1315,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	static int show_rev_once;
 	struct omap_gpio_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_bank *bank;
-	struct resource *res;
 	int id, i;
 
 	if (!pdev || !pdata) {
@@ -2007,14 +1323,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	gpio_bank_count = OMAP_NR_GPIOS;
+#ifdef CONFIG_ARCH_OMAP2
 	if (cpu_is_omap242x())
 		gpio_bank_count = OMAP242X_NR_GPIOS;
-	else if (cpu_is_omap243x())
-		gpio_bank_count = OMAP243X_NR_GPIOS;
-	else if (cpu_is_omap34xx())
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-	else if (cpu_is_omap44xx())
-		gpio_bank_count = OMAP44XX_NR_GPIOS;
+#endif
 
 	id = pdev->id;
 	if (id > gpio_bank_count) {
@@ -2028,47 +1341,17 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		return 0;
 
 	bank->virtual_irq_start = pdata->virtual_irq_start;
-
-	bank->ick = clk_get(NULL, pdata->ick_name);
-	if (IS_ERR(bank->ick))
-		pr_err("Could not get %s\n", pdata->ick_name);
-	else
-		clk_enable(bank->ick);
-
-	if (cpu_is_omap24xx()) {
-		bank->fck = clk_get(NULL, pdata->fck_name);
-		if (IS_ERR(bank->fck))
-			pr_err("Could not get %s\n", pdata->fck_name);
-		else
-			clk_enable(bank->fck);
-	}
+	bank->base = pdata->base;
+	bank->device_enable = pdata->device_enable;
+	bank->device_idle = pdata->device_idle;
+	bank->device_shutdown = pdata->device_shutdown;
 
 	spin_lock_init(&bank->lock);
-
-	/* Static mapping, never released */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!res)) {
-		pr_err("GPIO Bank %i Invalid mem resource\n", id);
-		return -ENODEV;
-	}
-
-	bank->base = ioremap(res->start, resource_size(res));
-	if (!bank->base) {
-		pr_err("Could not ioremap gpio bank%i\n", id);
-		return -ENOMEM;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!res)) {
-		pr_err("GPIO Bank %i Invalid irq resource\n", id);
-		return -ENODEV;
-	}
+	pdata->device_enable(pdev);
 
 	if (cpu_is_omap44xx()) {
 		__raw_writel(0xffffffff, bank->base +
 					OMAP4_GPIO_IRQSTATUSCLR0);
-		__raw_writew(0x0015, bank->base +
-					OMAP4_GPIO_SYSCONFIG);
 		__raw_writel(0x00000000, bank->base +
 					 OMAP4_GPIO_DEBOUNCENABLE);
 		/* Initialize interface clk ungated, module enabled */
@@ -2078,8 +1361,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 					OMAP24XX_GPIO_IRQENABLE1);
 		__raw_writel(0xffffffff, bank->base +
 					OMAP24XX_GPIO_IRQSTATUS1);
-		__raw_writew(0x0015, bank->base +
-					OMAP24XX_GPIO_SYSCONFIG);
 		__raw_writel(0x00000000, bank->base +
 					OMAP24XX_GPIO_DEBOUNCE_EN);
 
@@ -2120,13 +1401,16 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		set_irq_handler(i, handle_simple_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
-	set_irq_chained_handler(res->start, gpio_irq_handler);
-	set_irq_data(res->start, bank);
+	set_irq_chained_handler(pdata->irq, gpio_irq_handler);
+	set_irq_data(pdata->irq, bank);
 
+	/* XXX TODO: Remove once hwmod supports getting opt_clk details */
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		bank->dbck = clk_get(NULL, pdata->dbck_name);
+		char clk_name[11];
+		sprintf(clk_name, "gpio%d_dbck", id + 1);
+		bank->dbck = clk_get(NULL, clk_name);
 		if (IS_ERR(bank->dbck))
-			pr_err("Could not get %s\n", pdata->dbck_name);
+			pr_err("Could not get %s\n", clk_name);
 	}
 
 	/* Enable autoidle for the OCP interface */
@@ -2147,64 +1431,96 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 void __init omap_gpio_early_init(void)
 {
-	struct platform_device **pdev;
+	int i = 0;
 
-	if (cpu_is_omap242x()) {
-		pdev = omap242x_gpio_early_dev;
+	gpio_bank_count = OMAP_NR_GPIOS;
+#ifdef CONFIG_ARCH_OMAP2
+	if (cpu_is_omap242x())
 		gpio_bank_count = OMAP242X_NR_GPIOS;
-	} else if (cpu_is_omap243x()) {
-		pdev = omap243x_gpio_early_dev;
-		gpio_bank_count = OMAP243X_NR_GPIOS;
-	} else if (cpu_is_omap34xx()) {
-		pdev = omap3_gpio_early_dev;
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-	} else if (cpu_is_omap44xx()) {
-		pdev = omap4_gpio_early_dev;
-		gpio_bank_count = OMAP44XX_NR_GPIOS;
-	}
+#endif
+
+	do {
+		struct omap_device *od;
+		struct omap_hwmod *oh;
+		int hw_mod_name_len = 16;
+		int l;
+		char oh_name[hw_mod_name_len];
+		struct omap_gpio_platform_data *pdata;
+		char *name = "omap-gpio";
+
+		l = snprintf(oh_name, hw_mod_name_len, "gpio%d_hwmod", i + 1);
+		WARN(l >= hw_mod_name_len,
+			"String buffer overflow in GPIO device setup\n");
+
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh) {
+			pr_err("Could not look up %s\n", oh_name);
+			continue;
+		}
+
+		pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
+					GFP_KERNEL);
+		pdata->base = oh->_rt_va;
+		pdata->irq = oh->mpu_irqs[0].irq;
+		pdata->virtual_irq_start = IH_GPIO_BASE + 32 * i;
+		pdata->device_enable = omap_device_enable;
+		pdata->device_idle = omap_device_idle;
+		pdata->device_shutdown = omap_device_shutdown;
+
+		od = omap_device_build(name, i, oh, pdata,
+					sizeof(*pdata),	omap_gpio_latency,
+					ARRAY_SIZE(omap_gpio_latency), 1);
+		WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
+					name, oh->name);
+
+		i++;
+	} while (i < gpio_bank_count);
 
-	early_platform_add_devices(pdev, gpio_bank_count);
 	early_platform_driver_register_all("earlygpio");
 	early_platform_driver_probe("earlygpio", gpio_bank_count, 0);
+	return;
 }
 
 int __init omap_init_gpio(void)
 {
-	if (cpu_is_omap242x()) {
-		platform_device_add(&omap242x_gpio1);
-		platform_device_add(&omap242x_gpio2);
-		platform_device_add(&omap242x_gpio3);
-		platform_device_add(&omap242x_gpio4);
-		platform_device_register(&omap242x_gpio1);
-		platform_device_register(&omap242x_gpio2);
-		platform_device_register(&omap242x_gpio3);
-		platform_device_register(&omap242x_gpio4);
-	} else if (cpu_is_omap243x()) {
-		platform_device_add(&omap243x_gpio1);
-		platform_device_add(&omap243x_gpio2);
-		platform_device_add(&omap243x_gpio3);
-		platform_device_add(&omap243x_gpio4);
-		platform_device_add(&omap243x_gpio5);
-		platform_device_register(&omap243x_gpio1);
-		platform_device_register(&omap243x_gpio2);
-		platform_device_register(&omap243x_gpio3);
-		platform_device_register(&omap243x_gpio4);
-		platform_device_register(&omap243x_gpio5);
-	} else if (cpu_is_omap34xx()) {
-		platform_device_register(&omap3_gpio1);
-		platform_device_register(&omap3_gpio2);
-		platform_device_register(&omap3_gpio3);
-		platform_device_register(&omap3_gpio4);
-		platform_device_register(&omap3_gpio5);
-		platform_device_register(&omap3_gpio6);
-	} else if (cpu_is_omap44xx()) {
-		platform_device_add(&omap4_gpio1);
-		platform_device_add(&omap4_gpio2);
-		platform_device_add(&omap4_gpio3);
-		platform_device_add(&omap4_gpio4);
-		platform_device_add(&omap4_gpio5);
-		platform_device_add(&omap4_gpio6);
-	}
+	int i = 0;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	int hw_mod_name_len = 16;
+	int l;
+	char oh_name[hw_mod_name_len];
+	struct omap_gpio_platform_data *pdata;
+	char *name = "omap-gpio";
+
+	do {
+		l = snprintf(oh_name, hw_mod_name_len, "gpio%d_hwmod", i + 1);
+		WARN(l >= hw_mod_name_len,
+			"String buffer overflow in GPIO device setup\n");
+
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh) {
+			pr_err("Could not look up %s\n", oh_name);
+			continue;
+		}
+
+		pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
+					GFP_KERNEL);
+		pdata->base = oh->_rt_va;
+		pdata->irq = oh->mpu_irqs[0].irq;
+		pdata->virtual_irq_start = IH_GPIO_BASE + 32 * i;
+		pdata->device_enable = omap_device_enable;
+		pdata->device_idle = omap_device_idle;
+		pdata->device_shutdown = omap_device_shutdown;
+
+		od = omap_device_build(name, i, oh, pdata,
+					sizeof(*pdata),	omap_gpio_latency,
+					ARRAY_SIZE(omap_gpio_latency), 0);
+		WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
+					name, oh->name);
+
+		i++;
+	} while (i < gpio_bank_count);
+
 	return 0;
 }
 
@@ -2235,7 +1551,6 @@ static int __init omap_gpio_sysinit(void)
 		if (ret == 0)
 			ret = sysdev_register(&omap_gpio_device);
 	}
-
 	return ret;
 }
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 1470e8e..e1a09a6 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 #include <linux/sysdev.h>
 #include <mach/irqs.h>
+#include <linux/platform_device.h>
 
 #define OMAP1_MPUIO_BASE			0xfffb5000
 
@@ -63,11 +64,14 @@
 #define OMAP_MPUIO_LATCH		0x34
 #endif
 
+#if defined(CONFIG_ARCH_OMAP2)
+#define OMAP_NR_GPIOS			5
 #define OMAP242X_NR_GPIOS		4
-#define OMAP243X_NR_GPIOS		5
-#define OMAP34XX_NR_GPIOS		6
-#define OMAP44XX_NR_GPIOS		6
-#define OMAP_MAX_NR_GPIOS		OMAP44XX_NR_GPIOS
+#elif defined(CONFIG_ARCH_OMAP3)
+#define OMAP_NR_GPIOS			6
+#elif defined(CONFIG_ARCH_OMAP4)
+#define OMAP_NR_GPIOS			6
+#endif
 
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
@@ -194,12 +198,12 @@ extern void omap3_gpio_restore_pad_context(int restore_oe);
 #include <asm-generic/gpio.h>
 
 struct omap_gpio_platform_data {
-	unsigned long pbase;
+	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
-	char ick_name[11];
-	char fck_name[11];
-	char dbck_name[11];
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_shutdown) (struct platform_device *pdev);
+	int (*device_idle)(struct platform_device *pdev);
 };
 
 struct gpio_bank {
@@ -225,13 +229,14 @@ struct gpio_bank {
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
 	u32 mod_usage;
-	struct clk *ick;
-	struct clk *fck;
 	u8 initialized;
 	struct clk *dbck;
 	u32 dbck_enable_mask;
 	void __iomem *base;
 	u16 virtual_irq_start;
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_shutdown) (struct platform_device *pdev);
+	int (*device_idle)(struct platform_device *pdev);
 #endif
 };
 
-- 
1.6.3.3

