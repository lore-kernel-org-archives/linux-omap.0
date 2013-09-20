From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP2+: Use pdata quirks for wl12xx legacy init
Date: Fri, 20 Sep 2013 10:38:21 -0700
Message-ID: <20130920173821.2584.1124.stgit@localhost>
References: <20130920173310.2584.24522.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26359 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753042Ab3ITRiX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Sep 2013 13:38:23 -0400
In-Reply-To: <20130920173310.2584.24522.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Let's use the platform data quirk support for wl12xx
and move the board specific code out of devices.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c      |   38 ------------------------------------
 arch/arm/mach-omap2/pdata-quirks.c |   31 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5c5315b..5336c75 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -19,7 +19,6 @@
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/omap4-keypad.h>
-#include <linux/wl12xx.h>
 #include <linux/platform_data/mailbox-omap.h>
 
 #include <asm/mach-types.h>
@@ -475,40 +474,6 @@ static void omap_init_vout(void)
 static inline void omap_init_vout(void) {}
 #endif
 
-#if IS_ENABLED(CONFIG_WL12XX)
-
-static struct wl12xx_platform_data wl12xx __initdata;
-
-void __init omap_init_wl12xx_of(void)
-{
-	int ret;
-
-	if (!of_have_populated_dt())
-		return;
-
-	if (of_machine_is_compatible("ti,omap4-sdp")) {
-		wl12xx.board_ref_clock = WL12XX_REFCLOCK_26;
-		wl12xx.board_tcxo_clock = WL12XX_TCXOCLOCK_26;
-		wl12xx.irq = gpio_to_irq(53);
-	} else if (of_machine_is_compatible("ti,omap4-panda")) {
-		wl12xx.board_ref_clock = WL12XX_REFCLOCK_38;
-		wl12xx.irq = gpio_to_irq(53);
-	} else {
-		return;
-	}
-
-	ret = wl12xx_set_platform_data(&wl12xx);
-	if (ret) {
-		pr_err("error setting wl12xx data: %d\n", ret);
-		return;
-	}
-}
-#else
-static inline void omap_init_wl12xx_of(void)
-{
-}
-#endif
-
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -531,9 +496,6 @@ static int __init omap2_init_devices(void)
 		omap_init_sham();
 		omap_init_aes();
 		omap_init_rng();
-	} else {
-		/* These can be removed when bindings are done */
-		omap_init_wl12xx_of();
 	}
 	omap_init_sti();
 	omap_init_vout();
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 648d957..52b4bc3 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -8,8 +8,10 @@
  * published by the Free Software Foundation.
  */
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/wl12xx.h>
 
 #include "common.h"
 #include "common-board-devices.h"
@@ -34,16 +36,45 @@ static void __init __used legacy_init_ehci_clk(char *clkname)
 		       __func__, clkname, ret);
 }
 
+#if IS_ENABLED(CONFIG_WL12XX)
+
+static struct wl12xx_platform_data wl12xx __initdata;
+
+static void __init __used legacy_init_wl12xx(unsigned ref_clock,
+					     unsigned tcxo_clock,
+					     int gpio)
+{
+	int res;
+
+	wl12xx.board_ref_clock = ref_clock;
+	wl12xx.board_tcxo_clock = tcxo_clock;
+	wl12xx.irq = gpio_to_irq(gpio);
+
+	res = wl12xx_set_platform_data(&wl12xx);
+	if (res) {
+		pr_err("error setting wl12xx data: %d\n", res);
+		return;
+	}
+}
+#else
+static inline void omap_init_wl12xx_of(void)
+{
+}
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 static void __init omap4_sdp_legacy_init(void)
 {
 	omap_4430sdp_display_init_of();
+	legacy_init_wl12xx(WL12XX_REFCLOCK_26,
+			   WL12XX_TCXOCLOCK_26, 53);
 }
 
 static void __init omap4_panda_legacy_init(void)
 {
 	omap4_panda_display_init_of();
 	legacy_init_ehci_clk("auxclk3_ck");
+	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
 }
 #endif
 

