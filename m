From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
 boot failure)
Date: Thu, 13 Jan 2011 07:51:53 -0800
Message-ID: <20110113155152.GG4957@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com>
 <20110106203238.GH1198@n2100.arm.linux.org.uk>
 <20110106204053.GA7771@atomide.com>
 <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com>
 <20110111231611.GX4957@atomide.com>
 <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com>
 <20110113091546.GA24429@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58864 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747Ab1AMPwL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 10:52:11 -0500
Content-Disposition: inline
In-Reply-To: <20110113091546.GA24429@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110113 01:15]:
> On Thu, Jan 13, 2011 at 02:22:06PM +0530, Anand Gadiyar wrote:
> > Tony Lindgren wrote:
> > >  	/* Power on the ULPI PHY */
> > > -	if (gpio_is_valid(OMAP4SDP_MDM_PWR_EN_GPIO)) {
> > > -		/* FIXME: Assumes pad is already muxed for GPIO mode */
> > > -		gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY
> > VMDM_3V3");
> > > +	status = gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY
> > VMDM_3V3");
> > > +	if (status)
> > > +		pr_err("%s: Could not get USBB1 PHY GPIO\n");
> > 
> > Tony,
> > 
> > This throws up a build warning as there's no parameter corresponding to
> > the %s. Showed up in linux-next as of today.

Oops, sorry, will fix.
 
> It's pretty obvious that the above is wrong, and the compiler would
> have caught it with a warning when building it.  Was the above patch
> not build-tested before it was committed?

Sure, boot tested it but missed the warning though.
 
> Given the very sorry state of OMAP in mainline at present, I'm surprised
> that this kind of stuff is still going on...

At least I boot test the patches I send..

Regards,

Tony
