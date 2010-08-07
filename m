From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 8/8 ]usb : musb:Using runtime pm apis for musb.
Date: Sat, 07 Aug 2010 19:52:48 +0400
Message-ID: <4C5D8150.4020009@ru.mvista.com>
References: <1281115749-1601-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281115749-1601-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Hema HK wrote:

> Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync() 
> for enabling/disabling the clocks,sysconfig settings.

> used omap_hwmod_enable_wakeup & omap_hwmod_disable_wakeup apis to set/clear
> the wakeup enable bit.
> Also need to put the USB in force standby and force idle mode when usb not used
> and set it back to smart idle and smart stndby after wakeup.
> these cases are handled using the oh flags.
> For omap3430 auto idle bit has to be disabled because of the errata.So using 
> HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.

> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Basak, Partha <p-basak2-l0cyMroinI0@public.gmane.org>

> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
[...]
> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c	2010-08-06 10:44:06.000000000 -0400
> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c	2010-08-06 10:44:42.942112875 -0400

> @@ -129,14 +143,64 @@
>  	struct device_driver *drv = dev->driver;
>  
>  	if (drv) {
> +#ifdef CONFIG_PM_RUNTIME
>  		struct musb_hdrc_platform_data *pdata = dev->platform_data;
>  		const struct dev_pm_ops *pm = drv->pm;
> -		if (!pdata->is_usb_active(dev)) {
>  
> -			if (save)
> +		if (!pdata->is_usb_active(dev)) {
> +			switch (state) {
> +			case save_context:
> +				/* If the usb device not active then Save

    Why "usb" not in capitals, while "Save" starts from capital? :-)

> +				 * the context,set the sysconfig setting to

    Missing space before "set".

> +				 * force standby force idle during idle and
> +				 * disable the clock.
> +				 */
> +				oh->flags |= HWMOD_SWSUP_SIDLE
> +						| HWMOD_SWSUP_MSTANDBY;
>  				pm->suspend(dev);
> -			else
> +				pdata->device_idle(pdev);
> +
> +				break;
> +			case disable_clk:
> +				/* If the usb device not active then
> +				 * Save the context, set the sysconfig setting

    Same comment about "usb" and "Save"...

> +				 * to force standby force idle during idle and
> +				 * disable the clock.
> +				 */
> +
> +				oh->flags |= HWMOD_SWSUP_SIDLE
> +					| HWMOD_SWSUP_MSTANDBY;
> +				pdata->device_idle(pdev);
> +
> +				break;
> +
> +			case restore_context:
> +				/* Enable the clock, set the sysconfig
> +				 * back to smart idle and smart stndby after
> +				 * wakeup. restore the context.

    Should be "Restore" at the start of sentence, no?

> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
> ===================================================================
> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c	2010-08-06 10:44:30.093914217 -0400
> +++ linux-omap-pm/drivers/usb/musb/omap2430.c	2010-08-06 10:44:42.942112875 -0400
[...]
> @@ -209,10 +210,6 @@
>  	struct musb_hdrc_platform_data *plat = dev->platform_data;
>  	struct omap_musb_board_data *data = plat->board_data;
>  
> -#if defined(CONFIG_ARCH_OMAP2430)
> -	omap_cfg_reg(AE5_2430_USB0HS_STP);
> -#endif

    There's separate patch removing this in Greg's queue:

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-musb-kill-board-specific-pinmux-from-driver-file.patch

> Index: linux-omap-pm/include/linux/usb/musb.h
> ===================================================================
> --- linux-omap-pm.orig/include/linux/usb/musb.h	2010-08-06 10:44:06.000000000 -0400
> +++ linux-omap-pm/include/linux/usb/musb.h	2010-08-06 10:44:42.946115274 -0400
> @@ -10,6 +10,9 @@
>  #ifndef __LINUX_USB_MUSB_H
>  #define __LINUX_USB_MUSB_H
>  
> +#include <linux/platform_device.h>

    You could just use incomplete declaration of 'struct platfrom_device' 
instead of this #include.

> +#include <plat/omap_hwmod.h>
> +
>  /* The USB role is defined by the connector used on the board, so long as
>   * standards are being followed.  (Developer boards sometimes won't.)
>   */
> @@ -129,6 +132,21 @@
>  
>  	/* check usb device active state*/
>  	int		(*is_usb_active)(struct device *dev);
> +
> +	/* omap hwmod data structure	 */
> +	struct	omap_hwmod *oh;

    This should be wrapped into #ifdef, don't you think?

> +	/* enable clocks and set sysconfig register*/
> +	int		(*device_enable)(struct platform_device *pdev);
> +
> +	/* Disable clock and reset the sysconfig register settings*/
> +	int		(*device_idle)(struct platform_device *pdev);
> +
> +	/* set the enable wakeup bit of sysconfig register */
> +	int		(*enable_wakeup)(struct omap_device *od);
> +
> +	/* Clear the enable wakeup bit  of sysconfig register */
> +	int		(*disable_wakeup)(struct omap_device *od);

    This should be wrapped too, I think...

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
