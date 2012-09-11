From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/17] Input: omap-keypad: Remove dependencies to mach
 includes
Date: Mon, 10 Sep 2012 23:16:53 -0700
Message-ID: <20120911061652.GA23092@atomide.com>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
 <20120911053059.29637.22108.stgit@muffinssi.local>
 <20120911055709.GB17865@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43729 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752749Ab2IKGQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 02:16:58 -0400
Content-Disposition: inline
In-Reply-To: <20120911055709.GB17865@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>

* Felipe Balbi <balbi@ti.com> [120910 23:02]:
> 
> >  
> > +#ifdef CONFIG_ARCH_OMAP1
> > +#define omap_kp_24xx()		0
> > +#else
> > +#define omap_kp_24xx()		1
> > +#endif
> 
> I would rather use revision detection or different driver names (if
> revision register is broken).

Hmm actually looks like we can actually remove all the omap2+
support as we no longer have any users for this one. I think I
already converted the last one to matrix-keypad a while back.
 
> > +static struct omap_kp *omap_kp;
> 
> please don't. This will prevent multiple instances of this driver. Even
> though I don't think we will ever have an omap with multiple keypad
> instances, it's still not a good practice IMHO.
> 
> Also, this ends up being "hidden" (if you have a better work let me
> know) in most functions since they either pass omap_kp as argument or
> define a local omap_kp variable.

Yeah good point, I'll update that and remove the omap2+ support
for this driver.
 
> Sourav, is the revision register on this IP working fine across multiple
> OMAPs ?

Sounds like no need for that, as we're no longer using this for
omap2+..
 
> > @@ -253,9 +256,9 @@ static ssize_t omap_kp_enable_store(struct device *dev, struct device_attribute
> >  	mutex_lock(&kp_enable_mutex);
> >  	if (state != kp_enable) {
> >  		if (state)
> > -			enable_irq(INT_KEYBOARD);
> > +			enable_irq(omap_kp->irq);
> >  		else
> > -			disable_irq(INT_KEYBOARD);
> > +			disable_irq(omap_kp->irq);
> 
> GREAT!! :-)

Heh yeah that nice way to do it :)
 
> >  static int __devinit omap_kp_probe(struct platform_device *pdev)
> >  {
> > -	struct omap_kp *omap_kp;
> 
> ???? I don't see the point for that global omap_kp, actually ...

Yes you're right. Will send an updated one tomorrow.

Regards,

Tony
