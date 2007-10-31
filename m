From: jarkko.nikula@nokia.com
Subject: [PATCH 3/3] CBUS: Fix reentrant issues in retu-headset driver
Date: Wed, 31 Oct 2007 14:04:42 +0200
Message-ID: <1193832282-10044-4-git-send-email-jarkko.nikula@nokia.com>
References: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

- Make headset bias and headset button detection enable/disable functions
  reentrant. Protect also suspend/resume callbacks since they call
  retu_headset_set_bias directly.
- Don't define flag variables as bit fields since bit operations may not be
  atomic and we access one of them from interrupt. Now other flags don't
  need any additional locking since they are not accessed from interrupt
  context.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/cbus/retu-headset.c |   68 +++++++++++++++++++++++++++----------------
 1 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index 7f3f808..ed2e59b 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -34,11 +34,12 @@
 
 struct retu_headset {
 	spinlock_t			lock;
+	struct mutex			mutex;
 	struct platform_device		*pdev;
 	struct input_dev		*idev;
-	unsigned			bias_enabled:1;
-	unsigned			detection_enabled:1;
-	unsigned			pressed:1;
+	unsigned			bias_enabled;
+	unsigned			detection_enabled;
+	unsigned			pressed;
 	struct timer_list		enable_timer;
 	struct timer_list		detect_timer;
 };
@@ -58,40 +59,52 @@ static void retu_headset_set_bias(int enable)
 
 static void retu_headset_enable(struct retu_headset *hs)
 {
-	if (hs->bias_enabled)
-		return;
-	hs->bias_enabled = 1;
-	retu_headset_set_bias(1);
+	mutex_lock(&hs->mutex);
+	if (!hs->bias_enabled) {
+		hs->bias_enabled = 1;
+		retu_headset_set_bias(1);
+	}
+	mutex_unlock(&hs->mutex);
 }
 
 static void retu_headset_disable(struct retu_headset *hs)
 {
-	if (!hs->bias_enabled)
-		return;
-	hs->bias_enabled = 0;
-	retu_headset_set_bias(0);
+	mutex_lock(&hs->mutex);
+	if (hs->bias_enabled) {
+		hs->bias_enabled = 0;
+		retu_headset_set_bias(0);
+	}
+	mutex_unlock(&hs->mutex);
 }
 
 static void retu_headset_det_enable(struct retu_headset *hs)
 {
-	if (hs->detection_enabled)
-		return;
-	hs->detection_enabled = 1;
-	retu_set_clear_reg_bits(RETU_REG_CC1, (1 << 10) | (1 << 8), 0);
-	retu_enable_irq(RETU_INT_HOOK);
+	mutex_lock(&hs->mutex);
+	if (!hs->detection_enabled) {
+		hs->detection_enabled = 1;
+		retu_set_clear_reg_bits(RETU_REG_CC1, (1 << 10) | (1 << 8), 0);
+		retu_enable_irq(RETU_INT_HOOK);
+	}
+	mutex_unlock(&hs->mutex);
 }
 
 static void retu_headset_det_disable(struct retu_headset *hs)
 {
-	if (!hs->detection_enabled)
-		return;
-	hs->detection_enabled = 0;
-	retu_disable_irq(RETU_INT_HOOK);
-	del_timer_sync(&hs->enable_timer);
-	del_timer_sync(&hs->detect_timer);
-	if (hs->pressed)
-		input_report_key(hs->idev, RETU_HEADSET_KEY, 0);
-	retu_set_clear_reg_bits(RETU_REG_CC1, 0, (1 << 10) | (1 << 8));
+	unsigned long flags;
+
+	mutex_lock(&hs->mutex);
+	if (hs->detection_enabled) {
+		hs->detection_enabled = 0;
+		retu_disable_irq(RETU_INT_HOOK);
+		del_timer_sync(&hs->enable_timer);
+		del_timer_sync(&hs->detect_timer);
+		spin_lock_irqsave(&hs->lock, flags);
+		if (hs->pressed)
+			input_report_key(hs->idev, RETU_HEADSET_KEY, 0);
+		spin_unlock_irqrestore(&hs->lock, flags);
+		retu_set_clear_reg_bits(RETU_REG_CC1, 0, (1 << 10) | (1 << 8));
+	}
+	mutex_unlock(&hs->mutex);
 }
 
 static ssize_t retu_headset_hookdet_show(struct device *dev,
@@ -242,6 +255,7 @@ static int __init retu_headset_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, hs);
 
 	spin_lock_init(&hs->lock);
+	mutex_init(&hs->mutex);
 	setup_timer(&hs->enable_timer, retu_headset_enable_timer,
 		    (unsigned long) hs);
 	setup_timer(&hs->detect_timer, retu_headset_detect_timer,
@@ -290,8 +304,10 @@ static int retu_headset_suspend(struct platform_device *pdev,
 {
 	struct retu_headset *hs = platform_get_drvdata(pdev);
 
+	mutex_lock(&hs->mutex);
 	if (hs->bias_enabled)
 		retu_headset_set_bias(0);
+	mutex_unlock(&hs->mutex);
 
 	return 0;
 }
@@ -300,8 +316,10 @@ static int retu_headset_resume(struct platform_device *pdev)
 {
 	struct retu_headset *hs = platform_get_drvdata(pdev);
 
+	mutex_lock(&hs->mutex);
 	if (hs->bias_enabled)
 		retu_headset_set_bias(1);
+	mutex_unlock(&hs->mutex);
 
 	return 0;
 }
-- 
1.5.3.4
