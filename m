From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] usb: ehci-omap: Update platform header file path
Date: Wed, 25 Nov 2009 14:35:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2D5A@dbde02.ent.ti.com>
References: <20091125090259.GB30331@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49574 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934540AbZKYJGI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 04:06:08 -0500
In-Reply-To: <20091125090259.GB30331@lixom.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, "tony@atomide.com" <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Olaf Johansson wrote:
> 
> The OMAP usb header file has moved, update the driver so it 
> will build.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> Greg, any chance you can just ack this so Tony can merge it through his
> tree for .33? The header files changes in question are going in through
> that tree.
> 

I believe it has already been taken care of in Tony's for-next?

- Anand

> 
> Thanks,
> 
> -Olof
> 
> diff --git a/drivers/usb/host/ehci-omap.c 
> b/drivers/usb/host/ehci-omap.c
> index 7ba8df3..5cfed78 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -37,7 +37,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
> -#include <mach/usb.h>
> +#include <plat/usb.h>
>  
>  /*
>   * OMAP USBHOST Register addresses: VIRTUAL ADDRESSES
