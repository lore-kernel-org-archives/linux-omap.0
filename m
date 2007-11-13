From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] CBUS: Do not BUG_ON in retu-headset in case of spurious
	release event
Date: Tue, 13 Nov 2007 15:53:14 +0200
Message-ID: <1194961994-12212-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

There is a small chance that retu_headset_detect_timer can run twice
and pressed flag being zero in second run. Do nothing in that case instead
of throwing BUG_ON.

Double run can happen under very busy system assuming following scenario

1. Hook interrupt (run in softirq context, pressed flag = 1)
2. First retu_headset_enable_timer call
3. Busy system, retu raises an interrupt but cannot run hook interrupt for
   300-350 ms
4. Second hook interrupt
5. First retu_headset_detect_timer call (pressed flag = 0)
6. Second retu_headset_enable_timer
7. Second retu_headset_detect_timer
   -> pressed flag == 0 => BUG_ON

Patch also removes two debug messages since they are not needed very much
and removal cleans up code a bit.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/cbus/retu-headset.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index ed2e59b..3161658 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -180,7 +180,6 @@ static void retu_headset_hook_interrupt(unsigned long arg)
 {
 	struct retu_headset *hs = (struct retu_headset *) arg;
 	unsigned long flags;
-	int was_pressed = 0;
 
 	retu_ack_irq(RETU_INT_HOOK);
 	spin_lock_irqsave(&hs->lock, flags);
@@ -188,11 +187,8 @@ static void retu_headset_hook_interrupt(unsigned long arg)
 		/* Headset button was just pressed down. */
 		hs->pressed = 1;
 		input_report_key(hs->idev, RETU_HEADSET_KEY, 1);
-		was_pressed = 1;
 	}
 	spin_unlock_irqrestore(&hs->lock, flags);
-	if (was_pressed)
-		dev_info(&hs->pdev->dev, "button pressed\n");
 	retu_set_clear_reg_bits(RETU_REG_CC1, 0, (1 << 10) | (1 << 8));
 	mod_timer(&hs->enable_timer, jiffies + msecs_to_jiffies(50));
 }
@@ -211,11 +207,11 @@ static void retu_headset_detect_timer(unsigned long arg)
 	unsigned long flags;
 
 	spin_lock_irqsave(&hs->lock, flags);
-	BUG_ON(!hs->pressed);
-	input_report_key(hs->idev, RETU_HEADSET_KEY, 0);
-	hs->pressed = 0;
+	if (hs->pressed) {
+		hs->pressed = 0;
+		input_report_key(hs->idev, RETU_HEADSET_KEY, 0);
+	}
 	spin_unlock_irqrestore(&hs->lock, flags);
-	dev_info(&hs->pdev->dev, "button released\n");
 }
 
 static int __init retu_headset_probe(struct platform_device *pdev)
-- 
1.5.3.4
