From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP2+: am33xx: Change cpu_is_am33xx to soc_is_am33xx
Date: Thu, 28 Jun 2012 20:45:10 +0530
Message-ID: <1340896510-13043-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46684 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab2F1PeW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 11:34:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

As per recent discussion on the linux-omap list, we are
moving in the direction where, we will have only architecture,
ARCH_OMAP2PLUS and all devices/platforms will be treated
as a SoC underneath.

So the first step in this direction is to adopt this change
for all new devices getting in, converting
cpu_is_am33xx/335x() ==> soc_is_am33xx/335x()

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>t status
---
 arch/arm/mach-omap2/clock3xxx_data.c  |    2 +-
 arch/arm/mach-omap2/id.c              |    4 ++--
 arch/arm/plat-omap/include/plat/cpu.h |   15 +++++++++------
 arch/arm/plat-omap/sram.c             |    6 +++---
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 71a1d33..7300982 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3491,7 +3491,7 @@ int __init omap3xxx_clk_init(void)
 	} else if (cpu_is_ti816x()) {
 		cpu_mask = RATE_IN_TI816X;
 		cpu_clkflg = CK_TI816X;
-	} else if (cpu_is_am33xx()) {
+	} else if (soc_is_am33xx()) {
 		cpu_mask = RATE_IN_AM33XX;
 	} else if (cpu_is_ti814x()) {
 		cpu_mask = RATE_IN_TI814X;
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 00486a8..37eb95a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -44,7 +44,7 @@ int omap_type(void)
 
 	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
-	} else if (cpu_is_am33xx()) {
+	} else if (soc_is_am33xx()) {
 		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
@@ -189,7 +189,7 @@ static void __init omap3_cpuinfo(void)
 		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
 	} else if (cpu_is_ti816x()) {
 		cpu_name = "TI816X";
-	} else if (cpu_is_am335x()) {
+	} else if (soc_is_am335x()) {
 		cpu_name =  "AM335X";
 	} else if (cpu_is_ti814x()) {
 		cpu_name = "TI814X";
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 430081a..8c84d05 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -150,8 +150,8 @@ IS_AM_SUBCLASS(335x, 0x335)
 #define cpu_is_ti816x()			0
 #define cpu_is_ti814x()			0
 #define soc_is_am35xx()			0
-#define cpu_is_am33xx()			0
-#define cpu_is_am335x()			0
+#define soc_is_am33xx()			0
+#define soc_is_am335x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -328,8 +328,6 @@ IS_OMAP_TYPE(3430, 0x3430)
 # undef cpu_is_ti816x
 # undef cpu_is_ti814x
 # undef soc_is_am35xx
-# undef cpu_is_am33xx
-# undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
@@ -337,8 +335,13 @@ IS_OMAP_TYPE(3430, 0x3430)
 # define cpu_is_ti816x()		is_ti816x()
 # define cpu_is_ti814x()		is_ti814x()
 # define soc_is_am35xx()		is_am35xx()
-# define cpu_is_am33xx()		is_am33xx()
-# define cpu_is_am335x()		is_am335x()
+#endif
+
+# if defined(CONFIG_SOC_AM33XX)
+# undef soc_is_am33xx
+# undef soc_is_am335x
+# define soc_is_am33xx()		is_am33xx()
+# define soc_is_am335x()		is_am335x()
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 477363c..746bac7 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -85,7 +85,7 @@ static int is_sram_locked(void)
 			__raw_writel(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
 			__raw_writel(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
 		}
-		if (cpu_is_omap34xx() && !cpu_is_am33xx()) {
+		if (cpu_is_omap34xx() && !soc_is_am33xx()) {
 			__raw_writel(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
 			__raw_writel(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
 			__raw_writel(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
@@ -123,7 +123,7 @@ static void __init omap_detect_sram(void)
 				omap_sram_size = 0x800; /* 2K */
 			}
 		} else {
-			if (cpu_is_am33xx()) {
+			if (soc_is_am33xx()) {
 				omap_sram_start = AM33XX_SRAM_PA;
 				omap_sram_size = 0x10000; /* 64K */
 			} else if (cpu_is_omap34xx()) {
@@ -386,7 +386,7 @@ int __init omap_sram_init(void)
 		omap242x_sram_init();
 	else if (cpu_is_omap2430())
 		omap243x_sram_init();
-	else if (cpu_is_am33xx())
+	else if (soc_is_am33xx())
 		am33xx_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
-- 
1.7.0.4

