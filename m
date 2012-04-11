From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 10/12] arm: omap3: am35x: Add minimal EMIF4 support
Date: Wed, 11 Apr 2012 12:05:45 -0700
Message-ID: <1334171147-7517-11-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:50206 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932951Ab2DKTsQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:48:16 -0400
In-Reply-To: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The typical SDRAM Controller Subsystem module (SDRC)
on TI OMAP3 devices has two submodules: the SDRAM Memory
Scheduler (SMS) submodule, and the SDRC submodule--the
'SDRC' acronym/term is overloaded.  The am35x family of
devices is different in that it has an EMIF4 submodule
instead of an SDRC submodule.  The SMS submodules are
similar, though.

Currently, the code assumes that if its an OMAP3 device,
then it has an SDRC module and if it has an SDRC module,
it has an SDRC submodule.  Since the SDRC module can now
have an EMIF4 submodule, the code needs to be reworked.

This rework can be minimal since there is an EMIF driver being
developed which should take care of most of the EMIF4 details.
In the meantime:
- enable smart-idle and VTP power save mode in the EMIF4
- have omap3_core_dpll_m2_set_rate() return an error when
  there's an EMIF4 module because it assumes there's an
  SDRC submodule
- don't bother pushing map3_sram_configure_core_dpll()
  to sram since its not used when there's an EMIF4
  submodule.

NOTE: There is still a bit of ugliness in that the SDRC
submodule's mapping (in omap34xx_io_desc[]) is used.
That works okay since the address and size of the EMIF4
submodule is the same as the SDRC submodule's.  To fix that,
a special "early_cpu_is_xxx()" or "early_omap3_has_sdrc_emif4()"
routine needs to be created because its too early to use the
regular cpu_is_xxx() or omap3_has_sdrc_emif4() calls.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |    6 +++-
 arch/arm/mach-omap2/io.c               |    9 ++++++
 arch/arm/mach-omap2/sdrc.c             |   52 ++++++++++++++++++++++----------
 arch/arm/mach-omap2/sdrc.h             |   13 ++++++++
 arch/arm/plat-omap/sram.c              |    8 +++--
 5 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index d6e34dd..3864528 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
@@ -45,7 +46,7 @@
  * @rate: rounded target rate
  *
  * Program the DPLL M2 divider with the rounded target rate.  Returns
- * -EINVAL upon error, or 0 upon success.
+ * -EINVAL upon error or if there's an EMIF4 submodule, or 0 upon success.
  */
 int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 {
@@ -60,6 +61,9 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	if (!clk || !rate)
 		return -EINVAL;
 
+	if (omap3_has_sdrc_emif4())
+		return -EINVAL;
+
 	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
 	if (validrate != rate)
 		return -EINVAL;
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 065bd76..1accc90 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -450,6 +450,15 @@ void __init omap3630_init_early(void)
 
 void __init am35xx_init_early(void)
 {
+	/*
+	 * The am35x has an EMIF4 submodule in the SDRC module instead
+	 * of an SDRC submodule like other OMAP3 SoCs.  Fortunately,
+	 * the EMIF4 and SDRC submodules are at the same physical address
+	 * so we can use the SDRC mapping to access the EMIF4 submodule.
+	 * The reason for not making a separate mapping for the EMIF4 is
+	 * to avoid creating an early_cpu_is_xxx()-like call because its
+	 * too early to use cpu_is_3505/3517() or omap3_has_sdrc_emif4().
+	 */
 	omap3_init_early();
 }
 
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index e3d345f..d804065 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -24,11 +24,13 @@
 #include <linux/io.h>
 
 #include "common.h"
+#include "control.h"
 #include <plat/clock.h>
 #include <plat/sram.h>
 
 #include <plat/sdrc.h>
 #include "sdrc.h"
+#include "emif4.h"
 
 static struct omap_sdrc_params *sdrc_init_params_cs0, *sdrc_init_params_cs1;
 
@@ -136,28 +138,46 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 			    struct omap_sdrc_params *sdrc_cs1)
 {
 	u32 l;
+	void __iomem *ctrl_base;
 
 	l = sms_read_reg(SMS_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
 	sms_write_reg(l, SMS_SYSCONFIG);
 
-	l = sdrc_read_reg(SDRC_SYSCONFIG);
-	l &= ~(0x3 << 3);
-	l |= (0x2 << 3);
-	sdrc_write_reg(l, SDRC_SYSCONFIG);
-
-	sdrc_init_params_cs0 = sdrc_cs0;
-	sdrc_init_params_cs1 = sdrc_cs1;
-
-	/* XXX Enable SRFRONIDLEREQ here also? */
-	/*
-	 * PWDENA should not be set due to 34xx erratum 1.150 - PWDENA
-	 * can cause random memory corruption
-	 */
-	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
-		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
-	sdrc_write_reg(l, SDRC_POWER);
+	if (omap3_has_sdrc_emif4()) {
+		l = emif4_read_reg(EMIF4_PWR_MGMT_CTRL);
+		l &= ~(0x3 << 30);
+		l |= (0x2 << 30);
+		emif4_write_reg(l, EMIF4_PWR_MGMT_CTRL);
+
+		/* Enable VTP Power Save Mode */
+		ctrl_base = omap_ctrl_base_get();
+		if (ctrl_base) {
+			l = __raw_readl(ctrl_base + AM35XX_CONTROL_DEVCONF3);
+			l &= ~(0x3 << 13);
+			l |= (0x1 << 13);
+			__raw_writel(l, ctrl_base + AM35XX_CONTROL_DEVCONF3);
+		}
+	} else {
+		l = sdrc_read_reg(SDRC_SYSCONFIG);
+		l &= ~(0x3 << 3);
+		l |= (0x2 << 3);
+		sdrc_write_reg(l, SDRC_SYSCONFIG);
+
+		sdrc_init_params_cs0 = sdrc_cs0;
+		sdrc_init_params_cs1 = sdrc_cs1;
+
+		/* XXX Enable SRFRONIDLEREQ here also? */
+		/*
+		 * PWDENA should not be set due to 34xx erratum 1.150 - PWDENA
+		 * can cause random memory corruption
+		 */
+		l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
+			(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
+		sdrc_write_reg(l, SDRC_POWER);
+	}
+
 	omap2_sms_save_context();
 }
 
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index b3f8379..5fb6490 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -25,6 +25,7 @@ extern void __iomem *omap2_sdrc_base;
 extern void __iomem *omap2_sms_base;
 
 #define OMAP_SDRC_REGADDR(reg)			(omap2_sdrc_base + (reg))
+#define OMAP_EMIF4_REGADDR(reg)			(omap2_sdrc_base + (reg))
 #define OMAP_SMS_REGADDR(reg)			(omap2_sms_base + (reg))
 
 /* SDRC global register get/set */
@@ -39,6 +40,18 @@ static inline u32 sdrc_read_reg(u16 reg)
 	return __raw_readl(OMAP_SDRC_REGADDR(reg));
 }
 
+/* EMIF4 global register get/set */
+
+static inline void emif4_write_reg(u32 val, u16 reg)
+{
+	__raw_writel(val, OMAP_EMIF4_REGADDR(reg));
+}
+
+static inline u32 emif4_read_reg(u16 reg)
+{
+	return __raw_readl(OMAP_EMIF4_REGADDR(reg));
+}
+
 /* SMS global register get/set */
 
 static inline void sms_write_reg(u32 val, u16 reg)
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index eec98af..42ccfcb 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -353,9 +353,11 @@ void omap3_sram_restore_context(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 
-	_omap3_sram_configure_core_dpll =
-		omap_sram_push(omap3_sram_configure_core_dpll,
-			       omap3_sram_configure_core_dpll_sz);
+	if (!omap3_has_sdrc_emif4())
+		_omap3_sram_configure_core_dpll =
+			omap_sram_push(omap3_sram_configure_core_dpll,
+				       omap3_sram_configure_core_dpll_sz);
+
 	omap_push_sram_idle();
 }
 #endif /* CONFIG_PM */
-- 
1.7.9.4

