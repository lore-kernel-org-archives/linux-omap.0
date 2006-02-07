From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Convert drivers to new irq trigger modes
Date: Tue, 07 Feb 2006 18:32:58 +0100
Message-ID: <43E8D9CA.8000204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030501010004030508030503"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

This is a multi-part message in MIME format.
--------------030501010004030508030503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Convert drivers to new irq trigger modes.

New way to handle irq trigger mode is to pass it as flag to
request_irq()  instead of using special ARM function
set_irq_mode().

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------030501010004030508030503
Content-Type: text/x-patch;
 name="new_irq_model.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new_irq_model.patch"

--- ./drivers/i2c/chips/isp1301_omap.c_orig	2006-02-07 17:34:40.000000000 +0100
+++ ./drivers/i2c/chips/isp1301_omap.c	2006-02-07 18:03:24.000000000 +0100
@@ -60,6 +60,7 @@ struct isp1301 {
 	void			(*i2c_release)(struct device *dev);
 
 	int			irq;
+	int			irq_type;
 
 	u32			last_otg_ctrl;
 	unsigned		working:1;
@@ -1526,6 +1527,7 @@ static int isp1301_probe(struct i2c_adap
 	isp->timer.data = (unsigned long) isp;
 
 	isp->irq = -1;
+	isp->irq_type = SA_SAMPLE_RANDOM;
 	isp->client.addr = address;
 	i2c_set_clientdata(&isp->client, isp);
 	isp->client.adapter = bus;
@@ -1602,7 +1604,7 @@ fail1:
 		isp->irq = OMAP_GPIO_IRQ(2);
 		omap_request_gpio(2);
 		omap_set_gpio_direction(2, 1);
-		set_irq_type(isp->irq, IRQT_FALLING);
+		isp->irq_type = SA_TRIGGER_FALLING;
 	}
 
 	if (machine_is_omap_h3()) {
@@ -1611,11 +1613,11 @@ fail1:
 		isp->irq = OMAP_GPIO_IRQ(14);
 		omap_request_gpio(14);
 		omap_set_gpio_direction(14, 1);
-		set_irq_type(isp->irq, IRQT_FALLING);
+		isp->irq_type = SA_TRIGGER_FALLING;
 	}
 
 	status = request_irq(isp->irq, isp1301_irq,
-			SA_SAMPLE_RANDOM, DRIVER_NAME, isp);
+			isp->irq_type, DRIVER_NAME, isp);
 	if (status < 0) {
 		dev_dbg(&i2c->dev, "can't get IRQ %d, err %d\n",
 				isp->irq, status);
--- ./drivers/i2c/chips/tps65010.c_orig	2006-02-07 17:48:49.000000000 +0100
+++ ./drivers/i2c/chips/tps65010.c	2006-02-07 17:52:58.000000000 +0100
@@ -87,6 +87,7 @@ struct tps65010 {
 	struct i2c_client	client;
 	struct semaphore	lock;
 	int			irq;
+	int			irq_type;
 	struct work_struct	work;
 	struct dentry		*file;
 	unsigned		charging:1;
@@ -526,6 +527,8 @@ fail1:
 		return 0;
 	}
 
+	tps->irq_type = SA_SAMPLE_RANDOM;
+
 #ifdef	CONFIG_ARM
 	if (machine_is_omap_h2()) {
 		tps->model = TPS65010;
@@ -533,7 +536,7 @@ fail1:
 		tps->irq = OMAP_GPIO_IRQ(58);
 		omap_request_gpio(58);
 		omap_set_gpio_direction(58, 1);
-		set_irq_type(tps->irq, IRQT_FALLING);
+		tps->irq_type = SA_TRIGGER_FALLING;
 	}
 	if (machine_is_omap_osk()) {
 		tps->model = TPS65010;
@@ -541,21 +544,18 @@ fail1:
 		tps->irq = OMAP_GPIO_IRQ(OMAP_MPUIO(1));
 		omap_request_gpio(OMAP_MPUIO(1));
 		omap_set_gpio_direction(OMAP_MPUIO(1), 1);
-		set_irq_type(tps->irq, IRQT_FALLING);
+		tps->irq_type = SA_TRIGGER_FALLING;
 	}
 	if (machine_is_omap_h3()) {
 		tps->model = TPS65013;
 
 		// FIXME set up this board's IRQ ...
 	}
-#else
-#define set_irq_type(num,trigger)	do{}while(0)
 #endif
 
 	if (tps->irq > 0) {
-		set_irq_type(tps->irq, IRQT_LOW);
 		status = request_irq(tps->irq, tps65010_irq,
-			SA_SAMPLE_RANDOM, DRIVER_NAME, tps);
+			 tps->irq_type, DRIVER_NAME, tps);
 		if (status < 0) {
 			dev_dbg(&tps->client.dev, "can't get IRQ %d, err %d\n",
 					tps->irq, status);
--- ./drivers/mmc/omap.c_orig	2006-02-07 17:27:38.000000000 +0100
+++ ./drivers/mmc/omap.c	2006-02-07 17:30:27.000000000 +0100
@@ -1262,9 +1262,8 @@ static int __init mmc_omap_probe(struct 
 		}
 
 		omap_set_gpio_direction(host->switch_pin, 1);
-		set_irq_type(OMAP_GPIO_IRQ(host->switch_pin), IRQT_RISING);
 		ret = request_irq(OMAP_GPIO_IRQ(host->switch_pin),
-				  mmc_omap_switch_irq, 0, DRIVER_NAME, host);
+				  mmc_omap_switch_irq, SA_TRIGGER_RISING, DRIVER_NAME, host);
 		if (ret) {
 			printk(KERN_WARNING "MMC%d: Unable to get IRQ for MMC cover switch\n",
 			       host->id);
--- ./drivers/input/touchscreen/omap/omap_ts.c_orig	2006-02-07 17:44:24.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.c	2006-02-07 17:45:02.000000000 +0100
@@ -162,7 +162,7 @@ static int __init omap_ts_probe(struct p
 
 	/* request irq */
 	if (ts_omap.irq != -1) {
-		if (request_irq(ts_omap.irq, omap_ts_handler, 0,
+		if (request_irq(ts_omap.irq, omap_ts_handler, ts_omap.irq_type,
 				OMAP_TS_NAME, &ts_omap)) {
 			printk(KERN_ERR
 	  "omap_ts.c: Could not allocate touchscreen IRQ!\n");
--- ./drivers/input/touchscreen/omap/omap_ts.h_orig	2006-02-07 17:44:11.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.h	2006-02-07 17:45:28.000000000 +0100
@@ -46,6 +46,7 @@ struct omap_ts_t{
 	struct timer_list ts_timer;      // Timer for triggering acquisitions
 	int touched;
 	int irq;
+	int irq_type;
 	int irq_enabled;
 	struct ts_device *dev;
 	spinlock_t lock;
--- ./drivers/input/touchscreen/omap/ts_hx.c_orig	2006-02-07 17:43:20.000000000 +0100
+++ ./drivers/input/touchscreen/omap/ts_hx.c	2006-02-07 17:47:17.000000000 +0100
@@ -98,7 +98,7 @@ static int __init hx_ts_probe(struct oma
 	};
 
 	omap_set_gpio_direction(gpio, 1);
-	set_irq_type(ts->irq, IRQT_FALLING);
+	ts->irq_type = SA_TRIGGER_FALLING;
 	return 0;
 }
 
--- ./drivers/input/touchscreen/omap/ts_osk.c_orig	2006-02-07 17:43:43.000000000 +0100
+++ ./drivers/input/touchscreen/omap/ts_osk.c	2006-02-07 17:46:40.000000000 +0100
@@ -91,7 +91,7 @@ static int  __init osk_ts_probe(struct o
         omap_cfg_reg(P20_1610_GPIO4);
 	omap_request_gpio(4);
 	omap_set_gpio_direction(4, 1);
-	set_irq_type(OMAP_GPIO_IRQ(4), IRQT_FALLING);
+	ts->irq_type = SA_TRIGGER_FALLING;
 
 	ts->irq = PEN_IRQ;
 
--- ./drivers/input/touchscreen/omap/ts_inn1510.c_orig	2006-02-07 17:43:33.000000000 +0100
+++ ./drivers/input/touchscreen/omap/ts_inn1510.c	2006-02-07 17:53:40.000000000 +0100
@@ -176,6 +176,7 @@ static int __init inn1510_ts_probe(struc
 		return -ENODEV;
 
 	ts->irq = OMAP1510_INT_FPGA_TS;
+	ts->irq_type = SA_SAMPLE_RANDOM;
 	
 	return 0;
 }
--- ./drivers/input/keyboard/omap-keypad.c_orig	2006-02-07 17:32:10.000000000 +0100
+++ ./drivers/input/keyboard/omap-keypad.c	2006-02-07 17:33:32.000000000 +0100
@@ -365,10 +365,9 @@ static int __init omap_kp_probe(struct p
 		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 	} else {
 		for (i = 0; i < omap_kp->rows; i++) {
-			if (request_irq(OMAP_GPIO_IRQ(row_gpios[i]), omap_kp_interrupt, 0,
-						"omap-keypad", omap_kp) < 0)
+			if (request_irq(OMAP_GPIO_IRQ(row_gpios[i]), omap_kp_interrupt, 
+					SA_TRIGGER_FALLING, "omap-keypad", omap_kp) < 0)
 				return -EINVAL;
-			set_irq_type(OMAP_GPIO_IRQ(row_gpios[i]), IRQT_FALLING);
 		}
 	}
 







--------------030501010004030508030503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030501010004030508030503--
