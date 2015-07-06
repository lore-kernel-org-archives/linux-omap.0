From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RESEND 1/7] tty: serial: 8250: omap: fix kernel crash in suspend-to-ram
Date: Mon, 6 Jul 2015 15:17:51 +0530
Message-ID: <d8cb86b2717e0fc084b6651be54ee6d96dbc603a.1436174801.git.nsekhar@ti.com>
References: <cover.1436174801.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436174801.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap_device infrastructure has a suspend_noirq hook which
runtime suspends all devices late in the suspend cycle (see
_od_suspend_noirq() in arch/arm/mach-omap2/omap_device.c)

This leads to a NULL pointer exception in 8250_omap driver
since by the time omap8250_runtime_suspend() is called, 8250_dma
driver has already set rxchan to NULL via serial8250_release_dma().

Make an explicit check to see if rxchan is NULL in
runtime_{suspend|resume} hooks to fix this.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
Previous version: http://www.spinics.net/lists/linux-omap/msg119459.html
No change in this version except rebased to v4.2-rc1

 drivers/tty/serial/8250/8250_omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index d75a66c72750..20c5b9c4c288 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1285,7 +1285,7 @@ static int omap8250_runtime_suspend(struct device *dev)
 			return -EBUSY;
 	}
 
-	if (up->dma)
+	if (up->dma && up->dma->rxchan)
 		omap_8250_rx_dma(up, UART_IIR_RX_TIMEOUT);
 
 	priv->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
@@ -1310,7 +1310,7 @@ static int omap8250_runtime_resume(struct device *dev)
 	if (loss_cntx)
 		omap8250_restore_regs(up);
 
-	if (up->dma)
+	if (up->dma && up->dma->rxchan)
 		omap_8250_rx_dma(up, 0);
 
 	priv->latency = priv->calc_latency;
-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
