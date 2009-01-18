From: Tony Lindgren <tony@atomide.com>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH
	00/10] Omap fixes for 2.6.29-rc1)
Date: Sun, 18 Jan 2009 13:40:19 +0200
Message-ID: <20090118114013.GD7976@atomide.com>
References: <20090112143405.24205.52151.stgit@localhost> <20090115134908.GC20409@n2100.arm.linux.org.uk> <20090117142651.GA9947@n2100.arm.linux.org.uk> <200901171247.18153.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59750 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763516AbZARLkc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2009 06:40:32 -0500
Content-Disposition: inline
In-Reply-To: <200901171247.18153.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090117 22:47]:
> On Saturday 17 January 2009, Russell King - ARM Linux wrote:
> > Now that akpm pushed the usb_port_suspend() fix upstream, we move on
> > to the next breakage found by kautobuild, which for n770_defconfig is:
> > 
> > drivers/built-in.o: In function `ohci_omap_init':
> > hid-quirks.c:(.text+0x6c608): undefined reference to `otg_get_transceiver'
> > drivers/built-in.o: In function `omap_udc_probe':
> > hid-quirks.c:(.init.text+0x34c0): undefined reference to `otg_get_transceiver'
> > hid-quirks.c:(.init.text+0x3d40): undefined reference to `otg_put_transceiver'
> 
> Does this fix that problem?

Yes, that fixes it, Acked-by: Tony Lindgren <tony@atomide.com>.
I assume it will get merged via the USB tree, so not adding it to
omap-fixes.

FYI, I'll be flying back home soon so I probably won't be online 
until Tuesday at some point in case there are other fixes needed.

Tony


> ---
>  drivers/usb/host/Kconfig |    1 +
>  drivers/usb/otg/Kconfig  |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -140,6 +140,7 @@ config USB_OHCI_HCD
>  	tristate "OHCI HCD support"
>  	depends on USB && USB_ARCH_HAS_OHCI
>  	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
> +	select USB_OTG_UTILS if ARCH_OMAP
>  	---help---
>  	  The Open Host Controller Interface (OHCI) is a standard for accessing
>  	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -6,14 +6,14 @@
>  
>  comment "OTG and related infrastructure"
>  
> -if USB || USB_GADGET
> -
>  config USB_OTG_UTILS
>  	bool
>  	help
>  	  Select this to make sure the build includes objects from
>  	  the OTG infrastructure directory.
>  
> +if USB || USB_GADGET
> +
>  #
>  # USB Transceiver Drivers
>  #
> 
