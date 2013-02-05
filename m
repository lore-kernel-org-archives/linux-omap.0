From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
Date: Tue, 5 Feb 2013 10:44:18 -0800
Message-ID: <20130205184418.GL25185@atomide.com>
References: <50FE64DC.2030808@ti.com>
 <510788B9.9050907@ti.com>
 <20130130220532.GA22517@atomide.com>
 <20130204195251.GS22517@atomide.com>
 <20130205123055.GA17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:41906 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754443Ab3BESoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 13:44:22 -0500
Content-Disposition: inline
In-Reply-To: <20130205123055.GA17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130205 04:34]:
> On Mon, Feb 04, 2013 at 11:52:51AM -0800, Tony Lindgren wrote:
> > @@ -245,7 +245,7 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
> >  	return 0;
> >  }
> >  
> > -static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
> > +static struct twl4030_gpio_platform_data __initdata sdp3430_gpio_data = {
> >  	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
> >  				| BIT(16) | BIT(17),
> >  	.setup		= sdp3430_twl_gpio_setup,
> 
> Seeing platform data marked with __initdata makes me extremely nervous.
> Are you _absolutely_ _sure_ that this data either:
> 
> (a) gets copied before use, or
> (b) is not used after kernel init
> 
> ?

No, and that's why I said "I suspect some of these cannot be
__init/__initdata" and asked Peter to verify it :)
 
> Normally, platform data is passed via a pointer in struct device to
> drivers, and drivers either store a pointer to it, or if the driver is
> unbound/rebound, they can access it well after init time.

Yes it's not worth adding any copying of it in the twl-common.c.

Regards,

Tony
