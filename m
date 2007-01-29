From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Convert irq flags SA_* to IRQF_*
Date: Mon, 29 Jan 2007 13:44:27 +0100
Message-ID: <45BDEC2B.3000601@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090109020506060501010503"
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
To: linux_omap_open_source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090109020506060501010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Convert remaining interrupt flags SA_* to IRQF_* style.

Documentation/feature-removal-schedule.txt tells us:

What:    Interrupt only SA_* flags
When:    Januar 2007
Why:    The interrupt related SA_* flags are replaced by 
IRQF_* to move them
     out of the signal namespace.

and in linux/interrupt.h regarding SA_* we find

"Migration helpers. Scheduled for removal in 1/2007 Do not 
use for new code !"

Current -rt patches remove SA_* already, so seems to be time 
to convert all OMAP stuff.

In attachment there are 12 patches for this (feel free to 
regroup them):

01 plat-omap directory conversion
02 mach-omap1 directory conversion
(Note: mach-omap2 has no SA_*)
03 ads7846 conversion
04 omap-ts directory conversion
05 i2c-chips directory conversion
06 rtc-omap conversion
07 tsc2102 conversion
08 musbhsdma conversion
09 tahvo-usb conversion
10 omap-rtc conversion
11 innovator-ps2 conversion
12 omap16xxcam conversion

Cheers

Dirk


--------------090109020506060501010503
Content-Type: text/plain;
 name="01_plat_omap_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="01_plat_omap_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in plat-omap directory.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_mem.c
+++ linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -2498,7 +2498,7 @@ int __init dsp_mem_init(void)
 	/*
 	 * DSP MMU interrupt setup
 	 */
-	ret = request_irq(omap_dsp->mmu_irq, dsp_mmu_interrupt, SA_INTERRUPT,
+	ret = request_irq(omap_dsp->mmu_irq, dsp_mmu_interrupt, IRQF_DISABLED,
 			  "dsp_mmu",  &devid_mmu);
 	if (ret) {
 		printk(KERN_ERR
Index: linux-osk/arch/arm/plat-omap/gpio-switch.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/gpio-switch.c
+++ linux-osk/arch/arm/plat-omap/gpio-switch.c
@@ -301,16 +301,16 @@ static int __init new_switch(struct gpio
 		return 0;
 
 	if (can_do_both_edges(sw)) {
-		trigger = SA_TRIGGER_FALLING | SA_TRIGGER_RISING;
+		trigger = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
 		sw->both_edges = 1;
 	} else {
 		if (omap_get_gpio_datain(sw->gpio))
-			trigger = SA_TRIGGER_FALLING;
+			trigger = IRQF_TRIGGER_FALLING;
 		else
-			trigger = SA_TRIGGER_RISING;
+			trigger = IRQF_TRIGGER_RISING;
 	}
 	r = request_irq(OMAP_GPIO_IRQ(sw->gpio), gpio_sw_irq_handler,
-			SA_SHIRQ | trigger, sw->name, sw);
+			IRQF_SHIRQ | trigger, sw->name, sw);
 	if (r < 0) {
 		printk(KERN_ERR "gpio-switch: request_irq() failed "
 		       "for GPIO %d\n", sw->gpio);
Index: linux-osk/arch/arm/plat-omap/mailbox.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/mailbox.c
+++ linux-osk/arch/arm/plat-omap/mailbox.c
@@ -247,7 +247,7 @@ static int omap_mbox_init(struct omap_mb
 	if (unlikely(ret))
 		goto fail2;
 
-	ret = request_irq(mbox->irq, mbox_interrupt, SA_INTERRUPT,
+	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_DISABLED,
 			  mbox->name, mbox);
 	if (unlikely(ret)) {
 		printk(KERN_ERR
Index: linux-osk/arch/arm/plat-omap/sti/sti.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/sti/sti.c
+++ linux-osk/arch/arm/plat-omap/sti/sti.c
@@ -376,7 +376,7 @@ static int __devinit sti_probe(struct pl
 	}
 
 	ret = request_irq(platform_get_irq(pdev, 0), sti_interrupt,
-			  SA_INTERRUPT, "sti", NULL);
+			  IRQF_DISABLED, "sti", NULL);
 	if (unlikely(ret != 0))
 		goto err_badirq;
 

--------------090109020506060501010503
Content-Type: text/plain;
 name="02_mach_omap1_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="02_mach_omap1_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in mach-omap1 directory.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/arch/arm/mach-omap1/board-palmz71.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-palmz71.c
+++ linux-osk/arch/arm/mach-omap1/board-palmz71.c
@@ -342,7 +342,7 @@ palmz71_gpio_setup(int early)
 		}
 		omap_set_gpio_direction(PALMZ71_USBDETECT_GPIO, 1);
 		if (request_irq(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
-				palmz71_powercable, SA_SAMPLE_RANDOM,
+				palmz71_powercable, IRQF_SAMPLE_RANDOM,
 				"palmz71-cable", 0))
 			printk(KERN_ERR
 			       "IRQ request for power cable failed!\n");

--------------090109020506060501010503
Content-Type: text/plain;
 name="03_ads7846_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="03_ads7846_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in ads7846.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-osk.orig/drivers/input/touchscreen/ads7846.c
+++ linux-osk/drivers/input/touchscreen/ads7846.c
@@ -897,7 +897,7 @@ static int __devinit ads7846_probe(struc
 	ts->last_msg = m;
 
 	if (request_irq(spi->irq, ads7846_irq,
-			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
+			IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING,
 			spi->dev.bus_id, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		err = -EBUSY;

--------------090109020506060501010503
Content-Type: text/plain;
 name="04_omap_ts_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="04_omap_ts_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in omap-ts directory.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/input/touchscreen/omap/omap_ts.c
===================================================================
--- linux-osk.orig/drivers/input/touchscreen/omap/omap_ts.c
+++ linux-osk/drivers/input/touchscreen/omap/omap_ts.c
@@ -157,7 +157,7 @@ static int __init omap_ts_probe(struct p
 	/* request irq */
 	if (ts_omap.irq != -1) {
 		if (request_irq(ts_omap.irq, omap_ts_handler,
-				SA_SAMPLE_RANDOM | ts_omap.irq_type,
+				IRQF_SAMPLE_RANDOM | ts_omap.irq_type,
 				OMAP_TS_NAME, &ts_omap)) {
 			printk(KERN_ERR
 	  "omap_ts.c: Could not allocate touchscreen IRQ!\n");
Index: linux-osk/drivers/input/touchscreen/omap/ts_hx.c
===================================================================
--- linux-osk.orig/drivers/input/touchscreen/omap/ts_hx.c
+++ linux-osk/drivers/input/touchscreen/omap/ts_hx.c
@@ -98,7 +98,7 @@ static int __init hx_ts_probe(struct oma
 	};
 
 	omap_set_gpio_direction(gpio, 1);
-	ts->irq_type = SA_TRIGGER_FALLING;
+	ts->irq_type = IRQF_TRIGGER_FALLING;
 	return 0;
 }
 

--------------090109020506060501010503
Content-Type: text/plain;
 name="05_i2c_chips_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="05_i2c_chips_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in i2c-chips directory.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/i2c/chips/isp1301_omap.c
===================================================================
--- linux-osk.orig/drivers/i2c/chips/isp1301_omap.c
+++ linux-osk/drivers/i2c/chips/isp1301_omap.c
@@ -927,7 +927,7 @@ static int otg_bind(struct isp1301 *isp)
 
 	if (otg_dev)
 		status = request_irq(otg_dev->resource[1].start, omap_otg_irq,
-				SA_INTERRUPT, DRIVER_NAME, isp);
+				IRQF_DISABLED, DRIVER_NAME, isp);
 	else
 		status = -ENODEV;
 
@@ -1609,7 +1609,7 @@ fail1:
 		isp->irq = OMAP_GPIO_IRQ(2);
 		omap_request_gpio(2);
 		omap_set_gpio_direction(2, 1);
-		isp->irq_type = SA_TRIGGER_FALLING;
+		isp->irq_type = IRQF_TRIGGER_FALLING;
 	}
 
 	if (machine_is_omap_h3()) {
@@ -1618,7 +1618,7 @@ fail1:
 		isp->irq = OMAP_GPIO_IRQ(14);
 		omap_request_gpio(14);
 		omap_set_gpio_direction(14, 1);
-		isp->irq_type = SA_TRIGGER_FALLING;
+		isp->irq_type = IRQF_TRIGGER_FALLING;
 	}
 
 	if (machine_is_omap_h4()) {
Index: linux-osk/drivers/i2c/chips/menelaus.c
===================================================================
--- linux-osk.orig/drivers/i2c/chips/menelaus.c
+++ linux-osk/drivers/i2c/chips/menelaus.c
@@ -849,7 +849,7 @@ static int menelaus_probe(struct i2c_ada
 	/* Set output buffer strengths */
 	menelaus_write_reg(MENELAUS_MCT_CTRL1, 0x73);
 
-	err = request_irq(menelaus.irq, menelaus_irq, SA_INTERRUPT,
+	err = request_irq(menelaus.irq, menelaus_irq, IRQF_DISABLED,
 			  DRIVER_NAME, &menelaus);
 	if (err) {
 		printk(KERN_ERR "Could not get Menelaus IRQ\n");
Index: linux-osk/drivers/i2c/chips/twl4030_core.c
===================================================================
--- linux-osk.orig/drivers/i2c/chips/twl4030_core.c
+++ linux-osk/drivers/i2c/chips/twl4030_core.c
@@ -420,7 +420,7 @@ static void do_twl4030_module_irq(unsign
 				action = action->next;
 			} while (action);
 
-			if (status & SA_SAMPLE_RANDOM)
+			if (status & IRQF_SAMPLE_RANDOM)
 				add_interrupt_randomness(irq);
 
 			local_irq_disable();

--------------090109020506060501010503
Content-Type: text/plain;
 name="06_rtc_omap_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="06_rtc_omap_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in rtc-omap.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/rtc/rtc-omap.c
===================================================================
--- linux-osk.orig/drivers/rtc/rtc-omap.c
+++ linux-osk/drivers/rtc/rtc-omap.c
@@ -417,13 +417,13 @@ static int __devinit omap_rtc_probe(stru
 		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
 
 	/* handle periodic and alarm irqs */
-	if (request_irq(omap_rtc_timer, rtc_irq, SA_INTERRUPT,
+	if (request_irq(omap_rtc_timer, rtc_irq, IRQF_DISABLED,
 			rtc->class_dev.class_id, &rtc->class_dev)) {
 		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
 			pdev->name, omap_rtc_timer);
 		goto fail0;
 	}
-	if (request_irq(omap_rtc_alarm, rtc_irq, SA_INTERRUPT,
+	if (request_irq(omap_rtc_alarm, rtc_irq, IRQF_DISABLED,
 			rtc->class_dev.class_id, &rtc->class_dev)) {
 		pr_debug("%s: RTC alarm interrupt IRQ%d already claimed\n",
 			pdev->name, omap_rtc_alarm);

--------------090109020506060501010503
Content-Type: text/plain;
 name="07_tsc2102_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="07_tsc2102_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in tsc2102.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/spi/tsc2102.c
===================================================================
--- linux-osk.orig/drivers/spi/tsc2102.c
+++ linux-osk/drivers/spi/tsc2102.c
@@ -1033,8 +1033,8 @@ static int tsc2102_probe(struct spi_devi
 
 	clk_enable(tsc.bclk_ck);
 
-	if (request_irq(spi->irq, tsc2102_handler, SA_SAMPLE_RANDOM |
-				SA_TRIGGER_FALLING, "tsc2102", &tsc)) {
+	if (request_irq(spi->irq, tsc2102_handler, IRQF_SAMPLE_RANDOM |
+				IRQF_TRIGGER_FALLING, "tsc2102", &tsc)) {
 		printk(KERN_ERR "Could not allocate touchscreen IRQ!\n");
 		err = -EINVAL;
 		goto err_clk;

--------------090109020506060501010503
Content-Type: text/plain;
 name="08_musbhsdma_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="08_musbhsdma_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in musbhsdma.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/usb/musb/musbhsdma.c
===================================================================
--- linux-osk.orig/drivers/usb/musb/musbhsdma.c
+++ linux-osk/drivers/usb/musb/musbhsdma.c
@@ -382,7 +382,7 @@ dma_controller_create(struct musb *pThis
 	pController->Controller.channel_program = hsdma_channel_program;
 	pController->Controller.channel_abort = hsdma_channel_abort;
 
-	if (request_irq(irq, hsdma_irq, SA_INTERRUPT,
+	if (request_irq(irq, hsdma_irq, IRQF_DISABLED,
 			pThis->controller->bus_id, &pController->Controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
 		kfree(pController);

--------------090109020506060501010503
Content-Type: text/plain;
 name="09_tahvo_usb_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="09_tahvo_usb_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in tahvo-usb.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/cbus/tahvo-usb.c
===================================================================
--- linux-osk.orig/drivers/cbus/tahvo-usb.c
+++ linux-osk/drivers/cbus/tahvo-usb.c
@@ -188,7 +188,7 @@ static int omap_otg_probe(struct device 
 	}
 
 	return request_irq(tahvo_otg_dev->resource[1].start,
-			   omap_otg_irq, SA_INTERRUPT, DRIVER_NAME,
+			   omap_otg_irq, IRQF_DISABLED, DRIVER_NAME,
 			   &tahvo_usb_device);
 }
 

--------------090109020506060501010503
Content-Type: text/plain;
 name="10_omap_rtc_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="10_omap_rtc_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in omap-rtc.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/char/omap-rtc.c
===================================================================
--- linux-osk.orig/drivers/char/omap-rtc.c
+++ linux-osk/drivers/char/omap-rtc.c
@@ -117,7 +117,7 @@ static const unsigned char days_in_mo[] 
 {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 
 /*
- *	A very tiny interrupt handler. It runs with SA_INTERRUPT set.
+ *	A very tiny interrupt handler. It runs with IRQF_DISABLED set.
  */
 
 irqreturn_t rtc_interrupt(int irq, void *dev_id)
@@ -484,14 +484,14 @@ static int __init omap_rtc_probe(struct 
 		CMOS_WRITE(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
 	}
 
-	if (request_irq(omap_rtc_timer, rtc_interrupt, SA_INTERRUPT,
+	if (request_irq(omap_rtc_timer, rtc_interrupt, IRQF_DISABLED,
 			pdev->name, NULL)) {
 		pr_debug("%s: RTC timer interrupt IRQ%d is not free.\n",
 			pdev->name, omap_rtc_timer);
 		goto fail;
 	}
 
-	if (request_irq(omap_rtc_alarm, rtc_interrupt, SA_INTERRUPT,
+	if (request_irq(omap_rtc_alarm, rtc_interrupt, IRQF_DISABLED,
 			pdev->name, NULL)) {
 		pr_debug("%s: RTC alarm interrupt IRQ%d is not free.\n",
 			pdev->name, omap_rtc_alarm);

--------------090109020506060501010503
Content-Type: text/plain; name="11_innovator_ps2_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="11_innovator_ps2_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in innovator-ps2.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/input/keyboard/innovator_ps2.c
===================================================================
--- linux-osk.orig/drivers/input/keyboard/innovator_ps2.c
+++ linux-osk/drivers/input/keyboard/innovator_ps2.c
@@ -1108,7 +1108,7 @@ innovator_hid_open(struct input_dev *dev
 		return 0;
 
 	if (request_irq(OMAP1510_INT_FPGA_ATN, (void *) innovator_hid_interrupt,
-			SA_INTERRUPT, PFX, hid) < 0)
+			IRQF_DISABLED, PFX, hid) < 0)
 		return -EINVAL;
 
 	return 0;

--------------090109020506060501010503
Content-Type: text/plain;
 name="12_omap16xxcam_sa_irqf_conversion_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="12_omap16xxcam_sa_irqf_conversion_patch.txt"


ARM: OMAP: Convert interrupt flags SA_* to IRQF_* in omap16xxcam.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Index: linux-osk/drivers/media/video/omap/omap16xxcam.c
===================================================================
--- linux-osk.orig/drivers/media/video/omap/omap16xxcam.c
+++ linux-osk/drivers/media/video/omap/omap16xxcam.c
@@ -475,7 +475,7 @@ omap16xxcam_open(void *priv)
 	struct omap16xxcam *data = (struct omap16xxcam *) priv;
 	int ret;
 
-	if ((ret = request_irq(INT_CAMERA, omap16xx_cam_isr, SA_INTERRUPT, 
+	if ((ret = request_irq(INT_CAMERA, omap16xx_cam_isr, IRQF_DISABLED,
 					"camera", data))) {
 		printk("FAILED to aquire irq\n");
 		return ret;

--------------090109020506060501010503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090109020506060501010503--
