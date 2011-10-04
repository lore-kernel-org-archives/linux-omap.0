From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 8/9] regulator: helper to extract regulator node based on
 supply name
Date: Tue, 4 Oct 2011 11:00:42 -0600
Message-ID: <20111004170042.GA12036@ponder.secretlab.ca>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-9-git-send-email-rnayak@ti.com>
 <20110927122155.GE4289@opensource.wolfsonmicro.com>
 <4E81E281.505@ti.com>
 <20110927185913.GU4289@opensource.wolfsonmicro.com>
 <4E82D63A.7030207@ti.com>
 <20110928122628.GF3279@opensource.wolfsonmicro.com>
 <4E858D35.50903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63803 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832Ab1JDR7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 13:59:42 -0400
Received: by ywb5 with SMTP id 5so750776ywb.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 10:59:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E858D35.50903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "Girdwood, Liam" <lrg@ti.com>, "patches@linaro.org" <patches@linaro.org>

On Fri, Sep 30, 2011 at 03:04:45PM +0530, Rajendra Nayak wrote:
> On Wednesday 28 September 2011 05:56 PM, Mark Brown wrote:
> >On Wed, Sep 28, 2011 at 10:09:30AM +0200, Cousson, Benoit wrote:
> >>On 9/27/2011 8:59 PM, Mark Brown wrote:
> >
> >>>I'm not sure how this should work in a device tree world, I'd *hope*
> >>>we'd get a device tree node for the CPU and could then just make this a
> >>>regular consumer thing but then the cpufreq drivers would need to be
> >>>updated to make use of it.  The only reason we allow null devices right
> >>>now is the fact that cpufreq doesn't have a struct device it can use.
> >
> >>That's why we do have a MPU node in OMAP dts, in order to build an
> >>omap_device that will be mainly used for the DVFS on the MPU.
> >
> >>And even before DT migration, we used to build statically some
> >>omap_device to represent the various processors in the system (MPU,
> >>DSP, CortexM3...).
> >
> >Yeah, but that's very OMAP specific - we don't have that in general (in
> >fact it's the only Linux platform I'm aware of that has a device for the
> >CPU).
> 
> But isn't this the right thing to do for everyone else too?
> 

It is normal to have nodes for each CPU.  The /cpus/ node normally
contains cpu@* nodes for each logical cpu core, and I would expect
nodes for each additional DSP and MPU core.  Whether or not they
belong in the /cpus/ node is a matter of design (we don't have any
patterns for that yet).

g.
