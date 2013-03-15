From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 25/50] staging: omap-thermal: rewrite omap_bandgap_mcelsius_to_adc on kernel coding style
Date: Fri, 15 Mar 2013 09:00:13 -0400
Message-ID: <1363352438-15935-26-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Follow Documentation/CodingStyle while doing omap_bandgap_mcelsius_to_adc

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index d5359e3..e49a115 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -270,14 +270,16 @@ int omap_bandgap_mcelsius_to_adc(struct omap_bandgap *bg_ptr, int i, long temp,
 {
 	struct temp_sensor_data *ts_data = bg_ptr->conf->sensors[i].ts_data;
 	const int *conv_table = bg_ptr->conf->conv_table;
-	int high, low, mid;
+	int high, low, mid, ret = 0;
 
 	low = 0;
 	high = ts_data->adc_end_val - ts_data->adc_start_val;
 	mid = (high + low) / 2;
 
-	if (temp < conv_table[low] || temp > conv_table[high])
-		return -EINVAL;
+	if (temp < conv_table[low] || temp > conv_table[high]) {
+		ret = -ERANGE;
+		goto exit;
+	}
 
 	while (low < high) {
 		if (temp < conv_table[mid])
@@ -289,7 +291,8 @@ int omap_bandgap_mcelsius_to_adc(struct omap_bandgap *bg_ptr, int i, long temp,
 
 	*adc = ts_data->adc_start_val + low;
 
-	return 0;
+exit:
+	return ret;
 }
 
 /* Talert masks. Call it only if HAS(TALERT) is set */
-- 
1.7.7.1.488.ge8e1c
