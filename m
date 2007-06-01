From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 1/12] Add VFP support for ARM V7 - OMAP 3430 support
Date: Fri, 1 Jun 2007 17:38:58 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47010BAFD4@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Add VFP support for ARM V7, derived from latest ARM's VfP V3 patch.=20
Tested on 2420 / 2430 / 3430.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/Kconfig                      |   16 ++++++++++++++--
 arch/arm/vfp/vfp.h                    |    4 ++++
 arch/arm/vfp/vfphw.S                  |   22 +++++++++++++++++++++-
 arch/arm/vfp/vfpinstr.h               |    6 +++---
 arch/arm/vfp/vfpmodule.c              |   14 +++++++++++---
 include/asm-arm/fpstate.h             |    6 ++++++
 include/asm-arm/vfp.h                 |    2 ++
 include/asm-arm/vfpmacros.h           |    6 ++++++
 8 files changed, 67 insertions(+), 9 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/vfp/vfp.h val_3430_GIT/arch/arm/vfp/vfp.h
--- linux-omap/arch/arm/Kconfig	2007-05-25 13:27:02.000000000 -0500
+++ val_3430_GIT/arch/arm/Kconfig	2007-06-01 15:27:04.000000000 -0500
@@ -393,7 +393,7 @@ config ARCH_OMAP
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
-	  Support for TI's OMAP platform (OMAP1 and OMAP2).
+	  Support for TI's OMAP platform (OMAP1, OMAP2 and OMAP3).
=20
 endchoice
=20
@@ -925,7 +925,7 @@ config FPE_FASTFPE
=20
 config VFP
 	bool "VFP-format floating point maths"
-	depends on CPU_V6 || CPU_ARM926T
+	depends on CPU_V6 || CPU_ARM926T || CPU_V7
 	help
 	  Say Y to include VFP support code in the kernel. This is needed
 	  if your hardware includes a VFP unit.
@@ -935,6 +935,18 @@ config VFP
=20
 	  Say N if your target does not have VFP hardware.
=20
+config VFPv3
+	bool
+	depends on VFP
+	default y if CPU_V7
+
+config NEON
+	bool "NEON Advanced SIMD Extension support"
+	depends on VFPv3 && CPU_V7
+	help
+	  Say Y to include support code for NEON, the ARMv7 Advanced SIMD
+	  Extensions.
+
 endmenu
=20
 menu "Userspace binary formats"
--- linux-omap/arch/arm/vfp/vfp.h	2007-02-16 09:43:28.000000000 -0600
+++ val_3430_GIT/arch/arm/vfp/vfp.h	2007-06-01 15:22:56.000000000 -0500
@@ -265,7 +265,11 @@ struct vfp_double {
  * which returns (double)0.0.  This is useful for the compare with
  * zero instructions.
  */
+#ifdef CONFIG_VFPv3
+#define VFP_REG_ZERO	32
+#else
 #define VFP_REG_ZERO	16
+#endif
 extern u64 vfp_get_double(unsigned int reg);
 extern void vfp_put_double(u64 val, unsigned int reg);
=20
diff -purN linux-omap/arch/arm/vfp/vfphw.S =
val_3430_GIT/arch/arm/vfp/vfphw.S
--- linux-omap/arch/arm/vfp/vfphw.S	2007-02-16 09:43:28.000000000 -0600
+++ val_3430_GIT/arch/arm/vfp/vfphw.S	2007-06-01 15:23:02.000000000 =
-0500
@@ -100,10 +100,12 @@ vfp_support_entry:
 	cmp	r4, #0
 	beq	no_old_VFP_process
 	VFPFMRX	r5, FPSCR		@ current status
+#ifndef CONFIG_VFPv3
 	VFPFMRX	r6, FPINST		@ FPINST (always there, rev0 onwards)
 	tst	r1, #FPEXC_FPV2		@ is there an FPINST2 to read?
 	VFPFMRX	r8, FPINST2, NE		@ FPINST2 if needed - avoids reading
 					@ nonexistant reg on rev0
+#endif
 	VFPFSTMIA r4 			@ save the working registers
 	stmia	r4, {r1, r5, r6, r8}	@ save FPEXC, FPSCR, FPINST, FPINST2
 					@ and point r4 at the word at the
@@ -117,10 +119,12 @@ no_old_VFP_process:
 	VFPFLDMIA r10	 		@ reload the working registers while
 					@ FPEXC is in a safe state
 	ldmia	r10, {r1, r5, r6, r8}	@ load FPEXC, FPSCR, FPINST, FPINST2
+#ifndef CONFIG_VFPv3
 	tst	r1, #FPEXC_FPV2		@ is there an FPINST2 to write?
 	VFPFMXR	FPINST2, r8, NE		@ FPINST2 if needed - avoids writing
 					@ nonexistant reg on rev0
 	VFPFMXR	FPINST, r6
+#endif
 	VFPFMXR	FPSCR, r5		@ restore status
=20
 check_for_exception:
@@ -175,10 +179,12 @@ vfp_save_state:
 	@ r1 - FPEXC
 	DBGSTR1	"save VFP state %p", r0
 	VFPFMRX	r2, FPSCR		@ current status
+#ifndef CONFIG_VFPv3
 	VFPFMRX	r3, FPINST		@ FPINST (always there, rev0 onwards)
 	tst	r1, #FPEXC_FPV2		@ is there an FPINST2 to read?
 	VFPFMRX	r12, FPINST2, NE	@ FPINST2 if needed - avoids reading
 					@ nonexistant reg on rev0
+#endif
 	VFPFSTMIA r0 			@ save the working registers
 	stmia	r0, {r1, r2, r3, r12}	@ save FPEXC, FPSCR, FPINST, FPINST2
 	mov	pc, lr
@@ -217,8 +223,15 @@ vfp_get_double:
 	fmrrd	r0, r1, d\dr
 	mov	pc, lr
 	.endr
+#ifdef CONFIG_VFPv3
+	@ d16 - d31 registers
+	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	mrrc	p11, 3, r0, r1, c\dr	@ fmrrd	r0, r1, d\dr
+	mov	pc, lr
+	.endr
+#endif
=20
-	@ virtual register 16 for compare with zero
+	@ virtual register 16 (or 32 if VFPv3) for compare with zero
 	mov	r0, #0
 	mov	r1, #0
 	mov	pc, lr
@@ -231,3 +244,10 @@ vfp_put_double:
 	fmdrr	d\dr, r0, r1
 	mov	pc, lr
 	.endr
+#ifdef CONFIG_VFPv3
+	@ d16 - d31 registers
+	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	mcrr	p11, 3, r1, r2, c\dr	@ fmdrr	r1, r2, d\dr
+	mov	pc, lr
+	.endr
+#endif
diff -purN linux-omap/arch/arm/vfp/vfpinstr.h =
val_3430_GIT/arch/arm/vfp/vfpinstr.h
--- linux-omap/arch/arm/vfp/vfpinstr.h	2006-11-20 21:54:06.000000000 =
-0600
+++ val_3430_GIT/arch/arm/vfp/vfpinstr.h	2007-06-01 15:23:08.000000000 =
-0500
@@ -52,11 +52,11 @@
 #define FEXT_TO_IDX(inst)	((inst & 0x000f0000) >> 15 | (inst & (1 << =
7)) >> 7)
=20
 #define vfp_get_sd(inst)	((inst & 0x0000f000) >> 11 | (inst & (1 << =
22)) >> 22)
-#define vfp_get_dd(inst)	((inst & 0x0000f000) >> 12)
+#define vfp_get_dd(inst)	((inst & 0x0000f000) >> 12 | (inst & (1 << =
22)) >> 18)
 #define vfp_get_sm(inst)	((inst & 0x0000000f) << 1 | (inst & (1 << 5)) =
>> 5)
-#define vfp_get_dm(inst)	((inst & 0x0000000f))
+#define vfp_get_dm(inst)	((inst & 0x0000000f) | (inst & (1 << 5)) >> 1)
 #define vfp_get_sn(inst)	((inst & 0x000f0000) >> 15 | (inst & (1 << 7)) =
>> 7)
-#define vfp_get_dn(inst)	((inst & 0x000f0000) >> 16)
+#define vfp_get_dn(inst)	((inst & 0x000f0000) >> 16 | (inst & (1 << 7)) =
>> 3)
=20
 #define vfp_single(inst)	(((inst) & 0x0000f00) =3D=3D 0xa00)
=20
diff -purN linux-omap/arch/arm/vfp/vfpmodule.c =
val_3430_GIT/arch/arm/vfp/vfpmodule.c
--- linux-omap/arch/arm/vfp/vfpmodule.c	2007-02-16 09:43:28.000000000 =
-0600
+++ val_3430_GIT/arch/arm/vfp/vfpmodule.c	2007-06-01 15:23:18.000000000 =
-0500
@@ -124,13 +124,13 @@ void vfp_raise_sigfpe(unsigned int sicod
 	send_sig_info(SIGFPE, &info, current);
 }
=20
-static void vfp_panic(char *reason)
+static void vfp_panic(char *reason, u32 inst)
 {
 	int i;
=20
 	printk(KERN_ERR "VFP: Error: %s\n", reason);
 	printk(KERN_ERR "VFP: EXC 0x%08x SCR 0x%08x INST 0x%08x\n",
-		fmrx(FPEXC), fmrx(FPSCR), fmrx(FPINST));
+		fmrx(FPEXC), fmrx(FPSCR), inst);
 	for (i =3D 0; i < 32; i +=3D 2)
 		printk(KERN_ERR "VFP: s%2u: 0x%08x s%2u: 0x%08x\n",
 		       i, vfp_get_float(i), i+1, vfp_get_float(i+1));
@@ -146,7 +146,7 @@ static void vfp_raise_exceptions(u32 exc
 	pr_debug("VFP: raising exceptions %08x\n", exceptions);
=20
 	if (exceptions =3D=3D VFP_EXCEPTION_ERROR) {
-		vfp_panic("unhandled bounce");
+		vfp_panic("unhandled bounce", inst);
 		vfp_raise_sigfpe(0, regs);
 		return;
 	}
@@ -261,11 +261,16 @@ void VFP9_bounce(u32 trigger, u32 fpexc,
 	 * FPEXC bounce reason, but this appears to be unreliable.
 	 * Emulate the bounced instruction instead.
 	 */
+#ifndef CONFIG_VFPv3
 	inst =3D fmrx(FPINST);
+#else
+	inst =3D trigger;
+#endif
 	exceptions =3D vfp_emulate_instruction(inst, fpscr, regs);
 	if (exceptions)
 		vfp_raise_exceptions(exceptions, inst, orig_fpscr, regs);
=20
+#ifndef CONFIG_VFPv3
 	/*
 	 * If there isn't a second FP instruction, exit now.
 	 */
@@ -279,6 +284,9 @@ void VFP9_bounce(u32 trigger, u32 fpexc,
 	barrier();
 	trigger =3D fmrx(FPINST2);
 	orig_fpscr =3D fpscr =3D fmrx(FPSCR);
+#else
+	return;
+#endif
=20
  emulate:
 	exceptions =3D vfp_emulate_instruction(trigger, fpscr, regs);
--- linux-omap/include/asm-arm/vfpmacros.h	2006-11-20 21:57:05.000000000 =
-0600
+++ val_3430_GIT/include/asm-arm/vfpmacros.h	2007-06-01 =
15:24:17.000000000 -0500
@@ -21,6 +21,9 @@
 #else
 	LDC	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d0-d15}
 #endif
+#ifdef CONFIG_VFPv3
+	LDCL	p11, cr0, [\base],#32*4			@ FLDMIAD \base!, {d16-d31}
+#endif
 	.endm
=20
 	@ write all the working registers out of the VFP
@@ -30,4 +33,7 @@
 #else
 	STC	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d0-d15}
 #endif
+#ifdef CONFIG_VFPv3
+	STCL	p11, cr0, [\base],#32*4			@ FSTMIAD \base!, {d16-d31}
+#endif
 	.endm
--- linux-omap/include/asm-arm/vfp.h	2006-11-20 21:57:05.000000000 -0600
+++ val_3430_GIT/include/asm-arm/vfp.h	2007-06-01 15:24:12.000000000 =
-0500
@@ -55,11 +55,13 @@
 #define FPSCR_IXC		(1<<4)
 #define FPSCR_IDC		(1<<7)
=20
+#ifndef CONFIG_VFPv3
 /*
  * VFP9-S specific.
  */
 #define FPINST			cr9
 #define FPINST2			cr10
+#endif
=20
 /* FPEXC bits */
 #define FPEXC_FPV2		(1<<28)
--- linux-omap/include/asm-arm/fpstate.h	2007-02-16 09:43:38.000000000 =
-0600
+++ val_3430_GIT/include/asm-arm/fpstate.h	2007-06-01 15:24:06.000000000 =
-0500
@@ -24,17 +24,23 @@
  */
=20
 struct vfp_hard_struct {
+#ifdef CONFIG_VFPv3
+	__u64 fpregs[32];
+#else
 	__u64 fpregs[16];
+#endif
 #if __LINUX_ARM_ARCH__ < 6
 	__u32 fpmx_state;
 #endif
 	__u32 fpexc;
 	__u32 fpscr;
+#ifndef CONFIG_VFPv3
 	/*
 	 * VFP implementation specific state
 	 */
 	__u32 fpinst;
 	__u32 fpinst2;
+#endif
 #ifdef CONFIG_SMP
 	__u32 cpu;
 #endif
