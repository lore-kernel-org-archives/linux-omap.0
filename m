From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/5 v12] arm: omap: usb: register hwmods of usbhs
Date: Fri, 30 Sep 2011 01:15:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109300113200.32653@utopia.booyaka.com>
References: <1317361318-28295-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317361318-28295-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

Hi

On Fri, 30 Sep 2011, Keshava Munegowda wrote:

> The hwmod structure of usb_host_hs  and usb_tll are
> retrieved and registered with omap device
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>
> ---
>  arch/arm/mach-omap2/usb-host.c |  100 ++++++++++++++--------------------------
>  1 files changed, 34 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index 89ae298..771dc78 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -28,51 +28,28 @@

> +	oh[0] = omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
> +	if (!oh[0]) {
> +		pr_err("Could not look up %s\n", USBHS_UHH_HWMODNAME);
> +		return;
>  	}
>  
> -	if (platform_device_register(&usbhs_device) < 0)
> -		printk(KERN_ERR "USBHS platform_device_register failed\n");
> +	oh[1] = omap_hwmod_lookup(USBHS_TLL_HWMODNAME);
> +	if (!oh[1]) {
> +		pr_err("Could not look up %s\n", USBHS_TLL_HWMODNAME);
> +		return;
> +	}
>  
> -init_end:
> -	return;
> +	od = omap_device_build_ss(OMAP_USBHS_DEVICE, bus_id, oh, 2,
> +				(void *)&usbhs_data, sizeof(usbhs_data),
> +				omap_uhhtll_latency,
> +				ARRAY_SIZE(omap_uhhtll_latency), false);

Usually there's something wrong with omap_devices that contain 
multiple hwmods.  Is there some reason why there isn't a separate driver 
for the TLL?  Judging by a brief look at drivers/mfd/omap_usb_host.c, the 
TLL handling looks logically distinct?


- Paul
