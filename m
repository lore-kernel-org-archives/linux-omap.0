From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] OMAP2: omap-keypad: Enable more than 6 rows
Date: Thu, 23 Oct 2008 08:51:32 +0300
Message-ID: <1224741092-21577-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1224741092-21577-1-git-send-email-peter.ujfalusi@nokia.com>
 <1224741092-21577-2-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1224741092-21577-2-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

There is no reason to limit the GPIO rows to 6 for
OMAP2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/input/keyboard/omap-keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index d6cd79b..0f95046 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -137,7 +137,7 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 		/* read the keypad status */
 		for (col = 0; col < omap_kp->cols; col++) {
 			set_col_gpio_val(omap_kp, ~(1 << col));
-			state[col] = ~(get_row_gpio_val(omap_kp)) & 0x3f;
+			state[col] = ~(get_row_gpio_val(omap_kp)) & 0xff;
 		}
 		set_col_gpio_val(omap_kp, 0);
 
-- 
1.5.6.4

