From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] arm: Make VFPv3 usable on ARMv6
Date: Mon, 21 Jun 2010 16:51:25 +0300
Message-ID: <20100621135125.24299.91290.stgit@baageli.muru.com>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55010 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438Ab0FUNvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 09:51:15 -0400
In-Reply-To: <20100621133749.24299.36154.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

MVFR0 and MVFR1 are only available starting with ARM1136 r1p0 release
according to "B.5 VFP changes" in DDI0211F_arm1136_r1p0_trm.pdf. This is
also when TLS register got added, so we can use HAS_TLS also to test for
MVFR0 and MVFR1.

Otherwise VFPFMRX and VFPFMXR access fails and we get:

Internal error: Oops - undefined instruction: 0 [#1]
PC is at no_old_VFP_process+0x8/0x3c
LR is at __und_svc+0x48/0x80
...

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/vfpmacros.h |   18 ++++++++++++++++++
 arch/arm/vfp/vfpmodule.c         |   10 +++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/vfpmacros.h b/arch/arm/include/asm/vfpmacros.h
index 422f3cc..3d5fc41 100644
--- a/arch/arm/include/asm/vfpmacros.h
+++ b/arch/arm/include/asm/vfpmacros.h
@@ -3,6 +3,8 @@
  *
  * Assembler-only file containing VFP macros and register definitions.
  */
+#include <asm/hwcap.h>
+
 #include "vfp.h"
 
 @ Macros to allow building with old toolkits (with no VFP support)
@@ -22,12 +24,20 @@
 	LDC	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d0-d15}
 #endif
 #ifdef CONFIG_VFPv3
+#if __LINUX_ARM_ARCH__ <= 6
+	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
+	ldr	\tmp, [\tmp, #0]
+	tst	\tmp, #HWCAP_VFPv3D16
+	ldceq	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
+	addne	\base, \base, #32*4		    @ step over unused register space
+#else
 	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0
 	and	\tmp, \tmp, #MVFR0_A_SIMD_MASK	    @ A_SIMD field
 	cmp	\tmp, #2			    @ 32 x 64bit registers?
 	ldceql	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
 	addne	\base, \base, #32*4		    @ step over unused register space
 #endif
+#endif
 	.endm
 
 	@ write all the working registers out of the VFP
@@ -38,10 +48,18 @@
 	STC	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d0-d15}
 #endif
 #ifdef CONFIG_VFPv3
+#if __LINUX_ARM_ARCH__ <= 6
+	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
+	ldr	\tmp, [\tmp, #0]
+	tst	\tmp, #HWCAP_VFPv3D16
+	stceq	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
+	addne	\base, \base, #32*4		    @ step over unused register space
+#else
 	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0
 	and	\tmp, \tmp, #MVFR0_A_SIMD_MASK	    @ A_SIMD field
 	cmp	\tmp, #2			    @ 32 x 64bit registers?
 	stceql	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
 	addne	\base, \base, #32*4		    @ step over unused register space
 #endif
+#endif
 	.endm
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 315a540..19ba626 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -549,10 +549,14 @@ static int __init vfp_init(void)
 		/*
 		 * Check for the presence of the Advanced SIMD
 		 * load/store instructions, integer and single
-		 * precision floating point operations.
+		 * precision floating point operations. Only check
+		 * for NEON if the hardware has TLS register as the
+		 * MVFR registers got added in ARM1136 r1p0 with TLS.
 		 */
-		if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
-			elf_hwcap |= HWCAP_NEON;
+		if (elf_hwcap & HWCAP_TLS) {
+			if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
+				elf_hwcap |= HWCAP_NEON;
+		}
 #endif
 	}
 	return 0;

