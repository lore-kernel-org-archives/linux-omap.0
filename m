From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: RE: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF,
	reduces OFF latency by 20ms
Date: Wed, 17 Jun 2009 15:47:50 +0300
Message-ID: <1245242870.6847.161.camel@ubuntu>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305A541E6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:42622 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbZFQMrb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2009 08:47:31 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305A541E6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

On Wed, 2009-06-17 at 15:38 +0300, Nayak, Rajendra wrote:
> 
> >-----Original Message-----
> >From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com] 
> >Sent: Wednesday, June 17, 2009 3:56 PM
> >To: Nayak, Rajendra
> >Cc: linux-omap@vger.kernel.org; Derrick, David; Woodruff, Richard
> >Subject: RE: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle 
> >before OFF, reduces OFF latency by 20ms
> >
> >On Wed, 2009-06-17 at 12:50 +0300, Nayak, Rajendra wrote:
> >> >-----Original Message-----
> >> >From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com] 
> >> >Sent: Wednesday, June 17, 2009 1:17 PM
> >> >To: Nayak, Rajendra
> >> >Cc: linux-omap@vger.kernel.org; Derrick, David; Woodruff, Richard
> >> >Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle 
> >> >before OFF, reduces OFF latency by 20ms
> >> >
> >> >Hi Rajendra,
> >> >
> >> >On Tue, 2009-06-16 at 14:52 +0300, Rajendra Nayak wrote:
> >> >> If autoidle for DPLL4 is enabled in the stored scratchpad
> >> >> value of CM_AUTOIDLE_PLL then there is an added delay by
> >> >> the boot ROM when coming out of OFF mode.
> >> >> The patch disables this bitfield in the stored scratchpad value.
> >> >> 
> >> >> This should significantly reduce CORE OFF latency and also
> >> >> bring down the threshold for CORE OFF, making OFF affordable
> >> >> even with smaller sleep times.
> >> >
> >> >I did some measurements on RX-51 with this patch, and it 
> >seems it does
> >> >not reduce latency, it increases it by few hundred us.
> >> >
> >> >Servicing an empty timer interrupt from off mode (measured from VDD1
> >> >ramp up to start of VDD1 ramp down):
> >> >
> >> >with dpll4 patch : ~14100us
> >> >without patch    : ~13600us
> >> >
> >> >I attached pictures of both situations.
> >> >
> >> >My kernel had only C7 state enabled.
> >> >
> >> >Have you measured the latency effects on SDP or some other board?
> >> 
> >> I haven't done the latency measurements on SDP yet, but 
> >David had done it
> >> sometime back, using a different codebase though.
> >
> >OK, I also used our internal code base. Though the PM functionality is
> >pretty much the same as in l-o:pm branch.
> >
> >> 
> >> Can you explain more on how you are measuring the latency 
> >here, I am a bit
> >> confused. This is supposed to bring down the OFF wakeup 
> >latency, the sleep latency
> >> remains the same.
> >
> >I'm doing a timer interrupt periodically. Servicing that timer 
> >interrupt
> >takes the same amount of time every time. What varies (with the patch)
> >is the transition times from off to active and back to off.
> >
> >In the pictures the top graph shows current and bottom graph shows the
> >VDD1 and VDD2 voltages. I zoomed from the pictures the interval from
> >when VDD1 goes up, to the point when it starts to go down again.
> >
> >So I measured: wakeup latency + interrupt service + sleep latency.
> 
> Is the boot ROM different on the OMAP devices on nokia h/w or is it
> the same as that on the SDP?

I have heard that our ROM version would be somehow older version, but I
really don't have any facts on that matter.

- Kalle

> 
> >
> >- Kalle
> >
> >> 
> >> >
> >> >- Kalle
> >> >
> >> >
> >> >> This patch however does not optimize the C state threshold for
> >> >> CORE OFF states based on the new latency.
> >> >> 
> >> >> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> >> ---
> >> >>  arch/arm/mach-omap2/control.c |    7 +++++++
> >> >>  1 files changed, 7 insertions(+), 0 deletions(-)
> >> >> 
> >> >> diff --git a/arch/arm/mach-omap2/control.c 
> >> >b/arch/arm/mach-omap2/control.c
> >> >> index c9407c0..a7159a9 100644
> >> >> --- a/arch/arm/mach-omap2/control.c
> >> >> +++ b/arch/arm/mach-omap2/control.c
> >> >> @@ -238,6 +238,13 @@ void omap3_save_scratchpad_contents(void)
> >> >>  			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
> >> >>  	prcm_block_contents.cm_autoidle_pll =
> >> >>  			cm_read_mod_reg(PLL_MOD, 
> >> >OMAP3430_CM_AUTOIDLE_PLL);
> >> >> +	/*
> >> >> +	 * ROM restore takes 20mS longer if PER idle is enabled 
> >> >before OFF.
> >> >> +	 * Clear feature before sleep. The origional idle state is
> >> >> +	 * restored by software as part of wake procedure.
> >> >> +	 */
> >> >> +	prcm_block_contents.cm_autoidle_pll &= 
> >> >~OMAP3430_AUTO_PERIPH_DPLL_MASK;
> >> >> +
> >> >>  	prcm_block_contents.cm_clksel1_pll =
> >> >>  			cm_read_mod_reg(PLL_MOD, 
> >> >OMAP3430_CM_CLKSEL1_PLL);
> >> >>  	prcm_block_contents.cm_clksel2_pll =
> >> >
> >
> >
> >

