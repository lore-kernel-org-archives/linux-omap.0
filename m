From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/8] ARM: OMAP1: Move 16xx GPIO system clock to
 platform init code
Date: Thu, 23 Feb 2012 15:42:19 -0800
Message-ID: <20120223234219.GG18185@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234042.18709.57610.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:26907 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab2BWXmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 18:42:22 -0500
Content-Disposition: inline
In-Reply-To: <20120221234042.18709.57610.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120221 15:09]:
> This way we can remove omap_read/write call from the GPIO driver
> and remove include to linux/io.h.
...

> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -18,7 +18,6 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> -#include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
>  

I'll drop this hunk, it causes a conflict with Kevin's
GPIO runtime PM series and it's not really related to
this patch or actually needed. Updated patch below.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 14:52:38 -0800
Subject: [PATCH] ARM: OMAP1: Move 16xx GPIO system clock to platform init code

This way we can remove omap_read/write call from the GPIO driver
and remove include to linux/io.h.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -218,6 +218,13 @@ static int __init omap16xx_gpio_init(void)
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
 
+	/*
+	 * Enable system clock for GPIO module.
+	 * The CAM_CLK_CTRL *is* really the right place.
+	 */
+	omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
+					ULPD_CAM_CLK_CTRL);
+
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
 		platform_device_register(omap16xx_gpio_dev[i]);
 
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0b05629..5b7b164 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1064,13 +1064,6 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 						+ OMAP1610_GPIO_IRQSTATUS1);
 			__raw_writew(0x0014, bank->base
 						+ OMAP1610_GPIO_SYSCONFIG);
-
-			/*
-			 * Enable system clock for GPIO module.
-			 * The CAM_CLK_CTRL *is* really the right place.
-			 */
-			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
-						ULPD_CAM_CLK_CTRL);
 		}
 		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
 			__raw_writel(0xffffffff, bank->base
