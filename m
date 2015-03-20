From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2] usb: musb: Fix fifo reads for dm816x with musb_dsps
Date: Thu, 19 Mar 2015 17:10:16 -0700
Message-ID: <1426810216-12728-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i567.relay.mailchannels.net ([46.232.183.121]:19091
	"EHLO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750734AbbCTAPI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 20:15:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, George Cherian <george.cherian@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Looks like dm81xx can only do 32-bit fifo reads like am35x. Let's set
up musb-dsps with a custom read_fifo function based on the compatible
flag.

Otherwise we can get the following errors when starting dhclient on a
asix USB Ethernet adapter:

asix 2-1:1.0 eth2: asix_rx_fixup() Bad Header Length 0xffff003c, offset 4

While at it, let's also remove pointless cast of the driver data.

Cc: Bin Liu <binmlist@gmail.com>
Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: George Cherian <george.cherian@ti.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_dsps.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index a900c98..2c0750e 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -655,6 +655,24 @@ static int dsps_musb_reset(struct musb *musb)
 	return !session_restart;
 }
 
+/* Similar to am35x, dm81xx support only 32-bit read operation */
+static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
+{
+	void __iomem *fifo = hw_ep->fifo;
+
+	if (len >= 4) {
+		readsl(fifo, dst, len >> 2);
+		dst += len & ~0x03;
+		len &= 0x03;
+	}
+
+	/* Read any remaining 1 to 3 bytes */
+	if (len > 0) {
+		u32 val = musb_readl(fifo, 0);
+		memcpy(dst, &val, len);
+	}
+}
+
 static struct musb_platform_ops dsps_ops = {
 	.quirks		= MUSB_INDEXED_EP,
 	.init		= dsps_musb_init,
@@ -802,6 +820,9 @@ static int dsps_probe(struct platform_device *pdev)
 	}
 	wrp = match->data;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "ti,musb-dm816"))
+		dsps_ops.read_fifo = dsps_read_fifo32;
+
 	/* allocate glue */
 	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue)
@@ -878,7 +899,9 @@ static const struct dsps_musb_wrapper am33xx_driver_data = {
 
 static const struct of_device_id musb_dsps_of_match[] = {
 	{ .compatible = "ti,musb-am33xx",
-		.data = (void *) &am33xx_driver_data, },
+		.data = &am33xx_driver_data, },
+	{ .compatible = "ti,musb-dm816",
+		.data = &am33xx_driver_data, },
 	{  },
 };
 MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
-- 
2.1.4

