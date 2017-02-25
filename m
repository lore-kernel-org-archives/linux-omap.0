From: Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
Subject: [PATCH v3.1] [media] serial_ir: ensure we're ready to receive
 interrupts
Date: Sat, 25 Feb 2017 11:55:46 -0300
Message-ID: <4bf42b3935a6da2ec45730764c624ddc7c3f7c4f.1488032183.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ruslan Ruslichenko <rruslich-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, wfg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>, Sean Young <sean-hENCXIMQXOg@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux LED Subsystem <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, kernel test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKP <lkp-JC7UmRfGjtg@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Sean Young <sean-hENCXIMQXOg@public.gmane.org>

When the interrupt requested with devm_request_irq(), serial_ir.rcdev
is still null so will cause null deference if the irq handler is called
early on.

Also ensure that timeout_timer is setup.

Link: http://lkml.kernel.org/r/CA+55aFxsh2uF8gi5sN_guY3Z+tiLv7LpJYKBw+y8vqLzp+TsnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org

[mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org: moved serial_ir_probe() back to its original place]

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # for 4.10
Signed-off-by: Sean Young <sean-hENCXIMQXOg@public.gmane.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
---

Resent, using git

 drivers/media/rc/serial_ir.c | 123 ++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 61 deletions(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 923fb2299553..41b54e40176c 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -487,10 +487,69 @@ static void serial_ir_timeout(unsigned long arg)
 	ir_raw_event_handle(serial_ir.rcdev);
 }
 
+/* Needed by serial_ir_probe() */
+static int serial_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
+			unsigned int count);
+static int serial_ir_tx_duty_cycle(struct rc_dev *dev, u32 cycle);
+static int serial_ir_tx_carrier(struct rc_dev *dev, u32 carrier);
+static int serial_ir_open(struct rc_dev *rcdev);
+static void serial_ir_close(struct rc_dev *rcdev);
+
 static int serial_ir_probe(struct platform_device *dev)
 {
+	struct rc_dev *rcdev;
 	int i, nlow, nhigh, result;
 
+	rcdev = devm_rc_allocate_device(&dev->dev, RC_DRIVER_IR_RAW);
+	if (!rcdev)
+		return -ENOMEM;
+
+	if (hardware[type].send_pulse && hardware[type].send_space)
+		rcdev->tx_ir = serial_ir_tx;
+	if (hardware[type].set_send_carrier)
+		rcdev->s_tx_carrier = serial_ir_tx_carrier;
+	if (hardware[type].set_duty_cycle)
+		rcdev->s_tx_duty_cycle = serial_ir_tx_duty_cycle;
+
+	switch (type) {
+	case IR_HOMEBREW:
+		rcdev->input_name = "Serial IR type home-brew";
+		break;
+	case IR_IRDEO:
+		rcdev->input_name = "Serial IR type IRdeo";
+		break;
+	case IR_IRDEO_REMOTE:
+		rcdev->input_name = "Serial IR type IRdeo remote";
+		break;
+	case IR_ANIMAX:
+		rcdev->input_name = "Serial IR type AnimaX";
+		break;
+	case IR_IGOR:
+		rcdev->input_name = "Serial IR type IgorPlug";
+		break;
+	}
+
+	rcdev->input_phys = KBUILD_MODNAME "/input0";
+	rcdev->input_id.bustype = BUS_HOST;
+	rcdev->input_id.vendor = 0x0001;
+	rcdev->input_id.product = 0x0001;
+	rcdev->input_id.version = 0x0100;
+	rcdev->open = serial_ir_open;
+	rcdev->close = serial_ir_close;
+	rcdev->dev.parent = &serial_ir.pdev->dev;
+	rcdev->allowed_protocols = RC_BIT_ALL_IR_DECODER;
+	rcdev->driver_name = KBUILD_MODNAME;
+	rcdev->map_name = RC_MAP_RC6_MCE;
+	rcdev->min_timeout = 1;
+	rcdev->timeout = IR_DEFAULT_TIMEOUT;
+	rcdev->max_timeout = 10 * IR_DEFAULT_TIMEOUT;
+	rcdev->rx_resolution = 250000;
+
+	serial_ir.rcdev = rcdev;
+
+	setup_timer(&serial_ir.timeout_timer, serial_ir_timeout,
+		    (unsigned long)&serial_ir);
+
 	result = devm_request_irq(&dev->dev, irq, serial_ir_irq_handler,
 				  share_irq ? IRQF_SHARED : 0,
 				  KBUILD_MODNAME, &hardware);
@@ -516,9 +575,6 @@ static int serial_ir_probe(struct platform_device *dev)
 		return -EBUSY;
 	}
 
-	setup_timer(&serial_ir.timeout_timer, serial_ir_timeout,
-		    (unsigned long)&serial_ir);
-
 	result = hardware_init_port();
 	if (result < 0)
 		return result;
@@ -552,7 +608,8 @@ static int serial_ir_probe(struct platform_device *dev)
 			 sense ? "low" : "high");
 
 	dev_dbg(&dev->dev, "Interrupt %d, port %04x obtained\n", irq, io);
-	return 0;
+
+	return devm_rc_register_device(&dev->dev, rcdev);
 }
 
 static int serial_ir_open(struct rc_dev *rcdev)
@@ -723,7 +780,6 @@ static void serial_ir_exit(void)
 
 static int __init serial_ir_init_module(void)
 {
-	struct rc_dev *rcdev;
 	int result;
 
 	switch (type) {
@@ -754,63 +810,9 @@ static int __init serial_ir_init_module(void)
 		sense = !!sense;
 
 	result = serial_ir_init();
-	if (result)
-		return result;
-
-	rcdev = devm_rc_allocate_device(&serial_ir.pdev->dev, RC_DRIVER_IR_RAW);
-	if (!rcdev) {
-		result = -ENOMEM;
-		goto serial_cleanup;
-	}
-
-	if (hardware[type].send_pulse && hardware[type].send_space)
-		rcdev->tx_ir = serial_ir_tx;
-	if (hardware[type].set_send_carrier)
-		rcdev->s_tx_carrier = serial_ir_tx_carrier;
-	if (hardware[type].set_duty_cycle)
-		rcdev->s_tx_duty_cycle = serial_ir_tx_duty_cycle;
-
-	switch (type) {
-	case IR_HOMEBREW:
-		rcdev->input_name = "Serial IR type home-brew";
-		break;
-	case IR_IRDEO:
-		rcdev->input_name = "Serial IR type IRdeo";
-		break;
-	case IR_IRDEO_REMOTE:
-		rcdev->input_name = "Serial IR type IRdeo remote";
-		break;
-	case IR_ANIMAX:
-		rcdev->input_name = "Serial IR type AnimaX";
-		break;
-	case IR_IGOR:
-		rcdev->input_name = "Serial IR type IgorPlug";
-		break;
-	}
-
-	rcdev->input_phys = KBUILD_MODNAME "/input0";
-	rcdev->input_id.bustype = BUS_HOST;
-	rcdev->input_id.vendor = 0x0001;
-	rcdev->input_id.product = 0x0001;
-	rcdev->input_id.version = 0x0100;
-	rcdev->open = serial_ir_open;
-	rcdev->close = serial_ir_close;
-	rcdev->dev.parent = &serial_ir.pdev->dev;
-	rcdev->allowed_protocols = RC_BIT_ALL_IR_DECODER;
-	rcdev->driver_name = KBUILD_MODNAME;
-	rcdev->map_name = RC_MAP_RC6_MCE;
-	rcdev->min_timeout = 1;
-	rcdev->timeout = IR_DEFAULT_TIMEOUT;
-	rcdev->max_timeout = 10 * IR_DEFAULT_TIMEOUT;
-	rcdev->rx_resolution = 250000;
-
-	serial_ir.rcdev = rcdev;
-
-	result = rc_register_device(rcdev);
-
 	if (!result)
 		return 0;
-serial_cleanup:
+
 	serial_ir_exit();
 	return result;
 }
@@ -818,7 +820,6 @@ static int __init serial_ir_init_module(void)
 static void __exit serial_ir_exit_module(void)
 {
 	del_timer_sync(&serial_ir.timeout_timer);
-	rc_unregister_device(serial_ir.rcdev);
 	serial_ir_exit();
 }
 
-- 
2.9.3
