From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 1/2] ARM: OMAP: Add secure function omap_smc3() which
 calling instruction smc #1
Date: Mon, 5 Aug 2013 14:29:44 +0100
Message-ID: <20130805132939.GA2755@localhost.localdomain>
References: <531356997.66774.1373571839852.JavaMail.apache@mail81.abv.bg>
 <51DF0D7A.4090008@ti.com>
 <20130712102430.GA3249@localhost.localdomain>
 <201308041045.00698@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201308041045.00698@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: nm@ti.com, linux@arm.linux.org.uk, aaro.koskinen@iki.fi, tony@atomide.com, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, Santosh Shilimkar <santosh.shilimkar@ti.com>, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Aug 04, 2013 at 10:45:00AM +0200, Pali Roh=E1r wrote:
> Here is new version (v3) of omap secure part patch:
> =

> Other secure functions omap_smc1() and omap_smc2() calling instruction sm=
c #0
> but Nokia RX-51 board needs to call smc #1 for PPA access.
> =

> Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap=
-secure.h
> index 0e72917..c4586f4 100644
> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -51,6 +51,7 @@
>  extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
>  				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
>  extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
> +extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
>  extern phys_addr_t omap_secure_ram_mempool_base(void);
>  extern int omap_secure_ram_reserve_memblock(void);
>  =

> diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/omap-sm=
c.S
> index f6441c1..7bbc043 100644
> --- a/arch/arm/mach-omap2/omap-smc.S
> +++ b/arch/arm/mach-omap2/omap-smc.S
> @@ -1,9 +1,11 @@
>  /*
> - * OMAP44xx secure APIs file.
> + * OMAP34xx and OMAP44xx secure APIs file.
>   *
>   * Copyright (C) 2010 Texas Instruments, Inc.
>   * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
>   *
> + * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
> + * Copyright (C) 2013 Pali Roh=E1r <pali.rohar@gmail.com>
>   *
>   * This program is free software,you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -54,6 +56,23 @@ ENTRY(omap_smc2)
>  	ldmfd   sp!, {r4-r12, pc}
>  ENDPROC(omap_smc2)
>  =

> +/**
> + * u32 omap_smc3(u32 service_id, u32 process_id, u32 flag, u32 pargs)
> + * Low level common routine for secure HAL and PPA APIs via smc #1
> + * r0 - @service_id: Secure Service ID
> + * r1 - @process_id: Process ID
> + * r2 - @flag: Flag to indicate the criticality of operation
> + * r3 - @pargs: Physical address of parameter list
> + */
> +ENTRY(omap_smc3)
> +	stmfd	sp!, {r4-r11, lr}
> +	mov	r12, r0		@ Copy the secure service ID
> +	mov	r6, #0xff	@ Indicate new Task call
> +	dsb			@ Memory Barrier

Can you explain _why_ the barrier is there?  The reader doesn't need to
be told that a barrier instruction is a barrier instruction.

Cheers
---Dave
