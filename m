From: "Anna, Suman" <s-anna@ti.com>
Subject: RE: [PATCH 2/2] ARM: OMAP4+: Add a timer attribute for timers that
 can interrupt IPU
Date: Thu, 18 Apr 2013 18:21:22 +0000
Message-ID: <37C860A02101E749A747FA2D3C1E3C504A50ED@DLEE11.ent.ti.com>
References: <1366241008-53572-1-git-send-email-s-anna@ti.com>
 <516F388C.2050708@ti.com> <516F3CFB.8000708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52164 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab3DRSVY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 14:21:24 -0400
In-Reply-To: <516F3CFB.8000708@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jon,

> 
> On 04/17/2013 07:04 PM, Jon Hunter wrote:
> >
> > On 04/17/2013 06:23 PM, Suman Anna wrote:
> >> Some instances of the DMTIMER peripheral on OMAP4+ devices have the
> >> ability to interrupt the on-chip image processor unit (IPU) subsystem
> >> (a common name for the dual Cortex-M3 subsystem on OMAP4 or the dual
> >> Cortex-M4 subsystem on OMAP5) in addition to the ARM CPU. Add a
> >> DMTIMER attribute to indicate which timers can interrupt the IPU.
> >>
> >> This patch is similar to the patch, 5c3e4ec (ARM: OMAP: Add a timer
> >> attribute for timers that can interrupt the DSP) that adds a similar
> >> capability for DSP.
> >>
> >> DMTIMERs that have the ability to interrupt the IPU on OMAP devices
> >> are as follows:
> >>     OMAP1/2/3 devices : not applicable
> >>     OMAP4/5 devices   : DMTIMERs 3,4,9 & 11
> >>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> ---
> >>  Documentation/devicetree/bindings/arm/omap/timer.txt |  3 +++
> >>  arch/arm/boot/dts/omap4.dtsi                         |  4 ++++
> >>  arch/arm/boot/dts/omap5.dtsi                         |  4 ++++
> >>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c           | 16
> ++++++++++++++--
> >>  arch/arm/plat-omap/dmtimer.c                         |  2 ++
> >>  arch/arm/plat-omap/include/plat/dmtimer.h            |  1 +
> >>  6 files changed, 28 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt
> >> b/Documentation/devicetree/bindings/arm/omap/timer.txt
> >> index 8732d4d..edaf664 100644
> >> --- a/Documentation/devicetree/bindings/arm/omap/timer.txt
> >> +++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
> >> @@ -15,6 +15,9 @@ Optional properties:
> >>  - ti,timer-alwon:	Indicates the timer is in an alway-on power domain.
> >>  - ti,timer-dsp:		Indicates the timer can interrupt the on-chip DSP
> in
> >>  			addition to the ARM CPU.
> >> +- ti,timer-ipu:		Indicates the timer can interrupt the on-chip IPU
> (the
> >> +			dual Cortex-M3/Cortex-M4 subsystem on
> OMAP4/OMAP5) in
> >> +			addition to the ARM CPU.
> >
> > I am ok with adding a new property. However, reading the omap5
> > reference manual I see that the timers can interrupt the dsp, c2c and ipu.
> > Therefore, I am not sure if we should consider making this a property
> > with a value that is a mask of all other devices that can be
> > interrupted. For example, "ti,timer-irqs".

Do you intend for this to be only a DT entry simplification, but re-use the capability element in struct omap_dm_timer when parsing it and storing it? That might be ok since the capability property is already a bit-mask.  If the intention is to add another element/property, then I feel it may not add that much value. 

> >
> >>  - ti,timer-pwm: 	Indicates the timer can generate a PWM output.
> >>  - ti,timer-secure: 	Indicates the timer is reserved on a secure OMAP device
> >>  			and therefore cannot be used by the kernel.
> >> diff --git a/arch/arm/boot/dts/omap4.dtsi
> >> b/arch/arm/boot/dts/omap4.dtsi index 739bb79..55c633a 100644
> >> --- a/arch/arm/boot/dts/omap4.dtsi
> >> +++ b/arch/arm/boot/dts/omap4.dtsi
> >> @@ -460,6 +460,7 @@
> >>  			reg = <0x48034000 0x80>;
> >>  			interrupts = <0 39 0x4>;
> >>  			ti,hwmods = "timer3";
> >> +			ti,timer-ipu;
> >>  		};
> >>
> >>  		timer4: timer@48036000 {
> >> @@ -467,6 +468,7 @@
> >>  			reg = <0x48036000 0x80>;
> >>  			interrupts = <0 40 0x4>;
> >>  			ti,hwmods = "timer4";
> >> +			ti,timer-ipu;
> >>  		};
> >>
> >>  		timer5: timer@40138000 {
> >> @@ -511,6 +513,7 @@
> >>  			reg = <0x4803e000 0x80>;
> >>  			interrupts = <0 45 0x4>;
> >>  			ti,hwmods = "timer9";
> >> +			ti,timer-ipu;
> >>  			ti,timer-pwm;
> >>  		};
> >>
> >> @@ -527,6 +530,7 @@
> >>  			reg = <0x48088000 0x80>;
> >>  			interrupts = <0 47 0x4>;
> >>  			ti,hwmods = "timer11";
> >> +			ti,timer-ipu;
> >>  			ti,timer-pwm;
> >>  		};
> >>  	};
> >> diff --git a/arch/arm/boot/dts/omap5.dtsi
> >> b/arch/arm/boot/dts/omap5.dtsi index 0d155f5..c9ecdbe 100644
> >> --- a/arch/arm/boot/dts/omap5.dtsi
> >> +++ b/arch/arm/boot/dts/omap5.dtsi
> >> @@ -406,6 +406,7 @@
> >>  			reg = <0x48034000 0x80>;
> >>  			interrupts = <0 39 0x4>;
> >>  			ti,hwmods = "timer3";
> >> +			ti,timer-ipu;
> >>  		};
> >>
> >>  		timer4: timer@48036000 {
> >> @@ -413,6 +414,7 @@
> >>  			reg = <0x48036000 0x80>;
> >>  			interrupts = <0 40 0x4>;
> >>  			ti,hwmods = "timer4";
> >> +			ti,timer-ipu;
> >>  		};
> >>
> >>  		timer5: timer@40138000 {
> >> @@ -459,6 +461,7 @@
> >>  			reg = <0x4803e000 0x80>;
> >>  			interrupts = <0 45 0x4>;
> >>  			ti,hwmods = "timer9";
> >> +			ti,timer-ipu;
> >>  			ti,timer-pwm;
> >>  		};
> >>
> >> @@ -475,6 +478,7 @@
> >>  			reg = <0x48088000 0x80>;
> >>  			interrupts = <0 47 0x4>;
> >>  			ti,hwmods = "timer11";
> >> +			ti,timer-ipu;
> >>  			ti,timer-pwm;
> >>  		};
> >>
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> index 9e05765..f57796b 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> @@ -3150,6 +3150,16 @@ static struct omap_timer_capability_dev_attr
> capability_dsp_pwm_dev_attr = {
> >>  	.timer_capability       = OMAP_TIMER_HAS_DSP_IRQ |
> OMAP_TIMER_HAS_PWM,
> >>  };
> >>
> >> +/* timers with IPU interrupt dev attribute */ static struct
> >> +omap_timer_capability_dev_attr capability_ipu_dev_attr = {
> >> +	.timer_capability       = OMAP_TIMER_HAS_IPU_IRQ,
> >> +};
> >> +
> >> +/* pwm timers with IPU interrupt dev attribute */ static struct
> >> +omap_timer_capability_dev_attr capability_ipu_pwm_dev_attr = {
> >> +	.timer_capability       = OMAP_TIMER_HAS_IPU_IRQ |
> OMAP_TIMER_HAS_PWM,
> >> +};
> >> +
> >>  /* timer1 */
> >>  static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] = {
> >>  	{ .irq = 37 + OMAP44XX_IRQ_GIC_START }, @@ -3214,6 +3224,7 @@
> >> static struct omap_hwmod omap44xx_timer3_hwmod = {
> >>  			.modulemode   = MODULEMODE_SWCTRL,
> >>  		},
> >>  	},
> >> +	.dev_attr	= &capability_ipu_dev_attr,
> >>  };
> >>
> >>  /* timer4 */
> >> @@ -3235,6 +3246,7 @@ static struct omap_hwmod
> omap44xx_timer4_hwmod = {
> >>  			.modulemode   = MODULEMODE_SWCTRL,
> >>  		},
> >>  	},
> >> +	.dev_attr	= &capability_ipu_dev_attr,
> >>  };
> >>
> >>  /* timer5 */
> >> @@ -3344,7 +3356,7 @@ static struct omap_hwmod
> omap44xx_timer9_hwmod = {
> >>  			.modulemode   = MODULEMODE_SWCTRL,
> >>  		},
> >>  	},
> >> -	.dev_attr	= &capability_pwm_dev_attr,
> >> +	.dev_attr	= &capability_ipu_pwm_dev_attr,
> >>  };
> >>
> >>  /* timer10 */
> >> @@ -3389,7 +3401,7 @@ static struct omap_hwmod
> omap44xx_timer11_hwmod = {
> >>  			.modulemode   = MODULEMODE_SWCTRL,
> >>  		},
> >>  	},
> >> -	.dev_attr	= &capability_pwm_dev_attr,
> >> +	.dev_attr	= &capability_ipu_pwm_dev_attr,
> >>  };
> >>
> >>  /*
> >> diff --git a/arch/arm/plat-omap/dmtimer.c
> >> b/arch/arm/plat-omap/dmtimer.c index a0daa2f..b97bd6a 100644
> >> --- a/arch/arm/plat-omap/dmtimer.c
> >> +++ b/arch/arm/plat-omap/dmtimer.c
> >> @@ -817,6 +817,8 @@ static int omap_dm_timer_probe(struct
> platform_device *pdev)
> >>  			timer->capability |= OMAP_TIMER_ALWON;
> >>  		if (of_find_property(dev->of_node, "ti,timer-dsp", NULL))
> >>  			timer->capability |= OMAP_TIMER_HAS_DSP_IRQ;
> >> +		if (of_find_property(dev->of_node, "ti,timer-ipu", NULL))
> >> +			timer->capability |= OMAP_TIMER_HAS_IPU_IRQ;
> >>  		if (of_find_property(dev->of_node, "ti,timer-pwm", NULL))
> >>  			timer->capability |= OMAP_TIMER_HAS_PWM;
> >>  		if (of_find_property(dev->of_node, "ti,timer-secure", NULL)) diff
> >> --git a/arch/arm/plat-omap/include/plat/dmtimer.h
> >> b/arch/arm/plat-omap/include/plat/dmtimer.h
> >> index a3fbc48..4bbc72d 100644
> >> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> >> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> >> @@ -64,6 +64,7 @@
> >>  #define OMAP_TIMER_HAS_PWM				0x20000000
> >>  #define OMAP_TIMER_NEEDS_RESET
> 	0x10000000
> >>  #define OMAP_TIMER_HAS_DSP_IRQ
> 	0x08000000
> >> +#define OMAP_TIMER_HAS_IPU_IRQ
> 	0x04000000
> >>
> >>  /*
> >>   * timer errata flags
> >
> > You also need to update arch/arm/mach-omap2/timer.c if you are adding
> > a new property. See [1].
> >
> > [1]
> > http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/comm
> > it/?h=omap-for-
> v3.10/timer&id=2eb03937df3ebc822dab413bd69533dcd66afd48

Thanks, I will rebase the patch on the omap-for-v3.10/timer branch instead of the omap-for-v3.10/dt branch, on which I have created this patch.

Regards
Suman

> 
> Thinking about this some more, I should have added a
> omap_dmtimer_get_properties_dt() that returns the timer properties from
> device-tree and then there would be a single place for adding new properties. So
> if we add another property probably a good time to add such a helper function.
> 
> Cheers
> Jon
