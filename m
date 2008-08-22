From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Fri, 22 Aug 2008 12:24:31 +0300 (EEST)
Message-ID: <20080822.122431.177335763.Hiroshi.DOYU@nokia.com>
References: <13B9B4C6EF24D648824FF11BE89671620364E2B470@dlee02.ent.ti.com>
	<20080821.191137.256717219.Hiroshi.DOYU@nokia.com>
	<13B9B4C6EF24D648824FF11BE89671620364E2BAEC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46900 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbYHVJZD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 05:25:03 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620364E2BAEC@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com
Cc: tony@atomide.com, felipe.contreras@gmail.com, h-kanigeri2@ti.com, soni.trilok@gmail.com, vpasam@ti.com, linux-omap@vger.kernel.org, siarhei.siamashka@nokia.com, x00omar@ti.com, grgupta@ti.com

Hi Richard,

From: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 14:43:34 -0500

> Hi Hiroshi,
> 
> > -----Original Message-----
> > From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> 
> <snip>
> 
> > I think that, in this virtual clock, frequency changing will be done
> > in the totally different path(just in a normal clock tree). This
> > virtual clock resides in an independent clock tree and supposed to be
> > used aggressively just to turn on/off clocks(enable/disable), which
> > drivers use, for saving power consumption. So the relationship between
> > "clk" and "vclk" may be similar to "struct device" and "struct class"
> > in the linux driver-model, which means that, the former is based on
> > H/W connection and the latter is based on functionality. Of course
> > there is a possibility that other clk methods can be overwritten, but
> > it's has to be used for different purpose than a normal clock does,
> > not to break the H/W clock tree consistency.
> 
> Ok. I 'think' I better understand your idea.  Thanks for the description.
> 
> To me it seems like it could be slightly confusing to maintain 2
> clock structures.  One for v and one for p.  In the end it is
> probably not very hard to lean.
> 
> It would reduce some amount of code in the more complex
> subsystems/drivers resulting in a cleaner driver.
> 
> The interface used in drivers with the clock frame work is pretty
> simple so it might seem more about clean up then reducing complexity
> in the driver.
> 
> Do you feel a lot of drivers will benefit or it will expand to auto
> handle resources better?  If it is just 1 or 2 drivers then it might
> be the new code in clock framework and platform will add some
> complexity which is higher than what was removed from the driver.
> If lots of drivers use it then it would be positive.

I have no idea right now about how much drivers and the feature
evolution. But basically I feel positive because for now this won't
affect the existing clock tree(or framework) at all and this is just a
helper function for driver's clock initialization and can be
considered as a kind of independent add-on feature from the clock
framework perspective.

I agree that there is a possibility that some smart guy can extend
this to handle all device driver related resources(platform
dependent?) together.

	Hiroshi DOYU



