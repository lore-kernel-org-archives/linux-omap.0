From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [Patch 1/4] Proc updates for ARM V7
Date: Tue, 5 Jun 2007 19:26:35 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701120B42@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Proc updates for ARM V7 Cache handling functions for OMAP3.=20

Derived from ARM GIT.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 proc-v7.S |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletion(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
--- linux-omap/arch/arm/mm/proc-v7.S	2007-05-16 14:32:40.000000000 -0500
+++ val_3430_GIT/arch/arm/mm/proc-v7.S	2007-06-05 19:02:19.000000000 =
-0500
@@ -176,6 +176,38 @@ __v7_setup:
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
 	mov	r10, #0x1f			@ domains 0, 1 =3D manager
 	mcr	p15, 0, r10, c3, c0, 0		@ load domain access register
+
+#if defined(CONFIG_ARCH_OMAP3)
+
+#ifndef CONFIG_CPU_L2CACHE_DISABLE
+	@ L2 cache is enabled in the aux control register
+	mrc	p15, 0, r0, c1, c0, 1
+	orr	r0, r0, #0x13		@ speculative+enable+no-alais protection
+	mov	r10, r12		@ r12 is this function's sp. back it up.
+        mov	r12, #0x3		@ AUXCR service
+        .word 0xE1600070		@ Call OMAP SMI monitor service
+	mov	r12, r10		@ restore r12.
+#endif
+	adr	r5, v7_crval
+	ldmia	r5, {r5, r6}
+	mrc	p15, 0, r0, c1, c0, 0	@ read control register
+	bic	r0, r0, r5		@ clear bits them
+	orr	r0, r0, r6		@ set them
+	mov	pc, lr			@ return to head.S:__ret
+
+	/*
+	 *  TAT N EV   F    H   R
+	 * .EFR M.EE .UI. ..A. .RVI Z... B... .CAM
+	 * 0xxx x0xx 11x0 01x1 0xxx x000 0111 1xxx < forced typical
+	 * r    rr   rr r rr r r     rrr rrrr r    < always read only
+	 * .000 ..00 ..0. ..0. .011 1... .... .101 < we want
+	 */
+	.type   v7_crval, #object
+v7_crval:
+    crval   clear=3D0x7322f006, mmuset=3D0x00003805, ucset=3D0x00001804
+
+#else
+
 #ifndef CONFIG_CPU_L2CACHE_DISABLE
 	@ L2 cache configuration in the L2 aux control register
 	mrc	p15, 1, r10, c9, c0, 2
@@ -205,6 +237,7 @@ cr1_clear:
 	.word	0x0120c302
 cr1_set:
 	.word	0x00c0387d
+#endif
=20
 __v7_setup_stack:
 	.space	4 * 11				@ 11 registers
@@ -256,7 +289,7 @@ __v7_proc_info:
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
 	.long	cpu_v7_name
 	.long	v7_processor_functions
-	.long	v6wbi_tlb_fns
+	.long	v7wbi_tlb_fns
 	.long	v6_user_fns
 	.long	v7_cache_fns
 	.size	__v7_proc_info, . - __v7_proc_info
