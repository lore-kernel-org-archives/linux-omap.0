From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 02/11] per/neon and core handling in idle
Date: Wed, 02 Jul 2008 14:48:54 +0300
Message-ID: <87k5g4sdzt.fsf@trdhcp146196.ntc.nokia.com>
References: <003f01c8db85$02c99dc0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47259 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764028AbYGBLti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 07:49:38 -0400
In-Reply-To: <003f01c8db85$02c99dc0$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Tue, 1 Jul 2008 19:46:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> This patches adds handling of PER/NEON and CORE domain in idle.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   98 +++++++++++++++++++++++++++=
++++-------
>  arch/arm/mach-omap2/cpuidle34xx.h |    6 +-
>  arch/arm/mach-omap2/pm34xx.c      |   58 ++++++++++++++--------
>  3 files changed, 121 insertions(+), 41 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-01 =
18:48:09.962433167 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-01 18:48=
:12.884339399 +0530
> @@ -26,6 +26,8 @@
>  #include <asm/arch/pm.h>
>  #include <asm/arch/prcm.h>
>  #include <asm/arch/powerdomain.h>
> +#include <asm/arch/clockdomain.h>
> +#include <asm/arch/gpio.h>
>  #include "cpuidle34xx.h"
> =20
>  #ifdef CONFIG_CPU_IDLE
> @@ -35,6 +37,8 @@ struct omap3_processor_cx current_cx_sta
> =20
>  static int omap3_idle_bm_check(void)
>  {
> +	if (!omap3_can_sleep())
> +		return 1;
>  	return 0;
>  }
> =20
> @@ -46,34 +50,86 @@ static int omap3_enter_idle(struct cpuid
>  {
>  	struct omap3_processor_cx *cx =3D cpuidle_get_statedata(state);
>  	struct timespec ts_preidle, ts_postidle, ts_idle;
> -	struct powerdomain *mpu_pd;
> +	struct powerdomain *mpu_pd, *core_pd, *per_pd, *neon_pd;
> +	int per_pwrst, neon_pwrst;
> =20
>  	current_cx_state =3D *cx;
> =20
> -	/* Used to keep track of the total time in idle */
> -	getnstimeofday(&ts_preidle);
> -
> -
>  	if (cx->type =3D=3D OMAP3_STATE_C0) {
>  		/* Do nothing for C0, not even a wfi */
>  		return 0;
>  	}
> =20
> +	/* Used to keep track of the total time in idle */
> +	getnstimeofday(&ts_preidle);
> +
>  	mpu_pd =3D pwrdm_lookup("mpu_pwrdm");
> +	core_pd =3D pwrdm_lookup("core_pwrdm");
> +	per_pd =3D pwrdm_lookup("per_pwrdm");
> +	neon_pd =3D pwrdm_lookup("neon_pwrdm");
> +
> +	/* Reset previous power state registers */
> +	pwrdm_clear_all_prev_pwrst(mpu_pd);
> +	pwrdm_clear_all_prev_pwrst(neon_pd);
> +	pwrdm_clear_all_prev_pwrst(core_pd);
> +	pwrdm_clear_all_prev_pwrst(per_pd);
> +
> +	if (omap_irq_pending())
> +		return 0;
> +
> +	per_pwrst =3D pwrdm_read_pwrst(per_pd);
> +	neon_pwrst =3D pwrdm_read_pwrst(neon_pd);
> +
>  	/* Program MPU to target state */
> -	if (cx->mpu_state < PWRDM_POWER_ON)
> +	if (cx->mpu_state < PWRDM_POWER_ON) {
> +		if (neon_pwrst =3D=3D PWRDM_POWER_ON)
> +			pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_RET);
>  		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
> +	}
> +
> +	/* Program CORE and PER to target state */
> +	if (cx->core_state < PWRDM_POWER_ON) {
> +		if (per_pwrst =3D=3D PWRDM_POWER_ON) {
> +			omap2_gpio_prepare_for_retention();
> +			if (clocks_off_while_idle) {
> +				per_gpio_clk_disable();
> +				omap_serial_enable_clocks(0);
> +			}
> +		}

Why this is here? Why per is not put to sleep state if core is not?
Shouldn't you just disable gpio clocks in omap_sram_idle and if all
clocks in per domain are cut off then per domain enters its sleep
state. No matter what is the state of core domain.

Why per_pwrst is checked here? You know it is always on currently. It
won't never be anything else until those things in this if block is
done.

As the day comes when per_pwrst here is something else than
PWRDM_POWER_ON then serial clocks in core domain are not disabled
because disabling them are in that block.

> +		pwrdm_set_next_pwrst(core_pd, cx->core_state);
> +	}
> =20
>  	/* Execute ARM wfi */
>  	omap_sram_idle();
> =20
> -	/* Program MPU to ON */
> -	if (cx->mpu_state < PWRDM_POWER_ON)
> +	/* Program MPU/NEON to ON */
> +	if (cx->mpu_state < PWRDM_POWER_ON) {
> +		if (neon_pwrst =3D=3D PWRDM_POWER_ON)
> +			pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_ON);
>  		pwrdm_set_next_pwrst(mpu_pd, PWRDM_POWER_ON);
> +	}

No need to do these as they are written anyway in the next round. MPU
and NEON are not going to change their state in between.

> +
> +	if (cx->core_state < PWRDM_POWER_ON) {
> +		if (per_pwrst =3D=3D PWRDM_POWER_ON) {
> +			if (clocks_off_while_idle) {
> +				omap_serial_enable_clocks(1);
> +				per_gpio_clk_enable();
> +			}
> +			omap2_gpio_resume_after_retention();

Similiar comments as before omap_sram_idle() for this block.

> +		}
> +		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);

This can be also left to value before omap_sram_idle(), because it is
anyway written again in next round.

> +	}
> +
> +	pr_debug("MPU prev st:%x,NEON prev st:%x\n",
> +			       pwrdm_read_prev_pwrst(mpu_pd),
> +			       pwrdm_read_prev_pwrst(neon_pd));
> +	pr_debug("PER prev st:%x,CORE prev st:%x\n",
> +			       pwrdm_read_prev_pwrst(per_pd),
> +			       pwrdm_read_prev_pwrst(core_pd));
> =20
>  	getnstimeofday(&ts_postidle);
>  	ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
> -	return timespec_to_ns(&ts_idle);
> +	return (u32)timespec_to_ns(&ts_idle)/1000;
>  }
> =20
>  static int omap3_enter_idle_bm(struct cpuidle_device *dev,
> @@ -130,7 +186,7 @@ void omap_init_power_states(void)
>  	omap3_power_states[0].threshold =3D 0;
>  	omap3_power_states[0].mpu_state =3D PWRDM_POWER_ON;
>  	omap3_power_states[0].core_state =3D PWRDM_POWER_ON;
> -	omap3_power_states[0].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[0].flags =3D CPUIDLE_FLAG_SHALLOW;
> =20
>  	/* C1 . MPU WFI + Core active */
>  	omap3_power_states[1].valid =3D 1;
> @@ -140,7 +196,8 @@ void omap_init_power_states(void)
>  	omap3_power_states[1].threshold =3D 30;
>  	omap3_power_states[1].mpu_state =3D PWRDM_POWER_ON;
>  	omap3_power_states[1].core_state =3D PWRDM_POWER_ON;
> -	omap3_power_states[1].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[1].flags =3D CPUIDLE_FLAG_TIME_VALID |
> +						CPUIDLE_FLAG_SHALLOW;
> =20
>  	/* C2 . MPU CSWR + Core active */
>  	omap3_power_states[2].valid =3D 1;
> @@ -150,7 +207,8 @@ void omap_init_power_states(void)
>  	omap3_power_states[2].threshold =3D 300;
>  	omap3_power_states[2].mpu_state =3D PWRDM_POWER_RET;
>  	omap3_power_states[2].core_state =3D PWRDM_POWER_ON;
> -	omap3_power_states[2].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[2].flags =3D CPUIDLE_FLAG_TIME_VALID |
> +						CPUIDLE_FLAG_BALANCED;
> =20
>  	/* C3 . MPU OFF + Core active */
>  	omap3_power_states[3].valid =3D 0;
> @@ -159,18 +217,20 @@ void omap_init_power_states(void)
>  	omap3_power_states[3].wakeup_latency =3D 1800;
>  	omap3_power_states[3].threshold =3D 4000;
>  	omap3_power_states[3].mpu_state =3D PWRDM_POWER_OFF;
> -	omap3_power_states[3].core_state =3D PWRDM_POWER_RET;
> -	omap3_power_states[3].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[3].core_state =3D PWRDM_POWER_ON;
> +	omap3_power_states[3].flags =3D CPUIDLE_FLAG_TIME_VALID |
> +			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
> =20
>  	/* C4 . MPU CSWR + Core CSWR*/
> -	omap3_power_states[4].valid =3D 0;
> +	omap3_power_states[4].valid =3D 1;
>  	omap3_power_states[4].type =3D OMAP3_STATE_C4;
>  	omap3_power_states[4].sleep_latency =3D 2500;
>  	omap3_power_states[4].wakeup_latency =3D 7500;
>  	omap3_power_states[4].threshold =3D 12000;
>  	omap3_power_states[4].mpu_state =3D PWRDM_POWER_RET;
>  	omap3_power_states[4].core_state =3D PWRDM_POWER_RET;
> -	omap3_power_states[4].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[4].flags =3D CPUIDLE_FLAG_TIME_VALID |
> +			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
> =20
>  	/* C5 . MPU OFF + Core CSWR */
>  	omap3_power_states[5].valid =3D 0;
> @@ -180,7 +240,8 @@ void omap_init_power_states(void)
>  	omap3_power_states[5].threshold =3D 15000;
>  	omap3_power_states[5].mpu_state =3D PWRDM_POWER_OFF;
>  	omap3_power_states[5].core_state =3D PWRDM_POWER_RET;
> -	omap3_power_states[5].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[5].flags =3D CPUIDLE_FLAG_TIME_VALID |
> +			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
> =20
>  	/* C6 . MPU OFF + Core OFF */
>  	omap3_power_states[6].valid =3D 0;
> @@ -190,7 +251,8 @@ void omap_init_power_states(void)
>  	omap3_power_states[6].threshold =3D 300000;
>  	omap3_power_states[6].mpu_state =3D PWRDM_POWER_OFF;
>  	omap3_power_states[6].core_state =3D PWRDM_POWER_OFF;
> -	omap3_power_states[6].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +	omap3_power_states[6].flags =3D CPUIDLE_FLAG_TIME_VALID |
> +			CPUIDLE_FLAG_DEEP | CPUIDLE_FLAG_CHECK_BM;
>  }
> =20
>  struct cpuidle_driver omap3_idle_driver =3D {
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.h	2008-07-01 =
18:48:09.962433167 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h	2008-07-01 18:48=
:12.885339367 +0530
> @@ -33,11 +33,13 @@
>  /* Currently, we support only upto C2 */
>  #define MAX_SUPPORTED_STATES 3
> =20
> +extern unsigned short clocks_off_while_idle;
>  extern void omap_sram_idle(void);
> -extern int omap3_irq_pending(void);
> +extern int omap_irq_pending(void);
>  extern void per_gpio_clk_enable(void);
>  extern void per_gpio_clk_disable(void);
> -
> +extern void omap_serial_enable_clocks(int enable);
> +extern int omap3_can_sleep();
>  struct omap3_processor_cx {
>  	u8 valid;
>  	u8 type;
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-07-01 18:48=
:09.962433167 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-07-01 18:48:12.8=
85339367 +0530
> @@ -61,7 +61,7 @@ static struct clk *gpio_fcks[NUM_OF_PERG
> =20
>  /* XXX This is for gpio fclk hack. Will be removed as gpio driver
>   * handles fcks correctly */
> -static void per_gpio_clk_enable(void)
> +void per_gpio_clk_enable(void)
>  {
>  	int i;
>  	for (i =3D 1; i < NUM_OF_PERGPIOS + 1; i++)
> @@ -70,7 +70,7 @@ static void per_gpio_clk_enable(void)
> =20
>  /* XXX This is for gpio fclk hack. Will be removed as gpio driver
>   * handles fcks correctly */
> -static void per_gpio_clk_disable(void)
> +void per_gpio_clk_disable(void)
>  {
>  	int i;
>  	for (i =3D 1; i < NUM_OF_PERGPIOS + 1; i++)
> @@ -202,25 +202,7 @@ void omap_sram_idle(void)
>  		return;
>  	}
> =20
> -	omap2_gpio_prepare_for_retention();
> -
> -	if (clocks_off_while_idle) {
> -		omap_serial_enable_clocks(0);
> -		/* XXX This is for gpio fclk hack. Will be removed as
> -		 * gpio driver * handles fcks correctly */
> -		per_gpio_clk_disable();
> -	}
> -
>  	_omap_sram_idle(NULL, save_state, clocks_off_while_idle);
> -
> -	if (clocks_off_while_idle) {
> -		omap_serial_enable_clocks(1);
> -		/* XXX This is for gpio fclk hack. Will be removed as
> -		 * gpio driver * handles fcks correctly */
> -		per_gpio_clk_enable();
> -	}
> -
> -	omap2_gpio_resume_after_retention();

Couldn't these be left here. I assume you want to do gpio and serial
clock disabling only if per domain state is about to change. If this
is what you want then you should check that all other clocks in per
domain are disabled. If this is true then disable gpio and uart clocks
here. Still this code could be left here if done that way.

>  }
> =20
>  static int omap3_fclks_active(void)
> @@ -258,7 +240,7 @@ static int omap3_fclks_active(void)
>  	return 0;
>  }
> =20
> -static int omap3_can_sleep(void)
> +int omap3_can_sleep(void)
>  {
>  	if (!enable_dyn_sleep)
>  		return 0;
> @@ -329,8 +311,25 @@ static void omap3_pm_idle(void)
>  	if (omap_irq_pending())
>  		goto out;
> =20
> +	omap2_gpio_prepare_for_retention();
> +
> +	if (clocks_off_while_idle) {
> +		omap_serial_enable_clocks(0);
> +		/* XXX This is for gpio fclk hack. Will be removed as
> +		 * gpio driver * handles fcks correctly */
> +		per_gpio_clk_disable();
> +	}

Same comment as above.

> +
>  	omap_sram_idle();
> =20
> +	if (clocks_off_while_idle) {
> +		omap_serial_enable_clocks(1);
> +		/* XXX This is for gpio fclk hack. Will be removed as
> +		 * gpio driver * handles fcks correctly */
> +		per_gpio_clk_enable();
> +	}
> +
> +	omap2_gpio_resume_after_retention();

and same goes here.

>  out:
>  	local_fiq_enable();
>  	local_irq_enable();
> @@ -363,8 +362,25 @@ static int omap3_pm_suspend(void)
>  			goto restore;
>  	}
> =20
> +	omap2_gpio_prepare_for_retention();
> +
> +	if (clocks_off_while_idle) {
> +		omap_serial_enable_clocks(0);
> +		/* XXX This is for gpio fclk hack. Will be removed as
> +		 * gpio driver * handles fcks correctly */
> +		per_gpio_clk_disable();
> +	}
> +

And here.

>  	omap_sram_idle();
> =20
> +	if (clocks_off_while_idle) {
> +		omap_serial_enable_clocks(1);
> +		/* XXX This is for gpio fclk hack. Will be removed as
> +		 * gpio driver * handles fcks correctly */
> +		per_gpio_clk_enable();
> +	}
> +
> +	omap2_gpio_resume_after_retention();

And here.

>  restore:
>  	/* Restore next_pwrsts */
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
