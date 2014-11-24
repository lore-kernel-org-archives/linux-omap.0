From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/8] usb: musb: Populate new IO functions for tusb6010
Date: Mon, 24 Nov 2014 11:05:00 -0800
Message-ID: <1416855906-13931-3-git-send-email-tony@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19770 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbaKXTH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 14:07:56 -0500
In-Reply-To: <1416855906-13931-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Let's populate the new IO functions for tusb6010 but not use
them yet.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/tusb6010.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 2daa779..996ea21 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -126,6 +126,41 @@ static void tusb_wbus_quirk(struct musb *musb, int enabled)
 	}
 }
 
+static u32 tusb_fifo_offset(u8 epnum)
+{
+	return 0x200 + (epnum * 0x20);
+}
+
+/*
+ * TUSB6010 doesn't allow 8-bit access; 16-bit access is the minimum.
+ */
+static u8 tusb_readb(const void __iomem *addr, unsigned offset)
+{
+	u16 tmp;
+	u8 val;
+
+	tmp = __raw_readw(addr + (offset & ~1));
+	if (offset & 1)
+		val = (tmp >> 8);
+	else
+		val = tmp & 0xff;
+
+	return val;
+}
+
+static void tusb_writeb(void __iomem *addr, unsigned offset, u8 data)
+{
+	u16 tmp;
+
+	tmp = __raw_readw(addr + (offset & ~1));
+	if (offset & 1)
+		tmp = (data << 8) | (tmp & 0xff);
+	else
+		tmp = (tmp & 0xff00) | data;
+
+	__raw_writew(tmp, addr + (offset & ~1));
+}
+
 /*
  * TUSB 6010 may use a parallel bus that doesn't support byte ops;
  * so both loading and unloading FIFOs need explicit byte counts.
@@ -1135,9 +1170,15 @@ static int tusb_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops tusb_ops = {
+	.quirks		= MUSB_IN_TUSB,
 	.init		= tusb_musb_init,
 	.exit		= tusb_musb_exit,
 
+	.fifo_offset	= tusb_fifo_offset,
+	.readb		= tusb_readb,
+	.writeb		= tusb_writeb,
+	.read_fifo	= musb_read_fifo,
+	.write_fifo	= musb_write_fifo,
 	.enable		= tusb_musb_enable,
 	.disable	= tusb_musb_disable,
 
-- 
2.1.3

