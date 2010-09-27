From: Tim Nordell <tim.nordell@logicpd.com>
Subject: [PATCH v4 4/4] ARM: OMAP3LOGIC: Added SMSC Ethernet board support
Date: Mon, 27 Sep 2010 11:05:50 -0500
Message-ID: <1285603550-6382-5-git-send-email-tim.nordell@logicpd.com>
References: <1285603550-6382-1-git-send-email-tim.nordell@logicpd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285603550-6382-1-git-send-email-tim.nordell@logicpd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tim Nordell <tim.nordell@logicpd.com>
List-Id: linux-omap@vger.kernel.org

Enable SMSC911x Ethernet driver for LogicPD's OMAP
3530 LV SOM and OMAP 35x Torpedo board.

Signed-off-by: Tim Nordell <tim.nordell@logicpd.com>
---
 arch/arm/mach-omap2/board-omap3logic.c |   65 ++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index e1f8fbe..687213a 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -38,6 +38,7 @@
 #include <plat/mux.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/gpmc-smsc911x.h>
 #include <plat/gpmc.h>
 #include <plat/timer-gp.h>
 #include <plat/sdrc.h>
@@ -141,6 +142,58 @@ static void __init board_mmc_init(void)
 	omap3logic_vmmc1_supply.dev = board_mmc_info[0].dev;
 }
 
+static struct omap_smsc911x_platform_data __initdata board_smsc911x_data = {
+	.cs             = OMAP3LOGIC_SMSC911X_CS,
+	.gpio_irq       = -EINVAL,
+	.gpio_reset     = -EINVAL,
+	.flags          = IORESOURCE_IRQ_LOWLEVEL,
+};
+
+/* TODO/FIXME (comment by Peter Barada, LogicPD):
+ * Fix the PBIAS voltage for Torpedo MMC1 pins that
+ * are used for other needs (IRQs, etc).            */
+static void omap3torpedo_fix_pbias_voltage(void)
+{
+	u16 control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
+	u32 reg;
+
+	if (machine_is_omap3_torpedo())
+	{
+		/* Set the bias for the pin */
+		reg = omap_ctrl_readl(control_pbias_offset);
+
+		reg &= ~OMAP343X_PBIASLITEPWRDNZ1;
+		omap_ctrl_writel(reg, control_pbias_offset);
+
+		/* 100ms delay required for PBIAS configuration */
+		msleep(100);
+
+		reg |= OMAP343X_PBIASLITEVMODE1;
+		reg |= OMAP343X_PBIASLITEPWRDNZ1;
+		omap_ctrl_writel(reg | 0x300, control_pbias_offset);
+	}
+}
+
+static inline void __init board_smsc911x_init(void)
+{
+	if (machine_is_omap3530_lv_som()) {
+		/* OMAP3530 LV SOM board */
+		board_smsc911x_data.gpio_irq =
+					OMAP3530_LV_SOM_SMSC911X_GPIO_IRQ;
+		omap_mux_init_signal("gpio_152", OMAP_PIN_INPUT);
+	} else if (machine_is_omap3_torpedo()) {
+		/* OMAP3 Torpedo board */
+		board_smsc911x_data.gpio_irq = OMAP3_TORPEDO_SMSC911X_GPIO_IRQ;
+		omap_mux_init_signal("gpio_129", OMAP_PIN_INPUT);
+	} else {
+		/* unsupported board */
+		printk(KERN_ERR "%s(): unknown machine type\n", __func__);
+		return;
+	}
+
+	gpmc_smsc911x_init(&board_smsc911x_data);
+}
+
 static void __init omap3logic_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
@@ -148,11 +201,23 @@ static void __init omap3logic_init_irq(void)
 	omap_gpio_init();
 }
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux       NULL
+#endif
+
 static void __init omap3logic_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	omap3torpedo_fix_pbias_voltage();
 	omap3logic_i2c_init();
 	omap_serial_init();
 	board_mmc_init();
+	board_smsc911x_init();
+
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-- 
1.7.1
