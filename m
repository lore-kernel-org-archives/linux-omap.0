From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 6/6] usb: musb: Add support for ti81xx platform
Date: Mon, 29 Aug 2011 11:01:54 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC4CBA8E@dbde02.ent.ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
 <1314357108-2279-7-git-send-email-ajay.gupta@ti.com>
 <20110826235226.GD4829@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab1H2FcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 01:32:13 -0400
In-Reply-To: <20110826235226.GD4829@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>

Hi,
> On Fri, Aug 26, 2011 at 04:41:48PM +0530, Ajay Kumar Gupta wrote:
> > @@ -57,6 +58,10 @@ config USB_MUSB_AM35X
> >  	tristate "AM35x"
> >  	depends on ARCH_OMAP
> >
> > +config USB_MUSB_TI81XX
> > +	bool "TI81XX"
> > +	depends on SOC_OMAPTI81XX
> 
> this *must* be tristate. I can't emphasize enough how important this
> is.

Ok.
> 
> > diff --git a/drivers/usb/musb/musb_core.c
> > b/drivers/usb/musb/musb_core.c index 20a2873..07f3faf 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -1014,7 +1014,9 @@ static void musb_shutdown(struct
> platform_device *pdev)
> >  	|| defined(CONFIG_USB_MUSB_OMAP2PLUS)		\
> >  	|| defined(CONFIG_USB_MUSB_OMAP2PLUS_MODULE)	\
> >  	|| defined(CONFIG_USB_MUSB_AM35X)		\
> > -	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)
> > +	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)	\
> > +	|| defined(CONFIG_USB_MUSB_TI81XX)		\
> > +	|| defined(CONFIG_USB_MUSB_TI81XX_MODULE)
> 
> we really need to find a better way to handle this :-(

How about passing the mode info from musb_config (musb->config->fifo_mode),
same way as musb->config->fifo_cfg 

Infact I think, we can kill musb->config->fifo_cfg and have only
musb->config->mode as in this way all the fifo tables will be at one
place and should help in maintenance.


> 
> > diff --git a/drivers/usb/musb/ti81xx.c b/drivers/usb/musb/ti81xx.c
> new
> > file mode 100644 index 0000000..f95774e
> > --- /dev/null
> > +++ b/drivers/usb/musb/ti81xx.c
> 
> I still think this should be part of am35x.c It really look like they
> are very similar.

Wrapper registers are different but I will see on this and provide you details
On how the merged file would look like. I am afraid that we may have to use
Either #ifdef or cpu_is_xxx().

> 
> on monday I'll read the rest of the file.
Ok.

Ajay
> 
> --
> balbi
