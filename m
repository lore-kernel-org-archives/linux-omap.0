From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 1/3] serial: omap: Make context_loss_cnt signed
Date: Wed, 3 Oct 2012 17:24:36 +0530
Message-ID: <1349265278-27763-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

get_context_loss_count returns an int however it is stored in
unsigned integer context_loss_cnt . This patch tries to make
context_loss_cnt int. So that in case of errors the value
(which may be negative) is not interpreted wrongly.

In serial_omap_runtime_resume in case of errors returned by
get_context_loss_count print a warning and do a restore.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6ede6fd..fd0fb8c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -96,7 +96,7 @@ struct uart_omap_port {
 	unsigned char		msr_saved_flags;
 	char			name[20];
 	unsigned long		port_activity;
-	u32			context_loss_cnt;
+	int			context_loss_cnt;
 	u32			errata;
 	u8			wakeups_enabled;
 	unsigned int		irq_pending:1;
@@ -1556,11 +1556,15 @@ static int serial_omap_runtime_resume(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	u32 loss_cnt = serial_omap_get_context_loss_count(up);
+	int loss_cnt = serial_omap_get_context_loss_count(up);
 
-	if (up->context_loss_cnt != loss_cnt)
+	if (loss_cnt < 0) {
+		dev_err(dev, "serial_omap_get_context_loss_count failed : %d\n",
+			loss_cnt);
 		serial_omap_restore_context(up);
-
+	} else if (up->context_loss_cnt != loss_cnt) {
+		serial_omap_restore_context(up);
+	}
 	up->latency = up->calc_latency;
 	schedule_work(&up->qos_work);
 
-- 
1.7.5.4

