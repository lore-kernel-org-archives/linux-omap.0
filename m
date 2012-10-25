From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 4/7] i2c: omap: in case of VERSION_2 read IRQSTATUS_RAW but write to IRQSTATUS
Date: Thu, 25 Oct 2012 15:25:12 +0300
Message-ID: <1351167915-15079-5-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351167915-15079-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

on OMAP4+ we want to read IRQSTATUS_RAW register,
instead of IRQSTATUS. The reason being that IRQSTATUS
will only contain the bits which were enabled on
IRQENABLE_SET and that will break when we need to
poll for a certain bit which wasn't enabled as an
IRQ source.

One such case is after we finish converting to
deferred stop bit, we will have to poll for ARDY
bit before returning control for the client driver
in order to prevent us from trying to start a
transfer on a bus which is already busy.

Note, however, that omap-i2c.c needs a big rework
on register definition and register access. Such
work will be done in a separate series of patches.

Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b004126..20f9ad6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -271,8 +271,18 @@ static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base +
+	/* if we are OMAP_I2C_IP_VERSION_2, we need to read from
+	 * IRQSTATUS_RAW, but write to IRQSTATUS
+	 */
+	if ((i2c_dev->dtrev == OMAP_I2C_IP_VERSION_2) &&
+			(reg == OMAP_I2C_STAT_REG)) {
+		return __raw_readw(i2c_dev->base +
+				((i2c_dev->regs[reg] - 0x04)
+				 << i2c_dev->reg_shift));
+	} else {
+		return __raw_readw(i2c_dev->base +
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
+	}
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
-- 
1.8.0
