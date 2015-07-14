From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/7] serial: 8250_omap: refactor mdr1 update
Date: Tue, 14 Jul 2015 13:32:05 +0530
Message-ID: <2ba973118298069c4a37832a9fb13843a0ca8e91.1436855646.git.nsekhar@ti.com>
References: <cover.1436855646.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436855646.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The silicon errata[1] workaround implemented in a follow-on
patch, "serial: 8250_omap: workaround errata on disabling
UART after using DMA", requires MDR1 register programming.

Extract MDR1 register update into helper function,
omap8250_update_mdr1() to help with that.

[1] Advisory 21 in http://www.ti.com/lit/er/sprz408b/sprz408b.pdf

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
v2:
- Updated subject line and description according
  to comments received.

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
