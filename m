From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/2] ARM: OMAP: Add secure function omap_smc3()
 which calling instruction smc #1
Date: Tue, 8 Oct 2013 12:05:55 -0700
Message-ID: <20131008190555.GN8313@atomide.com>
References: <20130904124303.GA2369@localhost.localdomain>
 <201309080943.30542@pali>
 <5253B08C.4020305@codethink.co.uk>
 <20131008080908.GA25039@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131008080908.GA25039@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Dave Martin <Dave.Martin@arm.com>, nm@ti.com, aaro.koskinen@iki.fi, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, santosh.shilimkar@ti.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [131008 01:17]:
> On Tue, Oct 08, 2013 at 09:13:16AM +0200, Ben Dooks wrote:
> > On 08/09/13 09:43, Pali Roh=C3=A1r wrote:
> >> Here is new version (v4) of omap secure part patch:
> >>
> >> Other secure functions omap_smc1() and omap_smc2() calling instruc=
tion smc #0
> >> but Nokia RX-51 board needs to call smc #1 for PPA access.
> >>
> >> Signed-off-by: Ivaylo Dimitrov<freemangordon@abv.bg>
> >> Signed-off-by: Pali Roh=C3=A1r<pali.rohar@gmail.com>
> >> ---
> >> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-oma=
p2/omap-secure.h
> >> index 0e72917..c4586f4 100644
> >> --- a/arch/arm/mach-omap2/omap-secure.h
> >> +++ b/arch/arm/mach-omap2/omap-secure.h
> >> @@ -51,6 +51,7 @@
> >>   extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
> >>   				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> >>   extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
> >> +extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
> >>   extern phys_addr_t omap_secure_ram_mempool_base(void);
> >>   extern int omap_secure_ram_reserve_memblock(void);
> >>
> >> diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/=
omap-smc.S
> >> index f6441c1..fd90125 100644
> >> --- a/arch/arm/mach-omap2/omap-smc.S
> >> +++ b/arch/arm/mach-omap2/omap-smc.S
> >> @@ -1,9 +1,11 @@
> >>   /*
> >> - * OMAP44xx secure APIs file.
> >> + * OMAP34xx and OMAP44xx secure APIs file.
> >>    *
> >>    * Copyright (C) 2010 Texas Instruments, Inc.
> >>    * Written by Santosh Shilimkar<santosh.shilimkar@ti.com>
> >>    *
> >> + * Copyright (C) 2012 Ivaylo Dimitrov<freemangordon@abv.bg>
> >> + * Copyright (C) 2013 Pali Roh=C3=A1r<pali.rohar@gmail.com>
> >>    *
> >>    * This program is free software,you can redistribute it and/or =
modify
> >>    * it under the terms of the GNU General Public License version =
2 as
> >> @@ -54,6 +56,23 @@ ENTRY(omap_smc2)
> >>   	ldmfd   sp!, {r4-r12, pc}
> >>   ENDPROC(omap_smc2)
> >>
> >> +/**
> >> + * u32 omap_smc3(u32 service_id, u32 process_id, u32 flag, u32 pa=
rgs)
> >> + * Low level common routine for secure HAL and PPA APIs via smc #=
1
> >> + * r0 - @service_id: Secure Service ID
> >> + * r1 - @process_id: Process ID
> >> + * r2 - @flag: Flag to indicate the criticality of operation
> >> + * r3 - @pargs: Physical address of parameter list
> >> + */
> >> +ENTRY(omap_smc3)
> >> +	stmfd	sp!, {r4-r11, lr}
> >> +	mov	r12, r0		@ Copy the secure service ID
> >
> > I think you should save r12 in the call.
>=20
> Not necessary.

Assuming there are no other comments I'll apply these into
omap-for-v3.13/n900 branch.

Regards,

Tony
