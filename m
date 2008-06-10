From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 2/2] ARM: OMAP: Add OMAP34xx pin multiplexing into I2C bus registration helper
Date: Tue, 10 Jun 2008 08:42:51 +0300
Message-ID: <1213076571-21852-1-git-send-email-jarkko.nikula@nokia.com>
References: <1213022801-25058-2-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26367 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbYFJFnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 01:43:03 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5A5gwrd007359
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 08:42:59 +0300
In-Reply-To: <1213022801-25058-2-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

- Simplify function omap_i2c_mux_pins
- Add OMAP34xx pin multiplexing for busses 1 - 3

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/i2c.c |   55 ++++++++++++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 7990ab1..eddc24e 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -80,26 +80,43 @@ static struct platform_device omap_i2c_devices[] = {
 #endif
 };
 
-static void __init omap_i2c_mux_pins(int bus_id)
+#if defined(CONFIG_ARCH_OMAP24XX)
+static const int omap24xx_pins[][2] = {
+	{ M19_24XX_I2C1_SCL, L15_24XX_I2C1_SDA },
+	{ J15_24XX_I2C2_SCL, H19_24XX_I2C2_SDA },
+};
+#else
+static const int omap24xx_pins[][2] = {};
+#endif
+#if defined(CONFIG_ARCH_OMAP34XX)
+static const int omap34xx_pins[][2] = {
+	{ K21_34XX_I2C1_SCL, J21_34XX_I2C1_SDA},
+	{ AF15_34XX_I2C2_SCL, AE15_34XX_I2C2_SDA},
+	{ AF14_34XX_I2C3_SCL, AG14_34XX_I2C3_SDA},
+};
+#else
+static const int omap34xx_pins[][2] = {};
+#endif
+
+static void __init omap_i2c_mux_pins(int bus)
 {
-	/* TODO: Muxing for OMAP3 */
-	switch (bus_id) {
-	case 1:
-		if (cpu_class_is_omap1()) {
-			omap_cfg_reg(I2C_SCL);
-			omap_cfg_reg(I2C_SDA);
-		} else if (cpu_is_omap24xx()) {
-			omap_cfg_reg(M19_24XX_I2C1_SCL);
-			omap_cfg_reg(L15_24XX_I2C1_SDA);
-		}
-		break;
-	case 2:
-		if (cpu_is_omap24xx()) {
-			omap_cfg_reg(J15_24XX_I2C2_SCL);
-			omap_cfg_reg(H19_24XX_I2C2_SDA);
-		}
-		break;
+	int scl, sda;
+
+	if (cpu_class_is_omap1()) {
+		scl = I2C_SCL;
+		sda = I2C_SDA;
+	} else if (cpu_is_omap24xx()) {
+		scl = omap24xx_pins[bus][0];
+		sda = omap24xx_pins[bus][1];
+	} else if (cpu_is_omap34xx()) {
+		scl = omap34xx_pins[bus][0];
+		sda = omap34xx_pins[bus][1];
+	} else {
+		return;
 	}
+
+	omap_cfg_reg(sda);
+	omap_cfg_reg(scl);
 }
 
 int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
@@ -143,6 +160,6 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 		res[1].start = irq;
 	}
 
-	omap_i2c_mux_pins(bus_id);
+	omap_i2c_mux_pins(bus_id - 1);
 	return platform_device_register(pdev);
 }
-- 
1.5.5.3

