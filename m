From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 04/16] OMAP2+: UART: cleanup 8250 console driver support
Date: Fri, 30 Sep 2011 16:31:30 +0530
Message-ID: <1317380495-584-4-git-send-email-govindraj.raja@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

We had been using traditional 8250 driver as uart console driver
prior to omap-serial driver. Since we have omap-serial driver
in mainline kernel for some time now it has been used as default
uart console driver on omap2+ platforms. Remove 8250 support for
omap-uarts.

Serial_in and serial_out override for 8250 serial driver is also
removed. Empty fifo read fix is already taken care with omap-serial
driver with data ready bit check from LSR reg before reading RX fifo.
Also waiting for THRE(transmit hold reg empty) is done with wait_for_xmitr
in omap-serial driver.

Remove headers that were necessary to support 8250 support
and remove all config bindings done to keep 8250 backward compatibility
while adding omap-serial driver. Remove omap_uart_reset needed for
8250 autoconf.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |  111 ------------------------------------------
 1 files changed, 0 insertions(+), 111 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 62d15ad..4ab90bf 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -19,23 +19,17 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/serial_reg.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/serial_8250.h>
 #include <linux/pm_runtime.h>
 #include <linux/console.h>
 
-#ifdef CONFIG_SERIAL_OMAP
 #include <plat/omap-serial.h>
-#endif
-
 #include <plat/common.h>
 #include <plat/board.h>
-#include <plat/clock.h>
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -47,10 +41,8 @@
 #include "control.h"
 #include "mux.h"
 
-#define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
-#define UART_ERRATA_FIFO_FULL_ABORT	(0x1 << 0)
 #define UART_ERRATA_i202_MDR1_ACCESS	(0x1 << 1)
 
 /*
@@ -157,19 +149,6 @@ static inline void serial_write_reg(struct omap_uart_state *uart, int offset,
 	__raw_writeb(value, uart->membase + offset);
 }
 
-/*
- * Internal UARTs need to be initialized for the 8250 autoconfig to work
- * properly. Note that the TX watermark initialization may not be needed
- * once the 8250.c watermark handling code is merged.
- */
-
-static inline void __init omap_uart_reset(struct omap_uart_state *uart)
-{
-	serial_write_reg(uart, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
-	serial_write_reg(uart, UART_OMAP_SCR, 0x08);
-	serial_write_reg(uart, UART_OMAP_MDR1, UART_OMAP_MDR1_16X_MODE);
-}
-
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
 
 /*
@@ -555,41 +534,6 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
-#ifndef CONFIG_SERIAL_OMAP
-/*
- * Override the default 8250 read handler: mem_serial_in()
- * Empty RX fifo read causes an abort on omap3630 and omap4
- * This function makes sure that an empty rx fifo is not read on these silicons
- * (OMAP1/2/3430 are not affected)
- */
-static unsigned int serial_in_override(struct uart_port *up, int offset)
-{
-	if (UART_RX == offset) {
-		unsigned int lsr;
-		lsr = __serial_read_reg(up, UART_LSR);
-		if (!(lsr & UART_LSR_DR))
-			return -EPERM;
-	}
-
-	return __serial_read_reg(up, offset);
-}
-
-static void serial_out_override(struct uart_port *up, int offset, int value)
-{
-	unsigned int status, tmout = 10000;
-
-	status = __serial_read_reg(up, UART_LSR);
-	while (!(status & UART_LSR_THRE)) {
-		/* Wait up to 10ms for the character(s) to be sent. */
-		if (--tmout == 0)
-			break;
-		udelay(1);
-		status = __serial_read_reg(up, UART_LSR);
-	}
-	__serial_write_reg(up, offset, value);
-}
-#endif
-
 static int __init omap_serial_early_init(void)
 {
 	int i = 0;
@@ -650,15 +594,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	void *pdata = NULL;
 	u32 pdata_size = 0;
 	char *name;
-#ifndef CONFIG_SERIAL_OMAP
-	struct plat_serial8250_port ports[2] = {
-		{},
-		{.flags = 0},
-	};
-	struct plat_serial8250_port *p = &ports[0];
-#else
 	struct omap_uart_port_info omap_up;
-#endif
 
 	if (WARN_ON(!bdata))
 		return;
@@ -673,51 +609,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	oh = uart->oh;
 	uart->dma_enabled = 0;
-#ifndef CONFIG_SERIAL_OMAP
-	name = "serial8250";
-
-	/*
-	 * !! 8250 driver does not use standard IORESOURCE* It
-	 * has it's own custom pdata that can be taken from
-	 * the hwmod resource data.  But, this needs to be
-	 * done after the build.
-	 *
-	 * ?? does it have to be done before the register ??
-	 * YES, because platform_device_data_add() copies
-	 * pdata, it does not use a pointer.
-	 */
-	p->flags = UPF_BOOT_AUTOCONF;
-	p->iotype = UPIO_MEM;
-	p->regshift = 2;
-	p->uartclk = OMAP24XX_BASE_BAUD * 16;
-	p->irq = oh->mpu_irqs[0].irq;
-	p->mapbase = oh->slaves[0]->addr->pa_start;
-	p->membase = omap_hwmod_get_mpu_rt_va(oh);
-	p->irqflags = IRQF_SHARED;
-	p->private_data = uart;
-
-	/*
-	 * omap44xx, ti816x: Never read empty UART fifo
-	 * omap3xxx: Never read empty UART fifo on UARTs
-	 * with IP rev >=0x52
-	 */
-	uart->regshift = p->regshift;
-	uart->membase = p->membase;
-	if (cpu_is_omap44xx() || cpu_is_ti816x())
-		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
-	else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
-			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
-		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
-
-	if (uart->errata & UART_ERRATA_FIFO_FULL_ABORT) {
-		p->serial_in = serial_in_override;
-		p->serial_out = serial_out_override;
-	}
-
-	pdata = &ports[0];
-	pdata_size = 2 * sizeof(struct plat_serial8250_port);
-#else
-
 	name = DRIVER_NAME;
 
 	omap_up.dma_enabled = uart->dma_enabled;
@@ -729,7 +620,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	pdata = &omap_up;
 	pdata_size = sizeof(struct omap_uart_port_info);
-#endif
 
 	if (WARN_ON(!oh))
 		return;
@@ -762,7 +652,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	omap_device_enable(uart->pdev);
 	omap_uart_idle_init(uart);
-	omap_uart_reset(uart);
 	omap_hwmod_enable_wakeup(uart->oh);
 	omap_device_idle(uart->pdev);
 
-- 
1.7.4.1

