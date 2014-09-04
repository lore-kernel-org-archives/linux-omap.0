From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] Input: ti_am335x_tsc: Fix incorrect step config 5 wire touschscreen
Date: Thu,  4 Sep 2014 16:39:13 +0200
Message-ID: <1409841555-11336-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Jeff Lance <j-lance1@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Jeff Lance <j-lance1@ti.com>

The step config setting for a 5 wire touchscreen is incorrectly sets the
Y coordinates.
It was broken while we moved to DT. If you look close, the change was:

|- STEPCONFIG_XNP | STEPCONFIG_YPN;
|+ ts_dev->bit_xn | ts_dev->bit_yp;

while bit_xn = STEPCONFIG_XNN and bit_yp = STEPCONFIG_YNN. Not quite the
same :)

Fixes: bb76dc09ddfc ("input: ti_am33x_tsc: Order of TSC wires, made
configurable")
Signed-off-by: Jeff Lance <j-lance1@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 2ce649520fe0..092fa8b31c67 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -157,7 +157,7 @@ static void titsc_step_config(struct titsc *ts_dev)
 		break;
 	case 5:
 		config |= ts_dev->bit_xp | STEPCONFIG_INP_AN4 |
-				ts_dev->bit_xn | ts_dev->bit_yp;
+				STEPCONFIG_XNP | STEPCONFIG_YPN;
 		break;
 	case 8:
 		config |= ts_dev->bit_yp | STEPCONFIG_INP(ts_dev->inp_xp);
-- 
2.1.0

