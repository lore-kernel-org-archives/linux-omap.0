From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v2] MUSB: fix wrongly created sysfs entry
Date: Mon, 15 Dec 2008 21:59:42 +0200
Message-ID: <20081215195941.GA28753@frodo>
References: <20081215162505.4b11c9be@lxorguk.ukuu.org.uk> <1229359592.12163.80.camel@localhost.localdomain> <20081215171611.0b3877d5@lxorguk.ukuu.org.uk> <1229362427.12163.94.camel@localhost.localdomain> <1229363671.12163.109.camel@localhost.localdomain> <20081215180740.02ef1667@lxorguk.ukuu.org.uk> <FCCFB4CDC6E5564B9182F639FC356087025127B95B@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087025127B95C@dbde02.ent.ti.com> <20081215195136.GM23324@frodo> <FCCFB4CDC6E5564B9182F639FC356087025127B962@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36401 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbYLOT7u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 14:59:50 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087025127B962@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Tue, Dec 16, 2008 at 01:25:58AM +0530, Pandita, Vikram wrote:
> Agreed. In that case, we still need the following patch:
> Otherwise the srp entry does not get deleted on rmmod.

makes sense, can you just update one thing:

> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 5280dba..824ea57 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1829,7 +1829,7 @@ static void musb_free(struct musb *musb)
>  #ifdef CONFIG_SYSFS
>  	device_remove_file(musb->controller, &dev_attr_mode);
>  	device_remove_file(musb->controller, &dev_attr_vbus);
> -#ifdef CONFIG_USB_MUSB_OTG
> +#ifdef CONFIG_USB_GADGET_MUSB_HDRC
>  	device_remove_file(musb->controller, &dev_attr_srp);
>  #endif
>  #endif
> @@ -2060,7 +2060,7 @@ bad_config:
>  	status = device_create_file(dev, &dev_attr_vbus);
>  #ifdef CONFIG_USB_GADGET_MUSB_HDRC
>  	status = device_create_file(dev, &dev_attr_srp);
> -#endif /* CONFIG_USB_GADGET_MUSB_HDRC */
> +#endif

leave the comment there :-)

-- 
balbi
