From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] i2c-omap: Do not use interruptible wait call in
	omap_i2c_xfer_msg
Date: Fri, 28 Nov 2008 17:28:13 -0800
Message-ID: <20081129012813.13042.21122.stgit@localhost>
References: <20081129012612.13042.12283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53544 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbYK2B2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:28:12 -0500
In-Reply-To: <20081129012612.13042.12283.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c-linux@vger.kernel.org, ben-linux@fluff.org
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

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
 drivers/i2c/busses/i2c-omap.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 608038d..17476ec 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -328,8 +328,12 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w |= OMAP_I2C_CON_STP;
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 
-	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
-						      OMAP_I2C_TIMEOUT);
+	/*
+	 * REVISIT: We should abort the transfer on signals, but the bus goes
+	 * into arbitration and we're currently unable to recover from it.
+	 */
+	r = wait_for_completion_timeout(&dev->cmd_complete,
+					OMAP_I2C_TIMEOUT);
 	dev->buf_len = 0;
 	if (r < 0)
 		return r;

