From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 2/6] input: touchscreen: ti_am335x_tsc: Remove udelay in interrupt handler
Date: Fri, 14 Nov 2014 10:37:27 +0530
Message-ID: <1415941651-28962-3-git-send-email-vigneshr@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415941651-28962-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>

TSC interrupt handler had udelay to avoid reporting of false pen-up
interrupt to user space. This patch implements workaround suggesting in
Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay
and touchscreen lag. This also improves performance of touchscreen and
eliminates sudden jump of cursor at touch release.

IDLECONFIG and CHARGECONFIG registers are to be configured
with same values in order to eliminate false pen-up events. This
workaround may result in false pen-down to be detected, hence considerable
charge step delay needs to be added. The charge delay is set to 0xB000
(in terms of ADC clock cycles) by default.

TSC steps are disabled at the end of every sampling cycle and EOS bit is
set. Once the EOS bit is set, the TSC steps need to be re-enabled to begin
next sampling cycle.

Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
[vigneshr-l0cyMroinI0@public.gmane.org: Ported the patch from v3.12 to v3.18rc2]

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

v4:
 - check for PEN_IRQ bit in ADCFSM to avoid false-pen when ADC
   and TSC are used together.
 - Set charge delay to 0x400 as default. Most devices function
   normally at this value.

 drivers/input/touchscreen/ti_am335x_tsc.c | 63 ++++++++++++++-----------------
 include/linux/mfd/ti_am335x_tscadc.h      |  3 +-
 2 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 1aeac9675fe7..b94719fc8849 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -173,11 +173,9 @@ static void titsc_step_config(struct titsc *ts_dev)
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
 
-	/* Charge step configuration */
-	config = ts_dev->bit_xp | ts_dev->bit_yn |
-			STEPCHARGE_RFP_XPUL | STEPCHARGE_RFM_XNUR |
-			STEPCHARGE_INM_AN1 | STEPCHARGE_INP(ts_dev->inp_yp);
+	/* Make CHARGECONFIG same as IDLECONFIG */
 
+	config = titsc_readl(ts_dev, REG_IDLECONFIG);
 	titsc_writel(ts_dev, REG_CHARGECONFIG, config);
 	titsc_writel(ts_dev, REG_CHARGEDELAY, CHARGEDLY_OPENDLY);
 
@@ -261,12 +259,34 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 {
 	struct titsc *ts_dev = dev;
 	struct input_dev *input_dev = ts_dev->input;
-	unsigned int status, irqclr = 0;
+	unsigned int fsm, status, irqclr = 0;
 	unsigned int x = 0, y = 0;
 	unsigned int z1, z2, z;
-	unsigned int fsm;
 
-	status = titsc_readl(ts_dev, REG_IRQSTATUS);
+	status = titsc_readl(ts_dev, REG_RAWIRQSTATUS);
+	if (status & IRQENB_HW_PEN) {
+		ts_dev->pen_down = true;
+		titsc_writel(ts_dev, REG_IRQWAKEUP, 0x00);
+		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
+		irqclr |= IRQENB_HW_PEN;
+	}
+
+	if (status & IRQENB_PENUP) {
+		fsm = titsc_readl(ts_dev, REG_ADCFSM);
+		if (fsm == ADCFSM_STEPID) {
+			ts_dev->pen_down = false;
+			input_report_key(input_dev, BTN_TOUCH, 0);
+			input_report_abs(input_dev, ABS_PRESSURE, 0);
+			input_sync(input_dev);
+		} else {
+			ts_dev->pen_down = true;
+		}
+		irqclr |= IRQENB_PENUP;
+	}
+
+	if (status & IRQENB_EOS)
+		irqclr |= IRQENB_EOS;
+
 	/*
 	 * ADC and touchscreen share the IRQ line.
 	 * FIFO1 interrupts are used by ADC. Handle FIFO0 IRQs here only
@@ -297,34 +317,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		}
 		irqclr |= IRQENB_FIFO0THRES;
 	}
-
-	/*
-	 * Time for sequencer to settle, to read
-	 * correct state of the sequencer.
-	 */
-	udelay(SEQ_SETTLE);
-
-	status = titsc_readl(ts_dev, REG_RAWIRQSTATUS);
-	if (status & IRQENB_PENUP) {
-		/* Pen up event */
-		fsm = titsc_readl(ts_dev, REG_ADCFSM);
-		if (fsm == ADCFSM_STEPID) {
-			ts_dev->pen_down = false;
-			input_report_key(input_dev, BTN_TOUCH, 0);
-			input_report_abs(input_dev, ABS_PRESSURE, 0);
-			input_sync(input_dev);
-		} else {
-			ts_dev->pen_down = true;
-		}
-		irqclr |= IRQENB_PENUP;
-	}
-
-	if (status & IRQENB_HW_PEN) {
-
-		titsc_writel(ts_dev, REG_IRQWAKEUP, 0x00);
-		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
-	}
-
 	if (irqclr) {
 		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
 		am335x_tsc_se_set_cache(ts_dev->mfd_tscadc, ts_dev->step_mask);
@@ -417,6 +409,7 @@ static int titsc_probe(struct platform_device *pdev)
 	}
 
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
+	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
 	err = titsc_config_wires(ts_dev);
 	if (err) {
 		dev_err(&pdev->dev, "wrong i/p wire configuration\n");
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index e2e70053470e..3f4e994ace2b 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -52,6 +52,7 @@
 
 /* IRQ enable */
 #define IRQENB_HW_PEN		BIT(0)
+#define IRQENB_EOS		BIT(1)
 #define IRQENB_FIFO0THRES	BIT(2)
 #define IRQENB_FIFO0OVRRUN	BIT(3)
 #define IRQENB_FIFO0UNDRFLW	BIT(4)
@@ -107,7 +108,7 @@
 /* Charge delay */
 #define CHARGEDLY_OPEN_MASK	(0x3FFFF << 0)
 #define CHARGEDLY_OPEN(val)	((val) << 0)
-#define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(1)
+#define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(0x400)
 
 /* Control register */
 #define CNTRLREG_TSCSSENB	BIT(0)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
