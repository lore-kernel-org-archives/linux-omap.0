From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 6/8] can: c_can: Disable pins when CAN interface is down
Date: Fri, 14 Nov 2014 19:09:49 +0100
Message-ID: <1415988591-6032-7-git-send-email-mkl@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, rogerq@ti.com, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

DRA7 CAN IP suffers from a problem which causes it to be prevented
from fully turning OFF (i.e. stuck in transition) if the module was
disabled while there was traffic on the CAN_RX line.

To work around this issue we select the SLEEP pin state by default
on probe and use the DEFAULT pin state on CAN up and back to the
SLEEP pin state on CAN down.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 8e78bb48f5a4..f94a9fa60488 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -35,6 +35,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -603,6 +604,8 @@ static int c_can_start(struct net_device *dev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	/* activate pins */
+	pinctrl_pm_select_default_state(dev->dev.parent);
 	return 0;
 }
 
@@ -611,6 +614,9 @@ static void c_can_stop(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	c_can_irq_control(priv, false);
+
+	/* deactivate pins */
+	pinctrl_pm_select_sleep_state(dev->dev.parent);
 	priv->can.state = CAN_STATE_STOPPED;
 }
 
@@ -1244,6 +1250,13 @@ int register_c_can_dev(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 	int err;
 
+	/* Deactivate pins to prevent DRA7 DCAN IP from being
+	 * stuck in transition when module is disabled.
+	 * Pins are activated in c_can_start() and deactivated
+	 * in c_can_stop()
+	 */
+	pinctrl_pm_select_sleep_state(dev->dev.parent);
+
 	c_can_pm_runtime_enable(priv);
 
 	dev->flags |= IFF_ECHO;	/* we support local echo */
-- 
2.1.1

