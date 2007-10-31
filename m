From: jarkko.nikula@nokia.com
Subject: [PATCH 1/3] CBUS: Cleanup retu-headset driver
Date: Wed, 31 Oct 2007 14:04:40 +0200
Message-ID: <1193832282-10044-2-git-send-email-jarkko.nikula@nokia.com>
References: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
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

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Few cleanups, coding style fixes and unused stuff removal.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/cbus/retu-headset.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index cd55bf2..ac21394 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -32,18 +32,15 @@
 
 #define RETU_HEADSET_KEY		KEY_PHONE
 
-#define STATE_DISABLE_DET		1
-#define STATE_ENABLE_DET		2
-
 struct retu_headset {
-	struct platform_device *pdev;
-	struct input_dev *idev;
-	unsigned bias_enabled:1;
-
-	unsigned detection_enabled:1, pressed:1;
-	int detection_state;
-	struct timer_list enable_timer, detect_timer;
-	spinlock_t lock;
+	spinlock_t			lock;
+	struct platform_device		*pdev;
+	struct input_dev		*idev;
+	unsigned			bias_enabled:1;
+	unsigned			detection_enabled:1;
+	unsigned			pressed:1;
+	struct timer_list		enable_timer;
+	struct timer_list		detect_timer;
 };
 
 static void retu_headset_set_bias(int enable)
@@ -55,7 +52,7 @@ static void retu_headset_set_bias(int enable)
 		retu_set_clear_reg_bits(RETU_REG_AUDTXR, 1 << 3, 0);
 	} else {
 		retu_set_clear_reg_bits(RETU_REG_AUDTXR, 0,
-				    (1 << 0) | (1 << 1) | (1 << 3));
+					(1 << 0) | (1 << 1) | (1 << 3));
 	}
 }
 
@@ -288,7 +285,8 @@ static int retu_headset_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int retu_headset_suspend(struct platform_device *pdev, pm_message_t mesg)
+static int retu_headset_suspend(struct platform_device *pdev,
+				pm_message_t mesg)
 {
 	return 0;
 }
@@ -298,7 +296,6 @@ static int retu_headset_resume(struct platform_device *pdev)
 	return 0;
 }
 
-
 static struct platform_driver retu_headset_driver = {
 	.probe		= retu_headset_probe,
 	.remove		= retu_headset_remove,
-- 
1.5.3.4
