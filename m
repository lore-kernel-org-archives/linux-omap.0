From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 3/4] ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
Date: Tue, 17 Feb 2015 14:48:26 +0100
Message-ID: <CAMdRc4GkmqqbrBQHWvYTySWLvdz0wROfhGBsBe5iqnq2QdhQRg@mail.gmail.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<54E30972.4020107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E30972.4020107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tue, Feb 17, 2015 at 10:27 AM, Roger Quadros <rogerq@ti.com> wrote:
>
> Can you please point out which DT had used this pre-divided workaround? We will have to
> fix those then.

I didn't check. A cursory glance reveals all DTS in arch/arm/boot/dts
to use a value of 0.

>
> Can you please rebase your patches on top of v3.19?
> gpmc.c has been moved to drivers/memory/omap-gpmc.c


Will do.

>
> So all the below occurrences of "unsigned int clk_sel" become "enum gpmc_clksel".

Yes, I should have opted for a cleaner solution from the start.

> > +static unsigned int gpmc_ns_to_clk_ticks(unsigned int time_ns, int cs, unsigned int clk_sel)
> >  {
> >       unsigned long tick_ps;
> >
> >       /* Calculate in picosecs to yield more exact results */
> > -     tick_ps = gpmc_get_fclk_period();
> > +     tick_ps = gpmc_get_clk_period(cs, clk_sel);
> >
> >       return (time_ns * 1000 + tick_ps - 1) / tick_ps;
> >  }
> >
> > +static unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
> > +{
> > +     return gpmc_ns_to_clk_ticks(time_ns, 0, GPMC_FCLK);
>
> This function should have been unchanged since we're dealing with GPMC_FCLK
> and it was using gpmc_get_fclk_period().


Which function? gpmc_ns_to_ticks? It still uses FCLK. I merely did not
want to have the picosecond formula in two places. I don't see a good
reason to do so now either...

>
> Let's call this GPMC_SET_ONE_CLKSEL()


Will do.


>
> You will also need to correct gpmc_cs_show_timings() to show the
> correct timing for "wait-monitoring-ns" based on GPMC_CLK.


I was working off 3.14, checked if it worked for 3.17, so both didn't
have gpmc_cs_show_timings. I'll take a look.

Regards,

Robert
