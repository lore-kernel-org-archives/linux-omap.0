From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 7/8] : Hwmod api changes
Date: Mon, 09 Aug 2010 14:12:22 +0200
Message-ID: <4C5FF0A6.7080003@ti.com>
References: <1281115688-1429-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281115688-1429-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/6/2010 7:28 PM, Kalliguddi, Hema wrote:
> From: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>
> Omap USBOTG modules has a requirement to set the auto idle bit only after
> setting smart idle bit.

Is it a requirement or an errata? Could you provide more information 
(i.e. TRM page or errata number / description)?

> Modified the _sys_enable api to set the smart idle
> first and then the autoidle bit. Setting this will not have any impact on the
> other modules.
>
> Added 2 wrapper APIs in the omap device layer for wakeup enable/disable
> and sidle/mstandby settings.
>
> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Basak, Partha<p-basak2-l0cyMroinI0@public.gmane.org>
>
> Cc: Felipe Balbi<felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c              |   18 +++++++----
>   arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>   arch/arm/plat-omap/omap_device.c              |   42 ++++++++++++++++++++++++++
>   3 files changed, 56 insertions(+), 6 deletions(-)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c	2010-08-06 08:59:03.641863815 -0400
> +++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c	2010-08-06 09:02:00.021864999 -0400
> @@ -653,12 +653,6 @@
>   		_set_master_standbymode(oh, idlemode,&v);
>   	}
>
> -	if (sf&  SYSC_HAS_AUTOIDLE) {
> -		idlemode = (oh->flags&  HWMOD_NO_OCP_AUTOIDLE) ?
> -			0 : 1;
> -		_set_module_autoidle(oh, idlemode,&v);
> -	}
> -
>   	/* XXX OCP ENAWAKEUP bit? */
>
>   	/*
> @@ -671,6 +665,18 @@
>   		_set_clockactivity(oh, oh->class->sysc->clockact,&v);
>
>   	_write_sysconfig(v, oh);
> +
> +	/* Set the auto idle bit only after setting the smartidle bit
> +	 * as this is requirement for some modules like USBOTG
> +	 * setting this will not have any impact on the other modues.
> +	 */

Except that you are adding an extra access to a quite slow L4 slave 
interface. I'm not sure if write posted will help in that case.

> +
> +	if (sf&  SYSC_HAS_AUTOIDLE) {
> +		idlemode = (oh->flags&  HWMOD_NO_OCP_AUTOIDLE) ?
> +			0 : 1;
> +		_set_module_autoidle(oh, idlemode,&v);
> +	}
> +	_write_sysconfig(v, oh);
>   }
>
>   /**
> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/omap_device.h
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/omap_device.h	2010-08-06 08:59:03.661863725 -0400
> +++ linux-omap-pm/arch/arm/plat-omap/include/plat/omap_device.h	2010-08-06 09:02:00.021864999 -0400
> @@ -116,6 +116,8 @@
>   int omap_device_disable_clocks(struct omap_device *od);
>   int omap_device_enable_clocks(struct omap_device *od);
>
> +int omap_device_enable_wakeup(struct omap_device *od);
> +int omap_device_disable_wakeup(struct omap_device *od);
>
>   /*
>    * Entries should be kept in latency order ascending
> Index: linux-omap-pm/arch/arm/plat-omap/omap_device.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/plat-omap/omap_device.c	2010-08-06 08:59:03.661863725 -0400
> +++ linux-omap-pm/arch/arm/plat-omap/omap_device.c	2010-08-06 09:02:00.021864999 -0400
> @@ -757,3 +757,45 @@
>   	/* XXX pass along return value here? */
>   	return 0;
>   }
> +
> +/**
> + * omap_device_enable_wakeup - Enable the wakeup bit
> + * @od: struct omap_device *od
> + *
> + * Enable the wakup bit for omap_hwmods associated
> + * with the omap_device.  Returns 0.
> + */
> +
> +int omap_device_enable_wakeup(struct omap_device *od)

Why do you need that? Could you elaborate?

Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
