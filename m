From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
Date: Fri, 17 Aug 2012 08:22:15 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA92062@DBDE01.ent.ti.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
 <alpine.DEB.2.00.1207261359500.14468@utopia.booyaka.com>
 <20120814082911.GG11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA8F4CD@DBDE01.ent.ti.com>
 <20120817074934.GL11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754965Ab2HQIW1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 04:22:27 -0400
In-Reply-To: <20120817074934.GL11011@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Fri, Aug 17, 2012 at 13:19:34, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120815 02:11]:
> > On Tue, Aug 14, 2012 at 13:59:12, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Paul Walmsley <paul@pwsan.com> [120726 13:07]:
> > > > On Wed, 25 Jul 2012, Paul Walmsley wrote:
> > > > 
> > > > > These IP blocks and the ECAP IP blocks have periods in their names.
> > > > > The rest of the IP block named in the file don't use periods -- which
> > > > > is also the style used by the rest of the OMAP SoCs.  Is there
> > > > > some reason that these have periods in their names?
> > > > 
> > > > I've changed those to match the rest of the names, and queued the 
> > > > following for 3.7.
> > > > 
> > > > Thanks again for all the hard work you all put into this.  I realize that 
> > > > with all the upstream changes, this was probably a little painful for you. 
> > > > But from my perspective you've been a pleasure to work with through the 
> > > > process.
> > > 
> > > As am33xx and omap5 are DT only, we should start moving towards getting
> > > rid of grep -E "irq|pa_start|pa_end|dma" in this patch and get the standard
> > > data from .dtsi files instead.
> > > 
> > 
> > It may not be so straight, given the fact that hwmod layer 
> > requires these resources, as hwmod is responsible to configure SYSCONF 
> > register of the device (happens very early at core_init level).
> > 
> > Somehow we have to have some mechanism to initialize " _mpu_rt_va" before 
> > core_init call, which will take DT resources and initialize accordingly.
> 
> That's for the device reset/idle? We should not do that in hwmod code
> except in late_initcall for unclaimed devices as discussed earlier. We
> discussed setting up the reset function in the device specific headers
> so both device and hwmod code can call them as needed.
>  

Tony,

May be I didn't understand your above statement, can you please elaborate 
more on "device specific header file"?


Just to highlight, its not only during late_initcall, the _enable and _idle 
functions are getting executed as part of every runtime_pm_get\put_sync from 
the driver.

Are you saying as part of late_initcall, we should initialize " _mpu_rt_va" 
of "struct omap_hwmod"???

Also, as far unclaimed resources is concerned, somewhere you should have 
base addr of the device maintained, right? Currently, hwmod is maintaining 
this data and the execution goes something like,

Core_initcall()
	-> _setup()
		-> _setup_reset()
		-> _idle()


Another biggest worry is, if I play here, it may break existing omap3/4 
Functionality, especially may impact from PM perspective. So I believe, we 
need to have something which adds/cleans-up things in stages.
May be get rid of resource overwriting for AM33xx and OMAP5 alone as of 
now??

Any thoughts??

Thanks,
Vaibhav



> > Another dependency we will have is on system timers, Jon has already done 
> > some initial work on this, but I believe we did not concluded on the it.
> > I will re-start the thread again, since in any case DT support in timer is 
> > required.
> 
> Right.. The timers are a pain right now as they need to be initialized
> early. Everything else can and should be initialized at the device probe
> time, or from a late_initcall for the unclaimed devices.
>  
> > > Alternatively we could get rid of the names and match the module based on
> > > pa_start and pa_end.
> > > 
> > 
> > Just FYI, from resource perspective, I have changed omap_device layer for DT 
> > resources only (still need hwmod resources as explained above) and patch 
> > looks something like (and it works) -
> 
> Cool yeah few more dependencies remain still.
> 

> Regards,
> 
> Tony
> 

