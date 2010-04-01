From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 2/2] [STAGING] Synaptic : Add threaded IRQ support
Date: Thu, 1 Apr 2010 18:46:27 +0530 (IST)
Message-ID: <37428.10.24.255.17.1270127787.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
References: 
In-Reply-To: 
Sender: linux-input-owner@vger.kernel.org
To: gregkh@suse.de, devel@driverdev.osuosl.org
Cc: pavel@ucw.cz, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>From d04802248f813fea756e2714805bb61c86397a56 Mon Sep 17 00:00:00 2001 From: Hemanth V <hemanthv@ti.com>
Date: Thu, 1 Apr 2010 17:27:39 +0530
Subject: [PATCH] Add threaded IRQ support


Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 drivers/staging/dream/synaptics_i2c_rmi.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/dream/synaptics_i2c_rmi.c b/drivers/staging/dream/synaptics_i2c_rmi.c index 7c1b980..f2e333e 100644
--- a/drivers/staging/dream/synaptics_i2c_rmi.c
+++ b/drivers/staging/dream/synaptics_i2c_rmi.c
@@ -198,8 +198,6 @@ static void synaptics_ts_work_func(struct work_struct *work)

 		decode_report(ts, buf);
 	}
-	if (ts->use_irq)
-		enable_irq(ts->client->irq);
 }

 static enum hrtimer_restart synaptics_ts_timer_func(struct hrtimer *timer)
@@ -217,8 +215,7 @@ static irqreturn_t synaptics_ts_irq_handler(int irq, void *dev_id)
 {
 	struct synaptics_ts_data *ts = dev_id;

-	disable_irq_nosync(ts->client->irq);
-	queue_work(synaptics_wq, &ts->work);
+	synaptics_ts_work_func(&ts->work);
 	return IRQ_HANDLED;
 }

@@ -484,8 +481,10 @@ static int __devinit synaptics_ts_probe(
 		goto err_input_register_device_failed;
 	}
 	if (client->irq) {
-		ret = request_irq(client->irq, synaptics_ts_irq_handler,
-				  0, client->name, ts);
+		ret = request_threaded_irq(client->irq, NULL,
+					synaptics_ts_irq_handler,
+					IRQF_TRIGGER_LOW|IRQF_ONESHOT,
+					client->name, ts);
 		if (ret == 0) {
 			ret = i2c_set(ts, 0xf1, 0x01, "enable abs int");
 			if (ret)
-- 
1.5.6.3





