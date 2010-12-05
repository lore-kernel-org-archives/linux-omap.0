From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 5/5] ARM: GIC: private a standard get_irqnr_preamble assembler macro
Date: Sun, 05 Dec 2010 11:35:39 +0000
Message-ID: <E1PPCsV-0004xe-Ua@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45875 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab0LELfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:35:50 -0500
In-Reply-To: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Anton Vorontsov <avorontsov@mvista.com>, Tony Lindgren <tony@atomide.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-tegra@vger.kernel.org

Provide a standard get_irqnr_preamble assembler macro for platforms
to use, which retrieves the base address of the GIC CPU interface
from gic_cpu_base_addr.  Allow platforms to override this by defining
HAVE_GET_IRQNR_PREAMBLE.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/entry-macro-gic.S   |    7 +++++++
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |    5 -----
 arch/arm/mach-omap2/include/mach/entry-macro.S    |    1 +
 arch/arm/mach-realview/include/mach/entry-macro.S |    5 -----
 arch/arm/mach-tegra/include/mach/entry-macro.S    |    2 +-
 arch/arm/mach-ux500/include/mach/entry-macro.S    |    1 +
 arch/arm/mach-vexpress/include/mach/entry-macro.S |    5 -----
 7 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
index 05587f1..c115b82 100644
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
@@ -10,6 +10,13 @@
 
 #include <asm/hardware/gic.h>
 
+#ifndef HAVE_GET_IRQNR_PREAMBLE
+	.macro	get_irqnr_preamble, base, tmp
+	ldr	\base, =gic_cpu_base_addr
+	ldr	\base, [\base]
+	.endm
+#endif
+
 /*
  * The interrupt numbering scheme is defined in the
  * interrupt controller spec.  To wit:
diff --git a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
index e793c33..6bd83ed 100644
--- a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
@@ -14,10 +14,5 @@
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =gic_cpu_base_addr
-		ldr	\base, [\base]
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 2e358df..d54c4f8 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -170,6 +170,7 @@ omap_irq_base:	.word	0
 
 
 #ifdef CONFIG_ARCH_OMAP4
+#define HAVE_GET_IRQNR_PREAMBLE
 #include <asm/hardware/entry-macro-gic.S>
 
 		.macro  get_irqnr_preamble, base, tmp
diff --git a/arch/arm/mach-realview/include/mach/entry-macro.S b/arch/arm/mach-realview/include/mach/entry-macro.S
index 4417b10..4071164 100644
--- a/arch/arm/mach-realview/include/mach/entry-macro.S
+++ b/arch/arm/mach-realview/include/mach/entry-macro.S
@@ -13,11 +13,6 @@
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =gic_cpu_base_addr
-		ldr	\base, [\base]
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
diff --git a/arch/arm/mach-tegra/include/mach/entry-macro.S b/arch/arm/mach-tegra/include/mach/entry-macro.S
index dc09249..dd165c5 100644
--- a/arch/arm/mach-tegra/include/mach/entry-macro.S
+++ b/arch/arm/mach-tegra/include/mach/entry-macro.S
@@ -16,7 +16,7 @@
 #include <mach/io.h>
 
 #if defined(CONFIG_ARM_GIC)
-
+#define HAVE_GET_IRQNR_PREAMBLE
 #include <asm/hardware/entry-macro-gic.S>
 
 	/* Uses the GIC interrupt controller built into the cpu */
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
index 3cc3cdf..a37f585 100644
--- a/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 #include <mach/hardware.h>
+#define HAVE_GET_IRQNR_PREAMBLE
 #include <asm/hardware/entry-macro-gic.S>
 
 		.macro	disable_fiq
diff --git a/arch/arm/mach-vexpress/include/mach/entry-macro.S b/arch/arm/mach-vexpress/include/mach/entry-macro.S
index 19d5ac8..73c1129 100644
--- a/arch/arm/mach-vexpress/include/mach/entry-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/entry-macro.S
@@ -3,10 +3,5 @@
 	.macro	disable_fiq
 	.endm
 
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =gic_cpu_base_addr
-	ldr	\base, [\base]
-	.endm
-
 	.macro	arch_ret_to_user, tmp1, tmp2
 	.endm
-- 
1.6.2.5

