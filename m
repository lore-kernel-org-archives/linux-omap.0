From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 6/7] 34XX: PM: Workaround for taking care of gpio clocks
Date: Thu, 26 Jun 2008 18:00:22 +0530
Message-ID: <021d01c8d788$682aab10$68bf18ac@ent.ti.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com><1214385231-25677-1-git-send-email-jouni.hogander@nokia.com><021601c8d783$7696c8a0$68bf18ac@ent.ti.com> <87od5oe6hu.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:55891 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239AbYFZMag convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 08:30:36 -0400
In-Reply-To: <87od5oe6hu.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?'=22H=C3=B6gander=22_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

=20

> -----Original Message-----
> From: "H=C3=B6gander" Jouni [mailto:jouni.hogander@nokia.com]=20
> Sent: Thursday, June 26, 2008 5:46 PM
> To: ext Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 6/7] 34XX: PM: Workaround for taking care=20
> of gpio clocks
>=20
> "ext Rajendra Nayak" <rnayak@ti.com> writes:
>=20
> > =20
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org=20
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of=20
> Jouni Hogander
> >> Sent: Wednesday, June 25, 2008 2:44 PM
> >> To: linux-omap@vger.kernel.org
> >> Subject: [PATCH 6/7] 34XX: PM: Workaround for taking care of=20
> >> gpio clocks
> >>=20
> >> In omap3 gpios 2-6 are in per domain. Clocks for these should be
> >> disabled. This patch is needed until gpio driver disables=20
> gpio clocks.
> >>=20
> >> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> >> ---
> >>  arch/arm/mach-omap2/pm34xx.c    |   15 +++++++-
> >>  arch/arm/mach-omap2/sleep34xx.S |   74=20
> >> +++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 87 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/arch/arm/mach-omap2/pm34xx.c=20
> >> b/arch/arm/mach-omap2/pm34xx.c
> >> index edde254..9c7b7be 100644
> >> --- a/arch/arm/mach-omap2/pm34xx.c
> >> +++ b/arch/arm/mach-omap2/pm34xx.c
> >> @@ -47,12 +47,19 @@ struct power_state {
> >> =20
> >>  static LIST_HEAD(pwrst_list);
> >> =20
> >> -void (*_omap_sram_idle)(u32 *addr, int save_state);
> >> +void (*_omap_sram_idle)(u32 *addr, int save_state, int=20
> >> disable_clocks);
> >> =20
> >>  static void (*saved_idle)(void);
> >> =20
> >>  static struct powerdomain *mpu_pwrdm;
> >> =20
> >> +/* XXX This is for gpio fclk hack. Will be removed as gpio driver
> >> + * handles fcks correctly */
> >> +static void gpio_fclk_mask(u32 *fclk)
> >> +{
> >> +	*fclk &=3D ~(0x1f << 13);
> >> +}
> >> +
> >>  /* PRCM Interrupt Handler for wakeups */
> >>  static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
> >>  {
> >> @@ -169,7 +176,7 @@ static void omap_sram_idle(void)
> >> =20
> >>  	omap2_gpio_prepare_for_retention();
> >> =20
> >> -	_omap_sram_idle(NULL, save_state);
> >> +	_omap_sram_idle(NULL, save_state, clocks_off_while_idle);
> >> =20
> >>  	omap2_gpio_resume_after_retention();
> >>  }
> >> @@ -197,6 +204,10 @@ static int omap3_fclks_active(void)
> >>  				  CM_FCLKEN);
> >>  	fck_per =3D cm_read_mod_reg(OMAP3430_PER_MOD,
> >>  				  CM_FCLKEN);
> >> +
> >> +	if (clocks_off_while_idle)
> >> +		gpio_fclk_mask(&fck_per);
> >> +
> >>  	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
> >>  	    fck_cam | fck_per | fck_usbhost)
> >>  		return 1;
> >> diff --git a/arch/arm/mach-omap2/sleep34xx.S=20
> >> b/arch/arm/mach-omap2/sleep34xx.S
> >> index ebc7eb3..1f7009a 100644
> >> --- a/arch/arm/mach-omap2/sleep34xx.S
> >> +++ b/arch/arm/mach-omap2/sleep34xx.S
> >> @@ -32,6 +32,8 @@
> >> =20
> >>  #include "prm.h"
> >>  #include "sdrc.h"
> >> +#include "cm.h"
> >> +#include "cm-regbits-34xx.h"
> >> =20
> >>  #define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
> >>  				OMAP3430_PM_PREPWSTST)
> >> @@ -45,6 +47,15 @@
> >>  				SCRATCHPAD_MEM_OFFS)
> >>  #define SDRC_POWER_V	=09
> OMAP34XX_SDRC_REGADDR(SDRC_POWER)
> >> =20
> >> +/* XXX gpio fclk workaround */
> >> +#define CM_FCLKEN_PER_V	=09
> >> OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, \
> >> +				CM_FCLKEN)
> >> +#define CM_FCLKEN_PER_P		io_v2p(CM_FCLKEN_PER_V)
> >> +
> >> +#define GPIO_FCLK_MASK		OMAP3430_EN_GPIO6 |=20
> >> OMAP3430_EN_GPIO5 | \
> >> +				OMAP3430_EN_GPIO4 |=20
> >> OMAP3430_EN_GPIO3 | \
> >> +				OMAP3430_EN_GPIO2
> >> +
> >>  	.text
> >>  /* Function call to get the restore pointer for resume from OFF *=
/
> >>  ENTRY(get_restore_pointer)
> >> @@ -68,14 +79,41 @@ loop:
> >>  	/*b	loop*/	@Enable to debug by stepping through code
> >>  	/* r0 contains restore pointer in sdram */
> >>  	/* r1 contains information about saving context */
> >> +	/* r2 contains information whether clocks should be disabled */
> >>  	ldr     r4, sdrc_power          @ read the SDRC_POWER register
> >>  	ldr     r5, [r4]                @ read the contents of=20
> >> SDRC_POWER
> >>  	orr     r5, r5, #0x40           @ enable self refresh=20
> >> on idle req
> >>  	str     r5, [r4]                @ write back to=20
> >> SDRC_POWER register
> >> =20
> >> +	/* XXX gpio fclk workaround */
> >> +	/* Check if per fclken needs to be saved */
> >> +	cmp	r2, #0x0
> >> +	beq	skip_per_fclken_save
> >> +
> >> +	/* XXX gpio fclk workaround */
> >> +	/* Save current value of per fclken reg */
> >> +	ldr	r4, cm_fclken_per_v
> >> +	ldr	r5, [r4]
> >> +	str	r5, cm_fclken_per_val
> >> +skip_per_fclken_save:
> >> +
> >
> > Any reason why this is now done in SRAM?
>=20
> Because of the fact that gpios in per domain are not able to generate
> wakeup/interrupt if per domain is not active. We want to put per
> domain into sleep state as late as possible. IOPAD wakeup starts to
> work only after mpu enters its sleep state.
>=20

A much easiler way to do this is to put a sleep dep on MPU.

> >
> >>  	cmp	r1, #0x0
> >>  	/* If context save is required, do that and execute wfi */
> >>  	bne	save_context_wfi
> >
> > In case of OFF mode, clocks would never be disabled.
>=20
> Isn't it done below. I might be wrong because I haven't been able to
> test this with off mode.

No, it takes a complete different path from save_context_wfi and has a=20
different exit path as well.

>=20
> >
> >> +
> >> +	/* XXX gpio fclk workaround */
> >> +	/* Check if gpio clocks needs to be disabled */
> >> +	ldr	r5, cm_fclken_per_val
> >> +	cmp	r5, #0x0
> >> +	beq	skip_gpio_clk_disable
> >> +
> >> +	/* XXX gpio fclk workaround */
> >> +	/* Disable gpio clocks */
> >> +	ldr	r4, cm_fclken_per_v
> >> +	bic	r5, r5, #GPIO_FCLK_MASK
> >> +	str	r5, [r4]
> >> +skip_gpio_clk_disable:
> >
> > Even with clocks_off_while_idle set to 1, should'nt gpio=20
> clocks be cut and restored only=20
> > when a PER RET/OFF is attemted and not every time omap_sram_idle is
> > called?
>=20
> Where this would then happen if not in sram? I mean gpio clock contro=
l

The previous patches used to do it in per_gpio_clk_disable/enable(), si=
milar to the way=20
UART clocks are handled. That looked like a better aproach to me.

> is not in current gpio code and adding that into it needs huge
> effort. I'm not sure if it can be even handled there, because of this
> wakeup problem. Basically we have this need to keep per gpios active
> as long as possible, because after disabling their clocks they wont
> generate interrupts/wakeups until mpu is in ret or off mode.
>=20
> >
> >> +
> >>  	/* Data memory barrier and Data sync barrier */
> >>  	mov	r1, #0
> >>  	mcr	p15, 0, r1, c7, c10, 4
> >> @@ -93,6 +131,14 @@ loop:
> >>  	nop
> >>  	nop
> >>  	nop
> >> +
> >> +	/* XXX gpio fclk workaround */
> >> +	ldr	r5, cm_fclken_per_val
> >> +	cmp	r5, #0x0
> >> +	beq	skip_per_fclken_restore
> >> +	str	r5, [r4]
> >> +skip_per_fclken_restore:
> >> +
> >>  	bl i_dll_wait
> >> =20
> >>  	ldmfd	sp!, {r0-r12, pc}		@ restore regs=20
> >> and return
> >> @@ -483,6 +529,20 @@ finished:
> >>  	mcr     p15, 2, r10, c0, c0, 0
> >>  	isb
> >>  skip_l2_inval:
> >> +
> >> +	/* XXX gpio fclk workaround */
> >> +	/* Check if gpio clocks needs to be disabled */
> >> +	ldr	r5, cm_fclken_per_val
> >> +	cmp	r5, #0x0
> >> +	beq	skip_gpio_clk_disable_2
> >> +
> >> +	/* XXX gpio fclk workaround */
> >> +	/* Disable gpio clocks */
> >> +	ldr	r4, cm_fclken_per_p
> >> +	bic	r5, r5, #GPIO_FCLK_MASK
> >> +	str	r5, [r4]
> >> +skip_gpio_clk_disable_2:
> >> +
> >>  	/* Data memory barrier and Data sync barrier */
> >>  	mov     r1, #0
> >>  	mcr     p15, 0, r1, c7, c10, 4
> >> @@ -499,6 +559,14 @@ skip_l2_inval:
> >>  	nop
> >>  	nop
> >>  	nop
> >> +
> >> +	/* XXX gpio fclk workaround */
> >> +	ldr	r5, cm_fclken_per_val
> >> +	cmp	r5, #0x0
> >> +	beq	skip_per_fclken_restore_2
> >> +	str	r5, [r4]
> >> +skip_per_fclken_restore_2:
> >> +
> >>  	bl i_dll_wait
> >>  	/* restore regs and return */
> >>  	ldmfd   sp!, {r0-r12, pc}
> >> @@ -540,5 +608,11 @@ table_entry:
> >>  	.word	0x00000C02
> >>  cache_pred_disable_mask:
> >>  	.word	0xFFFFE7FB
> >> +cm_fclken_per_v:
> >> +	.word	CM_FCLKEN_PER_V
> >> +cm_fclken_per_p:
> >> +	.word	CM_FCLKEN_PER_P
> >> +cm_fclken_per_val:
> >> +	.word	0
> >>  ENTRY(omap34xx_cpu_suspend_sz)
> >>  	.word	. - omap34xx_cpu_suspend
> >> --=20
> >> 1.5.5
> >>=20
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe=20
> >> linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>=20
> >
> >
> >
>=20
> --=20
> Jouni H=C3=B6gander
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
