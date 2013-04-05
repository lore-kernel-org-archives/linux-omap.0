From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Fri, 5 Apr 2013 11:32:54 -0500
Message-ID: <20130405163254.GA7259@kahuna>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
 <1364507576-19345-2-git-send-email-nm@ti.com>
 <87ppybxxi0.fsf@linaro.org>
 <20130404025211.GA2456@snafu>
 <515D0BF1.7060802@ti.com>
 <20130404190053.GA4371@kahuna>
 <515E9E79.8010300@ti.com>
 <CAGo_u6r+JdNaCmVh+dHLppJ7eaYh4W5aL1aAg8xQfAju6PyZdQ@mail.gmail.com>
 <20130405161338.GB10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130405161338.GB10155@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 09:13-20130405, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [130405 04:31]:
> > On Fri, Apr 5, 2013 at 4:50 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> > > On Friday 05 April 2013 12:30 AM, Nishanth Menon wrote:
> > > - I am agree with Tony in his discussion in
> > >> http://marc.info/?t=136370325600009&r=1&w=2
> > >>
> > >> *if* we are moving clock to DT, we should move the data to DT as well -
> > >
> > Further, maintaining dts vs kernel code compatibility aside, consider
> > adding new platforms - more code containing clock data that we have to
> > carry on in kernel - If we have !
> > 
> > I love the idea that Roger's patch does, as a *step #1* of
> > transitioning clock data out-of-kernel image and enabling drivers to
> > entitle DT based boot.
> > 
> > if this is the only step we will ever take, then it will be a
> > disappointing decision. whether the final data goes to /lib/firmware
> > or arch/arm/boot/dts - even though, I prefer it in dts, I have no
> > strong feelings about it.
> > However, we need to be prepared (at the earliest possible time) to
> > move that data out of kernel image as *step #2*.
> 
> Yes agreed, Roger's approach is a good first step. It just needs to
> be a proper device driver under drivers/clock/omap. Also note that
> the /lib/firmware part is an additional step to the DT defined clocks,
> but might actually make it easier to implement various PM related bits
> than trying to map them as DT properties.

on the first step angle,
Applying current approach that Roger has taken:
Benoit's tree:
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
for_3.10/dts  d114294 ARM: dts: AM33XX: Corrects typo in interrupt field in SPI node
+:
https://patchwork.kernel.org/patch/2312211/
https://patchwork.kernel.org/patch/2335671/
And the diff below[1] as replacement for this patch - does indeed work on
PandaBoard. Now the question is which direction should I take - will
wait on decision in https://lkml.org/lkml/2013/4/5/173 thread.
I have similar issues: clock alias is a mess of a code to cleanup and keep alive
for mpu dplls - I have posted on this mail thread various variants of trying to
do this - there is no simple solution.

If we cannot go any further, we are essentially stalled on moving
cpufreq (OPP entries along with it, regulators, voltage ....) to device
tree.

[1]
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index cccf39a..1fddb1e 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -21,6 +21,8 @@
 				800000  1313000
 				1008000 1375000
 			>;
+			clocks = <&clks 6>;
+			clock-names = "cpu";
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index afa509a..5b147ef 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -49,6 +49,11 @@ static void __init omap_generic_init(void)
 		omap4_panda_display_init_of();
 	else if (of_machine_is_compatible("ti,omap4-sdp"))
 		omap_4430sdp_display_init_of();
+
+	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
+		struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+		platform_device_register_full(&devinfo);
+	}
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index a93617b..54530d0 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1675,6 +1675,7 @@ static struct clk *dt_clks[] = {
 	&auxclk3_ck,
 	&auxclk4_ck,
 	&auxclk5_ck,
+	&dpll_mpu_ck,
 };
 
 static struct clk_onecell_data clock_data;
-- 
Regards,
Nishanth Menon
