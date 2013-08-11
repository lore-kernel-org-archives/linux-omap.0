From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH v3 1/2] ARM: OMAP: Add secure function omap_smc3() which calling instruction smc #1
Date: Sun, 11 Aug 2013 21:36:40 +0300 (EEST)
Message-ID: <2121638991.49538.1376246200421.JavaMail.apache@mail81.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: pali.rohar@gmail.com, tony@atomide.com, nm@ti.com, linux@arm.linux.org.uk, aaro.koskinen@iki.fi, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Dave Martin=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH v3 1/2] ARM: O=
MAP: Add secure function omap_smc3() which
 calling instruction smc #1
 >=D0=94=D0=BE: Pali Roh=C3=A1r=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D0=BD=D0=B8=D0=BA, 2013, =D0=
=90=D0=B2=D0=B3=D1=83=D1=81=D1=82 5 16:29:44 EEST
 >
 >
 >On Sun, Aug 04, 2013 at 10:45:00AM +0200, Pali Roh=C3=A1r wrote:
 >> Here is new version (v3) of omap secure part patch:
 >>=20
 >> Other secure functions omap_smc1() and omap_smc2() calling instruct=
ion smc #0
 >> but Nokia RX-51 board needs to call smc #1 for PPA access.
 >>=20
 >> Signed-off-by: Ivaylo Dimitrov=20
 >> Signed-off-by: Pali Roh=C3=A1r=20
 >> ---
 >> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap=
2/omap-secure.h
 >> index 0e72917..c4586f4 100644
 >> --- a/arch/arm/mach-omap2/omap-secure.h
 >> +++ b/arch/arm/mach-omap2/omap-secure.h
 >> @@ -51,6 +51,7 @@
 >>  extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 >>  				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 >>  extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
 >> +extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
 >>  extern phys_addr_t omap_secure_ram_mempool_base(void);
 >>  extern int omap_secure_ram_reserve_memblock(void);
 >> =20
 >> diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/o=
map-smc.S
 >> index f6441c1..7bbc043 100644
 >> --- a/arch/arm/mach-omap2/omap-smc.S
 >> +++ b/arch/arm/mach-omap2/omap-smc.S
 >> @@ -1,9 +1,11 @@
 >>  /*
 >> - * OMAP44xx secure APIs file.
 >> + * OMAP34xx and OMAP44xx secure APIs file.
 >>   *
 >>   * Copyright (C) 2010 Texas Instruments, Inc.
 >>   * Written by Santosh Shilimkar=20
 >>   *
 >> + * Copyright (C) 2012 Ivaylo Dimitrov=20
 >> + * Copyright (C) 2013 Pali Roh=C3=A1r=20
 >>   *
 >>   * This program is free software,you can redistribute it and/or mo=
dify
 >>   * it under the terms of the GNU General Public License version 2 =
as
 >> @@ -54,6 +56,23 @@ ENTRY(omap_smc2)
 >>  	ldmfd   sp!, {r4-r12, pc}
 >>  ENDPROC(omap_smc2)
 >> =20
 >> +/**
 >> + * u32 omap_smc3(u32 service_id, u32 process_id, u32 flag, u32 par=
gs)
 >> + * Low level common routine for secure HAL and PPA APIs via smc #1
 >> + * r0 - @service_id: Secure Service ID
 >> + * r1 - @process_id: Process ID
 >> + * r2 - @flag: Flag to indicate the criticality of operation
 >> + * r3 - @pargs: Physical address of parameter list
 >> + */
 >> +ENTRY(omap_smc3)
 >> +	stmfd	sp!, {r4-r11, lr}
 >> +	mov	r12, r0		@ Copy the secure service ID
 >> +	mov	r6, #0xff	@ Indicate new Task call
 >> +	dsb			@ Memory Barrier
 >
 >Can you explain _why_ the barrier is there?  The reader doesn't need =
to
 >be told that a barrier instruction is a barrier instruction.
 >
 >Cheers
 >---Dave
 >
Hi Dave,

Would quoting Santosh's explanation "DSBs were needed on OMAP for power=
 sequencing." do the job?
Something like "@ Needed on OMAP for power sequencing" instead of "@ Me=
mory Barrier".

I want to be sure I correctly understand your requirement.

Regards,
Ivo
