From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 18/21] input: ti_am335x_tsc: ACK the HW_PEN irq in ISR
Date: Wed, 12 Jun 2013 18:58:19 +0200
Message-ID: <1371056302-12714-19-git-send-email-bigeasy@linutronix.de>
References: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

The interrupt source IRQENB_HW_PEN is enabled in suspend and suposed to
be used as a wake up source. Once this interrupt source is unmaksed, the
devices ends up in ISR and never continues.
This change ACKs the interrupt and disables it so the system does not
freeze.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 1bceb25..2ba7703 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -308,6 +308,12 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 		irqclr |= IRQENB_PENUP;
 	}
 
+	if (status & IRQENB_HW_PEN) {
+
+		titsc_writel(ts_dev, REG_IRQWAKEUP, 0x00);
+		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
+	}
+
 	titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
 
 	am335x_tsc_se_update(ts_dev->mfd_tscadc);
-- 
1.7.10.4

