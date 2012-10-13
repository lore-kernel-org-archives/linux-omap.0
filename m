From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3
 and CONFIG_VFPv3 set
Date: Sat, 13 Oct 2012 04:46:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210130441300.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38539 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab2JMEqT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 00:46:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>


After commit 846a136881b8f73c1f74250bf6acfaa309cab1f2 ("ARM: vfp: fix
saving d16-d31 vfp registers on v6+ kernels"), the OMAP 2430SDP board
started crashing during boot with omap2plus_defconfig:

[    3.875122] mmcblk0: mmc0:e624 SD04G 3.69 GiB
[    3.915954]  mmcblk0: p1
[    4.086639] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
[    4.093719] Modules linked in:
[    4.096954] CPU: 0    Not tainted  (3.6.0-02232-g759e00b #570)
[    4.103149] PC is at vfp_reload_hw+0x1c/0x44
[    4.107666] LR is at __und_usr_fault_32+0x0/0x8

It turns out that the context save/restore fix unmasked a latent bug in 
commit 5aaf254409f8d58229107b59507a8235b715a960 ("ARM: 6203/1: Make VFPv3 
usable on ARMv6").  When CONFIG_VFPv3 is set, but the kernel is booted on 
a pre-VFPv3 core, the code attempts to save and restore the d16-d31 VFP 
registers.  These are only present on non-D16 VFPv3+, so the kernel dies 
with an undefined instruction exception.  The kernel didn't crash before 
commit 846a136 because the save and restore code only touched d0-d15, 
present on all VFP.

Fix to save and restore the d16-d31 registers only if they are
present.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/vfp.h       |    6 ++++++
 arch/arm/include/asm/vfpmacros.h |    8 ++++----
 arch/arm/vfp/vfpmodule.c         |   10 ++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index f4ab34f..5689798 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -82,3 +82,9 @@
 #define VFPOPDESC_UNUSED_BIT	(24)
 #define VFPOPDESC_UNUSED_MASK	(0xFF << VFPOPDESC_UNUSED_BIT)
 #define VFPOPDESC_OPDESC_MASK	(~(VFPOPDESC_LENGTH_MASK | VFPOPDESC_UNUSED_MASK))
+
+#ifndef __ASSEMBLER__
+#include <linux/types.h>
+
+extern u32 vfp_has_d16_d31;
+#endif
diff --git a/arch/arm/include/asm/vfpmacros.h b/arch/arm/include/asm/vfpmacros.h
index 6a6f1e4..11496a9 100644
--- a/arch/arm/include/asm/vfpmacros.h
+++ b/arch/arm/include/asm/vfpmacros.h
@@ -25,9 +25,9 @@
 #endif
 #ifdef CONFIG_VFPv3
 #if __LINUX_ARM_ARCH__ <= 6
-	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
+	ldr	\tmp, =vfp_has_d16_d31		    @ have VFP regs d16-d31?
 	ldr	\tmp, [\tmp, #0]
-	tst	\tmp, #HWCAP_VFPv3D16
+	cmp	\tmp, #1
 	ldceql	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
 	addne	\base, \base, #32*4		    @ step over unused register space
 #else
@@ -49,9 +49,9 @@
 #endif
 #ifdef CONFIG_VFPv3
 #if __LINUX_ARM_ARCH__ <= 6
-	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
+	ldr	\tmp, =vfp_has_d16_d31		    @ have VFP regs d16-d31?
 	ldr	\tmp, [\tmp, #0]
-	tst	\tmp, #HWCAP_VFPv3D16
+	cmp	\tmp, #1
 	stceql	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
 	addne	\base, \base, #32*4		    @ step over unused register space
 #else
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index c834b32..929b53b 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -58,6 +58,12 @@ unsigned int VFP_arch;
 union vfp_state *vfp_current_hw_state[NR_CPUS];
 
 /*
+ * If the VFP on this ARM core has registers d16-d31, vfp_has_d16_d31 will
+ * be set to 1; otherwise, 0.  Only valid after startup.
+ */
+u32 vfp_has_d16_d31;
+
+/*
  * Is 'thread's most up to date state stored in this CPUs hardware?
  * Must be called from non-preemptible context.
  */
@@ -691,6 +697,8 @@ static int __init vfp_init(void)
 		thread_register_notifier(&vfp_notifier_block);
 		vfp_pm_init();
 
+		vfp_has_d16_d31 = 0;
+
 		/*
 		 * We detected VFP, and the support code is
 		 * in place; report VFP support to userspace.
@@ -706,6 +714,8 @@ static int __init vfp_init(void)
 			 */
 			if (((fmrx(MVFR0) & MVFR0_A_SIMD_MASK)) == 1)
 				elf_hwcap |= HWCAP_VFPv3D16;
+			else
+				vfp_has_d16_d31 = 1;
 		}
 #endif
 		/*
-- 
1.7.10.4

