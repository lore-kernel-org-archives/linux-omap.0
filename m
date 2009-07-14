From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: [PATCH 2/3] [OMAP:I2C]In case of a NACK|ARDY|AL return from the ISR
Date: Tue, 14 Jul 2009 16:19:39 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202957C7AFA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36856 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756238AbZGNVT5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 17:19:57 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>


In case of a NACK or ARDY or AL interrupt, complete the request.
There is no need to service the RRDY/RDR or XRDY/XDR interrupts.

Refer TRM SWPU114: Figure 18-31.I2C Master Transmitter Mode, Interrupt Method,
in F/S and HS Modes

http://focus.ti.com/pdfs/wtbu/SWPU114T_PrelimFinalEPDF_06_25_2009.pdf

Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
Signed-off-by: Vikram Pandita<vikram.pandita@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d280acf..05b5e4c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -685,8 +685,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			err |= OMAP_I2C_STAT_AL;
 		}
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
-					OMAP_I2C_STAT_AL))
+					OMAP_I2C_STAT_AL)) {
 			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
+		}
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
 			if (dev->fifo_size) {
-- 
1.5.6.3

