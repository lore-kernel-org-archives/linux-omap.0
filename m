From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
Date: Fri, 17 Aug 2012 01:40:47 -0700
Message-ID: <20120817084047.GN11011@atomide.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
 <alpine.DEB.2.00.1207261359500.14468@utopia.booyaka.com>
 <20120814082911.GG11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA8F4CD@DBDE01.ent.ti.com>
 <20120817074934.GL11011@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA92062@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59378 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab2HQIkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 04:40:51 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA92062@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120817 01:22]:
> On Fri, Aug 17, 2012 at 13:19:34, Tony Lindgren wrote:
> > * Hiremath, Vaibhav <hvaibhav@ti.com> [120815 02:11]:
> > > 
> > > Somehow we have to have some mechanism to initialize " _mpu_rt_va" before 
> > > core_init call, which will take DT resources and initialize accordingly.
> > 
> > That's for the device reset/idle? We should not do that in hwmod code
> > except in late_initcall for unclaimed devices as discussed earlier. We
> > discussed setting up the reset function in the device specific headers
> > so both device and hwmod code can call them as needed.
> 
> May be I didn't understand your above statement, can you please elaborate 
> more on "device specific header file"?

We should have the device drivers idle and reset the devices. But also
hwmod may need to do that for the unclaimed devices for PM to work. 
As the driver may not be even compiled in, the driver specific reset and
idle functions should be static inline functions in the device specific
header file so hwmod code can still call those.
 
> Just to highlight, its not only during late_initcall, the _enable and _idle 
> functions are getting executed as part of every runtime_pm_get\put_sync from 
> the driver.

Right, so no need to initialize those until at driver probe time.
 
> Are you saying as part of late_initcall, we should initialize " _mpu_rt_va" 
> of "struct omap_hwmod"???

I guess either at driver probe for the claimed devices, or at late_initcall
for the unclaimeded devices.

> Also, as far unclaimed resources is concerned, somewhere you should have 
> base addr of the device maintained, right? Currently, hwmod is maintaining 
> this data and the execution goes something like,
> 
> Core_initcall()
> 	-> _setup()
> 		-> _setup_reset()
> 		-> _idle()

For the DT only case also the unclaimed devices can from DT with
status = "disabled". 
 
> Another biggest worry is, if I play here, it may break existing omap3/4 
> Functionality, especially may impact from PM perspective. So I believe, we 
> need to have something which adds/cleans-up things in stages.

It seems that we need three stages: Something early for the timers only,
initialize most things during driver probe, then late_initcall for the
unclaimed devices.

> May be get rid of resource overwriting for AM33xx and OMAP5 alone as of 
> now??

Sorry I don't follow this part, care to explain a little more?

Regards,

Tony
