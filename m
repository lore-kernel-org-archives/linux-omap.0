From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/3] ARM: OMAP3: PRM/CM: Add back macros used by TI DSP/Bridge driver
Date: Tue, 24 Jun 2014 00:24:26 -0500
Message-ID: <1403587467-59876-3-git-send-email-s-anna@ti.com>
References: <1403587467-59876-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35542 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbaFXFZW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 01:25:22 -0400
In-Reply-To: <1403587467-59876-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>

The commit 7be914f {ARM: OMAP3: PRM/CM: Cleanup unused header} removed
some of the macros used by the TI DSP/Bridge driver. This fixes the
following build errors when trying to build DSP/Bridge driver (disabled
at present), otherwise results in the following build errors:

drivers/staging/tidspbridge/core/tiomap3430.c:531:31: error: 'OMAP3430_AUTO_IVA2_DPLL_SHIFT' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap3430.c:531:31: note: each undeclared identifier is reported only once for each function it appears in
make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
make[3]: *** Waiting for unfinished jobs....
drivers/staging/tidspbridge/core/tiomap_io.c: In function 'sm_interrupt_dsp':
drivers/staging/tidspbridge/core/tiomap_io.c:404:31: error: 'OMAP3430_AUTO_IVA2_DPLL_SHIFT' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap_io.c:404:31: note: each undeclared identifier is reported only once for each function it appears in
drivers/staging/tidspbridge/core/tiomap_io.c:414:12: error: 'OMAP3430_IVA2_DPLL_FREQSEL_SHIFT' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap_io.c:415:12: error: 'OMAP3430_EN_IVA2_DPLL_SHIFT' undeclared (first use in this function)
make[3]: *** [drivers/staging/tidspbridge/core/tiomap_io.o] Error 1
drivers/staging/tidspbridge/core/tiomap3430_pwr.c: In function 'dsp_clk_wakeup_event_ctrl':
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:442:19: error: 'OMAP3430_GRPSEL_GPT5_MASK' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:442:19: note: each undeclared identifier is reported only once for each function it appears in
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:455:19: error: 'OMAP3430_GRPSEL_GPT6_MASK' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:468:19: error: 'OMAP3430_GRPSEL_GPT7_MASK' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:481:19: error: 'OMAP3430_GRPSEL_GPT8_MASK' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:494:19: error: 'OMAP3430_GRPSEL_MCBSP1_MASK' undeclared (first use in this function)
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:546:19: error: 'OMAP3430_GRPSEL_MCBSP5_MASK' undeclared (first use in this function)
make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430_pwr.o] Error 1
make[2]: *** [drivers/staging/tidspbridge] Error 2

Fixes: 7be914f (ARM: OMAP3: PRM/CM: Cleanup unused header)
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h  | 3 +++
 arch/arm/mach-omap2/prm-regbits-34xx.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 04dab2f..ee6c784 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -26,11 +26,14 @@
 #define OMAP3430_EN_WDT3_SHIFT				12
 #define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK		(1 << 0)
 #define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT		0
+#define OMAP3430_IVA2_DPLL_FREQSEL_SHIFT		4
 #define OMAP3430_IVA2_DPLL_FREQSEL_MASK			(0xf << 4)
 #define OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT		3
+#define OMAP3430_EN_IVA2_DPLL_SHIFT			0
 #define OMAP3430_EN_IVA2_DPLL_MASK			(0x7 << 0)
 #define OMAP3430_ST_IVA2_SHIFT				0
 #define OMAP3430_ST_IVA2_CLK_MASK			(1 << 0)
+#define OMAP3430_AUTO_IVA2_DPLL_SHIFT			0
 #define OMAP3430_AUTO_IVA2_DPLL_MASK			(0x7 << 0)
 #define OMAP3430_IVA2_CLK_SRC_SHIFT			19
 #define OMAP3430_IVA2_CLK_SRC_WIDTH			3
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 106132d..cbefbd7 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -35,6 +35,8 @@
 #define OMAP3430_LOGICSTATEST_MASK			(1 << 2)
 #define OMAP3430_LASTLOGICSTATEENTERED_MASK		(1 << 2)
 #define OMAP3430_LASTPOWERSTATEENTERED_MASK		(0x3 << 0)
+#define OMAP3430_GRPSEL_MCBSP5_MASK			(1 << 10)
+#define OMAP3430_GRPSEL_MCBSP1_MASK			(1 << 9)
 #define OMAP3630_GRPSEL_UART4_MASK			(1 << 18)
 #define OMAP3430_GRPSEL_GPIO6_MASK			(1 << 17)
 #define OMAP3430_GRPSEL_GPIO5_MASK			(1 << 16)
@@ -42,6 +44,10 @@
 #define OMAP3430_GRPSEL_GPIO3_MASK			(1 << 14)
 #define OMAP3430_GRPSEL_GPIO2_MASK			(1 << 13)
 #define OMAP3430_GRPSEL_UART3_MASK			(1 << 11)
+#define OMAP3430_GRPSEL_GPT8_MASK			(1 << 9)
+#define OMAP3430_GRPSEL_GPT7_MASK			(1 << 8)
+#define OMAP3430_GRPSEL_GPT6_MASK			(1 << 7)
+#define OMAP3430_GRPSEL_GPT5_MASK			(1 << 6)
 #define OMAP3430_GRPSEL_MCBSP4_MASK			(1 << 2)
 #define OMAP3430_GRPSEL_MCBSP3_MASK			(1 << 1)
 #define OMAP3430_GRPSEL_MCBSP2_MASK			(1 << 0)
-- 
2.0.0

