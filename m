From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/22] ARM: omap1: move ohci phy power handling to board files
Date: Thu,  8 Aug 2019 23:22:13 +0200
Message-ID: <20190808212234.2213262-5-arnd@arndb.de>
References: <20190808212234.2213262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Two boards require a a special handler to control
their transceiver power. Move the corresponding code
into the board files and out of the common code.

The osk board already has a dependency on TPS65010,
this adds another one, with the same hack to get it
to compile with CONFIG_TPS65010=m.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-innovator.c   | 19 +++++++++++++++++
 arch/arm/mach-omap1/board-osk.c         | 19 +++++++++++++++++
 drivers/usb/host/ohci-omap.c            | 28 ++-----------------------
 include/linux/platform_data/usb-omap1.h |  2 ++
 4 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 2425f1bacb33..653af63320a8 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -290,6 +290,23 @@ static void __init innovator_init_smc91x(void)
 }
 
 #ifdef CONFIG_ARCH_OMAP15XX
+/*
+ * Board specific gang-switched transceiver power on/off.
+ */
+static int innovator_omap_ohci_transceiver_power(int on)
+{
+	if (on)
+		__raw_writeb(__raw_readb(INNOVATOR_FPGA_CAM_USB_CONTROL)
+				| ((1 << 5/*usb1*/) | (1 << 3/*usb2*/)),
+			       INNOVATOR_FPGA_CAM_USB_CONTROL);
+	else
+		__raw_writeb(__raw_readb(INNOVATOR_FPGA_CAM_USB_CONTROL)
+				& ~((1 << 5/*usb1*/) | (1 << 3/*usb2*/)),
+			       INNOVATOR_FPGA_CAM_USB_CONTROL);
+
+	return 0;
+}
+
 static struct omap_usb_config innovator1510_usb_config __initdata = {
 	/* for bundled non-standard host and peripheral cables */
 	.hmc_mode	= 4,
@@ -300,6 +317,8 @@ static struct omap_usb_config innovator1510_usb_config __initdata = {
 
 	.register_dev	= 1,
 	.pins[0]	= 2,
+
+	.transceiver_power = innovator_omap_ohci_transceiver_power,
 };
 
 static const struct omap_lcd_config innovator1510_lcd_config __initconst = {
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 4df15e693b6e..3be7b3b580d3 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -278,6 +278,23 @@ static void __init osk_init_cf(void)
 	irq_set_irq_type(gpio_to_irq(62), IRQ_TYPE_EDGE_FALLING);
 }
 
+/*
+ * Board specific gang-switched transceiver power on/off.
+ * NOTE:  OSK supplies power from DC, not battery.
+ */
+static int osk_omap_ohci_transceiver_power(int on)
+{
+	if (!IS_BUILTIN(CONFIG_TPS65010))
+		return -ENXIO;
+
+	if (on)
+		tps65010_set_gpio_out_value(GPIO1, LOW);
+	else
+		tps65010_set_gpio_out_value(GPIO1, HIGH);
+
+	return 0;
+}
+
 static struct omap_usb_config osk_usb_config __initdata = {
 	/* has usb host connector (A) ... for development it can also
 	 * be used, with a NONSTANDARD gender-bending cable/dongle, as
@@ -292,6 +309,8 @@ static struct omap_usb_config osk_usb_config __initdata = {
 	.rwc		= 1,
 #endif
 	.pins[0]	= 2,
+
+	.transceiver_power = osk_omap_ohci_transceiver_power,
 };
 
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index f7efe65f01c5..e92ef3231f2c 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -77,31 +77,6 @@ static void omap_ohci_clock_power(int on)
 	}
 }
 
-/*
- * Board specific gang-switched transceiver power on/off.
- * NOTE:  OSK supplies power from DC, not battery.
- */
-static int omap_ohci_transceiver_power(int on)
-{
-	if (on) {
-		if (machine_is_omap_innovator() && cpu_is_omap1510())
-			__raw_writeb(__raw_readb(INNOVATOR_FPGA_CAM_USB_CONTROL)
-				| ((1 << 5/*usb1*/) | (1 << 3/*usb2*/)),
-			       INNOVATOR_FPGA_CAM_USB_CONTROL);
-		else if (machine_is_omap_osk())
-			tps65010_set_gpio_out_value(GPIO1, LOW);
-	} else {
-		if (machine_is_omap_innovator() && cpu_is_omap1510())
-			__raw_writeb(__raw_readb(INNOVATOR_FPGA_CAM_USB_CONTROL)
-				& ~((1 << 5/*usb1*/) | (1 << 3/*usb2*/)),
-			       INNOVATOR_FPGA_CAM_USB_CONTROL);
-		else if (machine_is_omap_osk())
-			tps65010_set_gpio_out_value(GPIO1, HIGH);
-	}
-
-	return 0;
-}
-
 #ifdef	CONFIG_USB_OTG
 
 static void start_hnp(struct ohci_hcd *ohci)
@@ -213,7 +188,8 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 	}
 
 	/* FIXME hub_wq hub requests should manage power switching */
-	omap_ohci_transceiver_power(1);
+	if (config->transceiver_power)
+		config->transceiver_power(1);
 
 	/* board init will have already handled HMC and mux setup.
 	 * any external transceiver should already be initialized
diff --git a/include/linux/platform_data/usb-omap1.h b/include/linux/platform_data/usb-omap1.h
index 878e572a78bf..e7b8dc92a269 100644
--- a/include/linux/platform_data/usb-omap1.h
+++ b/include/linux/platform_data/usb-omap1.h
@@ -50,6 +50,8 @@ struct omap_usb_config {
 	int (*ocpi_enable)(void);
 
 	void (*lb_reset)(void);
+
+	int (*transceiver_power)(int on);
 };
 
 #endif /* __LINUX_USB_OMAP1_H */
-- 
2.20.0
