From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v4 2/4] OMAP4: Keyboard device registration
Date: Thu, 17 Jun 2010 11:37:09 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5BEFCC3@dbde02.ent.ti.com>
References: <x0066660@ti.com>
 <1276704555-30625-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59811 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab0FQGHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 02:07:14 -0400
In-Reply-To: <1276704555-30625-1-git-send-email-x0066660@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Arce, Abraham" <x0066660@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org]
> On Behalf Of Abraham Arce
> Sent: Wednesday, June 16, 2010 9:39 PM
> To: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> Cc: Arce, Abraham
> Subject: [PATCH v4 2/4] OMAP4: Keyboard device registration
> 
> Register keyboard device with hwmod framework
> 
> Signed-off-by: Abraham Arce <x0066660@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   50 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 03e6c9e..d229901 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
> +#include <linux/slab.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> @@ -29,6 +30,9 @@
>  #include <mach/gpio.h>
>  #include <plat/mmc.h>
>  #include <plat/dma.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +#include <plat/omap4-keypad.h>
> 
>  #include "mux.h"
> 
> @@ -139,6 +143,52 @@ static inline void omap_init_camera(void)
>  }
>  #endif
> 
> +#ifdef CONFIG_ARCH_OMAP4
> +
> +struct omap_device_pm_latency omap_keyboard_latency[] = {
> +	{
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func   = omap_device_enable_hwmods,
> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	},
> +};
> +
> +int omap4_init_kp(struct omap4_keypad_platform_data *kp)
> +{
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +	struct omap4_keypad_platform_data *pdata;
> +
> +	unsigned int id = 0;
> +	char *name = "omap4-keypad";
> +	char *oh_name = "kbd";
> +
> +	if (!cpu_is_omap44xx())
> +		return -ENODEV;
> +
> +	oh = omap_hwmod_lookup(oh_name);

Use omap_hwmod_for_each_by_class() instead of lookup by name.


> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
> +		return -EIO;
> +	}
> +
> +	pdata = kp;
> +
> +	pdata->base = oh->_rt_va;
> +	pdata->irq = oh->mpu_irqs[0].irq;

Use platform_get_() APIs to get base addr & irq instead of passing
it as pdata


> +
> +	od = omap_device_build(name, id, oh, pdata,
> +			sizeof(struct matrix_keypad_platform_data),
> +			omap_keyboard_latency,
> +			ARRAY_SIZE(omap_keyboard_latency), 1);
> +	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
> +		name, oh_name);
> +
> +	return 0;
> +}
> +
> +#endif
> +
>  #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
> 
>  #define MBOX_REG_SIZE   0x120
> --
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
