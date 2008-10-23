From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] OMAP2: omap-keypad: interrupt disable fix
Date: Thu, 23 Oct 2008 08:51:31 +0300
Message-ID: <1224741092-21577-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1224741092-21577-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1224741092-21577-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

The GPIO interrupts has been disabled several times
after the first key press.
No need to disable - again - the interrupts in the omap_kp_scan_keypad
function on OMAP2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/input/keyboard/omap-keypad.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index d57d2cb..d6cd79b 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -134,10 +134,6 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 
 	/* read the keypad status */
 	if (cpu_is_omap24xx()) {
-		int i;
-		for (i = 0; i < omap_kp->rows; i++)
-			disable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
-
 		/* read the keypad status */
 		for (col = 0; col < omap_kp->cols; col++) {
 			set_col_gpio_val(omap_kp, ~(1 << col));
-- 
1.5.6.4

