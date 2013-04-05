From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Fri, 5 Apr 2013 10:05:27 -0700
Message-ID: <20130405170527.GC10155@atomide.com>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
 <1364507576-19345-2-git-send-email-nm@ti.com>
 <87ppybxxi0.fsf@linaro.org>
 <20130404025211.GA2456@snafu>
 <515D0BF1.7060802@ti.com>
 <20130404190053.GA4371@kahuna>
 <515E9E79.8010300@ti.com>
 <CAGo_u6r+JdNaCmVh+dHLppJ7eaYh4W5aL1aAg8xQfAju6PyZdQ@mail.gmail.com>
 <20130405161338.GB10155@atomide.com>
 <20130405163254.GA7259@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130405163254.GA7259@kahuna>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [130405 09:37]:
> 
> on the first step angle,
> Applying current approach that Roger has taken:
> Benoit's tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
> for_3.10/dts  d114294 ARM: dts: AM33XX: Corrects typo in interrupt field in SPI node
> +:
> https://patchwork.kernel.org/patch/2312211/
> https://patchwork.kernel.org/patch/2335671/
> And the diff below[1] as replacement for this patch - does indeed work on
> PandaBoard. Now the question is which direction should I take - will
> wait on decision in https://lkml.org/lkml/2013/4/5/173 thread.

No need to wait AFAIK :) It seems we can already work on this:

1. Limit the DT clock use to the standard binding as defined in
   the Documentation/devicetree/bindings/clock/clock-bindings.txt
   until we have a clear plan of the possible additional bindings
   needed

2. Do a minimal drivers/clock/omap driver that remaps the bindings
   to the existing clocks. It seems that Roger already has all
   the code, it just needs to become a proper driver

> I have similar issues: clock alias is a mess of a code to cleanup and keep alive
> for mpu dplls - I have posted on this mail thread various variants of trying to
> do this - there is no simple solution.

I can see an issue there if the clocks are board specific, but
what's the clock alias issue with mpu dplls?
 
> If we cannot go any further, we are essentially stalled on moving
> cpufreq (OPP entries along with it, regulators, voltage ....) to device
> tree.

Heh I doubt that :)
 
> [1]
> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
> index cccf39a..1fddb1e 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -21,6 +21,8 @@
>  				800000  1313000
>  				1008000 1375000
>  			>;
> +			clocks = <&clks 6>;
> +			clock-names = "cpu";
>  			clock-latency = <300000>; /* From legacy driver */
>  		};
>  	};

So the clock-latency is non-standard here, but that's a
separate issue.

> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index afa509a..5b147ef 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -49,6 +49,11 @@ static void __init omap_generic_init(void)
>  		omap4_panda_display_init_of();
>  	else if (of_machine_is_compatible("ti,omap4-sdp"))
>  		omap_4430sdp_display_init_of();
> +
> +	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
> +		struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
> +		platform_device_register_full(&devinfo);
> +	}
>  }

Hmm why would the driver need this? Sounds like the driver is
missing support for DT?
  
>  #ifdef CONFIG_SOC_OMAP2420
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> index a93617b..54530d0 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -1675,6 +1675,7 @@ static struct clk *dt_clks[] = {
>  	&auxclk3_ck,
>  	&auxclk4_ck,
>  	&auxclk5_ck,
> +	&dpll_mpu_ck,
>  };
>  
>  static struct clk_onecell_data clock_data;

The dt_clks[] should be something that's allocated in the
driver/clock/omap driver, let's not stuff that into
cclock44xx_data.c.

Regards,

Tony
