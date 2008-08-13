From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Wed, 13 Aug 2008 11:27:05 +0530
Message-ID: <00ad01c8fd09$6bcdc6c0$LocalHost@wipultra1382>
References: <874p5q8l0c.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41533 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264AbYHMF5W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 01:57:22 -0400
In-Reply-To: <874p5q8l0c.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?'=22H=C3=B6gander=22_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

>=20
> Check wether serial can sleep is missing from=20
> omap3_enter_idle and it should be removed from omap3_can_sleep:
>=20
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c=20
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index a02da6d..16ff30b 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -431,7 +431,7 @@ static int omap3_enter_idle(struct=20
> cpuidle_device *dev,
> =20
>         current_cx_state =3D *cx;
> =20
> -       if (cx->type =3D=3D OMAP3_STATE_C0) {
> +       if (cx->type =3D=3D OMAP3_STATE_C0 || !omap_serial_can_sleep(=
)) {
>                 /* Do nothing for C0, not even a wfi */
>                 return 0;
>         }
>=20
> diff --git a/arch/arm/mach-omap2/pm34xx.c=20
> b/arch/arm/mach-omap2/pm34xx.c index f68fa0a..f9b3676 100644=20
> @@ -391,8 +391,6 @@ int omap3_can_sleep(void)
>                 return 0;
>         if (atomic_read(&sleep_block) > 0)
>                 return 0;
> -       if (!omap_serial_can_sleep())
> -               return 0;
>         return 1;
>  }
>=20
> Doing this would make serial console to work faster.

Yes, I removed these in my patches and put in the changes suggested by =
Richard
in 8250.c

I thought the final conclusion of the discussion was that it was too ex=
pensive to the keep the=20
system in C0 all the time while UART inactivity runs, or did I miss som=
ething?

>=20
> _omap_sram_idle should be non-static:
>=20
> diff --git a/arch/arm/mach-omap2/pm34xx.c=20
> b/arch/arm/mach-omap2/pm34xx.c index f68fa0a..133a666 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -60,7 +60,7 @@ u32 restore_pointer_address;
> =20
>  static LIST_HEAD(pwrst_list);
> =20
> -static void (*_omap_sram_idle)(u32 *addr, int save_state);
> +void (*_omap_sram_idle)(u32 *addr, int save_state);
> =20
>  static void (*saved_idle)(void);

I thought this is already part of the patches. It is now non-static.

> =20
> Serial and gpio clock disabling and gpio_prepare/resume can=20
> be removed from omap3_pm_idle because they are already done=20
> in omap_sram_idle. And if omap_serial_can_sleep is removed=20
> from omap3_can_sleep it should be added to omap3_pm_idle.=20
> Omap3_pm_idle can be also put behind #ifndef CONFIG_CPU_IDLE:
>=20
> +#ifndef CONFIG_CPU_IDLE
>  static void omap3_pm_idle(void)
>  {
>         local_irq_disable();
> @@ -454,33 +455,16 @@ static void omap3_pm_idle(void)
>         if (omap_irq_pending())
>                 goto out;
> =20
> -       omap2_gpio_prepare_for_retention();
> -
> -       if (clocks_off_while_idle) {
> -               omap_serial_enable_clocks(0, 0);
> -               omap_serial_enable_clocks(0, 1);
> -               omap_serial_enable_clocks(0, 2);
> -               /* XXX This is for gpio fclk hack. Will be removed as
> -                * gpio driver * handles fcks correctly */
> -               per_gpio_clk_disable();
> -       }
> +       if (!omap_serial_can_sleep())
> +               goto out;
> =20
>         omap_sram_idle();
> =20
> -       if (clocks_off_while_idle) {
> -               omap_serial_enable_clocks(1, 0);
> -               omap_serial_enable_clocks(1, 1);
> -               omap_serial_enable_clocks(1, 2);
> -               /* XXX This is for gpio fclk hack. Will be removed as
> -                * gpio driver * handles fcks correctly */
> -               per_gpio_clk_enable();
> -       }
> -
> -       omap2_gpio_resume_after_retention();
>  out:
>         local_fiq_enable();
>         local_irq_enable();
>  }
> +#endif /* CONFIG_CPU_IDLE */

These are also done as part of the last patch in the series.

>=20
> I would like to see also some reformatting. E.g. patch 11=20
> contains lots of code which is not related to "CORE context=20
> save/restore". It might be also good idea to enable only=20
> non-off mode C states and have a pwrdms_setup function which=20
> is something like this:
>=20
> static int __init pwrdms_setup(struct powerdomain *pwrdm) {
> 	struct power_state *pwrst;
>=20
> 	if (!pwrdm->pwrsts)
> 		return 0;
>=20
> 	pwrst =3D kmalloc(sizeof(struct power_state), GFP_KERNEL);
> 	if (!pwrst)
> 		return -ENOMEM;
> 	pwrst->pwrdm =3D pwrdm;
> 	pwrst->next_state =3D PWRDM_POWER_RET;
> 	list_add(&pwrst->node, &pwrst_list);
>=20
> 	if (pwrdm_has_hdwr_sar(pwrdm))
> 		pwrdm_enable_hdwr_sar(pwrdm);
>=20
> #ifdef CONFIG_CPU_IDLE
> 	/* Let cpuidle do selection here */
> 	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") ||=20
> !strcmp(pwrst->pwrdm->name, "mpu_pwrdm") ||
> 	    !strcmp(pwrst->pwrdm->name, "neon_pwrdm"))
> 		return set_pwrdm_state(pwrst->pwrdm, PWRDM_POWER_ON);
> 	else
> #endif
> 		return set_pwrdm_state(pwrst->pwrdm,=20
> pwrst->next_state); }
>=20
> This way cpuidle code would be in a state that it could be=20
> applied on linux-omap tree and it wouldn't break anything.=20
> Then have e.g. separate patch for testing off state. This=20
> patch could modify code to set next states to off and mark=20
> off mode C states as a valid.

Yes, will do that. Maybe the couple of comments above are also due to=20
the last patch doing a lot more than it actually should.

>=20
> >
> >> Hi,
> >>
> >> I am sending an updated patch set for CPUidle which includes all=20
> >> fixes/comments posted on the previous set by Jouni/Richard W/Peter=
=20
> >> and others.
> >>
> >> The Following are the fixes
> >> 1) Uart clock enable/disable moved out of the context save/restore=
=20
> >> patch
> >> 2) GPIO IRQENABLE save/restore fix from Richard
> >> 3) Fixes from Jouni which do the following
> >> 	1. Add wkdep between neon and mpu
> >> 	2. Add wkdep between per and core
> >> 	3. Deny hwsup mode before writing next pwrst state
> >> 	4. Make sure that order in idle loop is such that clocks are=20
> >> _really_
> >>    		enabled before accessing registers=20
> (serial & gpio).
> >> 4) Safe state idle fix from Richard
> >> 5) Uart smart-force fix from Richard
> >> 6) Toggle IO-PAD enable/disable in idle
> >>
> >> As earlier these patches apply on top of Jouni's=20
> workaround patch set=20
> >> ([PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.)
> >>
> >> The following is neccessay even with a minimal config to=20
> achieve OFF.
> >> $ echo 1 > /sys/power/sleep_while_idle $ echo 1 >=20
> >> /sys/power/clocks_off_while_idle
> >>
> >> regards,
> >> Rajendra
> >>
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap"=20
> > in the body of a message to majordomo@vger.kernel.org More=20
> majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
>=20
> --
> Jouni H=C3=B6gander
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
