From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 1/7] ARM: OMAP: UART: Make context_loss_cnt signed
Date: Mon, 16 Apr 2012 20:36:55 +0530
Message-ID: <1334588821-5224-2-git-send-email-shubhrajyoti@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35046 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761Ab2DPPHP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 11:07:15 -0400
In-Reply-To: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

get_context_loss_count returns an int however it is stored in
unsigned integer context_loss_cnt . This patch tries to make
context_loss_cnt int. So that in case of errors(which may be negative)
the value is not interpreted wrongly.

In serial_omap_runtime_resume in case of errors returned by
get_context_loss_count print a warning and do a restore.

Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 drivers/tty/serial/omap-serial.c              |   10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9ff4444..b7fb6dc 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -128,7 +128,7 @@ struct uart_omap_port {
 	unsigned char		msr_saved_flags;
 	char			name[20];
 	unsigned long		port_activity;
-	u32			context_loss_cnt;
+	int			context_loss_cnt;
 	u32			errata;
 	u8			wakeups_enabled;
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d00b38e..fe099bb 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1612,10 +1612,16 @@ static int serial_omap_runtime_resume(struct device *dev)
 
 	if (up && pdata) {
 		if (pdata->get_context_loss_count) {
-			u32 loss_cnt = pdata->get_context_loss_count(dev);
+			int loss_cnt = pdata->get_context_loss_count(dev);
 
-			if (up->context_loss_cnt != loss_cnt)
+			if (loss_cnt < 0) {
+				dev_err(dev,
+					"get_context_loss_count failed : %d\n",
+					loss_cnt);
 				serial_omap_restore_context(up);
+			} else if (up->context_loss_cnt != loss_cnt) {
+				serial_omap_restore_context(up);
+			}
 		}
 
 		/* Errata i291 */
-- 
1.7.4.1

