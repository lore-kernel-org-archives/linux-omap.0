From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] RX-51: ARM errata 430973 workaround
Date: Tue, 17 Sep 2013 16:24:17 -0700
Message-ID: <20130917232417.GK9994@atomide.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
 <1373461145-9812-1-git-send-email-pali.rohar@gmail.com>
 <1373461145-9812-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373461145-9812-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130710 06:06]:
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c

This file will be gone as soon as we're moving to device
tree based booting. So let's do this in more future proof
way.

> +/**
> + * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
> + * @idx: The PPA API index
> + * @process: Process ID
> + * @flag: The flag indicating criticality of operation
> + * @nargs: Number of valid arguments out of four.
> + * @arg1, arg2, arg3 args4: Parameters passed to secure API
> + *
> + * Return the non-zero error value on failure.
> + */
> +static u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u3=
2 nargs,
> +			   u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> +{
> +	u32 ret;
> +	u32 param[5];
> +
> +	param[0] =3D nargs+1; /* RX-51 needs number of arguments + 1 */
> +	param[1] =3D arg1;
> +	param[2] =3D arg2;
> +	param[3] =3D arg3;
> +	param[4] =3D arg4;
> +
> +	/*
> +	 * Secure API needs physical address
> +	 * pointer for the parameters
> +	 */
> +	local_irq_disable();
> +	local_fiq_disable();
> +	flush_cache_all();
> +	outer_clean_range(__pa(param), __pa(param + 5));
> +	ret =3D omap_smc3(idx, process, flag, __pa(param));
> +	flush_cache_all();
> +	local_fiq_enable();
> +	local_irq_enable();
> +
> +	return ret;
> +}

I think this used to be in omap-secure.c, and then made rx51
specific.. But since board-rx51.c is going away, let's move
this function to omap-secure.c.

> + * rx51_secure_update_aux_cr: Routine to modify the contents of Auxi=
liary Control Register
> + *  @set_bits: bits to set in ACR
> + *  @clr_bits: bits to clear in ACR
> + *
> + * Return the non-zero error value on failure.
> +*/
> +static u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits)
> +{
> +	u32 acr;
> +
> +	/* Read ACR */
> +	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=3Dr" (acr));
> +	acr &=3D ~clear_bits;
> +	acr |=3D set_bits;
> +
> +	return rx51_secure_dispatcher(RX51_PPA_WRITE_ACR,
> +				      0,
> +				      FLAG_START_CRITICAL,
> +				      1, acr, 0, 0, 0);
> +}

This too.

>  static void __init rx51_init(void)
>  {
>  	struct omap_sdrc_params *sdrc_params;
> @@ -105,6 +175,14 @@ static void __init rx51_init(void)
>  	rx51_peripherals_init();
>  	rx51_camera_init();
> =20
> +	if (omap_type() =3D=3D OMAP2_DEVICE_TYPE_SEC) {
> +#ifdef CONFIG_ARM_ERRATA_430973
> +		pr_info("RX-51: Enabling ARM errata 430973 workaround\n");
> +		/* set IBE to 1 */
> +		rx51_secure_update_aux_cr(BIT(6), 0);
> +#endif
> +	}
> +
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>  	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);

Then this can be called both from board-generic.c based on the
compatible flag, and board-rx51.c for now.

Regards,

Tony
