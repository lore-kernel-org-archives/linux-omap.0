From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] ARM: omap_device: handle first time activation of
 console device
Date: Wed, 16 Nov 2011 16:01:11 +0100
Message-ID: <4EC3D037.6020901@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com> <1321441346-19591-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42036 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092Ab1KPPBZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 10:01:25 -0500
In-Reply-To: <1321441346-19591-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

Hi Rajendra,

On 11/16/2011 12:02 PM, Rajendra Nayak wrote:
> console device on OMAP is never reset or idled by hwmod post
> initial setup, early during boot, for obvious reasons not to
> break early debug prints thrown on console.
> This leaves the console device enabled at boot and the first activation
> of it using hwmod needs to be handled in such a way that a disable is
> called followed by an enable of the hwmod, the subsequent activations
> can then use the default activation technique.
> 
> To handle this add a new binding to identify a hwmod which is used as
> the console device.
> 
> This patch is based on the what is done in serial.c for non-DT builds.
> 
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   .../devicetree/bindings/arm/omap/omap.txt          |    1 +
>   arch/arm/plat-omap/omap_device.c                   |   33 +++++++++++++++++++-
>   2 files changed, 33 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index dbdab40..46ffd41 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -21,6 +21,7 @@ Required properties:
>   Optional properties:
>   - ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
>     during suspend.
> +- ti,console_hwmod: boolean, identifies the hwmod used as console device

This is not directly hwmod related,  

>   Example:
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index e8d9869..2b2d068 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -88,6 +88,7 @@
>   #include<linux/pm_runtime.h>
>   #include<linux/of.h>
>   #include<linux/notifier.h>
> +#include<linux/console.h>
> 
>   #include<plat/omap_device.h>
>   #include<plat/omap_hwmod.h>
> @@ -114,6 +115,32 @@ static struct omap_device_pm_latency omap_default_latency[] = {
>   	}
>   };
> 
> +static int omap_console_hwmod_enable(struct omap_device *od)
> +{
> +	console_lock();
> +	/*
> +	 * For early console we prevented hwmod reset and idle

A period is missing. Or maybe it should a comma with not capital letter.

> +	 * So before we enable the uart clocks idle the console
> +	 * uart clocks, then enable back the console uart hwmod.
> +	 */
> +	omap_hwmod_idle(od->hwmods[0]);
> +	omap_hwmod_enable(od->hwmods[0]);

Why do we have to idle -> enable? The module is already enabled, isn't it?
The comment is not super clear for me :-)
Is the goal is to reset the IP?

> +	console_unlock();
> +	/*
> +	 * Restore the default activate/deactivate funcs,
> +	 * since now we have set the hwmod state machine right
> +	 * with the idle/enable for console uart
> +	 */
> +	od->pm_lats = omap_default_latency;

I do not understand that part to?
This is not the default, but instead a specific one only for the serial driver.

It looks to me that you are overwriting the default one with a specific one.

> +	return 0;
> +}
> +
> +static struct omap_device_pm_latency omap_console_latency[] = {
> +	{
> +		.activate_func	 = omap_console_hwmod_enable,
> +	},
> +};
> +
>   /* Private functions */
> 
>   /**
> @@ -342,6 +369,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>   	struct omap_hwmod **hwmods;
>   	struct omap_device *od;
>   	struct omap_hwmod *oh;
> +	struct omap_device_pm_latency *pm_lat = NULL;
>   	struct device_node *node = pdev->dev.of_node;
>   	const char *oh_name;
>   	int oh_cnt, i, ret = 0;
> @@ -370,7 +398,10 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>   		hwmods[i] = oh;
>   	}
> 
> -	od = omap_device_alloc(pdev, hwmods, oh_cnt, NULL, 0);
> +	if (of_find_property(node, "ti,console_hwmod", NULL))
> +		pm_lat = omap_console_latency;

That's looks like a hack to me to add that specific serial hooks into the core code.
But I'm not sure to have any better idea, since the issue is the lack of function pointer in DT :-)

> +	od = omap_device_alloc(pdev, hwmods, oh_cnt, pm_lat, 0);

It should not be 0 but the size of the array here: ARRAY_SIZE(omap_console_latency).

I'm wondering how it can work with zero since the code is doing that in omap_device_alloc:

od->pm_lats = kmemdup(pm_lats,
		      sizeof(struct omap_device_pm_latency) * pm_lats_cnt,
		      GFP_KERNEL);

Regards,
Benoit
