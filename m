From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/2] usb: ehci: Allow EHCI to be built on OMAP3
Date: Wed, 25 Nov 2009 14:36:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2D5B@dbde02.ent.ti.com>
References: <1257536793-15291-1-git-send-email-gadiyar@ti.com>
 <20091125085648.GA30331@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091125085648.GA30331-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Olof Johansson wrote:
> 
> OMAP34XX has EHCI, so select USB_ARCH_HAS_EHCI.
> 
> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>

Acked-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

> 
> ---
> 
> On Sat, Nov 07, 2009 at 01:16:32AM +0530, Anand Gadiyar wrote:
> > usb: ehci: Allow EHCI to be built on OMAP3
> > 
> > OMAP3 chips have a built-in EHCI controller.
> > The recently introduced omap ehci-hcd driver missed
> > out on selecting USB_ARCH_HAS_EHCI in Kconfig.
> > 
> > Without this, the driver cannot be built.
> 
> This is a losing battle. It scales much better to select the option
> from OMAP34XX, instead of starting to enumerate the various platforms
> in drivers/usb.
> 

Yes, I agree. Okay with me to drop my patch and use this one instead.

- Anand

> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 034d990..a913b05 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -18,6 +18,7 @@ config ARCH_OMAP2430
>  config ARCH_OMAP34XX
>  	bool "OMAP34xx Based System"
>  	depends on ARCH_OMAP3
> +	select USB_ARCH_HAS_EHCI
>  
>  config ARCH_OMAP3430
>  	bool "OMAP3430 support"
> --
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
