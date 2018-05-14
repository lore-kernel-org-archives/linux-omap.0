From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 03/14] thermal: ti-soc-thermal: fix comments in
 omap4-thermal-data.c
Date: Mon, 14 May 2018 13:42:10 +0200
Message-ID: <1526298141-14045-4-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114312epcas1p19fffd35baae3018f47df0fe31ca1b1b0@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

The comments about ADC code values are incorrect. Fix them.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index c12211e..85ba9dc 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -46,7 +46,7 @@
 
 /*
  * Temperature values in milli degree celsius
- * ADC code values from 530 to 923
+ * ADC code values from 0 to 127
  */
 static const int
 omap4430_adc_to_temp[OMAP4430_ADC_END_VALUE - OMAP4430_ADC_START_VALUE + 1] = {
@@ -136,7 +136,7 @@
 
 /*
  * Temperature values in milli degree celsius
- * ADC code values from 530 to 923
+ * ADC code values from 530 to 932
  */
 static const int
 omap4460_adc_to_temp[OMAP4460_ADC_END_VALUE - OMAP4460_ADC_START_VALUE + 1] = {
-- 
1.9.1
