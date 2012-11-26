From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 3/5] usb: hub: add device_path regulator control to
 generic hub
Date: Mon, 26 Nov 2012 11:23:23 -0800
Message-ID: <20121126192323.GC11239@kroah.com>
References: <20121126123427.18106.4112.stgit@build.warmcat.com>
 <20121126124544.18106.60130.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:58260 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635Ab2KZTXZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 14:23:25 -0500
Content-Disposition: inline
In-Reply-To: <20121126124544.18106.60130.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: stern@rowland.harvard.edu, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

On Mon, Nov 26, 2012 at 12:45:45PM +0000, Andy Green wrote:
> This adds the config option to associate a regulator with each hub,
> when the hub on a specific, interesting device path appears, then
> the regular is powered while the logical hub exists.
> 
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>  drivers/usb/core/Kconfig |   10 ++++++++++
>  drivers/usb/core/hub.c   |   26 +++++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index f70c1a1..4a91eb1 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -95,3 +95,13 @@ config USB_OTG_BLACKLIST_HUB
>  	  and software costs by not supporting external hubs.  So
>  	  are "Embedded Hosts" that don't offer OTG support.
>  
> +config USB_HUB_DEVICE_PATH_REGULATOR
> +	bool "Support generic regulators at hubs"
> +	select DEVICEPATH
> +	depends on USB
> +	default n
> +	help
> +	  Allows you to use the device_path APIs to associate kernel regulators
> +	  with dynamically probed USB hubs, so the regulators are enabled
> +	  as the appropriate hub instance gets created and disabled as it
> +	  is destroyed.

Even if I did like the device_path code (which I do not), this needs to
be rewritten to actually make sense to a user who would have to pick
this option, not a kernel developer.

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a815fd2..49ebb5e 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  #include <linux/freezer.h>
>  #include <linux/random.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/byteorder.h>
> @@ -54,7 +55,9 @@ struct usb_hub {
>  	struct usb_device	*hdev;
>  	struct kref		kref;
>  	struct urb		*urb;		/* for interrupt polling pipe */
> -
> +#ifdef CONFIG_USB_HUB_DEVICE_PATH_REGULATOR

No #ifdefs in .c files, if at all possible please.

thanks,

greg k-h
