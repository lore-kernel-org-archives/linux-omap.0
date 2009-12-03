From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/8] OMAP2/3: move SDRC macros to mach-omap2/sdrc.h
Date: Thu, 03 Dec 2009 03:07:04 -0700
Message-ID: <20091203100703.1203.90524.stgit@localhost.localdomain>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35915 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437AbZLCKLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:11:48 -0500
In-Reply-To: <20091203095830.1203.76290.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

clock34xx.c contains some macros which probably belong in mach-omap2/sdrc.h.
Move those macros to mach-omap2/sdrc.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com
---
 arch/arm/mach-omap2/clock34xx.c |   14 --------------
 arch/arm/mach-omap2/sdrc.h      |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index a4b903d..3929544 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -322,22 +322,8 @@ static struct omap_clk omap34xx_clks[] = {
 
 #define MAX_DPLL_WAIT_TRIES		1000000
 
-#define MIN_SDRC_DLL_LOCK_FREQ		83000000
-
 #define CYCLES_PER_MHZ			1000000
 
-/* Scale factor for fixed-point arith in omap3_core_dpll_m2_set_rate() */
-#define SDRC_MPURATE_SCALE		8
-
-/* 2^SDRC_MPURATE_BASE_SHIFT: MPU MHz that SDRC_MPURATE_LOOPS is defined for */
-#define SDRC_MPURATE_BASE_SHIFT		9
-
-/*
- * SDRC_MPURATE_LOOPS: Number of MPU loops to execute at
- * 2^MPURATE_BASE_SHIFT MHz for SDRC to stabilize
- */
-#define SDRC_MPURATE_LOOPS		96
-
 /*
  * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
  * that are sourced by DPLL5, and both of these require this clock
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 48207b0..12fc7da 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -56,4 +56,20 @@ static inline u32 sms_read_reg(u16 reg)
 			OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
 #endif	/* __ASSEMBLER__ */
 
+/* Minimum frequency that the SDRC DLL can lock at */
+#define MIN_SDRC_DLL_LOCK_FREQ		83000000
+
+/* Scale factor for fixed-point arith in omap3_core_dpll_m2_set_rate() */
+#define SDRC_MPURATE_SCALE		8
+
+/* 2^SDRC_MPURATE_BASE_SHIFT: MPU MHz that SDRC_MPURATE_LOOPS is defined for */
+#define SDRC_MPURATE_BASE_SHIFT		9
+
+/*
+ * SDRC_MPURATE_LOOPS: Number of MPU loops to execute at
+ * 2^MPURATE_BASE_SHIFT MHz for SDRC to stabilize
+ */
+#define SDRC_MPURATE_LOOPS		96
+
+
 #endif


