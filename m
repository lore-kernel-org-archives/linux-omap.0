From: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4: very confusing config around OHCI_OMAP3_HCD
Date: Thu, 3 May 2018 15:07:17 -0700
Message-ID: <20180503220717.GZ98604@atomide.com>
References: <20180503192510.GB32572@amd>
 <20180503192838.GY98604@atomide.com>
 <20180503193837.GC32572@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503193837.GC32572@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180503 19:40]:
> On Thu 2018-05-03 12:28:38, Tony Lindgren wrote:
> Ok, what about this? (Should I do the same for the other drivers?)
> Or at least put (DEPRECATED) as other drivers do?
> 
> Situation is quite confusing if you already have PLATFORM=y. OMAP=m
> can be selected, but nothing happens.

Sure works for me, let's see what linux-usb people think.

Regards,

Tony


> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 5d958da..67c151a 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -455,7 +455,7 @@ config USB_OHCI_HCD_AT91
>            Atmel chips.
>  
>  config USB_OHCI_HCD_OMAP3
> -	tristate "OHCI support for OMAP3 and later chips"
> +	tristate "dummy option for backwards compatibility"
>  	depends on (ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5)
>  	select USB_OHCI_HCD_PLATFORM
>  	default y
> @@ -463,9 +463,6 @@ config USB_OHCI_HCD_OMAP3
>  	  This option is deprecated now and the driver was removed, use
>  	  USB_OHCI_HCD_PLATFORM instead.
>  
> -	  Enables support for the on-chip OHCI controller on
> -	  OMAP3 and later chips.
> -
>  config USB_OHCI_HCD_DAVINCI
>  	tristate "OHCI support for TI DaVinci DA8xx"
>  	depends on ARCH_DAVINCI_DA8XX
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
