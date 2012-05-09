From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
	address space.
Date: Wed, 9 May 2012 16:48:49 +0100
Message-ID: <20120509154849.GA10375@n2100.arm.linux.org.uk>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com> <20120508124116.GE17798@arm.com> <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com> <20120508215554.GA18980@n2100.arm.linux.org.uk> <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com> <20120509122348.GA30632@n2100.arm.linux.org.uk> <CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37548 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008Ab2EIPt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 11:49:57 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Wed, May 09, 2012 at 06:00:10PM +0530, Shilimkar, Santosh wrote:
> On Wed, May 9, 2012 at 5:53 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh wrote:
> >> The only change done common code is =A0clearing 'XN' bit for DRAM
> >> region in page table entries. The other change of setting the DACR
> >> register is done in ARMv7 specific code.
> >
> > Yes, XN is an ARMv6+ thing. =A0Before ARMv5, it was implementation =
defined.
> >
> > Some implementations used the bit to mean "allow writes to update t=
he
> > cache". =A0Other implementations labelled this bit as "should be ze=
ro"
> > while others labelled it as "should be one".
> >
> Good to know.
>=20
> > The upshot of this is, we know that having this bit as '1' means th=
at
> > all the CPUs we support today work. =A0I would be _very_ concerned =
to
> > change this bit to zero as we _really_ don't know how the pre-ARMv6
> > CPUs would react.
> >
> I agree.
>=20
> > The solution to this is pretty simple - if ARMv6+ needs a different
> > base section mapping value, then we need to extract that from the c=
ode
> > and pass in the base section mapping value.
> >
> > I'll sort out a patch later today for this.
> Great.

This works for my 4430SDP board.  I haven't booted it on anything else =
yet.
Please can you check that this solves the issue for you?  Thanks.

 arch/arm/boot/compressed/head.S |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed=
/head.S
index dc7e8ce..5ad33a4 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -567,6 +567,12 @@ __armv3_mpu_cache_on:
 		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
 		mov	pc, lr
=20
+#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
+#define CB_BITS 0x08
+#else
+#define CB_BITS 0x0c
+#endif
+
 __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
 		bic	r3, r3, #0xff		@ Align the pointer
 		bic	r3, r3, #0x3f00
@@ -578,17 +584,14 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory=
 size
 		mov	r9, r0, lsr #18
 		mov	r9, r9, lsl #18		@ start of RAM
 		add	r10, r9, #0x10000000	@ a reasonable RAM size
-		mov	r1, #0x12
-		orr	r1, r1, #3 << 10
+		mov	r1, #0x12		@ XN|U + section mapping
+		orr	r1, r1, #3 << 10	@ AP=3D11
 		add	r2, r3, #16384
 1:		cmp	r1, r9			@ if virt > start of RAM
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-		orrhs	r1, r1, #0x08		@ set cacheable
-#else
-		orrhs	r1, r1, #0x0c		@ set cacheable, bufferable
-#endif
-		cmp	r1, r10			@ if virt > end of RAM
-		bichs	r1, r1, #0x0c		@ clear cacheable, bufferable
+		cmphs	r10, r1			@   && end of RAM > virt
+		bic	r1, r1, #0x1c		@ clear XN|U + C + B
+		orrlo	r1, r1, #0x10		@ Set XN|U for non-RAM
+		orrhs	r1, r1, r6		@ set RAM section settings
 		str	r1, [r0], #4		@ 1:1 mapping
 		add	r1, r1, #1048576
 		teq	r0, r2
@@ -599,7 +602,7 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory s=
ize
  * so there is no map overlap problem for up to 1 MB compressed kernel=
=2E
  * If the execution is in RAM then we would only be duplicating the ab=
ove.
  */
-		mov	r1, #0x1e
+		orr	r1, r6, #0x04		@ ensure B is set for this
 		orr	r1, r1, #3 << 10
 		mov	r2, pc
 		mov	r2, r2, lsr #20
@@ -620,6 +623,7 @@ __arm926ejs_mmu_cache_on:
 __armv4_mmu_cache_on:
 		mov	r12, lr
 #ifdef CONFIG_MMU
+		mov	r6, #CB_BITS | 0x12	@ U
 		bl	__setup_mmu
 		mov	r0, #0
 		mcr	p15, 0, r0, c7, c10, 4	@ drain write buffer
@@ -641,6 +645,7 @@ __armv7_mmu_cache_on:
 #ifdef CONFIG_MMU
 		mrc	p15, 0, r11, c0, c1, 4	@ read ID_MMFR0
 		tst	r11, #0xf		@ VMSA
+		movne	r6, #CB_BITS | 0x02	@ !XN
 		blne	__setup_mmu
 		mov	r0, #0
 		mcr	p15, 0, r0, c7, c10, 4	@ drain write buffer
@@ -655,7 +660,7 @@ __armv7_mmu_cache_on:
 		orr	r0, r0, #1 << 25	@ big-endian page tables
 #endif
 		orrne	r0, r0, #1		@ MMU enabled
-		movne	r1, #-1
+		movne	r1, #0xfffffffd		@ domain 0 =3D client
 		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
 		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
 #endif
@@ -668,6 +673,7 @@ __armv7_mmu_cache_on:
=20
 __fa526_cache_on:
 		mov	r12, lr
+		mov	r6, #CB_BITS | 0x12	@ U
 		bl	__setup_mmu
 		mov	r0, #0
 		mcr	p15, 0, r0, c7, c7, 0	@ Invalidate whole cache
@@ -682,6 +688,7 @@ __fa526_cache_on:
=20
 __arm6_mmu_cache_on:
 		mov	r12, lr
+		mov	r6, #CB_BITS | 0x12	@ U
 		bl	__setup_mmu
 		mov	r0, #0
 		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
