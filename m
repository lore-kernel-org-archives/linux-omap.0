From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v5 01/11] usb: musb: add musb->id to identify core
 instance
Date: Wed, 25 Jul 2012 12:19:32 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAE5B87@DBDE01.ent.ti.com>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-2-git-send-email-ajay.gupta@ti.com>
 <20120725121128.GO16794@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41488 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756555Ab2GYMTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 08:19:40 -0400
In-Reply-To: <20120725121128.GO16794@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

Hi,
> 
> On Wed, Jul 25, 2012 at 05:37:19PM +0530, Ajay Kumar Gupta wrote:
> > diff --git a/drivers/usb/musb/musb_core.c
> > b/drivers/usb/musb/musb_core.c index 89d1871..f5eb8a7 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> 
> <snip>
> 
> > @@ -1889,6 +1921,7 @@ musb_init_controller(struct device *dev, int nIrq,
> void __iomem *ctrl)
> >  	pm_runtime_enable(musb->controller);
> >
> >  	spin_lock_init(&musb->lock);
> > +	musb->id = pdev->id;
> 
> I fail to see where this musb->id would be used. Care to clarify ?

Sure, It is used in musb_init_debugfs(). Please refer 02/11.

Ajay
> 
> --
> balbi
