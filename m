From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/1] staging: omap-thermal: bandgap: fix setting of alert thresholds
Date: Wed, 19 Sep 2012 20:07:49 +0300
Message-ID: <1348074469-1361-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b-cousson@ti.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Radhesh Fadnis <radhesh.fadnis@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Radhesh Fadnis <radhesh.fadnis@ti.com>

There was an error in check for the valid temperature in
function temp_to_adc_conversion. The temperature value was
compared with higher limit for less than condition as well,
resulting in returning -EINVAL. Corrected the check condition
to properly check for lower and higher temperature limits.

Signed-off-by: Radhesh Fadnis <radhesh.fadnis@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index ff93c15..368a2e1 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -157,7 +157,7 @@ static int temp_to_adc_conversion(long temp, struct omap_bandgap *bg_ptr, int i,
 	high = ts_data->adc_end_val - ts_data->adc_start_val;
 	mid = (high + low) / 2;
 
-	if (temp < bg_ptr->conv_table[high] || temp > bg_ptr->conv_table[high])
+	if (temp < bg_ptr->conv_table[low] || temp > bg_ptr->conv_table[high])
 		return -EINVAL;
 
 	while (low < high) {
-- 
1.7.7.1.488.ge8e1c
