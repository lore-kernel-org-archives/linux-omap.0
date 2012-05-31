From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 19/19] ARM: OMAP4: powerdomain: update mpu / core off
 counters during device off
Date: Thu, 31 May 2012 09:50:21 +0300
Message-ID: <1338447021.8834.161.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-20-git-send-email-t-kristo@ti.com>
	 <CAOMWX4fV_UEOuUi3M0yT5QfyunAw7Gf85LoXOP2DquQzv=rB6w@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40517 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab2EaGu3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 02:50:29 -0400
In-Reply-To: <CAOMWX4fV_UEOuUi3M0yT5QfyunAw7Gf85LoXOP2DquQzv=rB6w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-05-30 at 16:08 -0500, Menon, Nishanth wrote:
> On Mon, May 14, 2012 at 5:18 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > Currently device off does not have any counters / timers of its own
> > and it is impossible to track the time spent in this state. In device
> > off, MPU / CORE powerdomains enter OSWR, so normally the RETENTION
> > state times / counts are increased during device off.
> >
> > This patch adds a new field to the powerdomain struct for context loss
> > register, which is checked during pwrdm_post_transition to see if
> > a device off type context loss has happened. If this is the case,
> > the counters + timers for OFF state are touched instead of RETENTION.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap-mpuss-lowpower.c   |    1 -
> >  arch/arm/mach-omap2/powerdomain.c           |    9 +++++++++
> >  arch/arm/mach-omap2/powerdomain.h           |    2 ++
> >  arch/arm/mach-omap2/powerdomains44xx_data.c |    2 ++
> >  arch/arm/mach-omap2/prm44xx.c               |   15 +++++++++++++++
> >  arch/arm/mach-omap2/prm44xx.h               |    2 ++
> >  6 files changed, 30 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> > index 1f06f97..f187025 100644
> > --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> > +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> > @@ -404,7 +404,6 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
> >        if (omap4_device_prev_state_off()) {
> >                omap4_dpll_resume_off();
> >                omap4_cm_resume_off();
> > -               omap4_device_clear_prev_off_state();
> 
> We should probably delete the function in it's entirety - not just the
> call - the original implementation just clears L3 and this
> implementation seems superior.

Yeah, that can be done, I don't think it is used anymore after this
change.

> 
> >        }
> >
> >  sar_save_failed:
> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> > index 96ad3dbe..f13bb2c 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -156,6 +156,15 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
> >                break;
> >        case PWRDM_STATE_PREV:
> >                prev = pwrdm_read_prev_pwrst(pwrdm);
> > +
> > +               /*
> > +                * If powerdomain has context offset defined, check if
> > +                * the domain has lost context (i.e. entered off)
> > +                */
> > +               if (pwrdm->context_offs)
> > +                       if (omap4_pwrdm_lost_context_rff(pwrdm->prcm_offs,
> > +                                                        pwrdm->context_offs))
> 
> We should wrap this under pwrdm_lost_context(pwrdm)
> pwrdm_lost_context should call the arch_pwrdm->lost_context_rff as
> needed? the rest of the powerdomain.c does not use OMAP4 specific
> APIs.

Yes, that sounds like a good change, I'll change this.

> 
> 
> > +                               prev = PWRDM_POWER_OFF;
> >                if (pwrdm->state != prev)
> >                        pwrdm->state_counter[prev]++;
> >                if (prev == PWRDM_POWER_RET)
> > diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> > index 0d72a8a..a427645 100644
> > --- a/arch/arm/mach-omap2/powerdomain.h
> > +++ b/arch/arm/mach-omap2/powerdomain.h
> > @@ -82,6 +82,7 @@ struct powerdomain;
> >  * @name: Powerdomain name
> >  * @voltdm: voltagedomain containing this powerdomain
> >  * @prcm_offs: the address offset from CM_BASE/PRM_BASE
> > + * @context_offs: the address offset for the CONTEXT register
> >  * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs
> >  * @pwrsts: Possible powerdomain power states
> >  * @pwrsts_logic_ret: Possible logic power states when pwrdm in RETENTION
> > @@ -106,6 +107,7 @@ struct powerdomain {
> >                struct voltagedomain *ptr;
> >        } voltdm;
> >        const s16 prcm_offs;
> > +       const s16 context_offs;
> >        const u8 pwrsts;
> >        const u8 pwrsts_logic_ret;
> >        const u8 flags;
> > diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
> > index d8701ce..c4de02f 100644
> > --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> > +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> > @@ -36,6 +36,7 @@ static struct powerdomain core_44xx_pwrdm = {
> >        .voltdm           = { .name = "core" },
> >        .prcm_offs        = OMAP4430_PRM_CORE_INST,
> >        .prcm_partition   = OMAP4430_PRM_PARTITION,
> > +       .context_offs     = OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET,
> >        .pwrsts           = PWRSTS_RET_ON,
> >        .pwrsts_logic_ret = PWRSTS_OFF_RET,
> >        .banks            = 5,
> > @@ -205,6 +206,7 @@ static struct powerdomain mpu_44xx_pwrdm = {
> >        .voltdm           = { .name = "mpu" },
> >        .prcm_offs        = OMAP4430_PRM_MPU_INST,
> >        .prcm_partition   = OMAP4430_PRM_PARTITION,
> > +       .context_offs     = OMAP4_RM_MPU_MPU_CONTEXT_OFFSET,
> >        .pwrsts           = PWRSTS_RET_ON,
> >        .pwrsts_logic_ret = PWRSTS_OFF_RET,
> >        .banks            = 3,
> 
> Why are we not populating the rest of the CONTEXT_OFFSET registers?

Well, the thing is, other domains don't have any 'spare' context
registers that are not needed by anything else. Like, all the per domain
context registers are used by some hwmod. If we grab the register for
this use, then the context lost count for that hwmod will break.

For PER domain, it might be possible to use RM_L4PER_L4_PER_CONTEXT
though (it has two bit positions), but that is the only one missing...
Other domains do go to OFF. L3_init domain doesn't have anything.

> 
> > diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> > index 86c6c6b..de9132f 100644
> > --- a/arch/arm/mach-omap2/prm44xx.c
> > +++ b/arch/arm/mach-omap2/prm44xx.c
> > @@ -289,6 +289,21 @@ static void __init omap44xx_prm_enable_io_wakeup(void)
> >                        OMAP4_PRM_IO_PMCTRL_OFFSET);
> >  }
> >
> > +bool omap4_pwrdm_lost_context_rff(s16 inst, s16 offset)
> > +{
> > +       u32 val;
> > +
> > +       val = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, inst, offset);
> > +
> > +       if (val & OMAP4430_LOSTCONTEXT_RFF_MASK) {
> > +               omap4_prminst_write_inst_reg(val, OMAP4430_PRM_PARTITION, inst,
> > +                                            offset);
> > +               return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> 
> could move to powerdomain4xx.c?

Yes, I'll do that.

-Tero

> 
> >  /**
> >  * omap4_device_set_state_off() - setup device off state
> >  * @enable:    set to off or not.
> > diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
> > index ee72ae6..fa76d9c 100644
> > --- a/arch/arm/mach-omap2/prm44xx.h
> > +++ b/arch/arm/mach-omap2/prm44xx.h
> > @@ -771,6 +771,8 @@ extern void omap44xx_prm_ocp_barrier(void);
> >  extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
> >  extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
> >
> > +extern bool omap4_pwrdm_lost_context_rff(s16 inst, s16 offset);
> we dont need to do this if we use arch_pwrdm->
> > +
> >  # endif
> >
> >  #endif
> 
> ---
> Regards,
> Nishanth Menon


