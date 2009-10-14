From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] omap: headers: Split entry-macro.S for mach-omap1 and
	mach-omap2
Date: Wed, 14 Oct 2009 14:49:20 -0700
Message-ID: <20091014214920.30227.10280.stgit@kaulin.muru.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014213748.30227.71513.stgit@kaulin.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Split entry-macro.S for mach-omap1 and mach-omap2

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

 arch/arm/mach-omap1/include/mach/entry-macro.S |   58 ++++++++
 arch/arm/mach-omap2/include/mach/entry-macro.S |  122 +++++++++++++++++
 arch/arm/plat-omap/include/mach/entry-macro.S  |  172 ------------------------
 3 files changed, 180 insertions(+), 172 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-omap2/include/mach/entry-macro.S
 delete mode 100644 arch/arm/plat-omap/include/mach/entry-macro.S

diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
new file mode 100644
index 0000000..2e98f86
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -0,0 +1,58 @@
+/*
+ * arch/arm/mach-omap1/include/mach/entry-macro.S
+ *
+ * Low-level IRQ helper macros for OMAP-based platforms
+ *
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <mach/hardware.h>
+#include <mach/io.h>
+#include <mach/irqs.h>
+#include <asm/hardware/gic.h>
+
+#if (defined(CONFIG_ARCH_OMAP730)||defined(CONFIG_ARCH_OMAP850)) && \
+	(defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX))
+#error "FIXME: OMAP730 doesn't support multiple-OMAP"
+#elif defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+#define INT_IH2_IRQ		INT_730_IH2_IRQ
+#elif defined(CONFIG_ARCH_OMAP15XX)
+#define INT_IH2_IRQ		INT_1510_IH2_IRQ
+#elif defined(CONFIG_ARCH_OMAP16XX)
+#define INT_IH2_IRQ		INT_1610_IH2_IRQ
+#else
+#warning "IH2 IRQ defaulted"
+#define INT_IH2_IRQ		INT_1510_IH2_IRQ
+#endif
+
+ 		.macro	disable_fiq
+		.endm
+
+		.macro  get_irqnr_preamble, base, tmp
+		.endm
+
+		.macro  arch_ret_to_user, tmp1, tmp2
+		.endm
+
+		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
+		ldr	\irqnr, [\base, #IRQ_ITR_REG_OFFSET]
+		ldr	\tmp, [\base, #IRQ_MIR_REG_OFFSET]
+		mov	\irqstat, #0xffffffff
+		bic	\tmp, \irqstat, \tmp
+		tst	\irqnr, \tmp
+		beq	1510f
+
+		ldr	\irqnr, [\base, #IRQ_SIR_FIQ_REG_OFFSET]
+		cmp	\irqnr, #0
+		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
+		cmpeq	\irqnr, #INT_IH2_IRQ
+		ldreq	\base, =OMAP1_IO_ADDRESS(OMAP_IH2_BASE)
+		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
+		addeqs	\irqnr, \irqnr, #32
+1510:
+		.endm
+
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
similarity index 73%
rename from arch/arm/plat-omap/include/mach/entry-macro.S
rename to arch/arm/mach-omap2/include/mach/entry-macro.S
index a559299..aafa0f6 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -15,54 +15,6 @@
 #include <mach/irqs.h>
 #include <asm/hardware/gic.h>
 
-#if defined(CONFIG_ARCH_OMAP1)
-
-#if defined(CONFIG_ARCH_OMAP730) && \
-	(defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX))
-#error "FIXME: OMAP730 doesn't support multiple-OMAP"
-#elif defined(CONFIG_ARCH_OMAP730)
-#define INT_IH2_IRQ		INT_730_IH2_IRQ
-#elif defined(CONFIG_ARCH_OMAP15XX)
-#define INT_IH2_IRQ		INT_1510_IH2_IRQ
-#elif defined(CONFIG_ARCH_OMAP16XX)
-#define INT_IH2_IRQ		INT_1610_IH2_IRQ
-#else
-#warning "IH2 IRQ defaulted"
-#define INT_IH2_IRQ		INT_1510_IH2_IRQ
-#endif
-
- 		.macro	disable_fiq
-		.endm
-
-		.macro  get_irqnr_preamble, base, tmp
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
-		ldr	\irqnr, [\base, #IRQ_ITR_REG_OFFSET]
-		ldr	\tmp, [\base, #IRQ_MIR_REG_OFFSET]
-		mov	\irqstat, #0xffffffff
-		bic	\tmp, \irqstat, \tmp
-		tst	\irqnr, \tmp
-		beq	1510f
-
-		ldr	\irqnr, [\base, #IRQ_SIR_FIQ_REG_OFFSET]
-		cmp	\irqnr, #0
-		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
-		cmpeq	\irqnr, #INT_IH2_IRQ
-		ldreq	\base, =OMAP1_IO_ADDRESS(OMAP_IH2_BASE)
-		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
-		addeqs	\irqnr, \irqnr, #32
-1510:
-		.endm
-
-#endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
-			defined(CONFIG_ARCH_OMAP4)
-
 #include <mach/omap24xx.h>
 #include <mach/omap34xx.h>
 
@@ -168,5 +120,3 @@
 
 		.macro	irq_prio_table
 		.endm
-
-#endif
