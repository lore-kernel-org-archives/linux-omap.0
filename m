From: <aaro.koskinen@nokia.com>
Subject: RE: [PATCH] arm: mach-omap2: pm: cleanup !CONFIG_SUSPEND handling
Date: Thu, 6 Jan 2011 12:05:51 +0000
Message-ID: <BC214410FD04D84F9079A62423659707164311@008-AM1MPN1-003.mgdnok.nokia.com>
References: <1293640483-25610-1-git-send-email-aaro.koskinen@nokia.com>
	<874o9mvpxf.fsf@ti.com>, <20110106111957.GA1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110106111957.GA1198@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Russell King - ARM Linux [linux@arm.linux.org.uk]:
> > > -static struct platform_suspend_ops omap_pm_ops = {
> > > -   .begin          = omap2_pm_begin,
> > > -   .enter          = omap2_pm_enter,
> > > -   .end            = omap2_pm_end,
> > > -   .valid          = suspend_valid_only_mem,
> > > +static const struct platform_suspend_ops omap_pm_ops[] = {
> > > +   {
> > > +           .begin          = omap2_pm_begin,
> > > +           .enter          = omap2_pm_enter,
> > > +           .end            = omap2_pm_end,
> > > +           .valid          = suspend_valid_only_mem,
> > > +   }
> > >  };
> > > -#else
> > > -static const struct platform_suspend_ops __initdata omap_pm_ops;
> > >  #endif /* CONFIG_SUSPEND */
> > >
> > >  /* XXX This function should be shareable between OMAP2xxx and OMAP3 */
> > > @@ -582,7 +582,7 @@ static int __init omap2_pm_init(void)
> > >                                                 omap24xx_cpu_suspend_sz);
> > >     }
> > >
> > > -   suspend_set_ops(&omap_pm_ops);
> > > +   suspend_set_ops(omap_pm_ops);
>
> Utterly yuck.  Declaring it as a single element array just to avoid an
> ifdef.  That's worse than having an ifdef here.

Why it is worse? Reducing the amount of different preprocessor branches will
result in better compile test / static analysis coverage.

> There's another solution.  Don't mess about with sticking such stuff in
> the header either.
>
> #ifdef WHATEVER
> static const struct platform_suspend_ops omap_pm_ops = {
>         .begin          = omap2_pm_begin,
>         .enter          = omap2_pm_enter,
>         .end            = omap2_pm_end,
>         .valid          = suspend_valid_only_mem,
> };
> #define PM_OPS omap_pm_ops
> #else
> #define PM_OPS NULL
> #endif
> ...
> 
>         suspend_set_ops(PM_OPS);
>
> That keeps it all nice and local, and you can see exactly what's going on
> without having it spread across many different random files.

I don't think it's obviously better or simpler. There's already made a mistake in
your example...

A.
