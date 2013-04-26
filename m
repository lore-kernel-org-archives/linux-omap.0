From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP2+: Legacy support for wl12xx when booted with
 devicetree
Date: Thu, 25 Apr 2013 20:52:10 -0700
Message-ID: <20130426035210.26065.39995.stgit@muffinssi.local>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41556 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759864Ab3DZDwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Apr 2013 23:52:14 -0400
In-Reply-To: <20130426034858.26065.65118.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Luciano Coelho <coelho@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Without WLAN we cannot switch omap4 to use device tree
only booting. This patch can be reverted when the
binding for wl12xx is added.

Cc: Luciano Coelho <coelho@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 73762ac..69c520e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
@@ -22,6 +23,7 @@
 #include <linux/platform_data/omap_ocp2scp.h>
 #include <linux/platform_data/mailbox-omap.h>
 #include <linux/usb/omap_control_usb.h>
+#include <linux/wl12xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -640,6 +642,40 @@ static void __init omap_init_ocp2scp(void)
 static inline void omap_init_ocp2scp(void) { }
 #endif
 
+#if IS_ENABLED(CONFIG_WL12XX)
+
+static struct wl12xx_platform_data wl12xx __initdata;
+
+void __init omap_init_wl12xx_of(void)
+{
+	int ret;
+
+	if (!of_have_populated_dt())
+		return;
+
+	if (of_machine_is_compatible("ti,omap4-sdp")) {
+		wl12xx.board_ref_clock = WL12XX_REFCLOCK_26;
+		wl12xx.board_tcxo_clock = WL12XX_TCXOCLOCK_26;
+		wl12xx.irq = gpio_to_irq(53);
+	} else if (of_machine_is_compatible("ti,omap4-panda")) {
+		wl12xx.board_ref_clock = WL12XX_REFCLOCK_38;
+		wl12xx.irq = gpio_to_irq(53);
+	} else {
+		return;
+	}
+
+	ret = wl12xx_set_platform_data(&wl12xx);
+	if (ret) {
+		pr_err("error setting wl12xx data: %d\n", ret);
+		return;
+	}
+}
+#else
+static inline omap_init_wl12xx_of(void)
+{
+}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -664,6 +700,9 @@ static int __init omap2_init_devices(void)
 		omap_init_mcspi();
 		omap_init_sham();
 		omap_init_aes();
+	} else {
+		/* These can be removed when bindings are done */
+		omap_init_wl12xx_of();
 	}
 	omap_init_sti();
 	omap_init_rng();

