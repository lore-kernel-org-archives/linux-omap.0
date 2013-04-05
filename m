From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Fri, 5 Apr 2013 14:10:03 -0700
Message-ID: <20130405211003.GK6182@atomide.com>
References: <515D0BF1.7060802@ti.com>
 <20130404190053.GA4371@kahuna>
 <515E9E79.8010300@ti.com>
 <CAGo_u6r+JdNaCmVh+dHLppJ7eaYh4W5aL1aAg8xQfAju6PyZdQ@mail.gmail.com>
 <20130405161338.GB10155@atomide.com>
 <20130405163254.GA7259@kahuna>
 <20130405170527.GC10155@atomide.com>
 <20130405171750.GA7398@kahuna>
 <20130405192829.GE10155@atomide.com>
 <20130405200201.GA7804@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130405200201.GA7804@kahuna>
Sender: linux-pm-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [130405 13:06]:
> On 12:28-20130405, Tony Lindgren wrote:
> > * Nishanth Menon <nm@ti.com> [130405 10:22]:
> > > On 10:05-20130405, Tony Lindgren wrote:
> > > > 
> > > > > diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> > > > > index afa509a..5b147ef 100644
> > > > > --- a/arch/arm/mach-omap2/board-generic.c
> > > > > +++ b/arch/arm/mach-omap2/board-generic.c
> > > > > @@ -49,6 +49,11 @@ static void __init omap_generic_init(void)
> > > > >  		omap4_panda_display_init_of();
> > > > >  	else if (of_machine_is_compatible("ti,omap4-sdp"))
> > > > >  		omap_4430sdp_display_init_of();
> > > > > +
> > > > > +	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
> > > > > +		struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
> > > > > +		platform_device_register_full(&devinfo);
> > > > > +	}
> > > > >  }
> > > > 
> > > > Hmm why would the driver need this? Sounds like the driver is
> > > > missing support for DT?
> > > Nope, this was a long chain of discussion in previous iterations of this
> > > patch.. more or less started here:
> > > https://patchwork.kernel.org/patch/2251821/
> > > Suggested as the generic approach for cpufreq drivers.
> > > Paul questioned this approach in:
> > > http://marc.info/?l=linux-pm&m=136485349218809&w=2
> > 
> > How about just set it up in omap2_common_pm_init instead
> > of the board-generic?
> umm.. We want to eventually want to get rid of mach-omap2/pm.c (all
> those create processor devices etc should go away with proper
> representation of devices as nodes in DT if possible.
> But, I think you mean something like in the "else" condition of
> https://patchwork.kernel.org/patch/2359711/ ? - I'd again have the same
> request of not having anything to do with pm.c and keeping as little as
> possible for all TI processors in mach-omap2.
> 
> Could you enlighten me about why you'd not like it in board-generic.c?
> will creating an function ti_generic_cpufreq_init() in board-generic.c
> and calling it from omap_generic_init help?

I'd like to keep board-generic.c down to minimum. Can't you
set it up in omap_init_cpufreq() in your second patch of this
series?

Regards,

Tony
