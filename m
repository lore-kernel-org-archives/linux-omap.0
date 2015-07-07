From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] net: can: c_can: Fix default pinmux glitch at init
Date: Tue, 7 Jul 2015 17:27:56 +0300
Message-ID: <1436279277-3386-2-git-send-email-rogerq@ti.com>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1436279277-3386-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: "J.D. Schroeder" <jay.schroeder@garmin.com>

The previous change 3973c526ae9c (net: can: c_can: Disable pins when CAN interface
is down) causes a slight glitch on the pinctrl settings when used. Since
commit ab78029 (drivers/pinctrl: grab default handles from device core),
the device core will automatically set the default pins. This causes
the pins to be momentarily set to the default and then to the sleep
state in register_c_can_dev(). By adding an optional "enable" state,
boards can set the default pin state to be disabled and avoid the
glitch when the switch from default to sleep first occurs. If the
"enable" state is not available c_can_pinctrl_select_state() falls
back to using the "default" pinctrl state.

[Roger Q] - Forward port to v4.2

Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/net/can/c_can/c_can.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 041525d..66e98e7 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -605,7 +605,18 @@ static int c_can_start(struct net_device *dev)
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* activate pins */
-	pinctrl_pm_select_default_state(dev->dev.parent);
+#ifdef CONFIG_PINCTRL
+	if (priv->device->pins) {
+		struct pinctrl_state *s;
+
+		/* Attempt to use "active" if available else use "default" */
+		s = pinctrl_lookup_state(priv->device->pins->p, "active");
+		if (!IS_ERR(s))
+			pinctrl_select_state(priv->device->pins->p, s);
+		else
+			pinctrl_pm_select_default_state(dev->dev.parent);
+	}
+#endif
 	return 0;
 }
 
-- 
2.1.4

