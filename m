From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v6 3/7] omap3: pm: re-programing the setup time based on CORE_DOMAIN target state
Date: Fri, 4 Jun 2010 13:18:42 +0530
Message-ID: <007501cb03ba$5bbd3cc0$e08818ac@apr.dhcp.ti.com>
References: <1274186129-23928-1-git-send-email-leslyam@ti.com> <8739x4vwrn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51734 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665Ab0FDHsy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jun 2010 03:48:54 -0400
In-Reply-To: <8739x4vwrn.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, 'Lesly A M' <x0080970@ti.com>, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, June 03, 2010 11:12 PM
> To: Lesly A M
> Cc: linux-omap@vger.kernel.org; Lesly A M; Nishanth Menon; David Derrick;
> Samuel Ortiz
> Subject: Re: [PATCH v6 3/7] omap3: pm: re-programing the setup time based
> on CORE_DOMAIN target state
> 
> Lesly A M <leslyam@ti.com> writes:
> 
> > This patch will add a new function omap_voltage_vc_update() to re-
> program
> > the VC parameters while entering low power mode, based on CORE_DOMAIN
> target state.
> > The voltsetup2 is used only when the device exits sys_off mode
> > (with PRM_VOLTCTRL[3]SEL_OFF set to 1).
> >
> > Also removed the clearing of PRM_VOLTCTRL register bits, because this
> will be
> > used only when it goes to low power mode next time.
> >
> > Signed-off-by: Lesly A M <x0080970@ti.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: David Derrick <dderrick@ti.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> 
> Again, issues from previous review[1] re-appear again.
> 
> For the record, when a series is posted multiple times and issues
> raised in previous reviews continue to appear, you should expect
> maintainers to pay less and less attention to the series.  I for one
> have an attention span that grows very short when I repeatedly see the
> same issues re-posted.
> 
> The comment below are ones I already raised in v5[1].
> 
> > ---
> >  arch/arm/mach-omap2/pm34xx.c  |   26 +++-----------------------
> >  arch/arm/mach-omap2/voltage.c |   41
> +++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/voltage.h |    1 +
> >  3 files changed, 45 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index 5039b35..1ff6293 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -439,20 +439,12 @@ void omap_sram_idle(void)
> >  	if (core_next_state < PWRDM_POWER_ON) {
> >  		omap_uart_prepare_idle(0);
> >  		omap_uart_prepare_idle(1);
> > -		if (core_next_state == PWRDM_POWER_OFF) {
> > -			u32 voltctrl = OMAP3430_AUTO_OFF;
> > +		/* Update the voltsetup time for RET/OFF */
> > +		omap_voltage_vc_update(core_next_state);
> >
> > -			if (voltage_off_while_idle)
> > -				voltctrl |= OMAP3430_SEL_OFF;
> > -			prm_set_mod_reg_bits(voltctrl,
> > -					     OMAP3430_GR_MOD,
> > -					     OMAP3_PRM_VOLTCTRL_OFFSET);
> > +		if (core_next_state == PWRDM_POWER_OFF) {
> >  			omap3_core_save_context();
> >  			omap3_prcm_save_context();
> > -		} else if (core_next_state == PWRDM_POWER_RET) {
> > -			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
> > -						OMAP3430_GR_MOD,
> > -						OMAP3_PRM_VOLTCTRL_OFFSET);
> >  		}
> >  	}
> 
> OK, the in the idle path, you replace the various VC settings with a
> call into the voltage layer.  Good.  But...
> 
> > @@ -510,18 +502,6 @@ void omap_sram_idle(void)
> >  		}
> >  		omap_uart_resume_idle(0);
> >  		omap_uart_resume_idle(1);
> > -		if (core_next_state == PWRDM_POWER_OFF) {
> > -			u32 voltctrl = OMAP3430_AUTO_OFF;
> > -
> > -			if (voltage_off_while_idle)
> > -				voltctrl |= OMAP3430_SEL_OFF;
> > -			prm_clear_mod_reg_bits(voltctrl,
> > -					       OMAP3430_GR_MOD,
> > -					       OMAP3_PRM_VOLTCTRL_OFFSET);
> > -		} else if (core_next_state == PWRDM_POWER_RET)
> > -			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
> > -						OMAP3430_GR_MOD,
> > -						OMAP3_PRM_VOLTCTRL_OFFSET);
> 
> ...in the resume path, this entire part is removed, but with
> replacement call into the voltage layer.  This needs to be well
> documented in the changelog as to why this is not needed.

The comment for removing this part is already there in the changelog:
****
> > Also removed the clearing of PRM_VOLTCTRL register bits, because this
> will be
> > used only when it goes to low power mode next time.
****

OK, I will add more detail in next ver.

> 
> Even better, if this part is really unnecessary, which by your patch
> you seem to imply, you should send a separate patch removing it with a
> good description.
> 
> Kevin

I think, it will be good if the changes are in same patch, with some more
good explanation.

Regards
Lesly A M

> 
> [1] http://marc.info/?l=linux-omap&m=127249508726287&w=2

