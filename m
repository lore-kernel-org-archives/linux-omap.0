From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 15/17] MMC: OMAP: Supporting MMC multislot structures for
 Siemens SX1 board
Date: Mon, 26 Nov 2007 12:02:01 -0400
Message-ID: <474AEDF9.10806@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Proposes the new board-sx1-mmc.c file to handle all the MMC
specific code for multislot support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/mach-omap1/board-sx1-mmc.c   |  110 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-sx1.c       |    3 +
 include/asm-arm/arch-omap/board-sx1.h |    4 +
 3 files changed, 117 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-sx1-mmc.c

diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
new file mode 100644
index 0000000..ac707c3
--- /dev/null
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -0,0 +1,110 @@
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
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
+		power_on ? "on" : "off", vdd);
+#endif
+	if (slot != 0) {
+		dev_err(dev, "No such slot %d\n", slot + 1);
+		return -ENODEV;
+	}
+
+	return 0;
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
index 389d3fa..de921be 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -432,6 +432,9 @@ static struct omap_board_config_kernel sx1_config[] __initdata = {
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
index 2bb8dd6..619e8f3 100644
--- a/include/asm-arm/arch-omap/board-sx1.h
+++ b/include/asm-arm/arch-omap/board-sx1.h
@@ -43,4 +43,8 @@ int sx1_setmmipower(u8 onoff);
 int sx1_setusbpower(u8 onoff);
 int sx1_setmmcpower(u8 onoff);
 
+/* MMC prototypes */
+
+extern void sx1_mmc_slot_cover_handler(void *arg, int state);
+
 #endif /* __ASM_ARCH_SX1_I2C_CHIPS_H */
-- 1.5.3.GIT
