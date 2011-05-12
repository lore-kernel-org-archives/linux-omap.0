From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 3/5] arm: omap: usb: device name change for the clk
 names of usbhs
Date: Thu, 12 May 2011 16:19:13 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CE66B4A@dbde02.ent.ti.com>
References: <1305122676-27236-1-git-send-email-keshava_mgowda@ti.com>
 <1305122676-27236-2-git-send-email-keshava_mgowda@ti.com>
 <1305122676-27236-3-git-send-email-keshava_mgowda@ti.com>
 <1305122676-27236-4-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36110 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab1ELKtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 06:49:22 -0400
In-Reply-To: <1305122676-27236-4-git-send-email-keshava_mgowda@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "parthab@india.ti.com" <parthab@india.ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Munegowda, Keshava
> Sent: Wednesday, May 11, 2011 7:35 PM
> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
> Cc: Munegowda, Keshava; Balbi, Felipe; Gadiyar, Anand; 
> parthab@india.ti.com
> Subject: [PATCH 3/5] arm: omap: usb: device name change for 
> the clk names of usbhs

[snip]...[snip]

> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -27,7 +27,7 @@
>  #include <linux/gpio.h>
>  #include <plat/usb.h>
>  
> -#define USBHS_DRIVER_NAME	"usbhs-omap"
> +#define USBHS_DRIVER_NAME	"usbhs_omap"
>  #define OMAP_EHCI_DEVICE	"ehci-omap"
>  #define OMAP_OHCI_DEVICE	"ohci-omap3"

[sp] Shouldn't we be consistent in using minus/dash and
     underscore in the device names?

~sanjeev

>  
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 