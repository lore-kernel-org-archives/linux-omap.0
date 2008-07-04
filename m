From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 3/3] CPU-idle trial fix + PM debug expansion
Date: Fri, 04 Jul 2008 10:39:29 +0300
Message-ID: <87od5em72m.fsf@trdhcp146196.ntc.nokia.com>
References: <1215100756-31445-1-git-send-email-tero.kristo@nokia.com>
	<1215100756-31445-2-git-send-email-tero.kristo@nokia.com>
	<1215100756-31445-3-git-send-email-tero.kristo@nokia.com>
	<1215100756-31445-4-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42869 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbYGDHje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 03:39:34 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m647dCRM025984
	for <linux-omap@vger.kernel.org>; Fri, 4 Jul 2008 10:39:31 +0300
In-Reply-To: <1215100756-31445-4-git-send-email-tero.kristo@nokia.com> (ext
	Tero Kristo's message of "Thu, 3 Jul 2008 18:59:16 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

"ext Tero Kristo" <tero.kristo@nokia.com> writes:

> CPU-idle has a possibility of working now, also added full PRCM regis=
ter dump
> into pm-debug.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   30 -------------------------
>  arch/arm/mach-omap2/pm-debug.c    |   17 ++++++++++----
>  arch/arm/mach-omap2/pm34xx.c      |   43 +++++++++++++++++++++++++++=
---------
>  3 files changed, 44 insertions(+), 46 deletions(-)
>  mode change 100644 =3D> 100755 arch/arm/mach-omap2/pm-debug.c
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 7af8653..9e65631 100755
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -461,10 +461,6 @@ static int omap3_enter_idle(struct cpuidle_devic=
e *dev,
>  	per_pwrst =3D pwrdm_read_pwrst(per_pd);
>  	neon_pwrst =3D pwrdm_read_pwrst(neon_pd);
> =20
> -	/* Do this before any changes to PRCM registers */
> -	if (cx->core_state =3D=3D PWRDM_POWER_OFF)
> -		omap3_save_prcm_ctx();
> -
>  	/* Program MPU to target state */
>  	if (cx->mpu_state < PWRDM_POWER_ON) {
>  		if (neon_pwrst =3D=3D PWRDM_POWER_ON) {
> @@ -478,17 +474,6 @@ static int omap3_enter_idle(struct cpuidle_devic=
e *dev,
> =20
>  	/* Program CORE and PER to target state */
>  	if (cx->core_state < PWRDM_POWER_ON) {
> -		if (per_pwrst =3D=3D PWRDM_POWER_ON) {
> -			omap2_gpio_prepare_for_retention();
> -			if (clocks_off_while_idle) {
> -				omap3_save_per_ctx();
> -				per_gpio_clk_disable();
> -				omap_save_uart_ctx(2);
> -				omap_serial_enable_clocks(0, 2);
> -			}
> -		}
> -		if (cx->core_state =3D=3D PWRDM_POWER_OFF)
> -			omap3_save_core_ctx();
>  		pwrdm_set_next_pwrst(core_pd, cx->core_state);
>  	}

This will leave cx->core_state to its previous value in case of ON
state. So just pwrdm_set_next_pwrst(core_pd, cx->core_state) without
if is better.

> =20
> @@ -510,22 +495,7 @@ static int omap3_enter_idle(struct cpuidle_devic=
e *dev,
>  	}
> =20
>  	if (cx->core_state < PWRDM_POWER_ON) {
> -		if ((cx->core_state =3D=3D PWRDM_POWER_OFF)
> -		&& (pwrdm_read_prev_pwrst(core_pd) =3D=3D PWRDM_POWER_OFF)) {
> -			omap3_restore_core_ctx();
> -			omap3_restore_prcm_ctx();
> -			omap3_restore_sram_ctx();
> -		}
>  		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);
> -		if (per_pwrst =3D=3D PWRDM_POWER_ON) {
> -			if (clocks_off_while_idle) {
> -				omap_serial_enable_clocks(1, 2);
> -				omap_restore_uart_ctx(2);
> -				per_gpio_clk_enable();
> -				omap3_restore_per_ctx();
> -			}
> -			omap2_gpio_resume_after_retention();
> -		}
>  	}
> =20
>  	pr_debug("MPU prev st:%x,NEON prev st:%x\n",
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-=
debug.c
> old mode 100644
> new mode 100755
> index b6f8621..f35b082
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -182,26 +182,33 @@ struct pm_module_def {
>  #define MOD_PRM 1
> =20
>  static const struct pm_module_def pm_dbg_reg_modules[] =3D {
> +	{ "IVA2", MOD_CM, OMAP3430_IVA2_MOD, 0, 0x4c },
>  	{ "OCP", MOD_CM, OCP_MOD, 0, 0x10 },
>  	{ "MPU", MOD_CM, MPU_MOD, 4, 0x4c },
>  	{ "CORE", MOD_CM, CORE_MOD, 0, 0x4c },
> -	{ "NEON", MOD_CM, OMAP3430_NEON_MOD, 0x20, 0x48 },
> +	{ "SGX", MOD_CM, OMAP3430ES2_SGX_MOD, 0, 0x4c },
>  	{ "WKUP", MOD_CM, WKUP_MOD, 0, 0x40 },
> -	{ "EMU", MOD_CM, OMAP3430_EMU_MOD, 0x40, 0x54 },
>  	{ "CCR", MOD_CM, PLL_MOD, 0, 0x70 },
>  	{ "DSS", MOD_CM, OMAP3430_DSS_MOD, 0, 0x4c },
> +	{ "CAM", MOD_CM, OMAP3430_CAM_MOD, 0, 0x4c },
>  	{ "PER", MOD_CM, OMAP3430_PER_MOD, 0, 0x4c },
> +	{ "EMU", MOD_CM, OMAP3430_EMU_MOD, 0x40, 0x54 },
> +	{ "NEON", MOD_CM, OMAP3430_NEON_MOD, 0x20, 0x48 },
>  	{ "USB", MOD_CM, OMAP3430ES2_USBHOST_MOD, 0, 0x4c },
> =20
> -	{ "OCP", MOD_PRM, OCP_MOD, 0x1c },
> +	{ "IVA2", MOD_PRM, OMAP3430_IVA2_MOD, 0x50, 0xfc },
> +	{ "OCP", MOD_PRM, OCP_MOD, 4, 0x1c },
>  	{ "MPU", MOD_PRM, MPU_MOD, 0x58, 0xe8 },
>  	{ "CORE", MOD_PRM, CORE_MOD, 0x58, 0xf8 },
> -	{ "NEON", MOD_PRM, OMAP3430_NEON_MOD, 0x58, 0xe8 },
> +	{ "SGX", MOD_PRM, OMAP3430ES2_SGX_MOD, 0x58, 0xe8 },
>  	{ "WKUP", MOD_PRM, WKUP_MOD, 0xa0, 0xb0 },
> -	{ "EMU", MOD_PRM, OMAP3430_EMU_MOD, 0x58, 0xe4 },
>  	{ "CCR", MOD_PRM, PLL_MOD, 0x40, 0x70 },
>  	{ "DSS", MOD_PRM, OMAP3430_DSS_MOD, 0x58, 0xe8 },
> +	{ "CAM", MOD_PRM, OMAP3430_CAM_MOD, 0x58, 0xe8 },
>  	{ "PER", MOD_PRM, OMAP3430_PER_MOD, 0x58, 0xe8 },
> +	{ "EMU", MOD_PRM, OMAP3430_EMU_MOD, 0x58, 0xe4 },
> +	{ "GLBL", MOD_PRM, OMAP3430_GR_MOD, 0x20, 0xe4 },
> +	{ "NEON", MOD_PRM, OMAP3430_NEON_MOD, 0x58, 0xe8 },
>  	{ "USB", MOD_PRM, OMAP3430ES2_USBHOST_MOD, 0x58, 0xe8 },
>  	{ "", 0, 0, 0, 0 },
>  };
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index c4afa7d..3c62b68 100755
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -75,6 +75,8 @@ void (*_omap_sram_idle)(u32 *addr, int save_state);
>  static void (*saved_idle)(void);
> =20
>  static struct powerdomain *mpu_pwrdm;
> +static struct powerdomain *core_pwrdm;
> +static struct powerdomain *per_pwrdm;
> =20
>  /* XXX This is for gpio fclk hack. Will be removed as gpio driver
>   * handles fcks correctly */
> @@ -235,6 +237,8 @@ void omap_sram_idle(void)
>  	/* save_state =3D 2 =3D> Only L2 lost */
>  	/* save_state =3D 3 =3D> L1, L2 and logic lost */
>  	int save_state =3D 0, mpu_next_state;
> +	int save_core;
> +	int save_per;
> =20
>  	if (!_omap_sram_idle)
>  		return;
> @@ -255,17 +259,26 @@ void omap_sram_idle(void)
>  		return;
>  	}
> =20
> -	omap3_save_core_ctx();
> -	omap3_save_prcm_ctx();
> +	save_core =3D (pwrdm_read_next_pwrst(core_pwrdm) =3D=3D PWRDM_POWER=
_OFF);
> +	save_per =3D (pwrdm_read_next_pwrst(per_pwrdm) =3D=3D
> PWRDM_POWER_OFF);

Just read next states here.

> +
> +	if (save_core) {
> +		omap3_save_core_ctx();
> +		omap3_save_prcm_ctx();
> +	}

And do this if core next_st < PWRDM_POWER_ON

> +
> +	if (save_per)
> +		omap3_save_per_ctx();

And same here. Additionally, do this only if core next_st <
PWRDM_POWER_ON.

> =20
> -	omap3_save_per_ctx();
>  	omap2_gpio_prepare_for_retention();
> =20
>  	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
>  	 * handqles fcks correctly */
>  	per_gpio_clk_disable();
> =20
> -	omap_save_uart_ctx();
> +	if (save_per)
> +		omap_save_uart_ctx();

Again, do this only if core next_st < PWRDM_POWER_ON and per next_st =3D=
=3D
PWRDM_POWER_OFF.

> +
>  	omap_serial_enable_clocks(0);

Consider Rajendras idea to do this only if needed.

> =20
>  	*(scratchpad_restore_addr) =3D restore_pointer_address;
> @@ -277,19 +290,24 @@ void omap_sram_idle(void)
>  	if (pwrdm_read_prev_pwrst(mpu_pwrdm) =3D=3D 0x0)
>  		restore_table_entry();
> =20
> -	omap3_restore_prcm_ctx();
> -	omap3_restore_sram_ctx();
> -	omap3_restore_core_ctx();
> +	if (save_core) {
> +		omap3_restore_prcm_ctx();
> +		omap3_restore_sram_ctx();
> +		omap3_restore_core_ctx();
> +	}
> =20
>  	omap_serial_enable_clocks(1); /* Causes crash with CORE off */
> =20
> -	omap_restore_uart_ctx();
> +	if (save_per)
> +		omap_restore_uart_ctx();
> =20
>  	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
>  	 * handles fcks correctly */
> =20
>  	per_gpio_clk_enable();
> -	omap3_restore_per_ctx();
> +
> +	if (save_per)
> +		omap3_restore_per_ctx();
> =20
>  	omap2_gpio_resume_after_retention();

Same comments to restore part as before wfi. I think you should look
at what Rajendra has done (logic in omap3_enter_idle). You might also
want to look at previous discussion related to this. Something like thi=
s:

void omap_sram_idle(void)
{
	/* Variable to tell what needs to be saved and restored
	 * in omap_sram_idle*/
	/* save_state =3D 0 =3D> Nothing to save and restored */
	/* save_state =3D 1 =3D> Only L1 and logic lost */
	/* save_state =3D 2 =3D> Only L2 lost */
	/* save_state =3D 3 =3D> L1, L2 and logic lost */
	int save_state =3D 0;
	int mpu_next_state =3D PWRDM_POWER_ON, core_next_state =3D PWRDM_POWER=
_ON,
		per_next_state =3D PWRDM_POWER_ON;
	int neon_state;

	if (!_omap_sram_idle)
		return;

	mpu_next_state =3D pwrdm_read_next_pwrst(mpu_pwrdm);
	switch (mpu_next_state) {
	case PWRDM_POWER_ON:
	case PWRDM_POWER_RET:
		/* No need to save context */
		save_state =3D 0;
		break;
	case PWRDM_POWER_OFF:
		save_state =3D 3;
		break;
	default:
		/* Invalid state */
		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
		return;
	}

	pm_dbg_pre_suspend();

	/* NEON control */
	if (mpu_next_state < PWRDM_POWER_ON) {
		neon_state =3D pwrdm_read_pwrst(neon_pwrdm);
		if (neon_state =3D=3D PWRDM_POWER_ON)
			pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
	}

	/* CORE & PER */
	core_next_state =3D pwrdm_read_next_pwrst(core_pwrdm);
	if (core_next_state < PWRDM_POWER_ON) {
		/* PER changes only with core */
		per_next_state =3D pwrdm_read_next_pwrst(per_pwrdm);
		if (per_next_state < PWRDM_POWER_ON) {
			if (per_next_state =3D=3D PWRDM_POWER_OFF) {
				omap3_save_per_ctx();
				/* This would be actually more effective */
				/* omap_save_uart_ctx(2); */
			}
			if (clocks_off_while_idle)
				per_gpio_clk_disable();
			/* This would be actually more effective */
			/* omap_serial_enable_clocks(0, 2); */
		}
		if (core_next_state =3D=3D PWRDM_POWER_OFF) {
			omap3_save_core_ctx();
			omap3_save_prcm_ctx();
			/* omap_save_uart_ctx(2); */
			/* omap_save_uart_ctx(2); */
		}
		if (core_next_state =3D=3D PWRDM_POWER_OFF || per_next_state =3D=3D P=
WRDM_POWER_OFF)
			omap_save_uart_ctx();
		if (clocks_off_while_idle)
			omap_serial_enable_clocks(0);
		/* omap_serial_enable_clocks(0, 2); */
		/* omap_serial_enable_clocks(0, 2); */
	=09
	}

	/* Is this related to per transition or transition in general? */
	omap2_gpio_prepare_for_retention();

	*(scratchpad_restore_addr) =3D restore_pointer_address;

	_omap_sram_idle(context_mem, save_state);

	*(scratchpad_restore_addr) =3D 0x0;

	if (pwrdm_read_prev_pwrst(mpu_pwrdm) =3D=3D 0x0)
		restore_table_entry();
=09
	if (core_next_state < PWRDM_POWER_ON) {
		if (core_next_state =3D=3D PWRDM_POWER_OFF) {
			omap3_restore_core_ctx();
			omap3_restore_sram_ctx();
			omap3_restore_prcm_ctx();
			/* omap_restore_uart_ctx(0); */
			/* omap_restore_uart_ctx(1); */
		}
		if (per_next_state < PWRDM_POWER_ON) {
			if (per_next_state =3D=3D PWRDM_POWER_OFF) {
				omap3_restore_per_ctx();
				/* This would be actually more effective */
				/* omap_restore_uart_ctx(2); */
			}
			if (clocks_off_while_idle) {
				per_gpio_clk_enable();
				/* This would be actually more effective */
				/* omap_serial_enable_clocks(0, 2); */
			}
		}
		if (core_next_state =3D=3D PWRDM_POWER_OFF || per_next_state =3D=3D P=
WRDM_POWER_OFF)
			omap_restore_uart_ctx();
		if (clocks_off_while_idle)
			omap_serial_enable_clocks(1);
		/* omap_serial_enable_clocks(1, 0); */
		/* omap_serial_enable_clocks(1, 1); */
	}

	omap2_gpio_resume_after_retention();

	pm_dbg_post_suspend();
}


>  }
> @@ -718,10 +736,13 @@ int __init omap3_pm_init(void)
>  	}
> =20
>  	mpu_pwrdm =3D pwrdm_lookup("mpu_pwrdm");
> +	core_pwrdm =3D pwrdm_lookup("core_pwrdm");
> +	per_pwrdm =3D pwrdm_lookup("per_pwrdm");
>  	neon_pwrdm =3D pwrdm_lookup("neon_pwrdm");
> =20
> -	if (mpu_pwrdm =3D=3D NULL || neon_pwrdm =3D=3D NULL) {
> -		printk(KERN_ERR "Failed to get mpu_pwrdm or neon_pwrdm\n");
> +	if (mpu_pwrdm =3D=3D NULL || neon_pwrdm =3D=3D NULL || per_pwrdm =3D=
=3D NULL ||
> +			core_pwrdm =3D=3D NULL) {
> +		printk(KERN_ERR "Failed to get pwrdm pointers\n");

Neon handling is missing.

>  		goto err2;
>  	}
> =20
> --=20
> 1.5.4.3
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
