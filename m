From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] usb: musb: Populate new IO functions for blackfin
Date: Mon, 24 Nov 2014 11:05:01 -0800
Message-ID: <1416855906-13931-4-git-send-email-tony@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19800 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbaKXTH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 14:07:56 -0500
In-Reply-To: <1416855906-13931-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bryan Wu <cooloney@gmail.com>

Populate new IO functions for blackfin

Cc: Bryan Wu <cooloney@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/blackfin.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index ac4422b..8b5ad57 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -33,6 +33,41 @@ struct bfin_glue {
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
+static u32 bfin_fifo_offset(u8 epnum)
+{
+	return USB_OFFSET(USB_EP0_FIFO) + (epnum * 8);
+}
+
+static u8 bfin_readb(const void __iomem *addr, unsigned offset)
+{
+	return (u8)(bfin_read16(addr + offset));
+}
+
+static u16 bfin_readw(const void __iomem *addr, unsigned offset)
+{
+	return bfin_read16(addr + offset);
+}
+
+static u32 bfin_readl(const void __iomem *addr, unsigned offset)
+{
+	return (u32)(bfin_read16(addr + offset));
+}
+
+static void bfin_writeb(void __iomem *addr, unsigned offset, u8 data)
+{
+	bfin_write16(addr + offset, (u16)data);
+}
+
+static void bfin_writew(void __iomem *addr, unsigned offset, u16 data)
+{
+	bfin_write16(addr + offset, data);
+}
+
+static void binf_writel(void __iomem *addr, unsigned offset, u32 data)
+{
+	bfin_write16(addr + offset, (u16)data);
+}
+
 /*
  * Load an endpoint's FIFO
  */
@@ -433,6 +468,14 @@ static const struct musb_platform_ops bfin_ops = {
 	.init		= bfin_musb_init,
 	.exit		= bfin_musb_exit,
 
+	.readb		= bfin_readb,
+	.writeb		= bfin_writeb,
+	.readw		= bfin_readw,
+	.writew		= bfin_writew,
+	.readl		= bfin_readl,
+	.writel		= bfin_writel,
+	.read_fifo	= musb_read_fifo,
+	.write_fifo	= musb_write_fifo,
 	.enable		= bfin_musb_enable,
 	.disable	= bfin_musb_disable,
 
-- 
2.1.3

