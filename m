From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/2] MMC: OMAP: Supporting MMC multislot structures for
 Siemens SX1 board
Date: Thu, 29 Nov 2007 13:52:53 -0400
Message-ID: <474EFC75.6060004@indt.org.br>
References: <474AEDBB.1070006@indt.org.br> <20071128020300.GB11825@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071128020300.GB11825@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Proposes the new board-sx1-mmc.c file to handle all the MMC
specific code for multislot support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/mach-omap1/board-sx1-mmc.c   |  124 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-sx1.c       |   19 +----
 include/asm-arm/arch-omap/board-sx1.h |    8 ++-
 3 files changed, 135 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-sx1-mmc.c

diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
new file mode 100644
index 0000000..45c2fbb
--- /dev/null
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -0,0 +1,124 @@
+/*
+ * linux/arch/arm/mach-omap1/board-sx1-mmc.c
+ *
+ * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
+ * Author: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
+ *
+ * This code is based on linux/arch/arm/mach-omap1/board-h2-mmc.c, which is:
+ * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/mmc.h>
+#include <asm/arch/gpio.h>
+
+#ifdef CONFIG_MMC_OMAP
+static int slot_cover_open;
+static struct device *mmc_device;
+
+static int sx1_mmc_set_power(struct device *dev, int slot, int power_on,
+				int vdd)
+{
+	int err;
+	u8 dat = 0;
+
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
+		power_on ? "on" : "off", vdd);
+#endif
+
+	if (slot != 0) {
+		dev_err(dev, "No such slot %d\n", slot + 1);
+		return -ENODEV;
+	}
+
+	err = i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
+	if (err < 0)
+		return err;
+
+	if (power_on)
+		dat |= SOFIA_MMC_POWER;
+	else
+		dat &= ~SOFIA_MMC_POWER;
+
+	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
+}
+
+static int sx1_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
+{
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
+		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
+#endif
+	if (slot != 0) {
+		dev_err(dev, "No such slot %d\n", slot + 1);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int sx1_mmc_get_cover_state(struct device *dev, int slot)
+{
+	BUG_ON(slot != 0);
+
+	return slot_cover_open;
+}
+
+void sx1_mmc_slot_cover_handler(void *arg, int state)
+{
+	if (mmc_device == NULL)
+		return;
+
+	slot_cover_open = state;
+	omap_mmc_notify_cover_event(mmc_device, 0, state);
+}
+
+static int sx1_mmc_late_init(struct device *dev)
+{
+	int ret = 0;
+
+	mmc_device = dev;
+
+	return ret;
+}
+
+static void sx1_mmc_cleanup(struct device *dev)
+{
+}
+
+static struct omap_mmc_platform_data sx1_mmc_data = {
+	.nr_slots                       = 1,
+	.switch_slot                    = NULL,
+	.init                           = sx1_mmc_late_init,
+	.cleanup                        = sx1_mmc_cleanup,
+	.slots[0]       = {
+		.set_power              = sx1_mmc_set_power,
+		.set_bus_mode           = sx1_mmc_set_bus_mode,
+		.get_ro                 = NULL,
+		.get_cover_state        = sx1_mmc_get_cover_state,
+		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
+					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.name                   = "mmcblk",
+	},
+};
+
+void __init sx1_mmc_init(void)
+{
+	omap_set_mmc_info(1, &sx1_mmc_data);
+}
+
+#else
+
+void __init sx1_mmc_init(void)
+{
+}
+
+void sx1_mmc_slot_cover_handler(void *arg, int state)
+{
+}
+#endif
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 389d3fa..b4ca20b 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -134,20 +134,7 @@ int sx1_setmmipower(u8 onoff)
 		dat &= ~SOFIA_MMILIGHT_POWER;
 	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
 }
-/* set MMC power on/off */
-int sx1_setmmcpower(u8 onoff)
-{
-	int err;
-	u8 dat = 0;
-	err = i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
-	if (err < 0)
-		return err;
-	if (onoff)
-		dat |= SOFIA_MMC_POWER;
-	else
-		dat &= ~SOFIA_MMC_POWER;
-	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
-}
+
 /* set USB power on/off */
 int sx1_setusbpower(u8 onoff)
 {
@@ -168,7 +155,6 @@ EXPORT_SYMBOL(sx1_getkeylight);
 EXPORT_SYMBOL(sx1_setbacklight);
 EXPORT_SYMBOL(sx1_getbacklight);
 EXPORT_SYMBOL(sx1_setmmipower);
-EXPORT_SYMBOL(sx1_setmmcpower);
 EXPORT_SYMBOL(sx1_setusbpower);
 
 /*----------- Keypad -------------------------*/
@@ -432,6 +418,9 @@ static struct omap_board_config_kernel sx1_config[] __initdata = {
 	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
 /*-----------------------------------------*/
+
+extern void __init sx1_mmc_init(void);
+
 static void __init omap_sx1_init(void)
 {
 	platform_add_devices(sx1_devices, ARRAY_SIZE(sx1_devices));
diff --git a/include/asm-arm/arch-omap/board-sx1.h b/include/asm-arm/arch-omap/board-sx1.h
index 2bb8dd6..75dd8c3 100644
--- a/include/asm-arm/arch-omap/board-sx1.h
+++ b/include/asm-arm/arch-omap/board-sx1.h
@@ -41,6 +41,12 @@ int sx1_getkeylight(u8 *keylight);
 
 int sx1_setmmipower(u8 onoff);
 int sx1_setusbpower(u8 onoff);
-int sx1_setmmcpower(u8 onoff);
+
+int i2c_write_byte(u8 devaddr, u8 regoffset, u8 value);
+int i2c_read_byte(u8 devaddr, u8 regoffset, u8 * value);
+
+/* MMC prototypes */
+
+extern void sx1_mmc_slot_cover_handler(void *arg, int state);
 
 #endif /* __ASM_ARCH_SX1_I2C_CHIPS_H */
-- 1.5.3.GIT
