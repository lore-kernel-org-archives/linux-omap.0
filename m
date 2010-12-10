From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/8 V3] usb: otg: Kconfig: Add Kconfig option for TWL6030
 transceiver.
Date: Fri, 10 Dec 2010 16:26:10 +0300
Message-ID: <4D022A72.9090603@ru.mvista.com>
References: <1291984728-25874-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:41886 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab0LJN1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 08:27:11 -0500
In-Reply-To: <1291984728-25874-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, David Brownell <dbrownell@users.sourceforge.net>

Hello.

On 10-12-2010 15:38, Hema HK wrote:

> Added the TWL6030-usb transceiver option in the Kconfig

> Signed-off-by: Hema HK<hemahk@ti.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: David Brownell<dbrownell@users.sourceforge.net>
[...]

> Index: usb/drivers/usb/otg/Kconfig
> ===================================================================
> --- usb.orig/drivers/usb/otg/Kconfig
> +++ usb/drivers/usb/otg/Kconfig
> @@ -59,6 +59,18 @@ config TWL4030_USB
>   	  This transceiver supports high and full speed devices plus,
>   	  in host mode, low speed.
>
> +config TWL6030_USB
> +	tristate "TWL6030 USB Transceiver Driver"
> +	depends on TWL4030_CORE
> +	select USB_OTG_UTILS
> +	help
> +	  Enable this to support the USB OTG transceiver on TWL6030
> +	  family chips. This TWL6030 transceiver has the VBUS and ID GND
> +	  and OTG SRP events capabilities. For all other transceiver functionality
> +	  UTMI PHY is embedded in OMAP4430. The internal PHY configurations APIs
> +	  are hooked to this driver through platform_data structure.
> +	  The definition of internal PHY APIs are in the mach-omap2 layer.
> +

    Why not do it in the patch 2, together with the driver itself? And where 
are you adding the driver to drivers/usb/otg/Makefile?

WBR, Sergei
