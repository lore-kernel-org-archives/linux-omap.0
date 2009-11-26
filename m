From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/8] omap: Split i2c platform init for mach-omap1 and
	mach-omap2
Date: Wed, 25 Nov 2009 16:19:52 -0800
Message-ID: <20091126001952.1546.21444.stgit@localhost>
References: <20091126001646.1546.34352.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62268 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759988AbZKZATq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 19:19:46 -0500
In-Reply-To: <20091126001646.1546.34352.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we cannot limit new mux code to mach-omap2.
The same signal names should eventually work for other
omaps under mach-omap2.

Note that these pins don't need to be OMAP_PIN_INPUT_PULLUP,
just OMAP_PIN_INPUT is enough.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c            |   20 ++++++++++++++++++++
 arch/arm/plat-omap/i2c.c                 |   24 +++++++++---------------
 arch/arm/plat-omap/include/plat/common.h |    1 +
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 733d3dc..000f304 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -743,6 +743,26 @@ static inline void omap_hdq_init(void) {}
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+
+/* Called from omap_i2c_mux_pins. The first i2c bus is non-muxable */
+void omap_i2c_mach_mux(int bus_id)
+{
+	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
+
+	if (cpu_is_omap34xx() && bus_id == 1)
+		return;
+
+	sprintf(mux_name, "i2c%i_scl.i2c%i_scl", bus_id, bus_id);
+	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
+	sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
+	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
+}
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 static int __init omap2_init_devices(void)
 {
 	/* please keep these calls, and their implementations above,
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index c08362d..ba2306a 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <mach/irqs.h>
+#include <plat/common.h>
 #include <plat/mux.h>
 
 #define OMAP_I2C_SIZE		0x3f
@@ -88,15 +89,6 @@ static const int omap24xx_pins[][2] = {
 #else
 static const int omap24xx_pins[][2] = {};
 #endif
-#if defined(CONFIG_ARCH_OMAP34XX)
-static const int omap34xx_pins[][2] = {
-	{ K21_34XX_I2C1_SCL, J21_34XX_I2C1_SDA},
-	{ AF15_34XX_I2C2_SCL, AE15_34XX_I2C2_SDA},
-	{ AF14_34XX_I2C3_SCL, AG14_34XX_I2C3_SDA},
-};
-#else
-static const int omap34xx_pins[][2] = {};
-#endif
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
 
@@ -104,15 +96,17 @@ static void __init omap_i2c_mux_pins(int bus)
 {
 	int scl, sda;
 
+	if (cpu_is_omap34xx()) {
+		omap_i2c_mach_mux(bus);
+		return;
+	}
+
 	if (cpu_class_is_omap1()) {
 		scl = I2C_SCL;
 		sda = I2C_SDA;
 	} else if (cpu_is_omap24xx()) {
-		scl = omap24xx_pins[bus][0];
-		sda = omap24xx_pins[bus][1];
-	} else if (cpu_is_omap34xx()) {
-		scl = omap34xx_pins[bus][0];
-		sda = omap34xx_pins[bus][1];
+		scl = omap24xx_pins[bus - 1][0];
+		sda = omap24xx_pins[bus - 1][1];
 	} else {
 		return;
 	}
@@ -156,7 +150,7 @@ static int __init omap_i2c_add_bus(int bus_id)
 		res[1].start = irq;
 	}
 
-	omap_i2c_mux_pins(bus_id - 1);
+	omap_i2c_mux_pins(bus_id);
 	return platform_device_register(pdev);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 064f173..e46aefe 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -40,6 +40,7 @@ extern struct sys_timer omap_timer;
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
 				 unsigned len);
+extern void omap_i2c_mach_mux(int bus_id);
 #else
 static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,

