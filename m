From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] usb: musb: use correct register widths in register dumps
Date: Thu,  8 Jul 2010 14:02:59 +0530
Message-ID: <1278577982-30046-2-git-send-email-ajay.gupta@ti.com>
References: <1278577982-30046-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278577982-30046-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

DMA_ADDR and DMA_COUNT are 32-bit registers, not 16-bit.

Marking them as 16-bit in the table causes only the lower
16-bits to be dumped and this is misleading.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_debugfs.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index bba76af..c79a5e3 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -92,29 +92,29 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "LS_EOF1",		0x7E,	8 },
 	{ "SOFT_RST",		0x7F,	8 },
 	{ "DMA_CNTLch0",	0x204,	16 },
-	{ "DMA_ADDRch0",	0x208,	16 },
-	{ "DMA_COUNTch0",	0x20C,	16 },
+	{ "DMA_ADDRch0",	0x208,	32 },
+	{ "DMA_COUNTch0",	0x20C,	32 },
 	{ "DMA_CNTLch1",	0x214,	16 },
-	{ "DMA_ADDRch1",	0x218,	16 },
-	{ "DMA_COUNTch1",	0x21C,	16 },
+	{ "DMA_ADDRch1",	0x218,	32 },
+	{ "DMA_COUNTch1",	0x21C,	32 },
 	{ "DMA_CNTLch2",	0x224,	16 },
-	{ "DMA_ADDRch2",	0x228,	16 },
-	{ "DMA_COUNTch2",	0x22C,	16 },
+	{ "DMA_ADDRch2",	0x228,	32 },
+	{ "DMA_COUNTch2",	0x22C,	32 },
 	{ "DMA_CNTLch3",	0x234,	16 },
-	{ "DMA_ADDRch3",	0x238,	16 },
-	{ "DMA_COUNTch3",	0x23C,	16 },
+	{ "DMA_ADDRch3",	0x238,	32 },
+	{ "DMA_COUNTch3",	0x23C,	32 },
 	{ "DMA_CNTLch4",	0x244,	16 },
-	{ "DMA_ADDRch4",	0x248,	16 },
-	{ "DMA_COUNTch4",	0x24C,	16 },
+	{ "DMA_ADDRch4",	0x248,	32 },
+	{ "DMA_COUNTch4",	0x24C,	32 },
 	{ "DMA_CNTLch5",	0x254,	16 },
-	{ "DMA_ADDRch5",	0x258,	16 },
-	{ "DMA_COUNTch5",	0x25C,	16 },
+	{ "DMA_ADDRch5",	0x258,	32 },
+	{ "DMA_COUNTch5",	0x25C,	32 },
 	{ "DMA_CNTLch6",	0x264,	16 },
-	{ "DMA_ADDRch6",	0x268,	16 },
-	{ "DMA_COUNTch6",	0x26C,	16 },
+	{ "DMA_ADDRch6",	0x268,	32 },
+	{ "DMA_COUNTch6",	0x26C,	32 },
 	{ "DMA_CNTLch7",	0x274,	16 },
-	{ "DMA_ADDRch7",	0x278,	16 },
-	{ "DMA_COUNTch7",	0x27C,	16 },
+	{ "DMA_ADDRch7",	0x278,	32 },
+	{ "DMA_COUNTch7",	0x27C,	32 },
 	{  }	/* Terminating Entry */
 };
 
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
