From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 2/5] driver: serial: omap: prevent runtime PM for "no_console_suspend"
Date: Mon, 22 Apr 2013 19:13:54 +0530
Message-ID: <1366638237-6880-3-git-send-email-sourav.poddar@ti.com>
References: <1366638237-6880-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366638237-6880-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

The driver manages "no_console_suspend" by preventing runtime PM
during the suspend path, which forces the console UART to stay awake.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/tty/serial/omap-serial.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 08332f3..640b14e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1582,7 +1582,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 	struct omap_uart_port_info *pdata = dev->platform_data;
 
-	if (!up)
+	if (!up || (!console_suspend_enabled && uart_console(&up->port)))
 		return -EINVAL;
 
 	if (!pdata)
@@ -1614,6 +1614,9 @@ static int serial_omap_runtime_resume(struct device *dev)
 
 	int loss_cnt = serial_omap_get_context_loss_count(up);
 
+	if (!console_suspend_enabled && uart_console(&up->port))
+		return -EINVAL;
+
 	if (loss_cnt < 0) {
 		dev_err(dev, "serial_omap_get_context_loss_count failed : %d\n",
 			loss_cnt);
-- 
1.7.1
