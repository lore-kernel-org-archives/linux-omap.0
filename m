From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 1/2] ARM: OMAP: Add secure function omap_smc3() which
 calling instruction smc #1
Date: Wed, 4 Sep 2013 13:43:11 +0100
Message-ID: <20130904124303.GA2369@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, tony@atomide.com, nm@ti.com, linux@arm.linux.org.uk, aaro.koskinen@iki.fi, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 04, 2013 at 10:10:29AM +0200, Pali Roh=C3=A1r wrote:
> On Sunday 11 August 2013 20:36:40 =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=
 =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 wrote:
> >   >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=
=BE =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
> >  >
> >  >=D0=9E=D1=82:  Dave Martin
> >  >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH v3 1/2] AR=
M: OMAP: Add secure function
> >  >omap_smc3() which
> >=20
> >  calling instruction smc #1
> >=20
> >  >=D0=94=D0=BE: Pali Roh=C3=A1r
> >  >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0=
: =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D0=BD=D0=B8=D0=BA, 2013, =D0=
=90=D0=B2=D0=B3=D1=83=D1=81=D1=82 5 16:29:44 EEST
> >  >
> >  >On Sun, Aug 04, 2013 at 10:45:00AM +0200, Pali Roh=C3=A1r wrote:
> >  >> Here is new version (v3) of omap secure part patch:
> >  >>=20
> >  >> Other secure functions omap_smc1() and omap_smc2() calling
> >  >> instruction smc #0 but Nokia RX-51 board needs to call
> >  >> smc #1 for PPA access.
> >  >>=20
> >  >> Signed-off-by: Ivaylo Dimitrov
> >  >> Signed-off-by: Pali Roh=C3=A1r
> >  >> ---
> >  >> diff --git a/arch/arm/mach-omap2/omap-secure.h
> >  >> b/arch/arm/mach-omap2/omap-secure.h index
> >  >> 0e72917..c4586f4 100644
> >  >> --- a/arch/arm/mach-omap2/omap-secure.h
> >  >> +++ b/arch/arm/mach-omap2/omap-secure.h
> >  >> @@ -51,6 +51,7 @@
> >  >>=20
> >  >>  extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32
> >  >>  nargs,
> >  >> =20
> >  >>  				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> >  >> =20
> >  >>  extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
> >  >>=20
> >  >> +extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32
> >  >> pargs);
> >  >>=20
> >  >>  extern phys_addr_t omap_secure_ram_mempool_base(void);
> >  >>  extern int omap_secure_ram_reserve_memblock(void);
> >  >>=20
> >  >> diff --git a/arch/arm/mach-omap2/omap-smc.S
> >  >> b/arch/arm/mach-omap2/omap-smc.S index f6441c1..7bbc043
> >  >> 100644
> >  >> --- a/arch/arm/mach-omap2/omap-smc.S
> >  >> +++ b/arch/arm/mach-omap2/omap-smc.S
> >  >> @@ -1,9 +1,11 @@
> >  >>=20
> >  >>  /*
> >  >>=20
> >  >> - * OMAP44xx secure APIs file.
> >  >> + * OMAP34xx and OMAP44xx secure APIs file.
> >  >>=20
> >  >>   *
> >  >>   * Copyright (C) 2010 Texas Instruments, Inc.
> >  >>   * Written by Santosh Shilimkar
> >  >>   *
> >  >>=20
> >  >> + * Copyright (C) 2012 Ivaylo Dimitrov
> >  >> + * Copyright (C) 2013 Pali Roh=C3=A1r
> >  >>=20
> >  >>   *
> >  >>   * This program is free software,you can redistribute it
> >  >>   and/or modify * it under the terms of the GNU General
> >  >>   Public License version 2 as
> >  >>=20
> >  >> @@ -54,6 +56,23 @@ ENTRY(omap_smc2)
> >  >>=20
> >  >>  	ldmfd   sp!, {r4-r12, pc}
> >  >> =20
> >  >>  ENDPROC(omap_smc2)
> >  >>=20
> >  >> +/**
> >  >> + * u32 omap_smc3(u32 service_id, u32 process_id, u32
> >  >> flag, u32 pargs) + * Low level common routine for secure
> >  >> HAL and PPA APIs via smc #1 + * r0 - @service_id: Secure
> >  >> Service ID
> >  >> + * r1 - @process_id: Process ID
> >  >> + * r2 - @flag: Flag to indicate the criticality of
> >  >> operation + * r3 - @pargs: Physical address of parameter
> >  >> list + */
> >  >> +ENTRY(omap_smc3)
> >  >> +	stmfd	sp!, {r4-r11, lr}
> >  >> +	mov	r12, r0		@ Copy the secure service ID
> >  >> +	mov	r6, #0xff	@ Indicate new Task call
> >  >> +	dsb			@ Memory Barrier
> >  >
> >  >Can you explain _why_ the barrier is there?  The reader
> >  >doesn't need to be told that a barrier instruction is a
> >  >barrier instruction.
> >  >
> >  >Cheers
> >  >---Dave
> >=20
> > Hi Dave,
> >=20
> > Would quoting Santosh's explanation "DSBs were needed on OMAP
> > for power sequencing." do the job? Something like "@ Needed
> > on OMAP for power sequencing" instead of "@ Memory Barrier".
> >=20
> > I want to be sure I correctly understand your requirement.
> >=20
> > Regards,
> > Ivo
>=20
> Hello,
>=20
> I'd like to know what happened with this patch? What is needed=20
> for including it into mainline? Note that without with this patch=20
> series Thumb-2 user space binaries crashing.

Apologies, it looks like I missed the previous reply somehow.

"Needed for power sequencing" is not a good explanation, because
DSB has no direct role in "power sequencing".

I'm guessing that the reason for its being needed is either not well
understood (otherwise someone would have offered a real explanation by
now), or it is a secret (errata, whatever) or related to something so
obscure it's likely to be of any interest or use to anyone anyway.

In the former case, just document the uncertainty.

In the latter case, at least document that the reasons are specific to
that platform and probably not applicable to other situations: this
warns someone maintaining or copying the code later that it may not mak=
e
sense for them, and they should stop and think.  It also avoids people
reading the code for educational purposes and learning incorrect lesson=
s
from it.

I've seen a mail thread where precisely this bad education happened:
someone is trying to figure out whether they need a DSB before every SV=
C
after reading the mach-omap2 SMC code.


The same goes for the disabling of interrupts around the call in
rx51_secure_dispatcher().  Even if the Secure World might write into th=
e
params struct during the SMC, making the params ____cacheline_aligned
should be sufficient to avoid the possibility of incoherent S/NS aliase=
s
of the same cacheline clobbering each other.  SMC disables all
interrupts on entry to the Secure World anyway, so I can't see what els=
e
the interrupt disabling achieves unless there are platform-specific
errata reasons.

Cheers
---Dave
