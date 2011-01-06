From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: mach-omap2: pm: cleanup !CONFIG_SUSPEND handling
Date: Thu, 6 Jan 2011 13:58:10 +0000
Message-ID: <20110106135810.GB1198@n2100.arm.linux.org.uk>
References: <1293640483-25610-1-git-send-email-aaro.koskinen@nokia.com> <874o9mvpxf.fsf@ti.com> <20110106111957.GA1198@n2100.arm.linux.org.uk> <BC214410FD04D84F9079A62423659707164311@008-AM1MPN1-003.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55785 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1AFN60 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 08:58:26 -0500
Content-Disposition: inline
In-Reply-To: <BC214410FD04D84F9079A62423659707164311@008-AM1MPN1-003.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: aaro.koskinen@nokia.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 06, 2011 at 12:05:51PM +0000, aaro.koskinen@nokia.com wrote:
> Hi,
> 
> Russell King - ARM Linux [linux@arm.linux.org.uk]:
> > > > -static struct platform_suspend_ops omap_pm_ops = {
> > > > -   .begin          = omap2_pm_begin,
> > > > -   .enter          = omap2_pm_enter,
> > > > -   .end            = omap2_pm_end,
> > > > -   .valid          = suspend_valid_only_mem,
> > > > +static const struct platform_suspend_ops omap_pm_ops[] = {
> > > > +   {
> > > > +           .begin          = omap2_pm_begin,
> > > > +           .enter          = omap2_pm_enter,
> > > > +           .end            = omap2_pm_end,
> > > > +           .valid          = suspend_valid_only_mem,
> > > > +   }
> > > >  };
> > > > -#else
> > > > -static const struct platform_suspend_ops __initdata omap_pm_ops;
> > > >  #endif /* CONFIG_SUSPEND */
> > > >
> > > >  /* XXX This function should be shareable between OMAP2xxx and OMAP3 */
> > > > @@ -582,7 +582,7 @@ static int __init omap2_pm_init(void)
> > > >                                                 omap24xx_cpu_suspend_sz);
> > > >     }
> > > >
> > > > -   suspend_set_ops(&omap_pm_ops);
> > > > +   suspend_set_ops(omap_pm_ops);
> >
> > Utterly yuck.  Declaring it as a single element array just to avoid an
> > ifdef.  That's worse than having an ifdef here.
> 
> Why it is worse? Reducing the amount of different preprocessor branches will
> result in better compile test / static analysis coverage.

You're not doing that.  You're just spreading the yuck around making it
far worse:

- in some header file
#ifndef CONFIG_FOO
#define omap_pm_ops NULL
#endif

- in lots of C files
#ifdef CONFIG_FOO
static const struct platform_suspend_ops omap_pm_ops[] = {
	{
		...
	}
};
#endif

	suspend_set_ops(omap_pm_ops);

So, rather than just having the full story in each file, it's spread
across two files.  Not only that, but over time CONFIG_FOO will probably
change, and that will lead to compile errors.

You're creating an array just to be able to use the symbol as a pointer.
That's a hack rather than an elegant solution.

So no, your implementation is _NOT_ a sane approach.

I'm going to explicitly say NAK to your patch here and now.  I really
don't like it one bit.  It's a complete hack through and through, and
that hack is spread across many files.
