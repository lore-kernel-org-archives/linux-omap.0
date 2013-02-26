From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 13/15] staging: omap-thermal: Remove double conv_table
 reference
Date: Tue, 26 Feb 2013 18:53:36 -0400
Message-ID: <1361919218-9788-14-git-send-email-eduardo.valentin@ti.com>
References: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch removes from data structure the double reference of
the conversion table. It keeps the reference coming from bandgap
data definition. The patch also adapts the code accordingly.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    8 ++++----
 drivers/staging/omap-thermal/omap-bandgap.h |    1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 82ad5db..83f74f4 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -179,7 +179,7 @@ int adc_to_temp_conversion(struct omap_bandgap *bg_ptr, int id, int adc_val,
 	if (adc_val < ts_data->adc_start_val || adc_val > ts_data->adc_end_val)
 		return -ERANGE;
 
-	*t = bg_ptr->conv_table[adc_val - ts_data->adc_start_val];
+	*t = bg_ptr->conf->conv_table[adc_val - ts_data->adc_start_val];
 
 	return 0;
 }
@@ -188,17 +188,18 @@ static int temp_to_adc_conversion(long temp, struct omap_bandgap *bg_ptr, int i,
 				  int *adc)
 {
 	struct temp_sensor_data *ts_data = bg_ptr->conf->sensors[i].ts_data;
+	const int *conv_table = bg_ptr->conf->conv_table;
 	int high, low, mid;
 
 	low = 0;
 	high = ts_data->adc_end_val - ts_data->adc_start_val;
 	mid = (high + low) / 2;
 
-	if (temp < bg_ptr->conv_table[low] || temp > bg_ptr->conv_table[high])
+	if (temp < conv_table[low] || temp > conv_table[high])
 		return -EINVAL;
 
 	while (low < high) {
-		if (temp < bg_ptr->conv_table[mid])
+		if (temp < conv_table[mid])
 			high = mid - 1;
 		else
 			low = mid + 1;
@@ -911,7 +912,6 @@ int omap_bandgap_probe(struct platform_device *pdev)
 		goto free_irqs;
 	}
 
-	bg_ptr->conv_table = bg_ptr->conf->conv_table;
 	for (i = 0; i < bg_ptr->conf->sensor_count; i++) {
 		struct temp_sensor_registers *tsr;
 		u32 val;
diff --git a/drivers/staging/omap-thermal/omap-bandgap.h b/drivers/staging/omap-thermal/omap-bandgap.h
index 59c9ba2..3e9072c 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.h
+++ b/drivers/staging/omap-thermal/omap-bandgap.h
@@ -369,7 +369,6 @@ struct omap_bandgap {
 	struct omap_bandgap_data	*conf;
 	struct clk			*fclock;
 	struct clk			*div_clk;
-	const int			*conv_table;
 	struct mutex			bg_mutex; /* Mutex for irq and PM */
 	int				irq;
 	int				tshut_gpio;
-- 
1.7.7.1.488.ge8e1c
