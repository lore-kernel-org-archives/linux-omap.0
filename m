From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/7] tty: 8250: omap eliminate use of of_machine_is_compatible()
Date: Mon, 6 Jul 2015 15:17:54 +0530
Message-ID: <bf1f3478de98a74a3c92246d6a5d86bc71aa0cf8.1436174801.git.nsekhar@ti.com>
References: <cover.1436174801.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436174801.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use of of_machine_is_compatible() for AM335x specific DMA
quirk in 8250_omap driver makes it ugly to extend the
quirk for other platforms. Instead use a new compatible.

The new compatible will also make it easier to care of other
quirks specific to AM335x and like SoCs.

This patch does break backward DTB compatibility for users of
8250_omap driver on AM335x boards. However, the 8250_omap driver
is new and omap_serial is still the default choice driver for UART
and so choosing to break compatibility over keeping the code
around forever.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 arch/arm/boot/dts/am33xx.dtsi                      | 12 ++++----
 drivers/tty/serial/8250/8250_omap.c                | 35 +++++++++++++---------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index d3bd2b1ec401..0ee88209b341 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible : should be "ti,omap3-uart" for OMAP3 controllers
 - compatible : should be "ti,omap4-uart" for OMAP4 controllers
 - compatible : should be "ti,am4372-uart" for AM437x controllers
+- compatible : should be "ti,am3352-uart" for AM335x controllers
 - reg : address and length of the register space
 - interrupts or interrupts-extended : Should contain the uart interrupt
                                       specifier or both the interrupt
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 21fcc440fc1a..b76f9a2ce05d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -210,7 +210,7 @@
 		};
 
 		uart0: serial@44e09000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 			reg = <0x44e09000 0x2000>;
@@ -221,7 +221,7 @@
 		};
 
 		uart1: serial@48022000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 			reg = <0x48022000 0x2000>;
@@ -232,7 +232,7 @@
 		};
 
 		uart2: serial@48024000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 			reg = <0x48024000 0x2000>;
@@ -243,7 +243,7 @@
 		};
 
 		uart3: serial@481a6000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 			reg = <0x481a6000 0x2000>;
@@ -252,7 +252,7 @@
 		};
 
 		uart4: serial@481a8000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			reg = <0x481a8000 0x2000>;
@@ -261,7 +261,7 @@
 		};
 
 		uart5: serial@481aa000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			reg = <0x481aa000 0x2000>;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index d9c96b993a84..52566387ec37 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/delay.h>
@@ -537,14 +538,14 @@ static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
 
 	switch (revision) {
 	case OMAP_UART_REV_46:
-		priv->habit = UART_ERRATA_i202_MDR1_ACCESS;
+		priv->habit |= UART_ERRATA_i202_MDR1_ACCESS;
 		break;
 	case OMAP_UART_REV_52:
-		priv->habit = UART_ERRATA_i202_MDR1_ACCESS |
+		priv->habit |= UART_ERRATA_i202_MDR1_ACCESS |
 				OMAP_UART_WER_HAS_TX_WAKEUP;
 		break;
 	case OMAP_UART_REV_63:
-		priv->habit = UART_ERRATA_i202_MDR1_ACCESS |
+		priv->habit |= UART_ERRATA_i202_MDR1_ACCESS |
 			OMAP_UART_WER_HAS_TX_WAKEUP;
 		break;
 	default:
@@ -1061,6 +1062,17 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 	return 0;
 }
 
+static const u8 am3352_habit = OMAP_DMA_TX_KICK;
+
+static const struct of_device_id omap8250_dt_ids[] = {
+	{ .compatible = "ti,omap2-uart" },
+	{ .compatible = "ti,omap3-uart" },
+	{ .compatible = "ti,omap4-uart" },
+	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap8250_dt_ids);
+
 static int omap8250_probe(struct platform_device *pdev)
 {
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1125,11 +1137,17 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.unthrottle = omap_8250_unthrottle;
 
 	if (pdev->dev.of_node) {
+		const struct of_device_id *id;
+
 		ret = of_alias_get_id(pdev->dev.of_node, "serial");
 
 		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				     &up.port.uartclk);
 		priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
+
+		id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
+		if (id && id->data)
+			priv->habit |= *(u8 *)id->data;
 	} else {
 		ret = pdev->id;
 	}
@@ -1184,9 +1202,6 @@ static int omap8250_probe(struct platform_device *pdev)
 			priv->omap8250_dma.rx_size = RX_TRIGGER;
 			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
 			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
-
-			if (of_machine_is_compatible("ti,am33xx"))
-				priv->habit |= OMAP_DMA_TX_KICK;
 		}
 	}
 #endif
@@ -1374,14 +1389,6 @@ static const struct dev_pm_ops omap8250_dev_pm_ops = {
 	.complete       = omap8250_complete,
 };
 
-static const struct of_device_id omap8250_dt_ids[] = {
-	{ .compatible = "ti,omap2-uart" },
-	{ .compatible = "ti,omap3-uart" },
-	{ .compatible = "ti,omap4-uart" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, omap8250_dt_ids);
-
 static struct platform_driver omap8250_platform_driver = {
 	.driver = {
 		.name		= "omap8250",
-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
