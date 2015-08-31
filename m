From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Mon, 31 Aug 2015 15:51:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1508121700500.7154@utopia.booyaka.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com> <1433332284-10766-3-git-send-email-vigneshr@ti.com> <alpine.DEB.2.02.1507152029460.32764@utopia.booyaka.com> <55A7CE59.6010600@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <55A7CE59.6010600@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "R, Vignesh" <vigneshr@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On Thu, 16 Jul 2015, R, Vignesh wrote:

> On 07/16/2015 03:24 AM, Paul Walmsley wrote:
> > 
> > On Wed, 3 Jun 2015, Vignesh R wrote:
> > 
> >> Add hwmod entries for the PWMSS on DRA7.
> >>
> >> Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
> >> equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
> >> As per AM57x TRM SPRUHZ6[1], October 2014, Section 29.1.3 Table 29-4,
> >> clock source to PWMSS is L4PER2_L3_GICLK. But it is actually
> >> L4PER2_L3_GICLK/2. The TRM does not show the division by 2.
> > 
> > Is the divide-by-two coming from PWMSS_EPWM.EPWM_TBCTL[HSPCLKDIV]?  Or is 
> > HSPCLKDIV a separate divider after the divide-by-2 you mention above?
> 
> No, it not related to HSPCLKDIV. The TRM wrongly states L4PER2_L3_GICLK
> as clock input for PWMSS. But actually  L4PER2_L4_GICLK(=L3_GICLK/2) is
> the clock input for PWMSS. This will be updated in TRM soon.

OK

> >> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> >> @@ -362,6 +362,149 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
> >>  	},
> >>  };
> >>  
> >> +/* pwmss  */
> >> +static struct omap_hwmod_class_sysconfig dra7xx_epwmss_sysc = {
> >> +	.rev_offs	= 0x0,
> >> +	.sysc_offs	= 0x4,
> >> +	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_RESET_STATUS,
> > 
> > This doesn't match SPRUHZ6 Table 29-13 "PWMSS_SYSCONFIG".  There's no 
> > RESETSTATUS bit.  There is a SOFTRESET bit. 
> > 
> > Could you please confirm whether this is intentional?
> 
> sorry my bad... I will change this in v3.

OK

> >> +/* ecap0 */
> >> +struct omap_hwmod dra7xx_ecap0_hwmod = {
> >> +	.name		= "ecap0",
> >> +	.class		= &dra7xx_ecap_hwmod_class,
> >> +	.clkdm_name	= "l4per2_clkdm",
> >> +	.main_clk	= "l4_root_clk_div",
> > 
> > Looking at SPRUHZ6 Section 29.1.4.2 "PWMSS Modules Local Clock Gating", 
> > there appears to be a local "mini-PRCM" for the PWMSS which implements 
> > clock gating and reports back on the status of what I'd guess is the local 
> > clock gating FSM.
> > 
> > So from that point of view, you should probably create a clock driver that 
> > manages both the clock gate request bit and the FSM status bit.  It should 
> > be something that can be reused for the other PWMSS IP blocks.  Then 
> > you'd create per-IP block clock nodes and set the main_clk to point to 
> > that node.
> 
> Since, this register is within the config space of PWMSS, the individual
> gating and reporting for the modules within PWMSS
> (PWMSS_CLKCONFIG) is currently being taken care by pwm-tipwmss.c(almost
> the sole function this driver is doing). It has been the same since
> am335x. Adding new clock nodes will result in driver changes and also
> changes to am335x, am437x (and other platforms) hwmod files. It also
> involves adding new nodes to clocks.dtsi and it will be difficult to
> maintain backward compatibility for older platforms. Is it not better to
> keep this as is, in order to maintain consistency (with am335x, am437x
> etc) and also that these clock bits are within IP's config space?

It's certainly possible that we as maintainers didn't look closely enough 
at the AM33xx data for the PWMSS when we merged it.  But if that's 
incorrect too, then now is the time to fix this.  Otherwise it will never 
get fixed, since each new group of people patching this code will keep 
punting it off to the indeterminate future.

In terms of hwmod data: based on the register maps in sections 29.4.3, 
29.3.3, and 29.2.3 of SPRUHZ6, none of these subdevices are hwmod devices.  
They don't support the Highlander OCP registers, they have no individual 
PRCM registers or register bitfields, and all of the idle and status 
reporting is to the PWMSS top-level IP block itself.  So it looks to me 
like the eCAP, eQEP, and ePWM modules should be registered via DT, rather 
than via hwmod.  It looks like you can get away with using the 
"simple-bus" abstraction, but you might ultimately have to define 
something custom here.  However, the PWMSS top level subsystem, described 
in section 29.1, does have the OCP registers, sideband signals, etc., and 
thus should remain a hwmod-registered device (via DT).

In terms of the clock data: based on section 29.1.4, section 29.1.5.2, 
figure 29-3, and table 29-4, there are several clock gating control bits.  
These should be modeled as clock nodes in the Linux common clock 
framework.  Furthermore these registers are located inside the PWMSS 
subsystem itself, and are only accessible when the PWMSS IP block is 
functional in a PM runtime point of view: i.e., when the block is mapped 
into memory space, clocked and out of reset, etc.  So the clock types for 
the PWMSS_CFG IP block should most likely be implemented in the PWMSS 
driver.  I think you'll still be able to define the clock node data itself 
in DT, but this will probably need a closer look.  Ideally, since the 
clock node register address data is the same for all three subsystem 
instances, one would be able to simply include a DT include file three 
times; but the DT binding data format may ultimately make this 
impractical.

In terms of the transition from the old approach to this approach, it ooks 
to me like the first thing to do would be to convert
drivers/pwm/pwm-tipwmss.c to define some clk_ops and register some clock
nodes with the CCF.  You've got the meat of the clock gating control code
there already.  Then the next thing to do would be to to get rid of
pwmss_submodule_state_change() and use
clk_{prepare,enable,disable,unprepare}*() in the drivers/pwm/pwm-ti*.c
subdrivers instead.  All of that looks like it should be possible to  
implement in a backwards-compatible way.  Then you'd convert the eCAP, 
eQEP, and ePWM code to probe as platform_devices, driven from a simple-bus 
or pwmss-bus or whatever in the DT data.  Naturally, the AM33xx/43xx data 
should be fixed also.  


- Paul
