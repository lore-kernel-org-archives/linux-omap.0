From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] tty: serial: OMAP: block idle while the UART is
 transferring data in PIO mode
Date: Wed, 25 Jan 2012 19:50:52 -0700
Message-ID: <20120126025036.31613.67819.stgit@dusk>
References: <20120126024903.31613.24730.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120126024903.31613.24730.stgit@dusk>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: govindraj.r@ti.com, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

Prevent OMAP UARTs from going idle while they are still transferring
data in PIO mode.  This works around an oversight in the OMAP UART
hardware present in OMAP34xx and earlier: an idle UART won't send a
wakeup when the TX FIFO threshold is reached.  This causes long delays
during data transmission when the MPU powerdomain enters a low-power
mode.  The MPU interrupt controller is not able to respond to
interrupts when it's in a low-power state, so the TX buffer is not
refilled until another wakeup event occurs.

This fix changes the erratum i291 DMA idle workaround.  Rather than
toggling between force-idle and no-idle, it will toggle between
smart-idle and no-idle.  The important part of the workaround is the
no-idle part, so this shouldn't result in any change in behavior.

This fix should work on all OMAP UARTs.  Future patches intended for
the 3.4 merge window will make this workaround conditional on a
"feature" flag, and will use the OMAP36xx+ TX event wakeup support.

Thanks to Kevin Hilman <khilman@ti.com> for mentioning the erratum i291
workaround, which led to the development of this approach.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/serial.c     |    8 ++++----
 drivers/tty/serial/omap-serial.c |    7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 247d894..f590afc 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -107,18 +107,18 @@ static void omap_uart_set_noidle(struct platform_device *pdev)
 	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
 }
 
-static void omap_uart_set_forceidle(struct platform_device *pdev)
+static void omap_uart_set_smartidle(struct platform_device *pdev)
 {
 	struct omap_device *od = to_omap_device(pdev);
 
-	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_FORCE);
+	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_SMART);
 }
 
 #else
 static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {}
 static void omap_uart_set_noidle(struct platform_device *pdev) {}
-static void omap_uart_set_forceidle(struct platform_device *pdev) {}
+static void omap_uart_set_smartidle(struct platform_device *pdev) {}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_OMAP_MUX
@@ -349,7 +349,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
 	omap_up.flags = UPF_BOOT_AUTOCONF;
 	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
-	omap_up.set_forceidle = omap_uart_set_forceidle;
+	omap_up.set_forceidle = omap_uart_set_smartidle;
 	omap_up.set_noidle = omap_uart_set_noidle;
 	omap_up.enable_wakeup = omap_uart_enable_wakeup;
 	omap_up.dma_rx_buf_size = info->dma_rx_buf_size;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c9c9ba2..11fa156 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -136,6 +136,7 @@ static void serial_omap_enable_ms(struct uart_port *port)
 static void serial_omap_stop_tx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
 
 	if (up->use_dma &&
 		up->uart_dma.tx_dma_channel != OMAP_UART_DMA_CH_FREE) {
@@ -158,6 +159,9 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		serial_out(up, UART_IER, up->ier);
 	}
 
+	if (!up->use_dma && pdata->set_forceidle)
+		pdata->set_forceidle(up->pdev);
+
 	pm_runtime_mark_last_busy(&up->pdev->dev);
 	pm_runtime_put_autosuspend(&up->pdev->dev);
 }
@@ -286,6 +290,7 @@ static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
 static void serial_omap_start_tx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
 	struct circ_buf *xmit;
 	unsigned int start;
 	int ret = 0;
@@ -293,6 +298,8 @@ static void serial_omap_start_tx(struct uart_port *port)
 	if (!up->use_dma) {
 		pm_runtime_get_sync(&up->pdev->dev);
 		serial_omap_enable_ier_thri(up);
+		if (pdata->set_noidle)
+			pdata->set_noidle(up->pdev);
 		pm_runtime_mark_last_busy(&up->pdev->dev);
 		pm_runtime_put_autosuspend(&up->pdev->dev);
 		return;


