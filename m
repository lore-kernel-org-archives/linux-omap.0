From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [Resend/PATCHv2] serial: omap: Remove unnecessary checks from suspend/resume
Date: Fri, 21 Sep 2012 12:34:08 +0530
Message-ID: <1348211049-9675-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, santosh.shilimkar@ti.com, paul@pwsan.com, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

Drop the check for "up" being valid on suspend/resume callbacks.
It should be valid always. Get rid of the "pdata" check also as
serial_omap_get_context_loss_count() checks for it.

Boot tested on omap4 panda and PM tested(hitting off in Idle
and suspend) on 3630 based Beagle board.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
Added Felipe's Reviewed by
v1->v2
Not a functionality change, just
Introduce a blank line before "signed off by" line.
 drivers/tty/serial/omap-serial.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f175385..3c05c5e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1222,10 +1222,8 @@ static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	if (up) {
-		uart_suspend_port(&serial_omap_reg, &up->port);
-		flush_work_sync(&up->qos_work);
-	}
+	uart_suspend_port(&serial_omap_reg, &up->port);
+	flush_work_sync(&up->qos_work);
 
 	return 0;
 }
@@ -1234,8 +1232,8 @@ static int serial_omap_resume(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	if (up)
-		uart_resume_port(&serial_omap_reg, &up->port);
+	uart_resume_port(&serial_omap_reg, &up->port);
+
 	return 0;
 }
 #endif
@@ -1553,17 +1551,14 @@ static int serial_omap_runtime_suspend(struct device *dev)
 static int serial_omap_runtime_resume(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
-	struct omap_uart_port_info *pdata = dev->platform_data;
 
-	if (up && pdata) {
-			u32 loss_cnt = serial_omap_get_context_loss_count(up);
+	u32 loss_cnt = serial_omap_get_context_loss_count(up);
 
-			if (up->context_loss_cnt != loss_cnt)
-				serial_omap_restore_context(up);
+	if (up->context_loss_cnt != loss_cnt)
+		serial_omap_restore_context(up);
 
-		up->latency = up->calc_latency;
-		schedule_work(&up->qos_work);
-	}
+	up->latency = up->calc_latency;
+	schedule_work(&up->qos_work);
 
 	return 0;
 }
-- 
1.7.1

