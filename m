From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 3/3] Input: ti_am335x_tsc - Prevent system suspend when TSC is in use
Date: Tue, 24 Apr 2018 11:57:41 +0530
Message-ID: <20180424062741.7891-4-vigneshr@ti.com>
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

Prevent system suspend while user has finger on touch screen,
because TSC is wakeup source and suspending device while in use will
result in failure to disable the module.
This patch uses pm_stay_awake() and pm_relax() APIs to prevent and
resume system suspend as required.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v3: No change

 drivers/input/touchscreen/ti_am335x_tsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index a548b0dbe320..ae6fc9099636 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -277,6 +277,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	if (status & IRQENB_HW_PEN) {
 		ts_dev->pen_down = true;
 		irqclr |= IRQENB_HW_PEN;
+		pm_stay_awake(ts_dev->mfd_tscadc->dev);
 	}
 
 	if (status & IRQENB_PENUP) {
@@ -286,6 +287,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			input_report_key(input_dev, BTN_TOUCH, 0);
 			input_report_abs(input_dev, ABS_PRESSURE, 0);
 			input_sync(input_dev);
+			pm_relax(ts_dev->mfd_tscadc->dev);
 		} else {
 			ts_dev->pen_down = true;
 		}
@@ -524,6 +526,7 @@ static int __maybe_unused titsc_resume(struct device *dev)
 		titsc_writel(ts_dev, REG_IRQWAKEUP,
 				0x00);
 		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
+		pm_relax(ts_dev->mfd_tscadc->dev);
 	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
-- 
2.17.0
