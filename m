From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 3/4] usb: musb: musb_cppi41: Workaround DMA stall issue during teardown
Date: Wed, 15 Feb 2017 15:26:56 +0100
Message-ID: <20170215142657.31571-4-abailon@baylibre.com>
References: <20170215142657.31571-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170215142657.31571-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The DMA may hang up if a teardown is initiated while an endpoint is still
active (Advisory 2.3.27 of DA8xx errata).
To workaround this issue, add a delay before to initiate the teardown.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/da8xx.c       | 2 +-
 drivers/usb/musb/musb_core.h   | 1 +
 drivers/usb/musb/musb_cppi41.c | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 458a499..ed28afd 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -483,7 +483,7 @@ da8xx_dma_controller_create(struct musb *musb, void __iomem *base)
 
 static const struct musb_platform_ops da8xx_ops = {
 	.quirks		= MUSB_INDEXED_EP | MUSB_PRESERVE_SESSION |
-			  MUSB_DMA_CPPI41,
+			  MUSB_DMA_CPPI41 | MUSB_DA8XX,
 	.init		= da8xx_musb_init,
 	.exit		= da8xx_musb_exit,
 
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 5b708be..3e98d42 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -172,6 +172,7 @@ struct musb_io;
  */
 struct musb_platform_ops {
 
+#define MUSB_DA8XX		BIT(8)
 #define MUSB_PRESERVE_SESSION	BIT(7)
 #define MUSB_DMA_UX500		BIT(6)
 #define MUSB_DMA_CPPI41		BIT(5)
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 00e272b..2df37be 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -552,6 +552,10 @@ static int cppi41_dma_channel_abort(struct dma_channel *channel)
 		}
 	}
 
+	/* DA8xx Advisory 2.3.27: wait 250 ms before to start the teardown */
+	if (musb->io.quirks & MUSB_DA8XX)
+		mdelay(250);
+
 	tdbit = 1 << cppi41_channel->port_num;
 	if (is_tx)
 		tdbit <<= 16;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
