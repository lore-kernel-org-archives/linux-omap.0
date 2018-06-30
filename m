From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/5] Input: ti_am335x_tsc: Mark TSC device as wakeup source
Date: Sat, 30 Jun 2018 16:03:15 +0530
Message-ID: <20180630103318.25355-3-vigneshr@ti.com>
References: <20180630103318.25355-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180630103318.25355-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Instead of TSCADC MFD device, mark TSC as wakeup source and change all
wakeup related PM calls to operate on TSC device.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index b86c1e5fbc11..a4f25a915ffc 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -46,6 +46,7 @@ static const int config_pins[] = {
 struct titsc {
 	struct input_dev	*input;
 	struct ti_tscadc_dev	*mfd_tscadc;
+	struct device		*dev;
 	unsigned int		irq;
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
@@ -276,7 +277,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	if (status & IRQENB_HW_PEN) {
 		ts_dev->pen_down = true;
 		irqclr |= IRQENB_HW_PEN;
-		pm_stay_awake(ts_dev->mfd_tscadc->dev);
+		pm_stay_awake(ts_dev->dev);
 	}
 
 	if (status & IRQENB_PENUP) {
@@ -286,7 +287,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			input_report_key(input_dev, BTN_TOUCH, 0);
 			input_report_abs(input_dev, ABS_PRESSURE, 0);
 			input_sync(input_dev);
-			pm_relax(ts_dev->mfd_tscadc->dev);
+			pm_relax(ts_dev->dev);
 		} else {
 			ts_dev->pen_down = true;
 		}
@@ -422,6 +423,7 @@ static int titsc_probe(struct platform_device *pdev)
 	ts_dev->mfd_tscadc = tscadc_dev;
 	ts_dev->input = input_dev;
 	ts_dev->irq = tscadc_dev->irq;
+	ts_dev->dev = &pdev->dev;
 
 	err = titsc_parse_dt(pdev, ts_dev);
 	if (err) {
@@ -436,6 +438,8 @@ static int titsc_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
+	device_init_wakeup(&pdev->dev, true);
+
 	titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
@@ -467,6 +471,7 @@ static int titsc_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_irq:
+	device_init_wakeup(&pdev->dev, false);
 	free_irq(ts_dev->irq, ts_dev);
 err_free_mem:
 	input_free_device(input_dev);
@@ -479,6 +484,7 @@ static int titsc_remove(struct platform_device *pdev)
 	struct titsc *ts_dev = platform_get_drvdata(pdev);
 	u32 steps;
 
+	device_init_wakeup(&pdev->dev, false);
 	free_irq(ts_dev->irq, ts_dev);
 
 	/* total steps followed by the enable mask */
@@ -499,7 +505,7 @@ static int __maybe_unused titsc_suspend(struct device *dev)
 	unsigned int idle;
 
 	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
-	if (device_may_wakeup(tscadc_dev->dev)) {
+	if (device_may_wakeup(dev)) {
 		titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
 		idle = titsc_readl(ts_dev, REG_IRQENABLE);
 		titsc_writel(ts_dev, REG_IRQENABLE,
@@ -515,11 +521,11 @@ static int __maybe_unused titsc_resume(struct device *dev)
 	struct ti_tscadc_dev *tscadc_dev;
 
 	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
-	if (device_may_wakeup(tscadc_dev->dev)) {
+	if (device_may_wakeup(dev)) {
 		titsc_writel(ts_dev, REG_IRQWAKEUP,
 				0x00);
 		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
-		pm_relax(ts_dev->mfd_tscadc->dev);
+		pm_relax(dev);
 	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
-- 
2.18.0
