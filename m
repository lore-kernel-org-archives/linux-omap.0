From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Thu, 16 Oct 2008 03:02:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810160212050.26871@utopia.booyaka.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <1223333252-25687-2-git-send-email-me@felipebalbi.com> <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com> <20081014172921.GJ20247@frodo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40674 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbYJPJCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 05:02:32 -0400
In-Reply-To: <20081014172921.GJ20247@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, david-b@pacbell.net

On Tue, 14 Oct 2008, Felipe Balbi wrote:

> On Tue, Oct 14, 2008 at 11:08:48AM -0600, Paul Walmsley wrote:
> > On Tue, 7 Oct 2008, Felipe Balbi wrote:
> > 
> > > Introduce a new mechanism to omap's clk implementation to
> > > associate the device with its clock during platform_device
> > > registration. Also gives the clock a function name (like
> > > mmc_fck, uart_fck, ehci_fck, etc) so drivers won't have to
> > > care about clk names any longer.
> > 
> > Let's make the function names shorter, like "fclk" and "iclk".  That 
> > should make them even easier to use in situations where the device name 
> > itself changes, e.g., "mmc"/"hsmmc" etc.  Plus the linker will be able to 
> > merge many them together into single constant strings.  For a device with 
> > multiple fclks like DSS, we can use "tv_fclk" also, etc.
> 
> I didn't quite get you here. The idea of mmc_fck is so that
> 
> clk_get(dev, "mmc_fck");
> 
> works fine and returns the correct clock. If we have several fck and ick
> function names, how will we clk_get() the right one ??

sounds like David has already clarified this; we can discuss further if 
not.

> > > diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> > > index 7bbfba2..c090f23 100644
> > > --- a/arch/arm/plat-omap/clock.c
> > > +++ b/arch/arm/plat-omap/clock.c
> > > + * @id: clock id as defined in arch/arm/mach-omapX/clkxxxx.h
> > > + * @dev: device pointer for the clock user
> > > + * @f: a function for the clock (uart_[if]ck, musb_ick, ehci_[if]ck, etc)
> > > + */
> > > +void __init omap_clk_associate(const char *id, struct device *dev, const char *f)
> > > +{
> > > +	struct clk *clk = clk_get(NULL, id);
> > > +
> > > +	if (!dev || !clk || !IS_ERR(clk_get(dev, f)))
> > > +		return;
> 
> > But there seems to be a deeper problem.  What happens when multiple device 
> > drivers want to associate to the same clock?  osc_ck is the pathological 
> > case.  Seems like you'll need a different data structure, like a list, to 
> > store in the struct clk.
> 
> Yeah, have to think about that, but then again, how can several users
> concurrently enable and disable the same clock ?
> 
> I mean, imagine driver A clk_enable(osc_ck) and while needing that
> clock, driver B clk_disable(osc_ck). That would break driver A, right ?

no - see below

> How is omap clk fw handling that case right now ? I'd say we should have
> one user per clk and in the case of osc_ck, that would be a clk input
> for generating another clk, or something like that, so driver A can
> clk_enable(osc_ck_A) and yet driver B could clk_disable(osc_ck_B) and
> everything still works.

clk_enable() increments the struct clk.usecount field each time it is 
called.  clk_disable() decrements it, and only disables the clock when it 
reaches 0.  The code that does this is in the first few lines of 
omap2_clk_enable() and omap2_clk_disable() in arch/arm/mach-omap2/clock.c.

[ In the medium term we will probably switch away from using clk_enable() 
and clk_disable() on osc_ck to keep the external oscillator powered on. 
But this could still apply to other clocks, e.g., boards could have 
multiple devices hanging off of the sys_clkoutX lines, etc. ]


- Paul
