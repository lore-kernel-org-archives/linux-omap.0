From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv3] driver: serial: prevent UART console idle on suspend while using "no_console_suspend"
Date: Fri, 5 Apr 2013 18:45:33 +0530
Message-ID: <1365167733-28083-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

With dt boot, uart wakeup after suspend is non functional while using
"no_console_suspend" in the bootargs. With "no_console_suspend" used, we
should prevent the runtime suspend of the uart port which is getting used
as an console.

Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
Cc: Felipe Balbi<balbi@ti.com>
Cc: Rajendra nayak<rnayak@ti.com>
Tested on omap5430evm, omap4430sdp.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v2->v3
Based on Kevin Hilman and Santosh Shilimkar comments, modified
serial core/driver layer to bypass runtime suspend 
for console uart while using "no_console_suspend".

This patch is based on Santosh Shilimkar serial patch[1]

[1]: http://permalink.gmane.org/gmane.linux.ports.arm.omap/95828
	
 drivers/tty/serial/omap-serial.c |    5 ++++-
 drivers/tty/serial/serial_core.c |    3 +++
 include/linux/serial_core.h      |    1 +
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 08332f3..81a1760 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1582,7 +1582,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 	struct omap_uart_port_info *pdata = dev->platform_data;
 
-	if (!up)
+	if (!up || (!console_suspend_enabled && up->port.port_is_console))
 		return -EINVAL;
 
 	if (!pdata)
@@ -1614,6 +1614,9 @@ static int serial_omap_runtime_resume(struct device *dev)
 
 	int loss_cnt = serial_omap_get_context_loss_count(up);
 
+	if (!console_suspend_enabled && up->port.port_is_console)
+		return -EINVAL;
+
 	if (loss_cnt < 0) {
 		dev_err(dev, "serial_omap_get_context_loss_count failed : %d\n",
 			loss_cnt);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a400002..6c8b041 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2594,6 +2594,9 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	uport->cons = drv->cons;
 	uport->state = state;
 
+	if (uart_console(uport))
+		uport->port_is_console = true;
+
 	/*
 	 * If this port is a console, then the spinlock is already
 	 * initialised.
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 87d4bbc..c944414 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -194,6 +194,7 @@ struct uart_port {
 	unsigned char		irq_wake;
 	unsigned char		unused[2];
 	void			*private_data;		/* generic platform data pointer */
+	bool			port_is_console;
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)
-- 
1.7.1
