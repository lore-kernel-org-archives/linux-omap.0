From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 09/13] MFD: twl-core: re-group the twl_mapping table for easier reading
Date: Tue, 13 Nov 2012 09:28:50 +0100
Message-ID: <1352795334-7406-10-git-send-email-peter.ujfalusi@ti.com>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Group the twl_mapping table in 5 lines chunks so it is more easier to find
the row we are looking for (if we need to).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index bb33b52..f857097 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -189,28 +189,29 @@ static struct twl_mapping twl4030_map[] = {
 	 */
 
 	{ 0, TWL4030_BASEADD_USB },
-
 	{ 1, TWL4030_BASEADD_AUDIO_VOICE },
 	{ 1, TWL4030_BASEADD_GPIO },
 	{ 1, TWL4030_BASEADD_INTBR },
 	{ 1, TWL4030_BASEADD_PIH },
-	{ 1, TWL4030_BASEADD_TEST },
 
+	{ 1, TWL4030_BASEADD_TEST },
 	{ 2, TWL4030_BASEADD_KEYPAD },
 	{ 2, TWL4030_BASEADD_MADC },
 	{ 2, TWL4030_BASEADD_INTERRUPTS },
 	{ 2, TWL4030_BASEADD_LED },
+
 	{ 2, TWL4030_BASEADD_MAIN_CHARGE },
 	{ 2, TWL4030_BASEADD_PRECHARGE },
 	{ 2, TWL4030_BASEADD_PWM0 },
 	{ 2, TWL4030_BASEADD_PWM1 },
 	{ 2, TWL4030_BASEADD_PWMA },
+
 	{ 2, TWL4030_BASEADD_PWMB },
 	{ 2, TWL5031_BASEADD_ACCESSORY },
 	{ 2, TWL5031_BASEADD_INTERRUPTS },
-
 	{ 3, TWL4030_BASEADD_BACKUP },
 	{ 3, TWL4030_BASEADD_INT },
+
 	{ 3, TWL4030_BASEADD_PM_MASTER },
 	{ 3, TWL4030_BASEADD_PM_RECEIVER },
 	{ 3, TWL4030_BASEADD_RTC },
@@ -273,9 +274,9 @@ static struct twl_mapping twl6030_map[] = {
 	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
 	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
 	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
+
 	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_MASTER },
 	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_SLAVE_MISC },
-
 	{ SUB_CHIP_ID0, TWL6030_BASEADD_RTC },
 	{ SUB_CHIP_ID0, TWL6030_BASEADD_MEM },
 	{ SUB_CHIP_ID1, TWL6025_BASEADD_CHARGER },
-- 
1.8.0
