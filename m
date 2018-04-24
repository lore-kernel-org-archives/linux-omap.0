From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 2/3] Input: ti_am335x_tsc - Ack pending IRQs at probe and before suspend
Date: Tue, 24 Apr 2018 11:57:40 +0530
Message-ID: <20180424062741.7891-3-vigneshr@ti.com>
References: <20180424062741.7891-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424062741.7891-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vignesh R <vigneshr@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

It is seen that just enabling the TSC module triggers a HW_PEN IRQ
without any interaction with touchscreen by user. This results in first
suspend/resume sequence to fail as system immediately wakes up from
suspend as soon as HW_PEN IRQ is enabled in suspend handler due to the
pending IRQ. Therefore clear all IRQs at probe and also in suspend
callback for sanity.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v3: Clear IRQs related to TSC module only

 drivers/input/touchscreen/ti_am335x_tsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 3908c21862c7..a548b0dbe320 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -35,6 +35,8 @@
 #define SEQ_SETTLE		275
 #define MAX_12BIT		((1 << 12) - 1)
 
+#define TSC_IRQENB_MASK		(IRQENB_FIFO0THRES | IRQENB_EOS | IRQENB_HW_PEN)
+
 static const int config_pins[] = {
 	STEPCONFIG_XPP,
 	STEPCONFIG_XNN,
@@ -437,6 +439,7 @@ static int titsc_probe(struct platform_device *pdev)
 	if (err)
 		dev_err(&pdev->dev, "irq wake enable failed.\n");
 
+	titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
 	err = titsc_config_wires(ts_dev);
@@ -502,6 +505,7 @@ static int __maybe_unused titsc_suspend(struct device *dev)
 
 	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
 	if (device_may_wakeup(tscadc_dev->dev)) {
+		titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
 		idle = titsc_readl(ts_dev, REG_IRQENABLE);
 		titsc_writel(ts_dev, REG_IRQENABLE,
 				(idle | IRQENB_HW_PEN));
-- 
2.17.0
