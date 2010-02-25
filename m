From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
Date: Thu, 25 Feb 2010 10:48:34 -0800
Message-ID: <20100225184833.GG28173@atomide.com>
References: <1267079758-14480-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1267079758-14480-1-git-send-email-x0082077-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org> [100224 22:33]:
> This patch adds the OMAP4 Kconfig options for MUSB.
> 
> Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
> ---
> Index: mainline/drivers/usb/musb/Kconfig
> ===================================================================
> --- mainline.orig/drivers/usb/musb/Kconfig
> +++ mainline/drivers/usb/musb/Kconfig
> @@ -38,6 +38,7 @@ config USB_MUSB_SOC
>  	default y if ARCH_DAVINCI
>  	default y if ARCH_OMAP2430
>  	default y if ARCH_OMAP34XX
> +	default y if ARCH_OMAP4
>  	default y if (BF54x && !BF544)
>  	default y if (BF52x && !BF522 && !BF523)
>  
> @@ -50,6 +51,9 @@ comment "OMAP 243x high speed USB suppor
>  comment "OMAP 343x high speed USB support"
>  	depends on USB_MUSB_HDRC && ARCH_OMAP34XX
>  
> +comment "OMAP 44xx high speed USB support"
> +	depends on USB_MUSB_HDRC && ARCH_OMAP4
> +
>  comment "Blackfin high speed USB Support"
>  	depends on USB_MUSB_HDRC && ((BF54x && !BF544) || (BF52x && !BF522 && !BF523))
>  
> @@ -153,7 +157,7 @@ config MUSB_PIO_ONLY
>  config USB_INVENTRA_DMA
>  	bool
>  	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
> -	default ARCH_OMAP2430 || ARCH_OMAP34XX || BLACKFIN
> +	default ARCH_OMAP2430 || ARCH_OMAP34XX || BLACKFIN || ARCH_OMAP4
>  	help
>  	  Enable DMA transfers using Mentor's engine.

FYI, this needs to be updated as I have patches queued up
to replace ARCH_OMAP34XX and with ARCH_OMAP3. You might
want to check all these patches for that and make sure
they build and work with the omap-for-linus branch.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
