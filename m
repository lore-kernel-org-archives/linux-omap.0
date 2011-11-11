From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 07/20] OMAP2+: UART: Remove context_save and move context restore to driver
Date: Fri, 11 Nov 2011 15:27:24 +0530
Message-ID: <1321005446-21741-8-git-send-email-govindraj.raja@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Remove context save function from serial.c and move context restore
function to omap-serial. Remove all regs stored in omap_uart_state
for contex_save/restore, reg read write funcs used in context_save/restore,
io_addresses populated for read/write funcs.

Clock gating mechanism was done in serial.c and had no info on uart state
thus we needed context save and restore in serial.c
With runtime conversion and clock gating done within uart driver
context restore can be done from regs value available from uart_omap_port
structure.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c     |  118 --------------------------------------
 drivers/tty/serial/omap-serial.c |   24 ++++++++
 2 files changed, 24 insertions(+), 118 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index beb46e8..3d5df9a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -41,8 +41,6 @@
 #include "control.h"
 #include "mux.h"
 
-#define UART_OMAP_WER		0x17	/* Wake-up enable register */
-
 #define UART_ERRATA_i202_MDR1_ACCESS	(0x1 << 1)
 
 /*
@@ -66,60 +64,16 @@ struct omap_uart_state {
 
 	int clocked;
 
-	int regshift;
-	void __iomem *membase;
-	resource_size_t mapbase;
-
 	struct list_head node;
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
 
 	u32 errata;
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
-	int context_valid;
-
-	/* Registers to be saved/restored for OFF-mode */
-	u16 dll;
-	u16 dlh;
-	u16 ier;
-	u16 sysc;
-	u16 scr;
-	u16 wer;
-	u16 mcr;
-#endif
 };
 
 static LIST_HEAD(uart_list);
 static u8 num_uarts;
 
-static inline unsigned int __serial_read_reg(struct uart_port *up,
-					     int offset)
-{
-	offset <<= up->regshift;
-	return (unsigned int)__raw_readb(up->membase + offset);
-}
-
-static inline unsigned int serial_read_reg(struct omap_uart_state *uart,
-					   int offset)
-{
-	offset <<= uart->regshift;
-	return (unsigned int)__raw_readb(uart->membase + offset);
-}
-
-static inline void __serial_write_reg(struct uart_port *up, int offset,
-		int value)
-{
-	offset <<= up->regshift;
-	__raw_writeb(value, up->membase + offset);
-}
-
-static inline void serial_write_reg(struct omap_uart_state *uart, int offset,
-				    int value)
-{
-	offset <<= uart->regshift;
-	__raw_writeb(value, uart->membase + offset);
-}
-
 /*
  * Internal UARTs need to be initialized for the 8250 autoconfig to work
  * properly. Note that the TX watermark initialization may not be needed
@@ -170,75 +124,6 @@ static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u8 mdr1_val,
 	}
 }
 
-static void omap_uart_save_context(struct omap_uart_state *uart)
-{
-	u16 lcr = 0;
-
-	if (!enable_off_mode)
-		return;
-
-	lcr = serial_read_reg(uart, UART_LCR);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
-	uart->dll = serial_read_reg(uart, UART_DLL);
-	uart->dlh = serial_read_reg(uart, UART_DLM);
-	serial_write_reg(uart, UART_LCR, lcr);
-	uart->ier = serial_read_reg(uart, UART_IER);
-	uart->sysc = serial_read_reg(uart, UART_OMAP_SYSC);
-	uart->scr = serial_read_reg(uart, UART_OMAP_SCR);
-	uart->wer = serial_read_reg(uart, UART_OMAP_WER);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_A);
-	uart->mcr = serial_read_reg(uart, UART_MCR);
-	serial_write_reg(uart, UART_LCR, lcr);
-
-	uart->context_valid = 1;
-}
-
-static void omap_uart_restore_context(struct omap_uart_state *uart)
-{
-	u16 efr = 0;
-
-	if (!enable_off_mode)
-		return;
-
-	if (!uart->context_valid)
-		return;
-
-	uart->context_valid = 0;
-
-	if (uart->errata & UART_ERRATA_i202_MDR1_ACCESS)
-		omap_uart_mdr1_errataset(uart, UART_OMAP_MDR1_DISABLE, 0xA0);
-	else
-		serial_write_reg(uart, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
-
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
-	efr = serial_read_reg(uart, UART_EFR);
-	serial_write_reg(uart, UART_EFR, UART_EFR_ECB);
-	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(uart, UART_IER, 0x0);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_write_reg(uart, UART_DLL, uart->dll);
-	serial_write_reg(uart, UART_DLM, uart->dlh);
-	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(uart, UART_IER, uart->ier);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_A);
-	serial_write_reg(uart, UART_MCR, uart->mcr);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_write_reg(uart, UART_EFR, efr);
-	serial_write_reg(uart, UART_LCR, UART_LCR_WLEN8);
-	serial_write_reg(uart, UART_OMAP_SCR, uart->scr);
-	serial_write_reg(uart, UART_OMAP_WER, uart->wer);
-	serial_write_reg(uart, UART_OMAP_SYSC, uart->sysc);
-
-	if (uart->errata & UART_ERRATA_i202_MDR1_ACCESS)
-		omap_uart_mdr1_errataset(uart, UART_OMAP_MDR1_16X_MODE, 0xA1);
-	else
-		/* UART 16x mode */
-		serial_write_reg(uart, UART_OMAP_MDR1,
-				UART_OMAP_MDR1_16X_MODE);
-}
-#else
-static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
-static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
 #endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
 
 static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
@@ -621,9 +506,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_device_disable_idle_on_suspend(pdev);
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
-	uart->regshift = 2;
-	uart->mapbase = oh->slaves[0]->addr->pa_start;
-	uart->membase = omap_hwmod_get_mpu_rt_va(oh);
 	uart->pdev = pdev;
 
 	oh->dev_attr = uart;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f16ef4b9..a834e91 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1408,6 +1408,25 @@ static int serial_omap_remove(struct platform_device *dev)
 	return 0;
 }
 
+static void serial_omap_restore_context(struct uart_omap_port *up)
+{
+	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
+	serial_out(up, UART_EFR, UART_EFR_ECB);
+	serial_out(up, UART_LCR, 0x0); /* Operational mode */
+	serial_out(up, UART_IER, 0x0);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
+	serial_out(up, UART_LCR, 0x0); /* Operational mode */
+	serial_out(up, UART_IER, up->ier);
+	serial_out(up, UART_FCR, up->fcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_MCR, up->mcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
+	serial_out(up, UART_EFR, up->efr);
+	serial_out(up, UART_LCR, up->lcr);
+	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_16X_MODE);
+}
+
 #ifdef CONFIG_PM_RUNTIME
 static int serial_omap_runtime_suspend(struct device *dev)
 {
@@ -1416,6 +1435,11 @@ static int serial_omap_runtime_suspend(struct device *dev)
 
 static int serial_omap_runtime_resume(struct device *dev)
 {
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+
+	if (up)
+		serial_omap_restore_context(up);
+
 	return 0;
 }
 #endif
-- 
1.7.4.1

