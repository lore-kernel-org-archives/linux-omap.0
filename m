From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC] omap-serial :Make the suspend/resume functions depend on CONFIG_PM_SLEEP.
Date: Wed, 11 Jan 2012 11:24:40 +0530
Message-ID: <1326261280-3895-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

    The macro SET_SYSTEM_SLEEP_PM_OPS  depends CONFIG_PM_SLEEP. The patch
    defines the suspend and resume functions for CONFIG_PM_SLEEP instead of
    CONFIG_SUSPEND.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
applies on Tony's uart branch

 drivers/tty/serial/omap-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 91b0f65..eb90a01 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1160,7 +1160,7 @@ static struct uart_driver serial_omap_reg = {
 	.cons		= OMAP_CONSOLE,
 };
 
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
-- 
1.7.1

