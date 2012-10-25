From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/7] i2c: omap: also complete() when stat becomes zero
Date: Thu, 25 Oct 2012 15:25:11 +0300
Message-ID: <1351167915-15079-4-git-send-email-balbi@ti.com>
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

In case we loop on IRQ handler until stat is
finally zero, we would end up in a situation
where all I2C transfers would misteriously
timeout because we were not calling complete()
in that situation.

Fix the issue by moving omap_i2c_complete_cmd()
call inside the 'out' label.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index bea0277..b004126 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1021,9 +1021,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		}
 	} while (stat);
 
-	omap_i2c_complete_cmd(dev, err);
-
 out:
+	omap_i2c_complete_cmd(dev, err);
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	return IRQ_HANDLED;
-- 
1.8.0
