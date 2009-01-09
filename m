From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v2] usb: musb: fix bug in musbhsdma programming
Date: Fri, 9 Jan 2009 10:46:02 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECEDDADE@dbde02.ent.ti.com>
References: <1231475946-6810-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37491 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbZAIFQP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 00:16:15 -0500
In-Reply-To: <1231475946-6810-1-git-send-email-ajay.gupta@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "david-b@pacbell.net" <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index 75b15ce..8e44355 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -136,7 +136,7 @@ static void configure_channel(struct dma_channel *channel,
>  		csr |= MUSB_HSDMA_BURSTMODE_INCR4;
> 
>  	csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
> -		| MUSB_HSDMA_MODE1
> +		| mode ? MUSB_HSDMA_MODE1 : 0

Just found that above change should be within braces.
-		| MUSB_HSDMA_MODE1
+		| (mode ? MUSB_HSDMA_MODE1 : 0)

-Ajay

>  		| MUSB_HSDMA_ENABLE
>  		| MUSB_HSDMA_IRQENABLE
>  		| (musb_channel->transmit
> --
> 1.5.6

