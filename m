From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2 6/9] serial: omap-serial: Use common rs485 device tree parsing function
Date: Fri, 23 Jun 2017 11:49:42 +0200
Message-ID: <20170623094945.31908-7-u.kleine-koenig@pengutronix.de>
References: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170623094945.31908-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

We just got a common helper for parsing the rs485 specific
device tree properties. Use it and drop the open coded parser.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Changes since v1:
 - drop paragraph in commit log that of_get_rs485_mode is more strict as this is wrong in v2.

 drivers/tty/serial/omap-serial.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1ea05ac57aa7..6e4728d3a24c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1638,17 +1638,7 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 		up->rts_gpio = -EINVAL;
 	}
 
-	if (of_property_read_u32_array(np, "rs485-rts-delay",
-				    rs485_delay, 2) == 0) {
-		rs485conf->delay_rts_before_send = rs485_delay[0];
-		rs485conf->delay_rts_after_send = rs485_delay[1];
-	}
-
-	if (of_property_read_bool(np, "rs485-rx-during-tx"))
-		rs485conf->flags |= SER_RS485_RX_DURING_TX;
-
-	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
-		rs485conf->flags |= SER_RS485_ENABLED;
+	of_get_rs485_mode(np, rs485conf);
 
 	return 0;
 }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
