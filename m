From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH] Allow change timing values to wait slow devices
 bring up before try register an interface to IP-Config (used on some
 drivers using Multi-purpose USB Networking Framework)
Date: Tue, 9 Feb 2010 14:20:35 -0800
Message-ID: <20100209222035.GI21755@atomide.com>
References: <600adaf51002061530o700378aaq75ff83b04d977958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49457 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab0BIWT6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 17:19:58 -0500
Content-Disposition: inline
In-Reply-To: <600adaf51002061530o700378aaq75ff83b04d977958@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tiago Maluta <tiago.maluta@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Tiago Maluta <tiago.maluta@gmail.com> [100206 15:28]:
> I'd like to know if this patch could be considered an general use or
> an particular case.

This is Linux generic, so it should get sent to linux-usb and net
lists instead.

Regards,

Tony

> 
> --tm
> 
> Signed-off-by: Tiago Maluta <maluta@unifei.edu.br>
> ---
>  drivers/net/usb/Kconfig |   17 +++++++++++++++++
>  net/ipv4/ipconfig.c     |    4 ++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
> index 32d9356..5b84e57 100644
> --- a/drivers/net/usb/Kconfig
> +++ b/drivers/net/usb/Kconfig
> @@ -127,6 +127,23 @@ config USB_USBNET
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called usbnet.
> 
> +
> +config USB_USBNETDEVICE_DELAY_PRE
> +	int "Define the friendly delay before opening net devices "
> +	depends on USB_USBNET
> +	default 500
> +	help
> +	    Some devices may not work due to a delay from hardware bring the interface
> +	    up. This value added a delay before search and register the interface.
> +
> +config USB_USBNETDEVICE_DELAY_POST
> +	int "Define the friendly delay after opening net devices "
> +	depends on USB_USBNET
> +	default 1
> +	help
> +	    Some devices may not work due to a delay from hardware bring the interface
> +	    up. This value added a delay before search and register the interface.
> +
>  config USB_NET_AX8817X
>  	tristate "ASIX AX88xxx Based USB 2.0 Ethernet Adapters"
>  	depends on USB_USBNET
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index 10a6a60..3faac07 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -86,8 +86,8 @@
>  #endif
> 
>  /* Define the friendly delay before and after opening net devices */
> -#define CONF_PRE_OPEN		500	/* Before opening: 1/2 second */
> -#define CONF_POST_OPEN		1	/* After opening: 1 second */
> +#define CONF_PRE_OPEN		CONFIG_USB_USBNETDEVICE_DELAY_PRE	/* Before
> opening. Default 1/2 second */
> +#define CONF_POST_OPEN		CONFIG_USB_USBNETDEVICE_DELAY_POST	/* After
> opening. Default 1 second */
> 
>  /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
>  #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
> -- 
> 1.6.4.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
