From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] usb: musb: MUSB_OTG should depend on PM
Date: Mon, 23 Jun 2008 14:13:49 +0300
Message-ID: <20080623111348.GR7741@atomide.com>
References: <1213182432-23952-1-git-send-email-felipe.balbi@nokia.com> <1213182432-23952-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.178] ([63.208.196.178]:54295 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755094AbYFWLNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 07:13:23 -0400
Content-Disposition: inline
In-Reply-To: <1213182432-23952-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080611 14:09]:
> Current musb Kconfig causes cyclic depency on x86
> arch. The best fix is to depend on PM in order to
> build on OTG mode.
> 
> Anyone interested in reproducing the error in your
> linux-omap trees, just make ARCH=x86 menuconfig

I guess this is now obsolete with Dave's HAS_CLK patch?

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/Kconfig |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index a485a86..acbbd5f 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -88,10 +88,9 @@ config USB_MUSB_PERIPHERAL
>  	  (With a "Mini-AB" connector, you should enable USB OTG.)
>  
>  config USB_MUSB_OTG
> -	depends on USB && USB_GADGET && EXPERIMENTAL
> +	depends on USB && USB_GADGET && PM && EXPERIMENTAL
>  	bool "Both host and peripheral:  USB OTG (On The Go) Device"
>  	select USB_GADGET_MUSB_HDRC
> -	select USB_OTG
>  	select PM
>  	help
>  	   The most notable feature of USB OTG is support for a
> -- 
> 1.5.6.rc1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
