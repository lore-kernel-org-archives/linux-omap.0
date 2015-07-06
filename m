From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/7] tty: 8250: workaround errata on disabling UART after using DMA
Date: Mon, 6 Jul 2015 15:17:55 +0530
Message-ID: <9f70a47010d019f76b822b60e7d4f512aa4e46d7.1436174801.git.nsekhar@ti.com>
References: <cover.1436174801.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436174801.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM335x, AM437x and DRA7x SoCs have an errata due to which UART
cannot be disabled after it has been used with DMA.

OMAP3 has a similar sounding errata which has been worked around
in a2fc36613ac1af2e9 ("ARM: OMAP3: Use manual idle for UARTs
because of DMA errata"). But the workaround used there does not
apply to AM335x, AM437x SoCs. These SoCs need a softreset of UART
before disabling them.

This patch implements that errata workaround. It is expected that
UART will be used with DMA so no explicit check for DMA usage
has been added for errata applicability.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/tty/serial/8250/8250_omap.c | 55 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 52566387ec37..af25869d145f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -33,6 +33,11 @@
 #define UART_ERRATA_i202_MDR1_ACCESS	(1 << 0)
 #define OMAP_UART_WER_HAS_TX_WAKEUP	(1 << 1)
 #define OMAP_DMA_TX_KICK		(1 << 2)
+/*
+ * See Advisory 21 in AM437x errata SPRZ408B, updated April 2015.
+ * The same errata is applicable to AM335x and DRA7x processors too.
+ */
+#define UART_ERRATA_CLOCK_DISABLE	(1 << 3)
 
 #define OMAP_UART_FCR_RX_TRIG		6
 #define OMAP_UART_FCR_TX_TRIG		4
@@ -54,6 +59,12 @@
 #define OMAP_UART_MVR_MAJ_SHIFT		8
 #define OMAP_UART_MVR_MIN_MASK		0x3f
 
+/* SYSC register bitmasks */
+#define OMAP_UART_SYSC_SOFTRESET	(1 << 1)
+
+/* SYSS register bitmasks */
+#define OMAP_UART_SYSS_RESETDONE	(1 << 0)
+
 #define UART_TI752_TLR_TX	0
 #define UART_TI752_TLR_RX	4
 
@@ -1062,13 +1073,15 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 	return 0;
 }
 
-static const u8 am3352_habit = OMAP_DMA_TX_KICK;
+static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
+static const u8 am4372_habit = UART_ERRATA_CLOCK_DISABLE;
 
 static const struct of_device_id omap8250_dt_ids[] = {
 	{ .compatible = "ti,omap2-uart" },
 	{ .compatible = "ti,omap3-uart" },
 	{ .compatible = "ti,omap4-uart" },
 	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
+	{ .compatible = "ti,am4372-uart", .data = &am4372_habit, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap8250_dt_ids);
@@ -1279,13 +1292,13 @@ static int omap8250_lost_context(struct uart_8250_port *up)
 {
 	u32 val;
 
-	val = serial_in(up, UART_OMAP_MDR1);
+	val = serial_in(up, UART_OMAP_SCR);
 	/*
-	 * If we lose context, then MDR1 is set to its reset value which is
-	 * UART_OMAP_MDR1_DISABLE. After set_termios() we set it either to 13x
-	 * or 16x but never to disable again.
+	 * If we lose context, then SCR is set to its reset value of zero.
+	 * After set_termios() we set bit 3 of SCR (TX_EMPTY_CTL_IT) to 1,
+	 * among other bits, to never set the register back to zero again.
 	 */
-	if (val == UART_OMAP_MDR1_DISABLE)
+	if (!val)
 		return 1;
 	return 0;
 }
@@ -1307,6 +1320,36 @@ static int omap8250_runtime_suspend(struct device *dev)
 			return -EBUSY;
 	}
 
+	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
+		int sysc;
+		int syss;
+		int timeout = 100;
+
+		sysc = serial_in(up, UART_OMAP_SYSC);
+
+		/* softreset the UART */
+		sysc |= OMAP_UART_SYSC_SOFTRESET;
+		serial_out(up, UART_OMAP_SYSC, sysc);
+
+		/* By experiments, 1us enough for reset complete on AM335x */
+		do {
+			udelay(1);
+			syss = serial_in(up, UART_OMAP_SYSS);
+		} while (--timeout && !(syss & OMAP_UART_SYSS_RESETDONE));
+
+		if (!timeout) {
+			dev_err(dev, "timed out waiting for reset done\n");
+			return -ETIMEDOUT;
+		}
+
+		/*
+		 * For UART module wake-up to work, MDR1.MODESELECT should
+		 * not be set to "Disable", so update it.
+		 */
+		if (device_may_wakeup(dev))
+			omap8250_update_mdr1(up, priv);
+	}
+
 	if (up->dma && up->dma->rxchan)
 		omap_8250_rx_dma(up, UART_IIR_RX_TIMEOUT);
 
-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
