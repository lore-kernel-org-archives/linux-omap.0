From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] tty: serial_core: Utilise/Enable the set_wake uart ops
Date: Mon, 23 Apr 2012 18:30:07 +0530
Message-ID: <1335186007-24452-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

From: "Govindraj.R" <govindraj.raja@ti.com>

Currently all low level uart driver register to serial_core layer
this core layer exposes various serial uart ops.

Whenever port is opened the low level platform specific wakeup
capability can be enabled use the already available set_wakeup uart ops
to configure wakeup capability.

When port is opened the wakeup can be enabled and when port is shutdown
the wakeups can be disabled.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/serial_core.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c4c05b..44b81aa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -185,6 +185,13 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	}
 
 	/*
+	 * Now with port open enable any platform specific wakeup
+	 * capability for the port if available.
+	 */
+	if (uport->ops->set_wake)
+		uport->ops->set_wake(uport, true);
+
+	/*
 	 * This is to allow setserial on this port. People may want to set
 	 * port/irq/type and then reconfigure the port properly if it failed
 	 * now.
@@ -1427,6 +1434,13 @@ static void uart_port_shutdown(struct tty_port *port)
 	uport->ops->shutdown(uport);
 
 	/*
+	 * now port is closed disable any platform
+	 * specific wakeup capability that might be enabled.
+	 */
+	if (uport->ops->set_wake)
+		uport->ops->set_wake(uport, false);
+
+	/*
 	 * Ensure that the IRQ handler isn't running on another CPU.
 	 */
 	synchronize_irq(uport->irq);
-- 
1.7.9

