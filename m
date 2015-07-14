From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 6/7] serial: 8250_omap: workaround module disable errata on dra7x SoCs
Date: Tue, 14 Jul 2015 13:32:08 +0530
Message-ID: <be99bca3d07b9e889b50de6619030b1fa7e31070.1436855647.git.nsekhar@ti.com>
References: <cover.1436855646.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436855646.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Due to Advisory 21 as documented in AM437x errata document,
UART module cannot be disabled once DMA is used. The only
workaround is to softreset the module before disabling it.

DRA7x UARTs are compatible to AM437x UARTs in terms of
this errata and prescribed workaround.

Enable usage of workaround for this errata on DRA7x SoCs.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
v2:
- subject line updated according to subsystem conventions

 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 drivers/tty/serial/8250/8250_omap.c                      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 0ee88209b341..7a71b5de77d6 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -6,6 +6,7 @@ Required properties:
 - compatible : should be "ti,omap4-uart" for OMAP4 controllers
 - compatible : should be "ti,am4372-uart" for AM437x controllers
 - compatible : should be "ti,am3352-uart" for AM335x controllers
+- compatible : should be "ti,dra742-uart" for DRA7x controllers
 - reg : address and length of the register space
 - interrupts or interrupts-extended : Should contain the uart interrupt
                                       specifier or both the interrupt
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a2ee75dee070..d9a37191a1ae 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1082,6 +1082,7 @@ static const struct of_device_id omap8250_dt_ids[] = {
 	{ .compatible = "ti,omap4-uart" },
 	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,am4372-uart", .data = &am4372_habit, },
+	{ .compatible = "ti,dra742-uart", .data = &am4372_habit, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap8250_dt_ids);
-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
