From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v3 03/15] mfd: menelaus: Convert to threaded irq
Date: Mon, 9 Dec 2013 10:21:13 -0600
Message-ID: <1386606085-26838-3-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386606085-26838-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

We don't need that extra workqueue when we have generic threaded irq
handlers support. This patch just moves over to threaded irqs and
deletes the unnecessary workqueue.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 8bd97ca..11d7d81 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -36,7 +36,6 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
-#include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
@@ -161,12 +160,9 @@
 #define MCT_PIN_ST_S1_CD_ST		(1 << 0)
 #define MCT_PIN_ST_S2_CD_ST		(1 << 1)
 
-static void menelaus_work(struct work_struct *_menelaus);
-
 struct menelaus_chip {
 	struct mutex		lock;
 	struct i2c_client	*client;
-	struct work_struct	work;
 #ifdef CONFIG_RTC_DRV_TWL92330
 	struct rtc_device	*rtc;
 	u8			rtc_control;
@@ -795,11 +791,9 @@ out:
 
 /*-----------------------------------------------------------------------*/
 
-/* Handles Menelaus interrupts. Does not run in interrupt context */
-static void menelaus_work(struct work_struct *_menelaus)
+static irqreturn_t menelaus_irq(int irq, void *_menelaus)
 {
-	struct menelaus_chip *menelaus =
-			container_of(_menelaus, struct menelaus_chip, work);
+	struct menelaus_chip *menelaus = _menelaus;
 	void (*handler)(struct menelaus_chip *menelaus);
 
 	while (1) {
@@ -826,18 +820,6 @@ static void menelaus_work(struct work_struct *_menelaus)
 			mutex_unlock(&menelaus->lock);
 		}
 	}
-	enable_irq(menelaus->client->irq);
-}
-
-/*
- * We cannot use I2C in interrupt context, so we just schedule work.
- */
-static irqreturn_t menelaus_irq(int irq, void *_menelaus)
-{
-	struct menelaus_chip *menelaus = _menelaus;
-
-	disable_irq_nosync(irq);
-	(void)schedule_work(&menelaus->work);
 
 	return IRQ_HANDLED;
 }
@@ -1225,8 +1207,8 @@ static int menelaus_probe(struct i2c_client *client,
 	menelaus_write_reg(MENELAUS_MCT_CTRL1, 0x73);
 
 	if (client->irq > 0) {
-		err = request_irq(client->irq, menelaus_irq, 0,
-				  DRIVER_NAME, menelaus);
+		err = request_threaded_irq(client->irq, NULL, menelaus_irq,
+				IRQF_ONESHOT, DRIVER_NAME, menelaus);
 		if (err) {
 			dev_dbg(&client->dev,  "can't get IRQ %d, err %d\n",
 					client->irq, err);
@@ -1235,7 +1217,6 @@ static int menelaus_probe(struct i2c_client *client,
 	}
 
 	mutex_init(&menelaus->lock);
-	INIT_WORK(&menelaus->work, menelaus_work);
 
 	pr_info("Menelaus rev %d.%d\n", rev >> 4, rev & 0x0f);
 
@@ -1258,7 +1239,6 @@ static int menelaus_probe(struct i2c_client *client,
 	return 0;
 fail:
 	free_irq(client->irq, menelaus);
-	flush_work(&menelaus->work);
 	return err;
 }
 
@@ -1267,7 +1247,6 @@ static int menelaus_remove(struct i2c_client *client)
 	struct menelaus_chip	*menelaus = i2c_get_clientdata(client);
 
 	free_irq(client->irq, menelaus);
-	flush_work(&menelaus->work);
 	the_menelaus = NULL;
 	return 0;
 }
-- 
1.8.4.GIT
