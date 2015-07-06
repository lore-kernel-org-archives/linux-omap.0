From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/7] tty: 8250: omap: introduce function to update mdr1
Date: Mon, 6 Jul 2015 15:17:53 +0530
Message-ID: <597e0f4bf4455cb7755851f5c34a02fbdd0d4aeb.1436174801.git.nsekhar@ti.com>
References: <cover.1436174801.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436174801.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

updating mdr1 register on OMAP needs to take care of
errata i202. Introduce a function to update mdr1.

This will be useful later on when mdr1 needs to be
written to from other places. No functional change.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/tty/serial/8250/8250_omap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 20c5b9c4c288..d9c96b993a84 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -232,6 +232,15 @@ static void omap8250_update_scr(struct uart_8250_port *up,
 	serial_out(up, UART_OMAP_SCR, priv->scr);
 }
 
+static void omap8250_update_mdr1(struct uart_8250_port *up,
+				 struct omap8250_priv *priv)
+{
+	if (priv->habit & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_8250_mdr1_errataset(up, priv);
+	else
+		serial_out(up, UART_OMAP_MDR1, priv->mdr1);
+}
+
 static void omap8250_restore_regs(struct uart_8250_port *up)
 {
 	struct omap8250_priv *priv = up->port.private_data;
@@ -282,11 +291,9 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 	serial_out(up, UART_XOFF1, priv->xoff);
 
 	serial_out(up, UART_LCR, up->lcr);
-	/* need mode A for FCR */
-	if (priv->habit & UART_ERRATA_i202_MDR1_ACCESS)
-		omap_8250_mdr1_errataset(up, priv);
-	else
-		serial_out(up, UART_OMAP_MDR1, priv->mdr1);
+
+	omap8250_update_mdr1(up, priv);
+
 	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
 }
 
-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
