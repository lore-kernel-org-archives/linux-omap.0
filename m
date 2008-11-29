From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/12] i2c-omap: Do not use interruptible wait call in
	omap_i2c_xfer_msg
Date: Fri, 28 Nov 2008 17:33:55 -0800
Message-ID: <20081129013355.13428.82156.stgit@localhost>
References: <20081129013318.13428.88465.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081129013318.13428.88465.stgit@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Juha Yrjola <juha.yrjola-EmnPodGKVbzby3iVrkZq2A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

If there is a signal pending and wait_for_completion_interruptible_timeout
terminates with -ERESTARTSYS, we return and disable the i2c clocks in
omap_i2c_xfer.

If we terminate before sending last i2c message with a stop condition, the
bus remains busy and we are not able to send new messages into bus with
successive omap_i2c_xfer calls. Therefore a pending signal is not caught
here and we return only because of timeout or i2c error.

Signed-off-by: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Juha Yrjola <juha.yrjola-EmnPodGKVbzby3iVrkZq2A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
