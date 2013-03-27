From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Wed, 27 Mar 2013 14:09:18 -0700
Message-ID: <20130327210918.GP10155@atomide.com>
References: <201302281905.48546@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201302281905.48546@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Russell King <linux@arm.linux.org.uk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130228 10:09]:
> --- /dev/null
> +++ b/drivers/char/hw_random/omap3-rom-asm.S
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2009 Nokia Corporation
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +ENTRY(omap3_rng_call_rom_asm)
> +	.arch_extension sec
> +	stmfd	sp!, {r4-r12, lr}
> +	stmfd	sp!, {r0-r3}
> +	bl	v7_flush_dcache_all
> +	ldmfd	sp!, {r0-r3}
> +	mov	r6, #0xff
> +	mov	r12, r0
> +	smc	#1
> +	mov	r12, r0
> +	bl	v7_flush_dcache_all
> +	mov	r0, #0
> +	mcr	p15, 0, r0, c7, c5, 0
> +	mov	r0, r12
> +	ldmfd	sp!, {r4-r12, pc}

This part should be in arch/arm/mach-omap2 because of the
direct calls to v7_flush_dcache_all. Then you can pass a pointer
to this function in platform_data for now, and set it up based
on the compatible flag with device tree from driver later on.

> --- /dev/null
> +++ b/drivers/char/hw_random/omap3-rom-drv.c
> @@ -0,0 +1,167 @@
> +/*
> + * omap3-rom-drv.c - RNG driver for TI OMAP3 CPU family
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Author: Juha Yrjola <juha.yrjola@solidboot.com>
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/random.h>
> +#include <linux/hw_random.h>
> +#include <linux/timer.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +
> +#include "../../../arch/arm/mach-omap2/soc.h"

NAK for this, this must be private to arch/arm/mach-omap2.

Instead, just create a minimal include/linux/platform_data/omap3-rom.h,
and pass the function pointer in the pdata if passed.

> +static int omap3_rom_rng_probe(struct platform_device *pdev)
> +{
> +	printk(KERN_INFO "%s: initializing\n", omap3_rom_rng_name);
> +	if (!cpu_is_omap34xx()) {
> +		printk(KERN_ERR "%s: currently supports only OMAP34xx CPUs\n",
> +		       omap3_rom_rng_name);
> +		return -ENODEV;
> +	}
> +	if (omap_type() =3D=3D OMAP2_DEVICE_TYPE_GP) {
> +		printk(KERN_ERR "%s: GP OMAPs not supported\n",
> +		       omap3_rom_rng_name);
> +		return -ENODEV;
> +	}
> +
> +	setup_timer(&idle_timer, omap3_rom_idle_rng, 0);
> +	rng_clk =3D clk_get_sys("omap_rng", "ick");
> +	if (IS_ERR(rng_clk)) {
> +		printk(KERN_ERR "%s: unable to get RNG clock\n",
> +		       omap3_rom_rng_name);
> +		return IS_ERR(rng_clk);
> +	}
> +
> +	/* Leave the RNG in reset state. */
> +	clk_prepare_enable(rng_clk);
> +	omap3_rom_idle_rng(0);
> +
> +	return hwrng_register(&omap3_rom_rng_ops);
> +}

You should replace the cpu_is_omap34xx() and omap_type() with
some flags that you pass in the pdata. These too can be then
deciphered based on the DT compatible flag later on. And then
you don't need to include soc.h.

Regards,

Tony
