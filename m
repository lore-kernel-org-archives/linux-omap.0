From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [ARM] omap850: Add missing CPU defines
Date: Mon, 07 Sep 2009 16:43:29 -0700
Message-ID: <1252367009.27752.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:55902 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbZIGXne (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 19:43:34 -0400
Received: by pxi34 with SMTP id 34so2544638pxi.4
        for <linux-omap@vger.kernel.org>; Mon, 07 Sep 2009 16:43:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* OMAP1 platform GPIO was not working correctly on omap850 due to missing OMAP850
  method checks.  This is now correctly implemented and working.

* A #if statement in common.c was excluding code for omap730 and 15xx, and should
  have also been excluding the code for omap850.  This is now fixed.

* omap850 mux was being done differently/incorrectly for omap850.  This is now fixed.

* INT_IH2_IRQ was not being defined for omap850, causing interrupts to not work
  on omap850.  This is now fixed.

Reported-by:
    Cory Maccarrone <darkstar6262@gmail.com>
    Alistair Buxton <a.j.buxton@gmail.com>
    Angelo Arrifano <miknix@gmail.com>

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/mux.c                     |   14 ++++++++++----
 arch/arm/plat-omap/common.c                   |    4 ++--
 arch/arm/plat-omap/gpio.c                     |    2 +-
 arch/arm/plat-omap/include/mach/entry-macro.S |    2 ++
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 721e0d9..78cd6b7 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -75,6 +75,10 @@ MUX_CFG_850("AA17_850_USB_DM",     2,   21,    0,   20,   0, 0)
 MUX_CFG_850("W16_850_USB_PU_EN",   2,   25,    0,   24,   0, 0)
 MUX_CFG_850("W17_850_USB_VBUSI",   2,   29,    0,   28,   0, 0)
 };
+#define OMAP850_PINS_SZ		ARRAY_SIZE(omap850_pins)
+#else
+#define omap850_pins		NULL
+#define OMAP850_PINS_SZ		0
 #endif
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
@@ -439,10 +443,6 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 			       cfg->pull_name, cfg->pull_reg, pull_orig, pull);
 	}
 
-#ifdef CONFIG_ARCH_OMAP850
-	omap_mux_register(omap850_pins, ARRAY_SIZE(omap850_pins));
-#endif
-
 #endif
 
 #ifdef CONFIG_OMAP_MUX_ERRORS
@@ -460,6 +460,12 @@ int __init omap1_mux_init(void)
 		arch_mux_cfg.cfg_reg	= omap1_cfg_reg;
 	}
 
+	if (cpu_is_omap850()) {
+		arch_mux_cfg.pins = omap850_pins;
+		arch_mux_cfg.size = OMAP850_PINS_SZ;
+		arch_mux_cfg.cfg_reg = omap1_cfg_reg;
+	}
+
 	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
 		arch_mux_cfg.pins	= omap1xxx_pins;
 		arch_mux_cfg.size	= OMAP1XXX_PINS_SZ;
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index a6fa786..d076cc1 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(omap_get_var_config);
 
 #define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
 
-#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX))
+#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850) || defined(CONFIG_ARCH_OMAP15XX))
 
 #include <linux/clocksource.h>
 
@@ -207,7 +207,7 @@ static int __init omap_init_clocksource_32k(void)
 }
 arch_initcall(omap_init_clocksource_32k);
 
-#endif	/* !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX)) */
+#endif	/* !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850) || defined(CONFIG_ARCH_OMAP15XX)) */
 
 /* Global address base setup code */
 
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7c70a6a..91ab375 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1659,7 +1659,7 @@ static int __init _omap_gpio_init(void)
 			__raw_writew(0xffff, bank->base + OMAP1610_GPIO_IRQSTATUS1);
 			__raw_writew(0x0014, bank->base + OMAP1610_GPIO_SYSCONFIG);
 		}
-		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_730) {
+		if (cpu_is_omap7xx() && (bank->method == METHOD_GPIO_730 || bank->method == METHOD_GPIO_850)) {
 			__raw_writel(0xffffffff, bank->base + OMAP730_GPIO_INT_MASK);
 			__raw_writel(0x00000000, bank->base + OMAP730_GPIO_INT_STATUS);
 
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index a559299..19c3198 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -22,6 +22,8 @@
 #error "FIXME: OMAP730 doesn't support multiple-OMAP"
 #elif defined(CONFIG_ARCH_OMAP730)
 #define INT_IH2_IRQ		INT_730_IH2_IRQ
+#elif defined(CONFIG_ARCH_OMAP850)
+#define INT_IH2_IRQ     INT_850_IH2_IRQ
 #elif defined(CONFIG_ARCH_OMAP15XX)
 #define INT_IH2_IRQ		INT_1510_IH2_IRQ
 #elif defined(CONFIG_ARCH_OMAP16XX)
-- 
1.6.0.4


