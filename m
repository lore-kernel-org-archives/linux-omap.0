From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq handling
Date: Sat, 15 Nov 2014 05:20:52 +0400
Message-ID: <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416014452-6712-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

commit 66b9298878742f08cb6e79b7c7d5632d782fd1e1 (i2c: omap: switch over
to do {} while loop) changed the interrupt handler to abort transfers
in case interrupt serviced 100 times but commit's comment states that
"No functional changes otherwise.".

Also, original commit could report status 0 (no error) on aborted transfers.

The patch restore original logic. In case interrupt serviced 100 times just
quit interrupt handler and don't abort active transfer.

Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9af7095..34b9011 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -920,7 +920,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
 		if (count++ == 100) {
 			dev_warn(dev->dev, "Too much work in one IRQ\n");
-			break;
+			goto out;
 		}
 
 		if (stat & OMAP_I2C_STAT_NACK) {
-- 
1.7.9.5
