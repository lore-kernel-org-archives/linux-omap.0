From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/9] regulator: helper to extract regulator node based on
 supply name
Date: Fri, 30 Sep 2011 11:35:50 +0100
Message-ID: <20110930103516.GB4195@opensource.wolfsonmicro.com>
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
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42541 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754105Ab1I3Kfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 06:35:51 -0400
Content-Disposition: inline
In-Reply-To: <4E858D35.50903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "Girdwood, Liam" <lrg@ti.com>, "patches@linaro.org" <patches@linaro.org>

On Fri, Sep 30, 2011 at 03:04:45PM +0530, Rajendra Nayak wrote:
> On Wednesday 28 September 2011 05:56 PM, Mark Brown wrote:
> >On Wed, Sep 28, 2011 at 10:09:30AM +0200, Cousson, Benoit wrote:

> >>And even before DT migration, we used to build statically some
> >>omap_device to represent the various processors in the system (MPU,
> >>DSP, CortexM3...).

> >Yeah, but that's very OMAP specific - we don't have that in general (in
> >fact it's the only Linux platform I'm aware of that has a device for the
> >CPU).

> But isn't this the right thing to do for everyone else too?

That doesn't really matter so long as nobody else is actually doing it;
you can't make a decision like this in an OMAP-specific fashion, you
need to make sure everyone else is on board with the decision and make
sure we've got at least at a high level way of representing the CPUs and
SoCs in the device tree that people can buy into.
