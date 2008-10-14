From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Tue, 14 Oct 2008 20:29:27 +0300
Message-ID: <20081014172921.GJ20247@frodo>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com> <1223333252-25687-2-git-send-email-me@felipebalbi.com> <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44857 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbYJNR3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 13:29:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Tue, Oct 14, 2008 at 11:08:48AM -0600, Paul Walmsley wrote:
> Hi Felipe,
> 
> so I'll put most of my comments here.
> 
> On Tue, 7 Oct 2008, Felipe Balbi wrote:
> 
> > Introduce a new mechanism to omap's clk implementation to
> > associate the device with its clock during platform_device
> > registration. Also gives the clock a function name (like
> > mmc_fck, uart_fck, ehci_fck, etc) so drivers won't have to
> > care about clk names any longer.
> 
> Let's make the function names shorter, like "fclk" and "iclk".  That 
> should make them even easier to use in situations where the device name 
> itself changes, e.g., "mmc"/"hsmmc" etc.  Plus the linker will be able to 
> merge many them together into single constant strings.  For a device with 
> multiple fclks like DSS, we can use "tv_fclk" also, etc.

I didn't quite get you here. The idea of mmc_fck is so that

clk_get(dev, "mmc_fck");

works fine and returns the correct clock. If we have several fck and ick
function names, how will we clk_get() the right one ??

> > diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> > index 7bbfba2..c090f23 100644
> > --- a/arch/arm/plat-omap/clock.c
> > +++ b/arch/arm/plat-omap/clock.c
> > @@ -43,7 +43,7 @@ static struct clk_functions *arch_clock;
> >   */
> >  struct clk * clk_get(struct device *dev, const char *id)
> >  {
> > -	struct clk *p, *clk = ERR_PTR(-ENOENT);
> > +	struct clk *p, *clk;
> >  	int idno;
> >  
> >  	if (dev == NULL || dev->bus != &platform_bus_type)
> > @@ -53,6 +53,15 @@ struct clk * clk_get(struct device *dev, const char *id)
> >  
> >  	mutex_lock(&clocks_mutex);
> >  
> > +	list_for_each_entry(clk, &clocks, node) {
> > +		if (clk->function && (dev == clk->dev) &&
> > +				strcmp(id, clk->function) == 0)
> > +			goto found;
> 
> Please avoid the gotos and use the previously-used form for returning 
> success, e.g., iterate on p; if found, then assign to clk, and break.
> 
> Also, is there some reason why there are two list_for_each_entry() blocks?  
> Those should be merged into one.

Will do.

> 
> > +
> > +		if (strcmp(id, clk->name) == 0)
> > +			goto found;
> 
> Doesn't the following code already handle the above case?

my bad, when merging both list_for_each_entry() this will disappear.

> > +/**
> 
> First, thank you for using kerneldoc.  But ...
> 
> > + * omap_clk_associate - associates a user to a clock so device drivers don't
> > + * have to care about clock names
> 
> ... Documentation/kernel-doc-nano-HOWTO.txt requires the short function 
> description to fit on one line.  If you need more room, please put the 
> larger description after a blank line after the last argument 
> documentation line (e.g., line beginning with '@').

Will fix.

> 
> > + *
> 
> This blank line needs to be removed per kerneldoc - "The @argument 
> descriptions must begin on the very next line ..."
> 
> > + * @id: clock id as defined in arch/arm/mach-omapX/clkxxxx.h
> > + * @dev: device pointer for the clock user
> > + * @f: a function for the clock (uart_[if]ck, musb_ick, ehci_[if]ck, etc)
> > + */
> > +void __init omap_clk_associate(const char *id, struct device *dev, const char *f)
> > +{
> > +	struct clk *clk = clk_get(NULL, id);
> > +
> > +	if (!dev || !clk || !IS_ERR(clk_get(dev, f)))
> > +		return;
> 
> Please break the clk_get() test above out into its own statement, and 
> clk_put() it before returning.

ok.

> There needs to be a test before these lines to ensure that some driver has 
> not already associated a function with this clock, or a device with this 
> clock, and to WARN_ON(1) if it has.

sounds good.

> But there seems to be a deeper problem.  What happens when multiple device 
> drivers want to associate to the same clock?  osc_ck is the pathological 
> case.  Seems like you'll need a different data structure, like a list, to 
> store in the struct clk.

Yeah, have to think about that, but then again, how can several users
concurrently enable and disable the same clock ?

I mean, imagine driver A clk_enable(osc_ck) and while needing that
clock, driver B clk_disable(osc_ck). That would break driver A, right ?

How is omap clk fw handling that case right now ? I'd say we should have
one user per clk and in the case of osc_ck, that would be a clk input
for generating another clk, or something like that, so driver A can
clk_enable(osc_ck_A) and yet driver B could clk_disable(osc_ck_B) and
everything still works.

-- 
balbi
