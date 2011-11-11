From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 09/20] OMAP2+: UART: Remove uart reset function.
Date: Fri, 11 Nov 2011 15:27:26 +0530
Message-ID: <1321005446-21741-10-git-send-email-govindraj.raja@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Remove the uart reset function which is configuring the
TX empty irq which can now be handled within omap-serial driver.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |   14 --------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 ++
 drivers/tty/serial/omap-serial.c              |    1 +
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3d5df9a..06887d3 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -74,19 +74,6 @@ struct omap_uart_state {
 static LIST_HEAD(uart_list);
 static u8 num_uarts;
 
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
@@ -521,7 +508,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	omap_device_enable(uart->pdev);
 	omap_uart_idle_init(uart);
-	omap_uart_reset(uart);
 	omap_hwmod_enable_wakeup(uart->oh);
 	omap_device_idle(uart->pdev);
 
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 70e7738..5b913c7 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -33,6 +33,8 @@
 
 #define OMAP_MODE13X_SPEED	230400
 
+#define OMAP_UART_SCR_TX_EMPTY	0x08
+
 /* WER = 0x7F
  * Enable module level wakeup in WER reg
  */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 5327ff0..f5a5ed6 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -770,6 +770,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_IER, up->ier);
 	serial_out(up, UART_LCR, cval);		/* reset DLAB */
 	up->lcr = cval;
+	up->scr = OMAP_UART_SCR_TX_EMPTY;
 
 	/* FIFOs and DMA Settings */
 
-- 
1.7.4.1

