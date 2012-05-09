From: "Buckley, Bryan" <bryan.buckley@ti.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address space.
Date: Wed, 9 May 2012 15:44:08 -0500
Message-ID: <CAG_NtY_qv-cv=Yd8CBcP4TrNCXJbTgz5WXvAsmCdQFWEotVhrg@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
	<20120508124116.GE17798@arm.com>
	<CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
	<20120508215554.GA18980@n2100.arm.linux.org.uk>
	<CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
	<20120509122348.GA30632@n2100.arm.linux.org.uk>
	<CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com>
	<20120509154849.GA10375@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:56005 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761110Ab2EIUoK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 16:44:10 -0400
Received: by qadz3 with SMTP id z3so2194777qad.3
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 13:44:09 -0700 (PDT)
In-Reply-To: <20120509154849.GA10375@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Wed, May 9, 2012 at 10:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Wed, May 09, 2012 at 06:00:10PM +0530, Shilimkar, Santosh wrote:
> > On Wed, May 9, 2012 at 5:53 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh wrot=
e:
> > >> The only change done common code is =A0clearing 'XN' bit for DRA=
M
> > >> region in page table entries. The other change of setting the DA=
CR
> > >> register is done in ARMv7 specific code.
> > >
> > > Yes, XN is an ARMv6+ thing. =A0Before ARMv5, it was implementatio=
n defined.
> > >
> > > Some implementations used the bit to mean "allow writes to update=
 the
> > > cache". =A0Other implementations labelled this bit as "should be =
zero"
> > > while others labelled it as "should be one".
> > >
> > Good to know.
> >
> > > The upshot of this is, we know that having this bit as '1' means =
that
> > > all the CPUs we support today work. =A0I would be _very_ concerne=
d to
> > > change this bit to zero as we _really_ don't know how the pre-ARM=
v6
> > > CPUs would react.
> > >
> > I agree.
> >
> > > The solution to this is pretty simple - if ARMv6+ needs a differe=
nt
> > > base section mapping value, then we need to extract that from the=
 code
> > > and pass in the base section mapping value.
> > >
> > > I'll sort out a patch later today for this.
> > Great.
>
> This works for my 4430SDP board. =A0I haven't booted it on anything e=
lse yet.
> Please can you check that this solves the issue for you? =A0Thanks.
>

Solves the issue for OMAP5. Thanks Russel and company.

> =A0arch/arm/boot/compressed/head.S | =A0 29 ++++++++++++++++++-------=
----
> =A01 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compress=
ed/head.S
> index dc7e8ce..5ad33a4 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -567,6 +567,12 @@ __armv3_mpu_cache_on:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c0, 0 =A0 =
@ invalidate whole cache v3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 pc, lr
>
> +#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
> +#define CB_BITS 0x08
> +#else
> +#define CB_BITS 0x0c
> +#endif
> +
> =A0__setup_mmu: =A0 sub =A0 =A0 r3, r4, #16384 =A0 =A0 =A0 =A0 =A0@ P=
age directory size
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bic =A0 =A0 r3, r3, #0xff =A0 =A0 =A0 =
=A0 =A0 @ Align the pointer
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bic =A0 =A0 r3, r3, #0x3f00
> @@ -578,17 +584,14 @@ __setup_mmu: =A0 =A0 =A0sub =A0 =A0 r3, r4, #16=
384 =A0 =A0 =A0 =A0 =A0@ Page directory size
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r9, r0, lsr #18
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r9, r9, lsl #18 =A0 =A0 =A0=
 =A0 @ start of RAM
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add =A0 =A0 r10, r9, #0x10000000 =A0 =A0=
@ a reasonable RAM size
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r1, #0x12
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 orr =A0 =A0 r1, r1, #3 << 10
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r1, #0x12 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 @ XN|U + section mapping
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 orr =A0 =A0 r1, r1, #3 << 10 =A0 =A0 =A0=
 =A0@ AP=3D11
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add =A0 =A0 r2, r3, #16384
> =A01: =A0 =A0 =A0 =A0 =A0 =A0 cmp =A0 =A0 r1, r9 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0@ if virt > start of RAM
> -#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 orrhs =A0 r1, r1, #0x08 =A0 =A0 =A0 =A0=
 =A0 @ set cacheable
> -#else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 orrhs =A0 r1, r1, #0x0c =A0 =A0 =A0 =A0=
 =A0 @ set cacheable, bufferable
> -#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmp =A0 =A0 r1, r10 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 @ if virt > end of RAM
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bichs =A0 r1, r1, #0x0c =A0 =A0 =A0 =A0=
 =A0 @ clear cacheable, bufferable
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmphs =A0 r10, r1 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 @ =A0 && end of RAM > virt
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bic =A0 =A0 r1, r1, #0x1c =A0 =A0 =A0 =A0=
 =A0 @ clear XN|U + C + B
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 orrlo =A0 r1, r1, #0x10 =A0 =A0 =A0 =A0=
 =A0 @ Set XN|U for non-RAM
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 orrhs =A0 r1, r1, r6 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0@ set RAM section settings
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str =A0 =A0 r1, [r0], #4 =A0 =A0 =A0 =A0=
 =A0 =A0@ 1:1 mapping
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add =A0 =A0 r1, r1, #1048576
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0teq =A0 =A0 r0, r2
> @@ -599,7 +602,7 @@ __setup_mmu: =A0 =A0 =A0 =A0sub =A0 =A0 r3, r4, #=
16384 =A0 =A0 =A0 =A0 =A0@ Page directory size
> =A0* so there is no map overlap problem for up to 1 MB compressed ker=
nel.
> =A0* If the execution is in RAM then we would only be duplicating the=
 above.
> =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r1, #0x1e
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 orr =A0 =A0 r1, r6, #0x04 =A0 =A0 =A0 =A0=
 =A0 @ ensure B is set for this
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0orr =A0 =A0 r1, r1, #3 << 10
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r2, pc
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r2, r2, lsr #20
> @@ -620,6 +623,7 @@ __arm926ejs_mmu_cache_on:
> =A0__armv4_mmu_cache_on:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r12, lr
> =A0#ifdef CONFIG_MMU
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r6, #CB_BITS | 0x12 =A0 =A0=
 @ U
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bl =A0 =A0 =A0__setup_mmu
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r0, #0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0=
@ drain write buffer
> @@ -641,6 +645,7 @@ __armv7_mmu_cache_on:
> =A0#ifdef CONFIG_MMU
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mrc =A0 =A0 p15, 0, r11, c0, c1, 4 =A0=
@ read ID_MMFR0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst =A0 =A0 r11, #0xf =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 @ VMSA
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 movne =A0 r6, #CB_BITS | 0x02 =A0 =A0 @=
 !XN
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0blne =A0 =A0__setup_mmu
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r0, #0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0=
@ drain write buffer
> @@ -655,7 +660,7 @@ __armv7_mmu_cache_on:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0orr =A0 =A0 r0, r0, #1 << 25 =A0 =A0 =A0=
 =A0@ big-endian page tables
> =A0#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0orrne =A0 r0, r0, #1 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0@ MMU enabled
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 movne =A0 r1, #-1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 movne =A0 r1, #0xfffffffd =A0 =A0 =A0 =A0=
 @ domain 0 =3D client
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcrne =A0 p15, 0, r3, c2, c0, 0 =A0 @ =
load page table pointer
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcrne =A0 p15, 0, r1, c3, c0, 0 =A0 @ =
load domain access control
> =A0#endif
> @@ -668,6 +673,7 @@ __armv7_mmu_cache_on:
>
> =A0__fa526_cache_on:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r12, lr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r6, #CB_BITS | 0x12 =A0 =A0=
 @ U
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bl =A0 =A0 =A0__setup_mmu
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r0, #0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c7, 0 =A0 =
@ Invalidate whole cache
> @@ -682,6 +688,7 @@ __fa526_cache_on:
>
> =A0__arm6_mmu_cache_on:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r12, lr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A0 r6, #CB_BITS | 0x12 =A0 =A0=
 @ U
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bl =A0 =A0 =A0__setup_mmu
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0 =A0 r0, #0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c0, 0 =A0 =
@ invalidate whole cache v3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
