From: "Jason Marini" <jason.marini@gmail.com>
Subject: [PATCH] ARM: OMAP: Fix occasional i2c driver hang
Date: Thu, 28 Aug 2008 15:30:58 -0400
Message-ID: <423644ca0808281230g1f8c20ceta4a6822098d4e431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:36419 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbYH1TbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 15:31:00 -0400
Received: by gxk9 with SMTP id 9so4958331gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 12:30:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The i2c driver contains a while loop that has no timeout.  If i2c is in a
funky state and OMAP_I2C_CON_STT remains asserted, the kernel hangs.  Insert
the standard i2c timeout into the loop.

Signed-off-by: Jason P Marini <jason.marini@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3c4e581..3a7b6ef 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -440,9 +440,16 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);

 	if (dev->b_hw && stop) {
+		unsigned long delay = jiffies + OMAP_I2C_TIMEOUT;
+
 		/* H/w behavior: dont write stt and stp together.. */
 		while (omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) & OMAP_I2C_CON_STT) {
-			/* Dont do anything - this will come in a couple of loops at max*/
+			/* Let the user know if i2c is in a bad state */
+			if (time_after (jiffies, delay)) {
+				dev_err(dev->dev, "controller timed out "
+				"waiting for start condition to finish\n");
+				return -ETIMEDOUT;
+			}
 		}
 		w |= OMAP_I2C_CON_STP;
 		w &= ~OMAP_I2C_CON_STT;
-- 
1.5.5.1
