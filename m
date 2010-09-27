From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 03/13 v3] OMAP: UART: omap_device converions,
      remove implicit 8520 assumptions
Date: Mon, 27 Sep 2010 20:19:38 +0530 (IST)
Message-ID: <43460.10.24.255.17.1285598978.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Major rework of OMAP UART init for omap_device conversion as well as
use with either 8250 driver or new omap-serial driver.

In preparation for a new omap-serial driver, remove 8250 assumptions
and dependencies from the serial core.

Convert UART core and PM support to use omap_device layer. Also add
support for both console on 8250 or omap-serial driver.

omap_device conversion:
- Convert clock API calls to omap_device calls
- Remove all static platform_data setup and configuration.  This is
  all done by the omap_device build phase.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |  529 +++++++++++++++++++++---------------------
 1 files changed, 260 insertions(+), 269 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 566e991..e6c4027 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -19,19 +19,29 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/serial_8250.h>
+
+#ifdef CONFIG_SERIAL_OMAP
+#include <plat/omap-serial.h>
+#endif

 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/clock.h>
 #include <plat/control.h>
+#include <plat/dma.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>

 #include "prm.h"
 #include "pm.h"
+#include "cm.h"
 #include "prm-regbits-34xx.h"

 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
@@ -48,6 +58,8 @@
  */
 #define DEFAULT_TIMEOUT 0

+#define MAX_UART_HWMOD_NAME_LEN		16
+
 struct omap_uart_state {
 	int num;
 	int can_sleep;
@@ -58,14 +70,21 @@ struct omap_uart_state {
 	void __iomem *wk_en;
 	u32 wk_mask;
 	u32 padconf;
+	u32 dma_enabled;

 	struct clk *ick;
 	struct clk *fck;
 	int clocked;

-	struct plat_serial8250_port *p;
+	int irq;
+	int regshift;
+	int irqflags;
+	void __iomem *membase;
+	resource_size_t mapbase;
+
 	struct list_head node;
-	struct platform_device pdev;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;

 	u32 errata;
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
@@ -83,75 +102,33 @@ struct omap_uart_state {
 };

 static LIST_HEAD(uart_list);
+static u8 num_uarts;

-static struct plat_serial8250_port serial_platform_data0[] = {
-	{
-		.irq		= 72,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-		.flags		= 0
-	}
-};
-
-static struct plat_serial8250_port serial_platform_data1[] = {
-	{
-		.irq		= 73,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-		.flags		= 0
-	}
-};
-
-static struct plat_serial8250_port serial_platform_data2[] = {
-	{
-		.irq		= 74,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-		.flags		= 0
-	}
-};
-
-static struct plat_serial8250_port serial_platform_data3[] = {
-	{
-		.irq		= 70,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-		.flags		= 0
-	}
-};

 void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
 {
-	serial_platform_data0[0].mapbase = omap2_globals->uart1_phys;
-	serial_platform_data1[0].mapbase = omap2_globals->uart2_phys;
-	serial_platform_data2[0].mapbase = omap2_globals->uart3_phys;
-	serial_platform_data3[0].mapbase = omap2_globals->uart4_phys;
 }

+static struct omap_device_pm_latency omap_uart_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func	 = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
 static inline unsigned int __serial_read_reg(struct uart_port *up,
-					   int offset)
+					     int offset)
 {
 	offset <<= up->regshift;
 	return (unsigned int)__raw_readb(up->membase + offset);
 }

-static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
+static inline unsigned int serial_read_reg(struct omap_uart_state *uart,
 					   int offset)
 {
-	offset <<= up->regshift;
-	return (unsigned int)__raw_readb(up->membase + offset);
+	offset <<= uart->regshift;
+	return (unsigned int)__raw_readb(uart->membase + offset);
 }

 static inline void __serial_write_reg(struct uart_port *up, int offset,
@@ -161,11 +138,11 @@ static inline void __serial_write_reg(struct uart_port *up, int offset,
 	__raw_writeb(value, up->membase + offset);
 }

-static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
+static inline void serial_write_reg(struct omap_uart_state *uart, int offset,
 				    int value)
 {
-	offset <<= p->regshift;
-	__raw_writeb(value, p->membase + offset);
+	offset <<= uart->regshift;
+	__raw_writeb(value, uart->membase + offset);
 }

 /*
@@ -173,14 +150,12 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
  * properly. Note that the TX watermark initialization may not be needed
  * once the 8250.c watermark handling code is merged.
  */
+
 static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
-
-	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
-	serial_write_reg(p, UART_OMAP_SCR, 0x08);
-	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
-	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
+	serial_write_reg(uart, UART_OMAP_MDR1, 0x07);
+	serial_write_reg(uart, UART_OMAP_SCR, 0x08);
+	serial_write_reg(uart, UART_OMAP_MDR1, 0x00);
 }

 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
@@ -197,24 +172,23 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u8 mdr1_val,
 		u8 fcr_val)
 {
-	struct plat_serial8250_port *p = uart->p;
 	u8 timeout = 255;

-	serial_write_reg(p, UART_OMAP_MDR1, mdr1_val);
+	serial_write_reg(uart, UART_OMAP_MDR1, mdr1_val);
 	udelay(2);
-	serial_write_reg(p, UART_FCR, fcr_val | UART_FCR_CLEAR_XMIT |
+	serial_write_reg(uart, UART_FCR, fcr_val | UART_FCR_CLEAR_XMIT |
 			UART_FCR_CLEAR_RCVR);
 	/*
 	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
 	 * TX_FIFO_E bit is 1.
 	 */
-	while (UART_LSR_THRE != (serial_read_reg(p, UART_LSR) &
+	while (UART_LSR_THRE != (serial_read_reg(uart, UART_LSR) &
 				(UART_LSR_THRE | UART_LSR_DR))) {
 		timeout--;
 		if (!timeout) {
 			/* Should *never* happen. we warn and carry on */
-			dev_crit(&uart->pdev.dev, "Errata i202: timedout %x\n",
-				serial_read_reg(p, UART_LSR));
+			dev_crit(&uart->pdev->dev, "Errata i202: timedout %x\n",
+			serial_read_reg(uart, UART_LSR));
 			break;
 		}
 		udelay(1);
@@ -224,23 +198,22 @@ static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u8 mdr1_val,
 static void omap_uart_save_context(struct omap_uart_state *uart)
 {
 	u16 lcr = 0;
-	struct plat_serial8250_port *p = uart->p;

 	if (!enable_off_mode)
 		return;

-	lcr = serial_read_reg(p, UART_LCR);
-	serial_write_reg(p, UART_LCR, 0xBF);
-	uart->dll = serial_read_reg(p, UART_DLL);
-	uart->dlh = serial_read_reg(p, UART_DLM);
-	serial_write_reg(p, UART_LCR, lcr);
-	uart->ier = serial_read_reg(p, UART_IER);
-	uart->sysc = serial_read_reg(p, UART_OMAP_SYSC);
-	uart->scr = serial_read_reg(p, UART_OMAP_SCR);
-	uart->wer = serial_read_reg(p, UART_OMAP_WER);
-	serial_write_reg(p, UART_LCR, 0x80);
-	uart->mcr = serial_read_reg(p, UART_MCR);
-	serial_write_reg(p, UART_LCR, lcr);
+	lcr = serial_read_reg(uart, UART_LCR);
+	serial_write_reg(uart, UART_LCR, 0xBF);
+	uart->dll = serial_read_reg(uart, UART_DLL);
+	uart->dlh = serial_read_reg(uart, UART_DLM);
+	serial_write_reg(uart, UART_LCR, lcr);
+	uart->ier = serial_read_reg(uart, UART_IER);
+	uart->sysc = serial_read_reg(uart, UART_OMAP_SYSC);
+	uart->scr = serial_read_reg(uart, UART_OMAP_SCR);
+	uart->wer = serial_read_reg(uart, UART_OMAP_WER);
+	serial_write_reg(uart, UART_LCR, 0x80);
+	uart->mcr = serial_read_reg(uart, UART_MCR);
+	serial_write_reg(uart, UART_LCR, lcr);

 	uart->context_valid = 1;
 }
@@ -248,7 +221,6 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 static void omap_uart_restore_context(struct omap_uart_state *uart)
 {
 	u16 efr = 0;
-	struct plat_serial8250_port *p = uart->p;

 	if (!enable_off_mode)
 		return;
@@ -261,29 +233,30 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 	if (uart->errata & UART_ERRATA_i202_MDR1_ACCESS)
 		omap_uart_mdr1_errataset(uart, 0x07, 0xA0);
 	else
-		serial_write_reg(p, UART_OMAP_MDR1, 0x7);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	efr = serial_read_reg(p, UART_EFR);
-	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
-	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(p, UART_IER, 0x0);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	serial_write_reg(p, UART_DLL, uart->dll);
-	serial_write_reg(p, UART_DLM, uart->dlh);
-	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(p, UART_IER, uart->ier);
-	serial_write_reg(p, UART_LCR, 0x80);
-	serial_write_reg(p, UART_MCR, uart->mcr);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	serial_write_reg(p, UART_EFR, efr);
-	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
-	serial_write_reg(p, UART_OMAP_SCR, uart->scr);
-	serial_write_reg(p, UART_OMAP_WER, uart->wer);
-	serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
+		serial_write_reg(uart, UART_OMAP_MDR1, 0x7);
+	serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mode */
+	efr = serial_read_reg(uart, UART_EFR);
+	serial_write_reg(uart, UART_EFR, UART_EFR_ECB);
+	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(uart, UART_IER, 0x0);
+	serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(uart, UART_DLL, uart->dll);
+	serial_write_reg(uart, UART_DLM, uart->dlh);
+	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(uart, UART_IER, uart->ier);
+	serial_write_reg(uart, UART_LCR, 0x80);
+	serial_write_reg(uart, UART_MCR, uart->mcr);
+	serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(uart, UART_EFR, efr);
+	serial_write_reg(uart, UART_LCR, UART_LCR_WLEN8);
+	serial_write_reg(uart, UART_OMAP_SCR, uart->scr);
+	serial_write_reg(uart, UART_OMAP_WER, uart->wer);
+	serial_write_reg(uart, UART_OMAP_SYSC, uart->sysc);
 	if (uart->errata & UART_ERRATA_i202_MDR1_ACCESS)
 		omap_uart_mdr1_errataset(uart, 0x00, 0xA1);
 	else
-		serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+		/* UART 16x mode */
+		serial_write_reg(uart, UART_OMAP_MDR1, 0x00);
 }
 #else
 static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
@@ -295,8 +268,7 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 	if (uart->clocked)
 		return;

-	clk_enable(uart->ick);
-	clk_enable(uart->fck);
+	omap_device_enable(uart->pdev);
 	uart->clocked = 1;
 	omap_uart_restore_context(uart);
 }
@@ -310,8 +282,7 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)

 	omap_uart_save_context(uart);
 	uart->clocked = 0;
-	clk_disable(uart->ick);
-	clk_disable(uart->fck);
+	omap_device_idle(uart->pdev);
 }

 static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
@@ -349,18 +320,24 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 }

 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
-					  int enable)
+					       int enable)
 {
-	struct plat_serial8250_port *p = uart->p;
-	u16 sysc;
+	u8 idlemode;

-	sysc = serial_read_reg(p, UART_OMAP_SYSC) & 0x7;
-	if (enable)
-		sysc |= 0x2 << 3;
-	else
-		sysc |= 0x1 << 3;
+	if (enable) {
+		/**
+		 * Errata 2.15: [UART]:Cannot Acknowledge Idle Requests
+		 * in Smartidle Mode When Configured for DMA Operations.
+		 */
+		if (uart->dma_enabled)
+			idlemode = HWMOD_IDLEMODE_FORCE;
+		else
+			idlemode = HWMOD_IDLEMODE_SMART;
+	} else {
+		idlemode = HWMOD_IDLEMODE_NO;
+	}

-	serial_write_reg(p, UART_OMAP_SYSC, sysc);
+	omap_hwmod_set_slave_idlemode(uart->oh, idlemode);
 }

 static void omap_uart_block_sleep(struct omap_uart_state *uart)
@@ -377,7 +354,7 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)

 static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 {
-	if (device_may_wakeup(&uart->pdev.dev))
+	if (device_may_wakeup(&uart->pdev->dev))
 		omap_uart_enable_wakeup(uart);
 	else
 		omap_uart_disable_wakeup(uart);
@@ -472,6 +449,7 @@ int omap_uart_can_sleep(void)
  * UART will not idle or sleep for its timeout period.
  *
  **/
+/* static int first_interrupt; */
 static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 {
 	struct omap_uart_state *uart = dev_id;
@@ -483,7 +461,6 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)

 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
 	int ret;

 	uart->can_sleep = 0;
@@ -546,9 +523,9 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->padconf = 0;
 	}

-	p->irqflags |= IRQF_SHARED;
-	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
-			  "serial idle", (void *)uart);
+	uart->irqflags |= IRQF_SHARED;
+	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
+				   IRQF_SHARED, "serial idle", (void *)uart);
 	WARN_ON(ret);
 }

@@ -559,10 +536,13 @@ void omap_uart_enable_irqs(int enable)

 	list_for_each_entry(uart, &uart_list, node) {
 		if (enable)
-			ret = request_irq(uart->p->irq, omap_uart_interrupt,
-				IRQF_SHARED, "serial idle", (void *)uart);
+			ret = request_threaded_irq(uart->irq, NULL,
+						   omap_uart_interrupt,
+						   IRQF_SHARED,
+						   "serial idle",
+						   (void *)uart);
 		else
-			free_irq(uart->p->irq, (void *)uart);
+			free_irq(uart->irq, (void *)uart);
 	}
 }

@@ -570,10 +550,9 @@ static ssize_t sleep_timeout_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	struct platform_device *pdev = container_of(dev,
-					struct platform_device, dev);
-	struct omap_uart_state *uart = container_of(pdev,
-					struct omap_uart_state, pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	struct omap_uart_state *uart = odev->hwmods[0]->dev_attr;

 	return sprintf(buf, "%u\n", uart->timeout / HZ);
 }
@@ -582,10 +561,9 @@ static ssize_t sleep_timeout_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t n)
 {
-	struct platform_device *pdev = container_of(dev,
-					struct platform_device, dev);
-	struct omap_uart_state *uart = container_of(pdev,
-					struct omap_uart_state, pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	struct omap_uart_state *uart = odev->hwmods[0]->dev_attr;
 	unsigned int value;

 	if (sscanf(buf, "%u", &value) != 1) {
@@ -608,48 +586,11 @@ static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
 #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
+static void omap_uart_block_sleep(struct omap_uart_state *uart) {}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */

-static struct omap_uart_state omap_uart[] = {
-	{
-		.pdev = {
-			.name			= "serial8250",
-			.id			= PLAT8250_DEV_PLATFORM,
-			.dev			= {
-				.platform_data	= serial_platform_data0,
-			},
-		},
-	}, {
-		.pdev = {
-			.name			= "serial8250",
-			.id			= PLAT8250_DEV_PLATFORM1,
-			.dev			= {
-				.platform_data	= serial_platform_data1,
-			},
-		},
-	}, {
-		.pdev = {
-			.name			= "serial8250",
-			.id			= PLAT8250_DEV_PLATFORM2,
-			.dev			= {
-				.platform_data	= serial_platform_data2,
-			},
-		},
-	},
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-	{
-		.pdev = {
-			.name			= "serial8250",
-			.id			= 3,
-			.dev			= {
-				.platform_data	= serial_platform_data3,
-			},
-		},
-	},
-#endif
-};
-
+#ifndef CONFIG_SERIAL_OMAP
 /*
  * Override the default 8250 read handler: mem_serial_in()
  * Empty RX fifo read causes an abort on omap3630 and omap4
@@ -682,71 +623,44 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 	}
 	__serial_write_reg(up, offset, value);
 }
+#endif
+
 void __init omap_serial_early_init(void)
 {
-	int i, nr_ports;
-	char name[16];
+	int i = 0;

-	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
-		nr_ports = 3;
-	else
-		nr_ports = ARRAY_SIZE(omap_uart);
+	do {
+		char oh_name[MAX_UART_HWMOD_NAME_LEN];
+		struct omap_hwmod *oh;
+		struct omap_uart_state *uart;

-	/*
-	 * Make sure the serial ports are muxed on at this point.
-	 * You have to mux them off in device drivers later on
-	 * if not needed.
-	 */
+		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
+			 "uart%d", i + 1);
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh)
+			break;
+
+		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
+		if (WARN_ON(!uart))
+			return;

-	for (i = 0; i < nr_ports; i++) {
-		struct omap_uart_state *uart = &omap_uart[i];
-		struct platform_device *pdev = &uart->pdev;
-		struct device *dev = &pdev->dev;
-		struct plat_serial8250_port *p = dev->platform_data;
+		uart->oh = oh;
+		uart->num = i++;
+		list_add_tail(&uart->node, &uart_list);
+		num_uarts++;

-		/* Don't map zero-based physical address */
-		if (p->mapbase == 0) {
-			dev_warn(dev, "no physical address for uart#%d,"
-				 " so skipping early_init...\n", i);
-			continue;
-		}
 		/*
-		 * Module 4KB + L4 interconnect 4KB
-		 * Static mapping, never released
+		 * NOTE: omap_hwmod_init() has not yet been called,
+		 *       so no hwmod functions will work yet.
 		 */
-		p->membase = ioremap(p->mapbase, SZ_8K);
-		if (!p->membase) {
-			dev_err(dev, "ioremap failed for uart%i\n", i + 1);
-			continue;
-		}
-
-		sprintf(name, "uart%d_ick", i + 1);
-		uart->ick = clk_get(NULL, name);
-		if (IS_ERR(uart->ick)) {
-			dev_err(dev, "Could not get uart%d_ick\n", i + 1);
-			uart->ick = NULL;
-		}

-		sprintf(name, "uart%d_fck", i+1);
-		uart->fck = clk_get(NULL, name);
-		if (IS_ERR(uart->fck)) {
-			dev_err(dev, "Could not get uart%d_fck\n", i + 1);
-			uart->fck = NULL;
-		}
-
-		/* FIXME: Remove this once the clkdev is ready */
-		if (!cpu_is_omap44xx()) {
-			if (!uart->ick || !uart->fck)
-				continue;
-		}
-
-		uart->num = i;
-		p->private_data = uart;
-		uart->p = p;
-
-		if (cpu_is_omap44xx())
-			p->irq += 32;
-	}
+		/*
+		 * During UART early init, device need to be probed
+		 * to determine SoC specific init before omap_device
+		 * is ready.  Therefore, don't allow idle here
+		 */
+		uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
+	} while (1);
 }

 /**
@@ -763,53 +677,135 @@ void __init omap_serial_early_init(void)
 void __init omap_serial_init_port(int port)
 {
 	struct omap_uart_state *uart;
-	struct platform_device *pdev;
-	struct device *dev;
-
-	BUG_ON(port < 0);
-	BUG_ON(port >= ARRAY_SIZE(omap_uart));
-
-	uart = &omap_uart[port];
-	pdev = &uart->pdev;
-	dev = &pdev->dev;
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	void *pdata = NULL;
+	u32 pdata_size = 0;
+	char *name;
+#ifndef CONFIG_SERIAL_OMAP
+	struct plat_serial8250_port ports[2] = {
+		{},
+		{.flags = 0},
+	};
+	struct plat_serial8250_port *p = &ports[0];
+#else
+	struct omap_uart_port_info omap_up;
+#endif

-	/* Don't proceed if there's no clocks available */
-	if (unlikely(!uart->ick || !uart->fck)) {
-		WARN(1, "%s: can't init uart%d, no clocks available\n",
-		     kobject_name(&dev->kobj), port);
+	if (WARN_ON(port < 0))
+		return;
+	if (WARN_ON(port >= num_uarts))
 		return;
-	}
-
-	omap_uart_enable_clocks(uart);
-
-	omap_uart_reset(uart);
-	omap_uart_idle_init(uart);

-	list_add_tail(&uart->node, &uart_list);
+	list_for_each_entry(uart, &uart_list, node)
+		if (port == uart->num)
+			break;

-	if (WARN_ON(platform_device_register(pdev)))
-		return;
+	oh = uart->oh;
+	uart->dma_enabled = 0;
+#ifndef CONFIG_SERIAL_OMAP
+	name = "serial8250";

-	if ((cpu_is_omap34xx() && uart->padconf) ||
-	    (uart->wk_en && uart->wk_mask)) {
-		device_init_wakeup(dev, true);
-		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
-	}
+	/*
+	 * !! 8250 driver does not use standard IORESOURCE* It
+	 * has it's own custom pdata that can be taken from
+	 * the hwmod resource data.  But, this needs to be
+	 * done after the build.
+	 *
+	 * ?? does it have to be done before the register ??
+	 * YES, because platform_device_data_add() copies
+	 * pdata, it does not use a pointer.
+	 */
+	p->flags = UPF_BOOT_AUTOCONF;
+	p->iotype = UPIO_MEM;
+	p->regshift = 2;
+	p->uartclk = OMAP24XX_BASE_BAUD * 16;
+	p->irq = oh->mpu_irqs[0].irq;
+	p->mapbase = oh->slaves[0]->addr->pa_start;
+	p->membase = omap_hwmod_get_mpu_rt_va(oh);
+	p->irqflags = IRQF_SHARED;
+	p->private_data = uart;

 	/*
 	 * omap44xx: Never read empty UART fifo
 	 * omap3xxx: Never read empty UART fifo on UARTs
 	 * with IP rev >=0x52
 	 */
+	uart->regshift = p->regshift;
+	uart->membase = p->membase;
 	if (cpu_is_omap44xx())
 		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
-	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
+	else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
 			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
 		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;

 	if (uart->errata & UART_ERRATA_FIFO_FULL_ABORT) {
-		uart->p->serial_in = serial_in_override;
-		uart->p->serial_out = serial_out_override;
+		p->serial_in = serial_in_override;
+		p->serial_out = serial_out_override;
+	}
+
+	pdata = &ports[0];
+	pdata_size = 2 * sizeof(struct plat_serial8250_port);
+#else
+
+	name = DRIVER_NAME;
+
+	omap_up.dma_enabled = uart->dma_enabled;
+	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
+	omap_up.mapbase = oh->slaves[0]->addr->pa_start;
+	omap_up.membase = omap_hwmod_get_mpu_rt_va(oh);
+	omap_up.irqflags = IRQF_SHARED;
+	omap_up.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+
+	pdata = &omap_up;
+	pdata_size = sizeof(struct omap_uart_port_info);
+#endif
+
+	if (WARN_ON(!oh))
+		return;
+
+	od = omap_device_build(name, uart->num, oh, pdata, pdata_size,
+			       omap_uart_latency,
+			       ARRAY_SIZE(omap_uart_latency), false);
+	WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
+	     name, oh->name);
+
+	uart->irq = oh->mpu_irqs[0].irq;
+	uart->regshift = 2;
+	uart->mapbase = oh->slaves[0]->addr->pa_start;
+	uart->membase = omap_hwmod_get_mpu_rt_va(oh);
+	uart->pdev = &od->pdev;
+
+	oh->dev_attr = uart;
+
+	/*
+	 * Because of early UART probing, UART did not get idled
+	 * on init.  Now that omap_device is ready, ensure full idle
+	 * before doing omap_device_enable().
+	 */
+	omap_hwmod_idle(uart->oh);
+
+	omap_device_enable(uart->pdev);
+	omap_uart_idle_init(uart);
+	omap_uart_reset(uart);
+	omap_hwmod_enable_wakeup(uart->oh);
+	omap_device_idle(uart->pdev);
+
+	/*
+	 * Need to block sleep long enough for interrupt driven
+	 * driver to start.  Console driver is in polling mode
+	 * so device needs to be kept enabled while polling driver
+	 * is in use.
+	 */
+	if (uart->timeout)
+		uart->timeout = (30 * HZ);
+	omap_uart_block_sleep(uart);
+	uart->timeout = DEFAULT_TIMEOUT;
+
+	if ((cpu_is_omap34xx() && uart->padconf) ||
+	    (uart->wk_en && uart->wk_mask)) {
+		device_init_wakeup(&od->pdev.dev, true);
+		DEV_CREATE_FILE(&od->pdev.dev, &dev_attr_sleep_timeout);
 	}

 	/* Enable the MDR1 errata for OMAP3 */
@@ -826,13 +822,8 @@ void __init omap_serial_init_port(int port)
  */
 void __init omap_serial_init(void)
 {
-	int i, nr_ports;
-
-	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
-		nr_ports = 3;
-	else
-		nr_ports = ARRAY_SIZE(omap_uart);
+	struct omap_uart_state *uart;

-	for (i = 0; i < nr_ports; i++)
-		omap_serial_init_port(i);
+	list_for_each_entry(uart, &uart_list, node)
+		omap_serial_init_port(uart->num);
 }
-- 
1.6.3.3


