From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 2/3] ARM: OMAP3+: clockdomain33xx: Add clockdomain
 data and respective operations
Date: Fri, 27 Apr 2012 09:14:59 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA0094D@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241725430.24864@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FD30E@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204252118170.30642@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FE75B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204260252240.10308@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FF79B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204261252430.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59588 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755946Ab2D0JPG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 05:15:06 -0400
In-Reply-To: <alpine.DEB.2.00.1204261252430.10308@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 27, 2012 at 00:26:47, Paul Walmsley wrote:
> On Thu, 26 Apr 2012, Hiremath, Vaibhav wrote:
> 
> > On Thu, Apr 26, 2012 at 14:27:20, Paul Walmsley wrote:
> 
> (attribution lost)
> 
> > > > I am thinking of separating clocktree patch (PATCH-V3 3/3) from this series, 
> > > > so that clockdomain stuff can get in independently, and clocktree anyway 
> > > > will follow them (it may take some time in review cycle).
> > > 
> > > Yes, I was thinking of doing this too.  The only aspect that gave me pause 
> > > is that the clockdomain changes are not 100% separate from the clock tree.  
> > > So we may have to update the clockdomain data as the clock tree changes.
> > 
> > Why do you say that, clockdomain changes are not 100% separate from 
> > clocktree? It is completely independent...
> 
> Clock enables and disables call clkdm_clk_{enable,disable}() which 
> undertakes the clockdomain enable sequence on the first clock enabled 
> inside the clockdomain, and the clockdomain disable sequence on the last 
> clock inside the clockdomain.  The clockdomain is associated with the 
> clock via the struct clk .clkdm and .clkdm_name fields.
> 

Paul,

"struct clk" will come into picture when we define clocktree 
(clock33xx_data.c file), isn't it?

>From clockdomain perspective, it is still independent and definite set of 
clock domains as per device with respective api's required to control it.
Which clock falls down to which domain, is defined in clocktree 
(clock33xx_data.c file), isn't it?


> So yes, they are interconnected; particularly if the clkdiv32k MODULEMODE 
> "clock" is really needed.
> 
> 

Coming back to example of div32k clock, assuming this as a module with MODULEMODE,

static struct clk clkdiv32k_ick = {
	.name           = "clkdiv32k_ick",
	.clkdm_name     = "clk_24mhz_clkdm",
	.rate           = 32768,
	.parent         = &clk_24mhz,
	.enable_reg     = AM33XX_CM_PER_CLKDIV32K_CLKCTRL,
	.enable_bit     = AM33XX_MODULEMODE_SWCTRL,
	.ops            = &clkops_omap2_dflt,
};

And we have separate domain for div32k clock.

static struct clockdomain clk_24mhz_am33xx_clkdm = {
	.name           = "clk_24mhz_clkdm",
	.pwrdm          = { .name = "per_pwrdm" },
	.cm_inst        = AM33XX_CM_PER_MOD,
	.prcm_partition = AM33XX_PRM_PARTITION,
	.clkdm_offs     = AM33XX_CM_PER_CLK_24MHZ_CLKSTCTRL_OFFSET,
	.clktrctrl_mask = AM33XX_CLKTRCTRL_MASK,
	.flags          = (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
};


In any case, I believe we have to define this domain in 
clockdomain_data, right?



Just FYI, I am about to initiate a mail-chain with design team, on your 
questions on div32k. Hopefully I will have some input by Monday.

Thanks,
Vaibhav

