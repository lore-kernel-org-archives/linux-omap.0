From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 06/11] mpu off state enabled
Date: Wed, 02 Jul 2008 15:19:16 +0300
Message-ID: <87bq1gscl7.fsf@trdhcp146196.ntc.nokia.com>
References: <004301c8db85$08e0e970$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33162 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbYGBMTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 08:19:36 -0400
In-Reply-To: <004301c8db85$08e0e970$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Tue, 1 Jul 2008 19:46:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> This patch updates the CPUidle code to handle MPU OFF related C state=
s
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   19 +++++++++++++++----
>  arch/arm/mach-omap2/cpuidle34xx.h |    5 +++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-01 =
16:47:53.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-01 16:55=
:39.112465404 +0530
> @@ -82,8 +82,12 @@ static int omap3_enter_idle(struct cpuid
> =20
>  	/* Program MPU to target state */
>  	if (cx->mpu_state < PWRDM_POWER_ON) {
> -		if (neon_pwrst =3D=3D PWRDM_POWER_ON)
> -			pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_RET);
> +		if (neon_pwrst =3D=3D PWRDM_POWER_ON) {
> +			if (cx->mpu_state =3D=3D PWRDM_POWER_RET)
> +				pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_RET);
> +			else if (cx->mpu_state =3D=3D PWRDM_POWER_OFF)
> +				pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_OFF);

How about pwrdm_set_next_pwrst(neon_pd, cx->mpu_state)?

> +		}
>  		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
>  	}
> =20
> @@ -99,9 +103,13 @@ static int omap3_enter_idle(struct cpuid
>  		pwrdm_set_next_pwrst(core_pd, cx->core_state);
>  	}
> =20
> +	*(scratchpad_restore_addr) =3D restore_pointer_address;
> +
>  	/* Execute ARM wfi */
>  	omap_sram_idle();
> =20
> +	*(scratchpad_restore_addr) =3D 0x0;
> +
>  	/* Program MPU/NEON to ON */
>  	if (cx->mpu_state < PWRDM_POWER_ON) {
>  		if (neon_pwrst =3D=3D PWRDM_POWER_ON)
> @@ -211,7 +219,7 @@ void omap_init_power_states(void)
>  						CPUIDLE_FLAG_BALANCED;
> =20
>  	/* C3 . MPU OFF + Core active */
> -	omap3_power_states[3].valid =3D 0;
> +	omap3_power_states[3].valid =3D 1;
>  	omap3_power_states[3].type =3D OMAP3_STATE_C3;
>  	omap3_power_states[3].sleep_latency =3D 1500;
>  	omap3_power_states[3].wakeup_latency =3D 1800;
> @@ -233,7 +241,7 @@ void omap_init_power_states(void)
>  			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
> =20
>  	/* C5 . MPU OFF + Core CSWR */
> -	omap3_power_states[5].valid =3D 0;
> +	omap3_power_states[5].valid =3D 1;
>  	omap3_power_states[5].type =3D OMAP3_STATE_C5;
>  	omap3_power_states[5].sleep_latency =3D 3000;
>  	omap3_power_states[5].wakeup_latency =3D 8500;
> @@ -270,6 +278,9 @@ int omap3_idle_init(void)
>  	struct cpuidle_state *state;
>  	struct cpuidle_device *dev;
> =20
> +	clear_scratchpad_contents();
> +	save_scratchpad_contents();
> +
>  	omap_init_power_states();
>  	cpuidle_register_driver(&omap3_idle_driver);
> =20
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.h	2008-07-01 =
16:25:16.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h	2008-07-01 16:56=
:13.298377929 +0530
> @@ -40,6 +40,11 @@ extern void per_gpio_clk_enable(void);
>  extern void per_gpio_clk_disable(void);
>  extern void omap_serial_enable_clocks(int enable);
>  extern int omap3_can_sleep();
> +extern void clear_scratchpad_contents(void);
> +extern void save_scratchpad_contents(void);
> +extern u32 *scratchpad_restore_addr;
> +extern u32 restore_pointer_address;
> +
>  struct omap3_processor_cx {
>  	u8 valid;
>  	u8 type;
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
