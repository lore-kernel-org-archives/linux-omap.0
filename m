From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 13/13] serial: 8250: add OMAP glue
Date: Wed, 23 Apr 2014 09:58:37 -0500
Message-ID: <1398265117-11793-13-git-send-email-balbi@ti.com>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398265117-11793-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

NOT COMPLETE

NYET-Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/tty/serial/8250/8250_omap.c | 233 ++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |   7 ++
 drivers/tty/serial/8250/Makefile    |   1 +
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_omap.c

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
new file mode 100644
index 0000000..e8ae479
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -0,0 +1,233 @@
+/*
+ * 8250-omap.c - OMAP adaptation for 8250 driver
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
+ *
+ * Based on omap-serial.c:
+ *
+ * Copyright (C) 2010 Texas Instruments
+ *
+ * Authors:
+ *	Govindraj R	<govindraj.raja-l0cyMroinI0@public.gmane.org>
+ *	Thara Gopinath	<thara-l0cyMroinI0@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Note: This driver is made separate from 8250 driver as we cannot
+ * over load 8250 driver with omap platform specific configuration for
+ * features like DMA, it makes easier to implement features like DMA and
+ * hardware flow control and software flow control configuration with
+ * this driver as required for the omap-platform.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_data/serial-omap.h>
+
+#include <dt-bindings/gpio/gpio.h>
+
+#define OMAP_MAX_HSUART_PORTS	6
+
+#define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
+
+#define OMAP_UART_REV_42 0x0402
+#define OMAP_UART_REV_46 0x0406
+#define OMAP_UART_REV_52 0x0502
+#define OMAP_UART_REV_63 0x0603
+
+#define OMAP_UART_TX_WAKEUP_EN		BIT(7)
+
+/* Feature flags */
+#define OMAP_UART_WER_HAS_TX_WAKEUP	BIT(0)
+
+#define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
+#define UART_ERRATA_i291_DMA_FORCEIDLE	BIT(1)
+
+#define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
+
+/* SCR register bitmasks */
+#define OMAP_UART_SCR_RX_TRIG_GRANU1_MASK		(1 << 7)
+#define OMAP_UART_SCR_TX_TRIG_GRANU1_MASK		(1 << 6)
+#define OMAP_UART_SCR_TX_EMPTY			(1 << 3)
+
+/* FCR register bitmasks */
+#define OMAP_UART_FCR_RX_FIFO_TRIG_MASK			(0x3 << 6)
+#define OMAP_UART_FCR_TX_FIFO_TRIG_MASK			(0x3 << 4)
+
+/* MVR register bitmasks */
+#define OMAP_UART_MVR_SCHEME_SHIFT	30
+
+#define OMAP_UART_LEGACY_MVR_MAJ_MASK	0xf0
+#define OMAP_UART_LEGACY_MVR_MAJ_SHIFT	4
+#define OMAP_UART_LEGACY_MVR_MIN_MASK	0x0f
+
+#define OMAP_UART_MVR_MAJ_MASK		0x700
+#define OMAP_UART_MVR_MAJ_SHIFT		8
+#define OMAP_UART_MVR_MIN_MASK		0x3f
+
+#define OMAP_UART_DMA_CH_FREE	-1
+
+#define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
+#define OMAP_MODE13X_SPEED	230400
+
+/* WER = 0x7F
+ * Enable module level wakeup in WER reg
+ */
+#define OMAP_UART_WER_MOD_WKUP	0X7F
+
+/* Enable XON/XOFF flow control on output */
+#define OMAP_UART_SW_TX		0x08
+
+/* Enable XON/XOFF flow control on input */
+#define OMAP_UART_SW_RX		0x02
+
+#define OMAP_UART_SW_CLR	0xF0
+
+#define OMAP_UART_TCR_TRIG	0x0F
+
+struct uart_omap_port {
+	struct uart_8250_port	uart;
+	struct device		*dev;
+	int			wakeirq;
+
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned char		fcr;
+	unsigned char		efr;
+	unsigned char		dll;
+	unsigned char		dlh;
+	unsigned char		mdr1;
+	unsigned char		scr;
+	unsigned char		wer;
+
+	int			line;
+
+	/*
+	 * Some bits in registers are cleared on a read, so they must
+	 * be saved whenever the register is read but the bits will not
+	 * be immediately processed.
+	 */
+	unsigned int		lsr_break_flag;
+	unsigned char		msr_saved_flags;
+	char			name[20];
+	unsigned long		port_activity;
+	int			context_loss_cnt;
+	u32			errata;
+	u8			wakeups_enabled;
+	u32			features;
+};
+
+#define to_uart_omap_port(p) ((container_of((p), struct uart_omap_port, port)))
+
+static int serial_omap_probe(struct platform_device *pdev)
+{
+	struct uart_omap_port *up;
+	struct resource *mem;
+	void __iomem *base;
+	int uartirq = 0;
+	int ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	uartirq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (!uartirq)
+		return -EPROBE_DEFER;
+
+	up = devm_kzalloc(&pdev->dev, sizeof(*up), GFP_KERNEL);
+	if (!up)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	up->dev = &pdev->dev;
+	up->uart.port.mapbase = mem->start;
+	up->uart.port.membase = base;
+	up->uart.port.irq = uartirq;
+	up->uart.port.dev = &pdev->dev;
+	up->uart.port.type = PORT_16750;
+	up->uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
+	up->uart.port.iotype = UPIO_MEM;
+
+	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				&up->uart.port.uartclk)) {
+		up->uart.port.uartclk = DEFAULT_CLK_SPEED;
+		dev_warn(&pdev->dev,
+			 "No clock speed specified: using default: %d\n",
+			 DEFAULT_CLK_SPEED);
+	}
+
+	platform_set_drvdata(pdev, up);
+
+	device_init_wakeup(up->dev, true);
+	pm_runtime_irq_safe(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	ret = serial8250_register_8250_port(&up->uart);
+	if (ret < 0)
+		goto err_add_port;
+
+	up->line = ret;
+
+	return 0;
+
+err_add_port:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
+				pdev->id, __func__, ret);
+	return ret;
+}
+
+static int serial_omap_remove(struct platform_device *dev)
+{
+	struct uart_omap_port *up = platform_get_drvdata(dev);
+
+	serial8250_unregister_port(up->line);
+
+	pm_runtime_put_sync(up->dev);
+	pm_runtime_disable(up->dev);
+
+	return 0;
+}
+
+static const struct of_device_id omap_serial_of_match[] = {
+	{ .compatible = "ti,am335x-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_serial_of_match);
+
+static struct platform_driver serial_omap_driver = {
+	.probe          = serial_omap_probe,
+	.remove         = serial_omap_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.of_match_table = of_match_ptr(omap_serial_of_match),
+	},
+};
+
+module_platform_driver(serial_omap_driver);
+
+MODULE_DESCRIPTION("OMAP High Speed UART driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Texas Instruments Incorporated");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 2332991..ad092d5 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -287,6 +287,13 @@ config SERIAL_8250_DW
 	  Selecting this option will enable handling of the extra features
 	  present in the Synopsys DesignWare APB UART.
 
+config SERIAL_8250_OMAP
+	tristate "Support for OMAP 8250 quirks"
+	depends on SERIAL_8250
+	help
+	  Selecting this option will enable handling of the extra features
+	  present in the TI OMAP UART.
+
 config SERIAL_8250_EM
 	tristate "Support for Emma Mobile integrated serial port"
 	depends on SERIAL_8250 && ARM && HAVE_CLK
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 36d68d0..0119a11 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -19,4 +19,5 @@ obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
+obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
-- 
1.9.2.459.g68773ac

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
