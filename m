From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] [I2C] OMAP: Don't write IE state in unidle if 0
Date: Tue, 22 Dec 2009 18:06:13 -0700
Message-ID: <1261530373-408-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Jouni Hogander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor-l0cyMroinI0@public.gmane.org>, Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, Hu Tao <taohu-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>, Xiaolong Chen <A21785-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>, Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit ef871432... (i2c-omap: OMAP3: PM: (re)init for every transfer
to support off-mode) introduced a change which make the dev->iestate
contents be written to the OMAP_I2C_IE_REG every time omap_i2c_unidle
is called.  Previously, the state was only written if it wasn't equal
to zero.

In omap_i2c_probe, omap_i2c_unidle() is called prior to omap_i2c_init(),
in which case dev->iestate has not yet been initialized and will be set
to zero.  Having this value written to the registers causes deadlock
while booting.

As such, this change restores the original functionality.

Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3440d88..c0bb9eb 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -248,7 +248,13 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 	}
 	dev->idle = 0;
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+
+	/*
+	 * Don't write to this register if the IE state is 0 as it can
+	 * cause deadlock.
+	 */
+	if (dev->iestate)
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev)
-- 
1.6.3.3
