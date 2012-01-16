From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/5] omap-serial: make serial_omap_restore_context depend on CONFIG_PM_RUNTIME
Date: Mon, 16 Jan 2012 15:52:37 +0530
Message-ID: <1326709360-26020-3-git-send-email-shubhrajyoti@ti.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

The function serial_omap_restore_context is called only from
serial_omap_runtime_resume which depends on CONFIG_PM_RUNTIME. Make
serial_omap_restore_context also compile conditionally.

if CONFIG_PM_RUNTIME is not defined below warn may be seen.

  LD      net/xfrm/built-in.o
drivers/tty/serial/omap-serial.c:1524: warning: 'serial_omap_restore_context' defined but not used
  CC      drivers/tty/vt/selection.o

Acked-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 33e3360..1c24269 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1521,6 +1521,7 @@ static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1)
 	}
 }
 
+#ifdef CONFIG_PM_RUNTIME
 static void serial_omap_restore_context(struct uart_omap_port *up)
 {
 	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
@@ -1550,7 +1551,6 @@ static void serial_omap_restore_context(struct uart_omap_port *up)
 		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 }
 
-#ifdef CONFIG_PM_RUNTIME
 static int serial_omap_runtime_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
-- 
1.7.1

