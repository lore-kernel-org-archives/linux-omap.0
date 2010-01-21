From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/7] usb: musb: deprecate what we don't use
Date: Thu, 21 Jan 2010 15:33:55 +0200
Message-ID: <1264080838-9452-5-git-send-email-felipe.balbi@nokia.com>
References: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264080838-9452-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

after 2.6.34, those fields will be removed from
struct musb_hdrc_platform_data, it's expected
that other architectures are fixed by then.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 include/linux/usb/musb.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 4b7f8fa..8e0f2bc 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -30,26 +30,26 @@ struct musb_hdrc_eps_bits {
 struct musb_hdrc_config {
 	/* MUSB configuration-specific details */
 	unsigned	multipoint:1;	/* multipoint device */
-	unsigned	dyn_fifo:1;	/* supports dynamic fifo sizing */
-	unsigned	soft_con:1;	/* soft connect required */
-	unsigned	utm_16:1;	/* utm data witdh is 16 bits */
+	unsigned	dyn_fifo:1 __deprecated; /* supports dynamic fifo sizing */
+	unsigned	soft_con:1 __deprecated; /* soft connect required */
+	unsigned	utm_16:1 __deprecated; /* utm data witdh is 16 bits */
 	unsigned	big_endian:1;	/* true if CPU uses big-endian */
 	unsigned	mult_bulk_tx:1;	/* Tx ep required for multbulk pkts */
 	unsigned	mult_bulk_rx:1;	/* Rx ep required for multbulk pkts */
 	unsigned	high_iso_tx:1;	/* Tx ep required for HB iso */
 	unsigned	high_iso_rx:1;	/* Rx ep required for HD iso */
-	unsigned	dma:1;		/* supports DMA */
-	unsigned	vendor_req:1;	/* vendor registers required */
+	unsigned	dma:1 __deprecated; /* supports DMA */
+	unsigned	vendor_req:1 __deprecated; /* vendor registers required */
 
 	u8		num_eps;	/* number of endpoints _with_ ep0 */
-	u8		dma_channels;	/* number of dma channels */
+	u8		dma_channels __deprecated; /* number of dma channels */
 	u8		dyn_fifo_size;	/* dynamic size in bytes */
-	u8		vendor_ctrl;	/* vendor control reg width */
-	u8		vendor_stat;	/* vendor status reg witdh */
-	u8		dma_req_chan;	/* bitmask for required dma channels */
+	u8		vendor_ctrl __deprecated; /* vendor control reg width */
+	u8		vendor_stat __deprecated; /* vendor status reg witdh */
+	u8		dma_req_chan __deprecated; /* bitmask for required dma channels */
 	u8		ram_bits;	/* ram address size */
 
-	struct musb_hdrc_eps_bits *eps_bits;
+	struct musb_hdrc_eps_bits *eps_bits __deprecated;
 #ifdef CONFIG_BLACKFIN
         /* A GPIO controlling VRSEL in Blackfin */
         unsigned int    gpio_vrsel;
-- 
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
