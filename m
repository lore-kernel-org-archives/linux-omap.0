From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v4 1/2] ARM: OMAP: Add secure function omap_smc3() which
 calling instruction smc #1
Date: Tue, 08 Oct 2013 09:13:16 +0200
Message-ID: <5253B08C.4020305@codethink.co.uk>
References: <20130904124303.GA2369@localhost.localdomain> <201309080943.30542@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([37.128.190.40]:37494 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab3JHHNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 03:13:25 -0400
In-Reply-To: <201309080943.30542@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dave Martin <Dave.Martin@arm.com>, tony@atomide.com, nm@ti.com, linux@arm.linux.org.uk, aaro.koskinen@iki.fi, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org, =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgA==?= =?UTF-8?B?0L7Qsg==?= <freemangordon@abv.bg>, santosh.shilimkar@ti.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/09/13 09:43, Pali Roh=C3=A1r wrote:
> Here is new version (v4) of omap secure part patch:
>
> Other secure functions omap_smc1() and omap_smc2() calling instructio=
n smc #0
> but Nokia RX-51 board needs to call smc #1 for PPA access.
>
> Signed-off-by: Ivaylo Dimitrov<freemangordon@abv.bg>
> Signed-off-by: Pali Roh=C3=A1r<pali.rohar@gmail.com>
> ---
> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/=
omap-secure.h
> index 0e72917..c4586f4 100644
> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -51,6 +51,7 @@
>   extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
>   				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
>   extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
> +extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
>   extern phys_addr_t omap_secure_ram_mempool_base(void);
>   extern int omap_secure_ram_reserve_memblock(void);
>
> diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/oma=
p-smc.S
> index f6441c1..fd90125 100644
> --- a/arch/arm/mach-omap2/omap-smc.S
> +++ b/arch/arm/mach-omap2/omap-smc.S
> @@ -1,9 +1,11 @@
>   /*
> - * OMAP44xx secure APIs file.
> + * OMAP34xx and OMAP44xx secure APIs file.
>    *
>    * Copyright (C) 2010 Texas Instruments, Inc.
>    * Written by Santosh Shilimkar<santosh.shilimkar@ti.com>
>    *
> + * Copyright (C) 2012 Ivaylo Dimitrov<freemangordon@abv.bg>
> + * Copyright (C) 2013 Pali Roh=C3=A1r<pali.rohar@gmail.com>
>    *
>    * This program is free software,you can redistribute it and/or mod=
ify
>    * it under the terms of the GNU General Public License version 2 a=
s
> @@ -54,6 +56,23 @@ ENTRY(omap_smc2)
>   	ldmfd   sp!, {r4-r12, pc}
>   ENDPROC(omap_smc2)
>
> +/**
> + * u32 omap_smc3(u32 service_id, u32 process_id, u32 flag, u32 pargs=
)
> + * Low level common routine for secure HAL and PPA APIs via smc #1
> + * r0 - @service_id: Secure Service ID
> + * r1 - @process_id: Process ID
> + * r2 - @flag: Flag to indicate the criticality of operation
> + * r3 - @pargs: Physical address of parameter list
> + */
> +ENTRY(omap_smc3)
> +	stmfd	sp!, {r4-r11, lr}
> +	mov	r12, r0		@ Copy the secure service ID

I think you should save r12 in the call.


--=20
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
