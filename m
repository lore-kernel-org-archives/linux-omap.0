From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: omap: ohci: Missing driver unregister in module
 exit
Date: Thu, 16 Sep 2010 17:09:20 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C210F6A6@dbde02.ent.ti.com>
References: <1284419401-32101-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1284419401-32101-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "Kamat, Nishant" <nskamat-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Munegowda, Keshava
> Sent: Tuesday, September 14, 2010 4:40 AM
> To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Gadiyar, Anand; Kamat, Nishant; Munegowda, Keshava
> Subject: [PATCH] usb: omap: ohci: Missing driver unregister in module exit
> 
> The un-registration of OHCI driver was not done in
> the ohci_hcd_mod_exit function. This was affecting rmmod command not
> to work for OMAP3 platforms.
> The platform driver un-registration for OMAP3 platforms is perfomed
> while removing the OHCI module from kernel.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/host/ohci-hcd.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6/drivers/usb/host/ohci-hcd.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/host/ohci-hcd.c
> +++ linux-2.6/drivers/usb/host/ohci-hcd.c
> @@ -1270,6 +1270,9 @@ static void __exit ohci_hcd_mod_exit(voi
>  #ifdef PLATFORM_DRIVER
>  	platform_driver_unregister(&PLATFORM_DRIVER);
>  #endif
> +#ifdef OMAP3_PLATFORM_DRIVER
> +	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
> +#endif
>  #ifdef PS3_SYSTEM_BUS_DRIVER
>  	ps3_ohci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
>  #endif

Hi Greg,
     Do you any comments on this patch? 

Keshava Munegowda

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
