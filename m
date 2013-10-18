From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP1: Fix a bunch of GPIO related section warnings
 after initdata got corrected
Date: Fri, 18 Oct 2013 09:03:58 -0700
Message-ID: <20131018160358.GL15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45697 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750890Ab3JRQEC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 12:04:02 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>

From: Tony Lindgren <tony@atomide.com>
Date: Fri, 18 Oct 2013 08:54:16 -0700
Subject: [PATCH] ARM: OMAP1: Fix a bunch of GPIO related section warnings after initdata got corrected

Commit f8e7ba66 (ARM: OMAP1: fix incorrect placement of
__initdata tag) fixed things but we started seeing section
warnings. Looks like I missed those in my automatic
build scripts:

Section mismatch in reference from the variable omap7xx_gpio6 to the (unknown reference) .init.data:(unknown)
Section mismatch in reference from the variable omap7xx_gpio6 to the (unknown reference) .init.data:(unknown)
Section mismatch in reference from the variable omap7xx_gpio5 to the (unknown reference) .init.data:(unknown)
...

Fix the issue by removing __initdata for the resources.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Arnd, Kevin, Olof, want to apply this directly on top of the fixes
I sent earlier?

---

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 420e94b..312a092 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -25,7 +25,7 @@
 #define OMAP1510_GPIO_BASE		0xFFFCE000
 
 /* gpio1 */
-static struct resource omap15xx_mpu_gpio_resources[] __initdata = {
+static struct resource omap15xx_mpu_gpio_resources[] = {
 	{
 		.start	= OMAP1_MPUIO_VBASE,
 		.end	= OMAP1_MPUIO_VBASE + SZ_2K - 1,
@@ -48,7 +48,7 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
 	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
 };
 
-static struct omap_gpio_platform_data omap15xx_mpu_gpio_config __initdata = {
+static struct omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 1,
@@ -66,7 +66,7 @@ static struct platform_device omap15xx_mpu_gpio = {
 };
 
 /* gpio2 */
-static struct resource omap15xx_gpio_resources[] __initdata = {
+static struct resource omap15xx_gpio_resources[] = {
 	{
 		.start	= OMAP1510_GPIO_BASE,
 		.end	= OMAP1510_GPIO_BASE + SZ_2K - 1,
@@ -90,7 +90,7 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 	.pinctrl	= OMAP1510_GPIO_PIN_CONTROL,
 };
 
-static struct omap_gpio_platform_data omap15xx_gpio_config __initdata = {
+static struct omap_gpio_platform_data omap15xx_gpio_config = {
 	.bank_width		= 16,
 	.regs                   = &omap15xx_gpio_regs,
 };
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 16e7fcf..6e6ec93 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -31,7 +31,7 @@
 #define SYSCONFIG_WORD			0x14
 
 /* mpu gpio */
-static struct resource omap16xx_mpu_gpio_resources[] __initdata = {
+static struct resource omap16xx_mpu_gpio_resources[] = {
 	{
 		.start	= OMAP1_MPUIO_VBASE,
 		.end	= OMAP1_MPUIO_VBASE + SZ_2K - 1,
@@ -54,7 +54,7 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
 	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
 };
 
-static struct omap_gpio_platform_data omap16xx_mpu_gpio_config __initdata = {
+static struct omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 1,
@@ -72,7 +72,7 @@ static struct platform_device omap16xx_mpu_gpio = {
 };
 
 /* gpio1 */
-static struct resource omap16xx_gpio1_resources[] __initdata = {
+static struct resource omap16xx_gpio1_resources[] = {
 	{
 		.start	= OMAP1610_GPIO1_BASE,
 		.end	= OMAP1610_GPIO1_BASE + SZ_2K - 1,
@@ -100,7 +100,7 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
 };
 
-static struct omap_gpio_platform_data omap16xx_gpio1_config __initdata = {
+static struct omap_gpio_platform_data omap16xx_gpio1_config = {
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -116,7 +116,7 @@ static struct platform_device omap16xx_gpio1 = {
 };
 
 /* gpio2 */
-static struct resource omap16xx_gpio2_resources[] __initdata = {
+static struct resource omap16xx_gpio2_resources[] = {
 	{
 		.start	= OMAP1610_GPIO2_BASE,
 		.end	= OMAP1610_GPIO2_BASE + SZ_2K - 1,
@@ -128,7 +128,7 @@ static struct resource omap16xx_gpio2_resources[] __initdata = {
 	},
 };
 
-static struct omap_gpio_platform_data omap16xx_gpio2_config __initdata = {
+static struct omap_gpio_platform_data omap16xx_gpio2_config = {
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -144,7 +144,7 @@ static struct platform_device omap16xx_gpio2 = {
 };
 
 /* gpio3 */
-static struct resource omap16xx_gpio3_resources[] __initdata = {
+static struct resource omap16xx_gpio3_resources[] = {
 	{
 		.start	= OMAP1610_GPIO3_BASE,
 		.end	= OMAP1610_GPIO3_BASE + SZ_2K - 1,
@@ -156,7 +156,7 @@ static struct resource omap16xx_gpio3_resources[] __initdata = {
 	},
 };
 
-static struct omap_gpio_platform_data omap16xx_gpio3_config __initdata = {
+static struct omap_gpio_platform_data omap16xx_gpio3_config = {
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -172,7 +172,7 @@ static struct platform_device omap16xx_gpio3 = {
 };
 
 /* gpio4 */
-static struct resource omap16xx_gpio4_resources[] __initdata = {
+static struct resource omap16xx_gpio4_resources[] = {
 	{
 		.start	= OMAP1610_GPIO4_BASE,
 		.end	= OMAP1610_GPIO4_BASE + SZ_2K - 1,
@@ -184,7 +184,7 @@ static struct resource omap16xx_gpio4_resources[] __initdata = {
 	},
 };
 
-static struct omap_gpio_platform_data omap16xx_gpio4_config __initdata = {
+static struct omap_gpio_platform_data omap16xx_gpio4_config = {
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 8136fdc..4612d25 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -30,7 +30,7 @@
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 
 /* mpu gpio */
-static struct resource omap7xx_mpu_gpio_resources[] __initdata = {
+static struct resource omap7xx_mpu_gpio_resources[] = {
 	{
 		.start	= OMAP1_MPUIO_VBASE,
 		.end	= OMAP1_MPUIO_VBASE + SZ_2K - 1,
@@ -53,7 +53,7 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
 	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE >> 1,
 };
 
-static struct omap_gpio_platform_data omap7xx_mpu_gpio_config __initdata = {
+static struct omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 2,
@@ -71,7 +71,7 @@ static struct platform_device omap7xx_mpu_gpio = {
 };
 
 /* gpio1 */
-static struct resource omap7xx_gpio1_resources[] __initdata = {
+static struct resource omap7xx_gpio1_resources[] = {
 	{
 		.start	= OMAP7XX_GPIO1_BASE,
 		.end	= OMAP7XX_GPIO1_BASE + SZ_2K - 1,
@@ -94,7 +94,7 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
 	.irqctrl	= OMAP7XX_GPIO_INT_CONTROL,
 };
 
-static struct omap_gpio_platform_data omap7xx_gpio1_config __initdata = {
+static struct omap_gpio_platform_data omap7xx_gpio1_config = {
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -110,7 +110,7 @@ static struct platform_device omap7xx_gpio1 = {
 };
 
 /* gpio2 */
-static struct resource omap7xx_gpio2_resources[] __initdata = {
+static struct resource omap7xx_gpio2_resources[] = {
 	{
 		.start	= OMAP7XX_GPIO2_BASE,
 		.end	= OMAP7XX_GPIO2_BASE + SZ_2K - 1,
@@ -122,7 +122,7 @@ static struct resource omap7xx_gpio2_resources[] __initdata = {
 	},
 };
 
-static struct omap_gpio_platform_data omap7xx_gpio2_config __initdata = {
+static struct omap_gpio_platform_data omap7xx_gpio2_config = {
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -138,7 +138,7 @@ static struct platform_device omap7xx_gpio2 = {
 };
 
 /* gpio3 */
-static struct resource omap7xx_gpio3_resources[] __initdata = {
+static struct resource omap7xx_gpio3_resources[] = {
 	{
 		.start	= OMAP7XX_GPIO3_BASE,
 		.end	= OMAP7XX_GPIO3_BASE + SZ_2K - 1,
@@ -150,7 +150,7 @@ static struct resource omap7xx_gpio3_resources[] __initdata = {
 	},
 };
 
-static struct omap_gpio_platform_data omap7xx_gpio3_config __initdata = {
+static struct omap_gpio_platform_data omap7xx_gpio3_config = {
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -166,7 +166,7 @@ static struct platform_device omap7xx_gpio3 = {
 };
 
 /* gpio4 */
-static struct resource omap7xx_gpio4_resources[] __initdata = {
+static struct resource omap7xx_gpio4_resources[] = {
 	{
 		.start	= OMAP7XX_GPIO4_BASE,
 		.end	= OMAP7XX_GPIO4_BASE + SZ_2K - 1,
@@ -178,7 +178,7 @@ static struct resource omap7xx_gpio4_resources[] __initdata = {
 	},
 };
 
-static struct omap_gpio_platform_data omap7xx_gpio4_config __initdata = {
+static struct omap_gpio_platform_data omap7xx_gpio4_config = {
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -194,7 +194,7 @@ static struct platform_device omap7xx_gpio4 = {
 };
 
 /* gpio5 */
-static struct resource omap7xx_gpio5_resources[] __initdata = {
+static struct resource omap7xx_gpio5_resources[] = {
 	{
 		.start	= OMAP7XX_GPIO5_BASE,
 		.end	= OMAP7XX_GPIO5_BASE + SZ_2K - 1,
@@ -206,7 +206,7 @@ static struct resource omap7xx_gpio5_resources[] __initdata = {
 	},
 };
 
-static struct omap_gpio_platform_data omap7xx_gpio5_config __initdata = {
+static struct omap_gpio_platform_data omap7xx_gpio5_config = {
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -222,7 +222,7 @@ static struct platform_device omap7xx_gpio5 = {
 };
 
 /* gpio6 */
-static struct resource omap7xx_gpio6_resources[] __initdata = {
+static struct resource omap7xx_gpio6_resources[] = {
 	{
 		.start	= OMAP7XX_GPIO6_BASE,
 		.end	= OMAP7XX_GPIO6_BASE + SZ_2K - 1,
@@ -234,7 +234,7 @@ static struct resource omap7xx_gpio6_resources[] __initdata = {
 	},
 };
 
-static struct omap_gpio_platform_data omap7xx_gpio6_config __initdata = {
+static struct omap_gpio_platform_data omap7xx_gpio6_config = {
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
