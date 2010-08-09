From: "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 7/8] : Hwmod api changes
Date: Mon, 9 Aug 2010 11:22:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401D2AC@dbde02.ent.ti.com>
References: <1281115688-1429-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281115688-1429-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 

> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> [mailto:linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of 
> Kalliguddi, Hema
> Sent: Friday, August 06, 2010 10:58 PM
> To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Kalliguddi, Hema; Basak, Partha; Felipe Balbi; Tony 
> Lindgren; Kevin Hilman
> Subject: [PATCH 7/8] : Hwmod api changes
> 
> From: Hema HK  <hemahk-l0cyMroinI0@public.gmane.org>
> 
> Omap USBOTG modules has a requirement to set the auto idle 
> bit only after
> setting smart idle bit. Modified the _sys_enable api to set 
> the smart idle 
> first and then the autoidle bit. Setting this will not have 
> any impact on the 
> other modules.
> 
> Added 2 wrapper APIs in the omap device layer for wakeup 
> enable/disable 
> and sidle/mstandby settings. 
> 
> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Basak, Partha <p-basak2-l0cyMroinI0@public.gmane.org>
> 
> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> 
> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   18 +++++++----
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/omap_device.c              |   42 
> ++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 6 deletions(-)
> 
> Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c	
> 2010-08-06 08:59:03.641863815 -0400
> +++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c	
> 2010-08-06 09:02:00.021864999 -0400
> @@ -653,12 +653,6 @@
>  		_set_master_standbymode(oh, idlemode, &v);
>  	}
>  
> -	if (sf & SYSC_HAS_AUTOIDLE) {
> -		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
> -			0 : 1;
> -		_set_module_autoidle(oh, idlemode, &v);
> -	}
> -
>  	/* XXX OCP ENAWAKEUP bit? */
>  
>  	/*
> @@ -671,6 +665,18 @@
>  		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
>  
>  	_write_sysconfig(v, oh);
> +
> +	/* Set the auto idle bit only after setting the smartidle bit
> +	 * as this is requirement for some modules like USBOTG
> +	 * setting this will not have any impact on the other modues.
> +	 */
> +
> +	if (sf & SYSC_HAS_AUTOIDLE) {
> +		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
> +			0 : 1;
> +		_set_module_autoidle(oh, idlemode, &v);
> +	}
> +	_write_sysconfig(v, oh);
>  }
>  
>  /**
> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/omap_device.h
> ===================================================================
> --- 
> linux-omap-pm.orig/arch/arm/plat-omap/include/plat/omap_d
> evice.h	2010-08-06 08:59:03.661863725 -0400
> +++ 
> linux-omap-pm/arch/arm/plat-omap/include/plat/omap_device.h	
> 2010-08-06 09:02:00.021864999 -0400
> @@ -116,6 +116,8 @@
>  int omap_device_disable_clocks(struct omap_device *od);
>  int omap_device_enable_clocks(struct omap_device *od);
>  
> +int omap_device_enable_wakeup(struct omap_device *od);
> +int omap_device_disable_wakeup(struct omap_device *od);

Kevin,Paul,

Does it make sense for the framework itself to enable wakeup
for all devices when the slave port is programmed to be in
Smartidle, instead of exposing 2 more omap device level api;s
to the drivers?
I have a patch for this and can post it for review in case you
feel it makes sense.

regards,
Rajendra

>  
>  /*
>   * Entries should be kept in latency order ascending
> Index: linux-omap-pm/arch/arm/plat-omap/omap_device.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/plat-omap/omap_device.c	
> 2010-08-06 08:59:03.661863725 -0400
> +++ linux-omap-pm/arch/arm/plat-omap/omap_device.c	
> 2010-08-06 09:02:00.021864999 -0400
> @@ -757,3 +757,45 @@
>  	/* XXX pass along return value here? */
>  	return 0;
>  }
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
> +{
> +	struct omap_hwmod *oh;
> +	int i;
> +
> +	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
> +		omap_hwmod_enable_wakeup(oh);
> +
> +	/* XXX pass along return value here? */
> +	return 0;
> +}
> +
> +/**
> + * omap_device_disable_wakeup -Disable the wakeup bit
> + * @od: struct omap_device *od
> + *
> + * Disable the wakup bit for omap_hwmods associated
> + * with the omap_device.  Returns 0.
> + */
> +
> +
> +int omap_device_disable_wakeup(struct omap_device *od)
> +{
> +	struct omap_hwmod *oh;
> +	int i;
> +
> +	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
> +		omap_hwmod_disable_wakeup(oh);
> +
> +	/* XXX pass along return value here? */
> +	return 0;
> +}
> +
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
