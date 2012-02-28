From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [PATCH] tty: serial: OMAP: Fix oops due to NULL pdata in DT boot
Date: Tue, 28 Feb 2012 18:22:12 +0100
Message-ID: <4F4D0D44.3010604@ti.com>
References: <20120126024903.31613.24730.stgit@dusk> <20120126025036.31613.67819.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120126025036.31613.67819.stgit@dusk>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, gregkh@linuxfoundation.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

The following commit: be4b0281956c5cae4f63f31f11d07625a6988766
(tty: serial: OMAP: block idle while the UART is transferring data in PIO mode),
is introducing an oops if OMAP is booted using device tree blob because
the pdata will not be initialized.

Check if pdata is set before de-referencing it.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/tty/serial/omap-serial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f809041..0121486 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -159,7 +159,7 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		serial_out(up, UART_IER, up->ier);
 	}
 
-	if (!up->use_dma && pdata->set_forceidle)
+	if (!up->use_dma && pdata && pdata->set_forceidle)
 		pdata->set_forceidle(up->pdev);
 
 	pm_runtime_mark_last_busy(&up->pdev->dev);
@@ -298,7 +298,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 	if (!up->use_dma) {
 		pm_runtime_get_sync(&up->pdev->dev);
 		serial_omap_enable_ier_thri(up);
-		if (pdata->set_noidle)
+		if (pdata && pdata->set_noidle)
 			pdata->set_noidle(up->pdev);
 		pm_runtime_mark_last_busy(&up->pdev->dev);
 		pm_runtime_put_autosuspend(&up->pdev->dev);
@@ -1613,7 +1613,7 @@ static int serial_omap_runtime_resume(struct device *dev)
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 	struct omap_uart_port_info *pdata = dev->platform_data;
 
-	if (up) {
+	if (up && pdata) {
 		if (pdata->get_context_loss_count) {
 			u32 loss_cnt = pdata->get_context_loss_count(dev);
 
-- 
1.7.0.4


