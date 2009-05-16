From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RESUBMIT][PATCH 6/7] OMAP4: Clock stubs since clock	management
 framework not in.
Date: Sun, 17 May 2009 01:51:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49042A3@dbde02.ent.ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-6-git-send-email-santosh.shilimkar@ti.com>
 <20090516101404.GM15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40177 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbZEPUWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 16:22:18 -0400
In-Reply-To: <20090516101404.GM15328@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Saturday, May 16, 2009 3:44 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> linux-omap@vger.kernel.org
> Subject: Re: [RESUBMIT][PATCH 6/7] OMAP4: Clock stubs since 
> clock management framework not in.

> > +/* This functions is moved to arch/arm/common/clkdev.c. 
> For OMAP4 since
> > + * clock framework is not up , it is defined here to avoid 
> rework in
> > + * every driver */
> > +
> > +/* Dummy hooks only for OMAP4.For rest OMAPs, common 
> clkdev is used */
> > +#if defined(CONFIG_ARCH_OMAP4)
> > +struct clk *clk_get(struct device *dev, const char *id)
> > +{
> > +	return NULL;
> 
> Okay, so all clk's are NULL pointers on OMAP4 currently.
> 
> > +}
> > +EXPORT_SYMBOL(clk_get);
> > +
> > +void clk_put(struct clk *clk)
> > +{
> > +}
> > +EXPORT_SYMBOL(clk_put);
> > +void omap2_clk_prepare_for_reboot(void)
> > +{
> > +}
> > +EXPORT_SYMBOL(omap2_clk_prepare_for_reboot);
> > +#endif
> >  int clk_enable(struct clk *clk)
> >  {
> >  	unsigned long flags;
> >  	int ret = 0;
> > +	if (cpu_is_omap44xx())
> > +		/* OMAP4 clk framework not supported yet */
> > +		return 0;
> 

> And this enables things to work.
Don't know whether above line is a question from you. Just for info all needed clocks are enabled in the u-boot currently.

Regards,
Santosh
 