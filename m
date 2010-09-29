From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/3 v4] musb: add musb support for AM35x
Date: Wed, 29 Sep 2010 21:16:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404A9D8AB99@dbde02.ent.ti.com>
References: <1285764321-13934-1-git-send-email-ajay.gupta@ti.com>
 <1285764321-13934-2-git-send-email-ajay.gupta@ti.com>
 <4CA35B3A.4090707@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45909 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab0I2PqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 11:46:24 -0400
In-Reply-To: <4CA35B3A.4090707@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

Hi,

[...]
> > +	devconf2 &= ~CONF2_OTGMODE;
> > +	switch (musb_mode) {
> > +#ifdef	CONFIG_USB_MUSB_OTG
> > +	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
> > +		devconf2 |= CONF2_NO_OVERRIDE;
> 
> This does nothing, can be removed...

Yes, but it's good to have it from code readability perspective.

I can remove it but let's get Felipe's opinion on this.

[...] 
> > +	if (musb->set_clock)
> > +		musb->set_clock(musb->clock, 0);
> > +	else
> > +		clk_disable(musb->clock);
> > +
> > +	otg_fck = clk_get(musb->controller, "fck");
> > +	if (IS_ERR(otg_fck)) {
> > +		DBG(2, "clk_get() failed for otg_fck.\n");
> > +	} else {
> > +		clk_put(otg_fck);
> > +		clk_put(otg_fck);
> > +		clk_disable(otg_fck);
> 
> I think the order should be:
> clk_disable(...);
> clk_put(...);

Again I would wait for Felipe's opinion on this ordering. BTW there
Are codes on musb_core.c where clk_put is done before clk_disable().

>> And of course, it should be put only once... ;)
No. clk_put() needs to be done twice as clk_get() is called two times;
one in musb_platform_init() and other in current function musb_platform_exit.

Other solution could be to save otg_fck in some static variable as
Sergei suggested.

Thanks,
Ajay
> 
[...]

