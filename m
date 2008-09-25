From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] i2c-omap: Do not use interruptible wait call in omap_i2c_xfer_msg
Date: Thu, 25 Sep 2008 10:53:47 +0300
Message-ID: <1222329234-31473-2-git-send-email-tony@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60743 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYIYHyD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:54:03 -0400
In-Reply-To: <1222329234-31473-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c@lm-sensors.org
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>, Juha Yrjola <juha.yrjola@solidboot.com>, Tony Lindgren <tony@atomide.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

If there is a signal pending and wait_for_completion_interruptible_timeout
terminates with -ERESTARTSYS, we return and disable the i2c clocks in
omap_i2c_xfer.

If we terminate before sending last i2c message with a stop condition, the
bus remains busy and we are not able to send new messages into bus with
successive omap_i2c_xfer calls. Therefore a pending signal is not caught
here and we return only because of timeout or i2c error.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e7eb7bf..cfb76f5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -328,8 +328,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w |= OMAP_I2C_CON_STP;
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 
-	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
-						      OMAP_I2C_TIMEOUT);
+	r = wait_for_completion_timeout(&dev->cmd_complete,
+					OMAP_I2C_TIMEOUT);
 	dev->buf_len = 0;
 	if (r < 0)
 		return r;
-- 
1.5.6.rc3.21.g8c6b5

