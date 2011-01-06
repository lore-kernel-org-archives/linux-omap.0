From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: mach-omap2: pm: cleanup !CONFIG_SUSPEND handling
Date: Thu, 6 Jan 2011 11:19:57 +0000
Message-ID: <20110106111957.GA1198@n2100.arm.linux.org.uk>
References: <1293640483-25610-1-git-send-email-aaro.koskinen@nokia.com> <874o9mvpxf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43989 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab1AFLUK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 06:20:10 -0500
Content-Disposition: inline
In-Reply-To: <874o9mvpxf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 05, 2011 at 04:25:32PM -0800, Kevin Hilman wrote:
> As you likely noticed, removing the const leads to checkpatch warnings:
> 
> WARNING: struct platform_suspend_ops should normally be const
> 
> so the choice is between a checkpatch warning or a bunch of compiler
> warnings.

checkpatch should not be checking that data declarations are const.
That's a decision for those people declaring them to decide upon, as
they may need to modify the structure before registration.

By doing so, we end up encouraging people to write more code - such
as declaring it __initconst, and then kmalloc'ing, memcpy'ing and
modifying that before registering it.

> > -static struct platform_suspend_ops omap_pm_ops = {
> > -	.begin		= omap2_pm_begin,
> > -	.enter		= omap2_pm_enter,
> > -	.end		= omap2_pm_end,
> > -	.valid		= suspend_valid_only_mem,
> > +static const struct platform_suspend_ops omap_pm_ops[] = {
> > +	{
> > +		.begin		= omap2_pm_begin,
> > +		.enter		= omap2_pm_enter,
> > +		.end		= omap2_pm_end,
> > +		.valid		= suspend_valid_only_mem,
> > +	}
> >  };
> > -#else
> > -static const struct platform_suspend_ops __initdata omap_pm_ops;
> >  #endif /* CONFIG_SUSPEND */
> >  
> >  /* XXX This function should be shareable between OMAP2xxx and OMAP3 */
> > @@ -582,7 +582,7 @@ static int __init omap2_pm_init(void)
> >  						    omap24xx_cpu_suspend_sz);
> >  	}
> >  
> > -	suspend_set_ops(&omap_pm_ops);
> > +	suspend_set_ops(omap_pm_ops);

Utterly yuck.  Declaring it as a single element array just to avoid an
ifdef.  That's worse than having an ifdef here.

There's another solution.  Don't mess about with sticking such stuff in
the header either.

#ifdef WHATEVER
static const struct platform_suspend_ops omap_pm_ops = {
	.begin		= omap2_pm_begin,
	.enter		= omap2_pm_enter,
	.end		= omap2_pm_end,
	.valid		= suspend_valid_only_mem,
};
#define PM_OPS omap_pm_ops
#else
#define PM_OPS NULL
#endif
...

	suspend_set_ops(PM_OPS);

That keeps it all nice and local, and you can see exactly what's going on
without having it spread across many different random files.
