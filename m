From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Fri, 9 Sep 2011 23:27:30 +0800
Message-ID: <20110909152729.GG32138@S2100-06.ap.freescale.net>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
 <20110909080416.GF31581@S2100-06.ap.freescale.net>
 <4E69C9CF.6090709@ti.com>
 <20110909141321.GC32138@S2100-06.ap.freescale.net>
 <CAMQu2gxeDzFGyhsXK-wDkyiJRoD6_GN58m=3_=NC8yKa_ThJnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:10890 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1IIPTA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 11:19:00 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gxeDzFGyhsXK-wDkyiJRoD6_GN58m=3_=NC8yKa_ThJnQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, Dave Martin <dave.martin@linaro.org>

On Fri, Sep 09, 2011 at 07:41:08PM +0530, Shilimkar, Santosh wrote:
> On Fri, Sep 9, 2011 at 7:43 PM, Shawn Guo <shawn.guo@freescale.com> w=
rote:
> > On Fri, Sep 09, 2011 at 01:39:51PM +0530, Santosh wrote:
> >> On Friday 09 September 2011 01:34 PM, Shawn Guo wrote:
> >> >Hi Santosh,
> >> >
> >> >On Sun, Sep 04, 2011 at 07:24:15PM +0530, Santosh Shilimkar wrote=
:
> >> >>This patch adds the CPU0 and CPU1 off mode support. CPUX close s=
witch
> >> >>retention (CSWR) is not supported by hardware design.
> >> >>
> >> >>The CPUx OFF mode isn't supported on OMAP4430 ES1.0
> >> >>
> >> >>CPUx sleep code is common for hotplug, suspend and CPUilde.
> >> >>
> >> >>Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> >> >>Cc: Kevin Hilman<khilman@ti.com>
> >> >>---
> >> >> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A03 +-
> >> >> =A0arch/arm/mach-omap2/include/mach/omap-secure.h =A0| =A0 =A08=
 +
> >> >> =A0arch/arm/mach-omap2/include/mach/omap4-common.h | =A0 25 +++
> >> >> =A0arch/arm/mach-omap2/omap-mpuss-lowpower.c =A0 =A0 =A0 | =A02=
49 +++++++++++++++++++++++
> >> >> =A0arch/arm/mach-omap2/omap-smp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A06 +
> >> >> =A0arch/arm/mach-omap2/omap4-sar-layout.h =A0 =A0 =A0 =A0 =A0| =
=A0 =A09 +
> >> >> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A06 +
> >> >> =A0arch/arm/mach-omap2/sleep44xx.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0213 +++++++++++++++++++
> >> >> =A08 files changed, 518 insertions(+), 1 deletions(-)
> >> >> =A0create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c
> >> >>
> >> >
> >> >[...]
> >> >
> >> >>diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-oma=
p2/sleep44xx.S
> >> >>index 049f426..230ab8c 100644
> >> >>--- a/arch/arm/mach-omap2/sleep44xx.S
> >> >>+++ b/arch/arm/mach-omap2/sleep44xx.S
> >> >>@@ -11,8 +11,221 @@
> >> >>
> >> >> =A0#include<linux/linkage.h>
> >> >> =A0#include<asm/system.h>
> >> >>+#include<asm/smp_scu.h>
> >> >>+#include<asm/memory.h>
> >> >>+#include<asm/hardware/cache-l2x0.h>
> >> >>
> >> >>+#include<plat/omap44xx.h>
> >> >> =A0#include<mach/omap4-common.h>
> >> >>+#include<mach/omap-secure.h>
> >> >>+
> >> >>+#include "omap4-sar-layout.h"
> >> >>+
> >> >>+#ifdef CONFIG_SMP
> >> >>+
> >> >>+.macro =A0 =A0 DO_SMC
> >> >>+ =A0 dsb
> >> >>+ =A0 smc =A0 =A0 #0
> >> >>+ =A0 dsb
> >> >>+.endm
> >> >>+
> >> >>+ppa_zero_params:
> >> >>+ =A0 .word =A0 =A0 =A0 =A0 =A0 0x0
> >> >>+
> >> >>+/*
> >> >>+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>+ * =3D=3D CPU suspend finisher =3D=3D
> >> >>+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>+ *
> >> >>+ * void omap4_finish_suspend(unsigned long cpu_state)
> >> >>+ *
> >> >>+ * This function code saves the CPU context and performs the CP=
U
> >> >>+ * power down sequence. Calling WFI effectively changes the CPU
> >> >>+ * power domains states to the desired target power state.
> >> >>+ *
> >> >>+ * @cpu_state : contains context save state (r0)
> >> >>+ * 0 - No context lost
> >> >>+ * =A0 =A0 =A0 =A0 1 - CPUx L1 and logic lost: MPUSS CSWR
> >> >>+ * =A0 =A0 =A0 =A0 2 - CPUx L1 and logic lost + GIC lost: MPUSS=
 OSWR
> >> >>+ * 3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
> >> >
> >> >I was told by rmk that same as imx6q, omap44xx will retain L2 con=
tent
> >> >across suspen/resume cycle. =A0Then what does "L2 lost" mean here=
? =A0Or
> >> >what rmk meant is the case cpu_state =3D=3D 2?
> >> >
> >> Yes.
> >>
> >> The last case is entire SOC OFF. We call Device OFF in OMAP.
> >> All voltages will scale to 0 V. This isn't supported by this
> >> series.
> >>
> > Then the second question would be what the following patch in this
> > series is for.
> >
> > =A0 =A0[PATCH 20/25] OMAP4: PM: Add L2X0 cache lowpower support
> >
> > I could have read the patch incorrectly, but it seems l2x_clean_inv
> > will also be called for "MPUSS OSWR" in which case L2 is retained?
> > Shouldn't L2 for this case have been handled by rmk's patch (ARM: p=
m:
> > add L2 cache cleaning for suspend)?
> >
> Yes you did read it wrongly :)
> It won't be called for OSWR
>=20
Come on, man.  It's really hard for me who is still at entry level of
assembly to understand that.  So please help me out.

The following is a copy from arch/arm/mach-omap2/sleep44xx.S after I
apply this patch series on v3.1-rc4.

> /*
>  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  * =3D=3D CPU suspend finisher =3D=3D
>  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  *
>  * void omap4_finish_suspend(unsigned long cpu_state)
>  *
>  * This function code saves the CPU context and performs the CPU
>  * power down sequence. Calling WFI effectively changes the CPU
>  * power domains states to the desired target power state.
>  *
>  * @cpu_state : contains context save state (r0)

So cpu_state is passed in r0.

>  *	0 - No context lost
>  * 	1 - CPUx L1 and logic lost: MPUSS CSWR
>  * 	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
>  *	3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
>  * @return: This function never returns for CPU OFF and DORMANT power=
 states.
>  * Post WFI, CPU transitions to DORMANT or OFF power state and on wak=
e-up
>  * from this follows a full CPU reset path via ROM code to CPU restor=
e code.
>  * It returns to the caller for CPU INACTIVE and ON power states or i=
n case
>  * CPU failed to transition to targeted OFF/DORMANT state.
>  */
> ENTRY(omap4_finish_suspend)
> 	stmfd	sp!, {lr}
> 	cmp	r0, #0x0
> 	beq	do_WFI				@ No lowpower state, jump to WFI

The case "0" is handled here.

>=20
> 	/*
> 	 * Flush all data from the L1 data cache before disabling
> 	 * SCTLR.C bit.
> 	 */
> 	bl	omap4_get_sar_ram_base

Isn't r0 lost here?

> 	ldr	r9, [r0, #OMAP_TYPE_OFFSET]
> 	cmp	r9, #0x1			@ Check for HS device
> 	bne	skip_secure_l1_clean
> 	mov	r0, #SCU_PM_NORMAL
> 	mov	r1, #0xFF			@ clean seucre L1
> 	stmfd   r13!, {r4-r12, r14}
> 	ldr	r12, =3DOMAP4_MON_SCU_PWR_INDEX
> 	DO_SMC
> 	ldmfd   r13!, {r4-r12, r14}
> skip_secure_l1_clean:
>=20
> 	/*
> 	 * Clear the SCTLR.C bit to prevent further data cache
> 	 * allocation. Clearing SCTLR.C would make all the data accesses
> 	 * strongly ordered and would not hit the cache.
> 	 */
> 	mrc	p15, 0, r0, c1, c0, 0
> 	bic	r0, r0, #(1 << 2)		@ Disable the C bit
> 	mcr	p15, 0, r0, c1, c0, 0
> 	isb
>=20
> 	/*
> 	 * Invalidate L1 data cache. Even though only invalidate is
> 	 * necessary exported flush API is used here. Doing clean
> 	 * on already clean cache would be almost NOP.
> 	 */
> 	bl	v7_flush_dcache_all
>=20
> 	/*
> 	 * Switch the CPU from Symmetric Multiprocessing (SMP) mode
> 	 * to AsymmetricMultiprocessing (AMP) mode by programming
> 	 * the SCU power status to DORMANT or OFF mode.
> 	 * This enables the CPU to be taken out of coherency by
> 	 * preventing the CPU from receiving cache, TLB, or BTB
> 	 * maintenance operations broadcast by other CPUs in the cluster.
> 	 */
> 	bl	omap4_get_sar_ram_base
> 	mov	r8, r0
> 	ldr	r9, [r8, #OMAP_TYPE_OFFSET]
> 	cmp	r9, #0x1			@ Check for HS device
> 	bne	scu_gp_set
> 	mrc	p15, 0, r0, c0, c0, 5		@ Read MPIDR
> 	ands	r0, r0, #0x0f
> 	ldreq	r0, [r8, #SCU_OFFSET0]
> 	ldrne	r0, [r8, #SCU_OFFSET1]
> 	mov	r1, #0x00
> 	stmfd   r13!, {r4-r12, r14}
> 	ldr	r12, =3DOMAP4_MON_SCU_PWR_INDEX
> 	DO_SMC
> 	ldmfd   r13!, {r4-r12, r14}
> 	b	skip_scu_gp_set
> scu_gp_set:
> 	mrc	p15, 0, r0, c0, c0, 5		@ Read MPIDR
> 	ands	r0, r0, #0x0f
> 	ldreq	r1, [r8, #SCU_OFFSET0]
> 	ldrne	r1, [r8, #SCU_OFFSET1]
> 	bl	omap4_get_scu_base
> 	bl	scu_power_mode
> skip_scu_gp_set:
> 	mrc	p15, 0, r0, c1, c1, 2		@ Read NSACR data
> 	tst	r0, #(1 << 18)
> 	mrcne	p15, 0, r0, c1, c0, 1
> 	bicne	r0, r0, #(1 << 6)		@ Disable SMP bit
> 	mcrne	p15, 0, r0, c1, c0, 1
> 	isb
> 	dsb
> #ifdef CONFIG_CACHE_L2X0
> 	/*
> 	 * Clean and invalidate the L2 cache.
> 	 * Common cache-l2x0.c functions can't be used here since it
> 	 * uses spinlocks. We are out of coherency here with data cache
> 	 * disabled. The spinlock implementation uses exclusive load/store
> 	 * instruction which can fail without data cache being enabled.
> 	 * OMAP4 hardware doesn't support exclusive monitor which can
> 	 * overcome exclusive access issue. Because of this, CPU can
> 	 * lead to deadlock.
> 	 */
> l2x_clean_inv:
> 	bl	omap4_get_sar_ram_base
> 	mov	r8, r0
> 	mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
> 	ands	r5, r5, #0x0f
> 	ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]
> 	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]
> 	cmp	r0, #3
> 	bne	do_WFI

It looks like you are bypassing L2 clean and invalidate for cases
"1" and "2" here.  But I really do not understand how you get r0
back here.

Regards,
Shawn

> #ifdef CONFIG_PL310_ERRATA_727915
> 	mov	r0, #0x03
> 	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
> 	DO_SMC
> #endif
> 	bl	omap4_get_l2cache_base
> 	mov	r2, r0
> 	ldr	r0, =3D0xffff
> 	str	r0, [r2, #L2X0_CLEAN_INV_WAY]
> wait:
> 	ldr	r0, [r2, #L2X0_CLEAN_INV_WAY]
> 	ldr	r1, =3D0xffff
> 	ands	r0, r0, r1
> 	bne	wait
> #ifdef CONFIG_PL310_ERRATA_727915
> 	mov	r0, #0x00
> 	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
> 	DO_SMC
> #endif
> l2x_sync:
> 	bl	omap4_get_l2cache_base
> 	mov	r2, r0
> 	mov	r0, #0x0
> 	str	r0, [r2, #L2X0_CACHE_SYNC]
> sync:
> 	ldr	r0, [r2, #L2X0_CACHE_SYNC]
> 	ands	r0, r0, #0x1
> 	bne	sync
> #endif
>=20
> do_WFI:
> 	bl	omap_do_wfi
>=20
> 	/*
> 	 * CPU is here when it failed to enter OFF/DORMANT or
> 	 * no low power state was attempted.
> 	 */
> 	mrc	p15, 0, r0, c1, c0, 0
> 	tst	r0, #(1 << 2)			@ Check C bit enabled?
> 	orreq	r0, r0, #(1 << 2)		@ Enable the C bit
> 	mcreq	p15, 0, r0, c1, c0, 0
> 	isb
>=20
> 	/*
> 	 * Ensure the CPU power state is set to NORMAL in
> 	 * SCU power state so that CPU is back in coherency.
> 	 * In non-coherent mode CPU can lock-up and lead to
> 	 * system deadlock.
> 	 */
> 	mrc	p15, 0, r0, c1, c0, 1
> 	tst	r0, #(1 << 6)			@ Check SMP bit enabled?
> 	orreq	r0, r0, #(1 << 6)
> 	mcreq	p15, 0, r0, c1, c0, 1
> 	isb
> 	bl	omap4_get_sar_ram_base
> 	mov	r8, r0
> 	ldr	r9, [r8, #OMAP_TYPE_OFFSET]
> 	cmp	r9, #0x1			@ Check for HS device
> 	bne	scu_gp_clear
> 	mov	r0, #SCU_PM_NORMAL
> 	mov	r1, #0x00
> 	stmfd   r13!, {r4-r12, r14}
> 	ldr	r12, =3DOMAP4_MON_SCU_PWR_INDEX
> 	DO_SMC
> 	ldmfd   r13!, {r4-r12, r14}
> 	b	skip_scu_gp_clear
> scu_gp_clear:
> 	bl	omap4_get_scu_base
> 	mov	r1, #SCU_PM_NORMAL
> 	bl	scu_power_mode
> skip_scu_gp_clear:
> 	isb
> 	dsb
> 	ldmfd	sp!, {pc}
> ENDPROC(omap4_finish_suspend)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
