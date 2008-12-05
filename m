From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] ARM: OMAP3: Add OMAP34xx pin multiplexing into I2C bus
	registration helper
Date: Fri, 05 Dec 2008 12:02:35 -0800
Message-ID: <20081205200235.31125.89850.stgit@localhost>
References: <20081205195846.31125.21080.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50643 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYLEUCh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 15:02:37 -0500
In-Reply-To: <20081205195846.31125.21080.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

- Simplify function omap_i2c_mux_pins
- Add OMAP34xx pin multiplexing for busses 1 - 3

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/i2c.c |   55 ++++++++++++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 0e6d147..89a6ab0 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -79,26 +79,43 @@ static struct platform_device omap_i2c_devices[] = {
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
@@ -142,6 +159,6 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 		res[1].start = irq;
 	}
 
-	omap_i2c_mux_pins(bus_id);
+	omap_i2c_mux_pins(bus_id - 1);
 	return platform_device_register(pdev);
 }

