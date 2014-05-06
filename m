From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] mfd: twl6040: Correct HPPLL configuration for 19.2 and 38.4 MHz mclk
Date: Tue, 6 May 2014 11:46:10 +0300
Message-ID: <1399365970-19543-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47021 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934374AbaEFIqQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 04:46:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com

When the MCLK is 19.2 or 38.4 MHz the HPPLL need to be enabled and can be
put in bypass mode.
This will fix HPPLL use on boards with 19.2MHz mclk.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 12b314ea48dc..ae26d84b3a59 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -441,12 +441,9 @@ int twl6040_set_pll(struct twl6040 *twl6040, int pll_id,
 					    TWL6040_HPLLENA;
 				break;
 			case 19200000:
-				/*
-				* PLL disabled
-				* (enable PLL if MCLK jitter quality
-				*  doesn't meet specification)
-				*/
-				hppllctl |= TWL6040_MCLK_19200KHZ;
+				/* PLL enabled, bypass mode */
+				hppllctl |= TWL6040_MCLK_19200KHZ |
+					    TWL6040_HPLLBP | TWL6040_HPLLENA;
 				break;
 			case 26000000:
 				/* PLL enabled, active mode */
@@ -454,9 +451,9 @@ int twl6040_set_pll(struct twl6040 *twl6040, int pll_id,
 					    TWL6040_HPLLENA;
 				break;
 			case 38400000:
-				/* PLL enabled, active mode */
+				/* PLL enabled, bypass mode */
 				hppllctl |= TWL6040_MCLK_38400KHZ |
-					    TWL6040_HPLLENA;
+					    TWL6040_HPLLBP | TWL6040_HPLLENA;
 				break;
 			default:
 				dev_err(twl6040->dev,
-- 
1.9.2

