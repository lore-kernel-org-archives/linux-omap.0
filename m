From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Thu, 26 Apr 2012 06:21:21 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FE7EA@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204252335190.30642@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54444 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab2DZGVa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 02:21:30 -0400
In-Reply-To: <alpine.DEB.2.00.1204252335190.30642@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 26, 2012 at 11:15:21, Paul Walmsley wrote:
> Hi,
> 
> > +/*
> > + * clkdiv32 is generated from fixed division of 732.4219
> > + */
> > +static struct clk clkdiv32k_ick = {
> > +	.name		= "clkdiv32k_ick",
> > +	.clkdm_name	= "clk_24mhz_clkdm",
> > +	.rate		= 32768,
> > +	.parent		= &clk_24mhz,
> > +	.enable_reg	= AM33XX_CM_PER_CLKDIV32K_CLKCTRL,
> > +	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
> > +	.ops		= &clkops_omap2_dflt,
> > +};
> 
> While working on this file, this clock seemed quite perplexing.  Perhaps 
> you might be able to answer some questions about it.
> 
> - The fractional fixed division seems a little bogus.  Is this actually an 
> M,N counter?  A few moments with PARI revealed a likely M,N of 64,46875.  
> Could you please confirm that this is the case for this clock?
> 
> - This clock structure makes this clock appear to be a fixed-frequency 
> clock.  But according to SPRUH73D Figure 8-10 "Peripheral PLL Structure", 
> the divider feeding this clock can be switched between an M,N of 64,46875 
> and 32,46875 depending on the value of CONTROL_CLK32K_DIVRATIO_CTRL.  So 
> shouldn't we implement that?
> 

Unfortunately, this is fractional divider, assuming input clock of 24MHz.

24MHz / 732.4219 = 32KHz (Normal OPP100)
24MHz / 366.2109 = 32KHz (OPP50)

The register control CONTROL_CLK32K_DIVRATIO_CTRL is provided to choose 
between these two dividers.

As per the Spec, we have some known HW/Si issues to run whole system at 
OPP50, that's where if you refer to the TRM Table 8-22. Per PLL Typical 
Frequencies (MHz), it only talks about OPP100, which is 732.4219 divider.

So, technically, if both OPP's (OPP100 and OPP50) works fine, then yes, we 
should handle it. But given the fact that, OPP50 is not fully functional due 
to HW/Si issues, from CORE and PER perspective we will always stay at OPP100.

To summarize, I had to make it fixed-frequency due to,

 - Fractional divisor value.
 - We will always stay at OPP100 in any case, making this divisor constant 
   always.

> - This clock is feeding downstream clocks, but it's using the MODULEMODE 
> control interface, as if it were a standalone IP block.  Do you know why 
> it's using the MODULEMODE control method rather than some optional clock 
> control bits, like OMAP4 does?
> 

Yes, this clock is feeding to timers, gpio debounce clocks, etc...
Honestly, I do not know the answer to why part of it.
(May be another integration/design issue)

Thanks,
Vaibhav

> 
> - Paul
> 

