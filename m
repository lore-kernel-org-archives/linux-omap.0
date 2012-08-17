From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
Date: Fri, 17 Aug 2012 00:49:34 -0700
Message-ID: <20120817074934.GL11011@atomide.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
 <alpine.DEB.2.00.1207261359500.14468@utopia.booyaka.com>
 <20120814082911.GG11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA8F4CD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54963 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284Ab2HQHtj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 03:49:39 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA8F4CD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120815 02:11]:
> On Tue, Aug 14, 2012 at 13:59:12, Tony Lindgren wrote:
> > Hi,
> > 
> > * Paul Walmsley <paul@pwsan.com> [120726 13:07]:
> > > On Wed, 25 Jul 2012, Paul Walmsley wrote:
> > > 
> > > > These IP blocks and the ECAP IP blocks have periods in their names.
> > > > The rest of the IP block named in the file don't use periods -- which
> > > > is also the style used by the rest of the OMAP SoCs.  Is there
> > > > some reason that these have periods in their names?
> > > 
> > > I've changed those to match the rest of the names, and queued the 
> > > following for 3.7.
> > > 
> > > Thanks again for all the hard work you all put into this.  I realize that 
> > > with all the upstream changes, this was probably a little painful for you. 
> > > But from my perspective you've been a pleasure to work with through the 
> > > process.
> > 
> > As am33xx and omap5 are DT only, we should start moving towards getting
> > rid of grep -E "irq|pa_start|pa_end|dma" in this patch and get the standard
> > data from .dtsi files instead.
> > 
> 
> It may not be so straight, given the fact that hwmod layer 
> requires these resources, as hwmod is responsible to configure SYSCONF 
> register of the device (happens very early at core_init level).
> 
> Somehow we have to have some mechanism to initialize " _mpu_rt_va" before 
> core_init call, which will take DT resources and initialize accordingly.

That's for the device reset/idle? We should not do that in hwmod code
except in late_initcall for unclaimed devices as discussed earlier. We
discussed setting up the reset function in the device specific headers
so both device and hwmod code can call them as needed.
 
> Another dependency we will have is on system timers, Jon has already done 
> some initial work on this, but I believe we did not concluded on the it.
> I will re-start the thread again, since in any case DT support in timer is 
> required.

Right.. The timers are a pain right now as they need to be initialized
early. Everything else can and should be initialized at the device probe
time, or from a late_initcall for the unclaimed devices.
 
> > Alternatively we could get rid of the names and match the module based on
> > pa_start and pa_end.
> > 
> 
> Just FYI, from resource perspective, I have changed omap_device layer for DT 
> resources only (still need hwmod resources as explained above) and patch 
> looks something like (and it works) -

Cool yeah few more dependencies remain still.

Regards,

Tony
