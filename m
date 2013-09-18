From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] RX-51: ARM errata 430973 workaround
Date: Wed, 18 Sep 2013 12:27:31 -0700
Message-ID: <20130918192731.GE9994@atomide.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
 <1373461145-9812-3-git-send-email-pali.rohar@gmail.com>
 <20130917232417.GK9994@atomide.com>
 <201309182122.01570@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201309182122.01570@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130918 12:29]:
> Hello Tony,
>=20
> here is new v3 patch. I just only moved functions rx51_secure_dispatc=
her and
> rx51_secure_update_aux_cr to omap-secure.c and added header to omap-s=
ecure.h
> Because I only moved two functions to other source file I tested only=
 compilation.
> It is OK now?

Yes looks OK to me for v3.13 for the patch.

=46or the patch description, maybe also add something saying
that the rx51_secure_dispatcher() is different from the existing
smc function as that may be easy to miss while glancing over
the code?

Regards,

Tony
=20
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/b=
oard-rx51.c
> index 773510556..db168c9 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -2,6 +2,8 @@
>   * Board support file for Nokia N900 (aka RX-51).
>   *
>   * Copyright (C) 2007, 2008 Nokia
> + * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
> + * Copyright (C) 2013 Pali Roh=C3=A1r <pali.rohar@gmail.com>
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -31,7 +33,9 @@
>  #include "mux.h"
>  #include "gpmc.h"
>  #include "pm.h"
> +#include "soc.h"
>  #include "sdram-nokia.h"
> +#include "omap-secure.h"
> =20
>  #define RX51_GPIO_SLEEP_IND 162
> =20
> @@ -103,6 +107,14 @@ static void __init rx51_init(void)
>  	usb_musb_init(&musb_board_data);
>  	rx51_peripherals_init();
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
> diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/=
omap-secure.c
> index b970440..eba74cf 100644
> --- a/arch/arm/mach-omap2/omap-secure.c
> +++ b/arch/arm/mach-omap2/omap-secure.c
> @@ -3,6 +3,8 @@
>   *
>   * Copyright (C) 2011 Texas Instruments, Inc.
>   *	Santosh Shilimkar <santosh.shilimkar@ti.com>
> + * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
> + * Copyright (C) 2013 Pali Roh=C3=A1r <pali.rohar@gmail.com>
>   *
>   *
>   * This program is free software,you can redistribute it and/or modi=
fy
> @@ -70,3 +72,63 @@ phys_addr_t omap_secure_ram_mempool_base(void)
>  {
>  	return omap_secure_memblock_base;
>  }
> +
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
> +u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs=
,
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
> +
> +/**
> + * rx51_secure_update_aux_cr: Routine to modify the contents of Auxi=
liary Control Register
> + *  @set_bits: bits to set in ACR
> + *  @clr_bits: bits to clear in ACR
> + *
> + * Return the non-zero error value on failure.
> +*/
> +u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits)
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
> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/=
omap-secure.h
> index c4586f4..51b59c6 100644
> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -3,6 +3,8 @@
>   *
>   * Copyright (C) 2011 Texas Instruments, Inc.
>   *	Santosh Shilimkar <santosh.shilimkar@ti.com>
> + * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
> + * Copyright (C) 2013 Pali Roh=C3=A1r <pali.rohar@gmail.com>
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -46,6 +48,11 @@
>  #define OMAP4_PPA_L2_POR_INDEX		0x23
>  #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
> =20
> +/* Secure RX-51 PPA (Primary Protected Application) APIs */
> +#define RX51_PPA_HWRNG			29
> +#define RX51_PPA_L2_INVAL		40
> +#define RX51_PPA_WRITE_ACR		42
> +
>  #ifndef __ASSEMBLER__
> =20
>  extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
> @@ -55,6 +62,10 @@ extern u32 omap_smc3(u32 id, u32 process, u32 flag=
, u32 pargs);
>  extern phys_addr_t omap_secure_ram_mempool_base(void);
>  extern int omap_secure_ram_reserve_memblock(void);
> =20
> +extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u3=
2 nargs,
> +				  u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> +extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
> +
>  #ifdef CONFIG_OMAP4_ERRATA_I688
>  extern int omap_barrier_reserve_memblock(void);
>  #else
>=20
>=20
> --=20
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
