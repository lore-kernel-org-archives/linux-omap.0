From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 13/14] staging: ti-soc-thermal:Introduce ti_bandgap_get_trend function for OMAP5
Date: Mon, 1 Apr 2013 12:04:45 -0400
Message-ID: <1364832286-17304-14-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy@ti.com>

The patch adds ti_bandgap_get_trend function. This is specific
to OMAP5 for now it computes the trend from the temp values stored
in the hardware history buffer.

Formula: (T1 - T2) / P.

Where:
                T1: Last read valid temperature.
                T2: Last but one read valid temperature.
                P:  Update Interval.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-bandgap.c |   67 +++++++++++++++++++++++++++
 drivers/staging/ti-soc-thermal/ti-bandgap.h |    1 +
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.c b/drivers/staging/ti-soc-thermal/ti-bandgap.c
index cc0c4ba..5b06b12 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.c
@@ -962,6 +962,73 @@ static int ti_bandgap_set_continuous_mode(struct ti_bandgap *bgp)
 }
 
 /**
+ * ti_bandgap_get_trend() - To fetch the temperature trend of a sensor
+ * @bgp: pointer to struct ti_bandgap
+ * @id: id of the individual sensor
+ * @trend: Pointer to trend.
+ *
+ * This function needs to be called to fetch the temperature trend of a
+ * Particular sensor. The function computes the difference in temperature
+ * w.r.t time. For the bandgaps with built in history buffer the temperatures
+ * are read from the buffer and for those without the Buffer -ENOTSUPP is
+ * returned.
+ *
+ * Return: 0 if no error, else return corresponding error. If no
+ *		error then the trend value is passed on to trend parameter
+ */
+int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend)
+{
+	struct temp_sensor_registers *tsr;
+	u32 temp1, temp2, reg1, reg2;
+	int t1, t2, interval, ret = 0;
+
+	ret = ti_bandgap_validate(bgp, id);
+	if (ret)
+		goto exit;
+
+	if (!TI_BANDGAP_HAS(bgp, HISTORY_BUFFER) ||
+	    !TI_BANDGAP_HAS(bgp, FREEZE_BIT)) {
+		ret = -ENOTSUPP;
+		goto exit;
+	}
+
+	tsr = bgp->conf->sensors[id].registers;
+
+	/* Freeze and read the last 2 valid readings */
+	reg1 = tsr->ctrl_dtemp_1;
+	reg2 = tsr->ctrl_dtemp_2;
+
+	/* read temperature from history buffer */
+	temp1 = ti_bandgap_readl(bgp, reg1);
+	temp1 &= tsr->bgap_dtemp_mask;
+
+	temp2 = ti_bandgap_readl(bgp, reg2);
+	temp2 &= tsr->bgap_dtemp_mask;
+
+	/* Convert from adc values to mCelsius temperature */
+	ret = ti_bandgap_adc_to_mcelsius(bgp, temp1, &t1);
+	if (ret)
+		goto exit;
+
+	ret = ti_bandgap_adc_to_mcelsius(bgp, temp2, &t2);
+	if (ret)
+		goto exit;
+
+	/* Fetch the update interval */
+	ret = ti_bandgap_read_update_interval(bgp, id, &interval);
+	if (ret || !interval)
+		goto exit;
+
+	*trend = (t1 - t2) / interval;
+
+	dev_dbg(bgp->dev, "The temperatures are t1 = %d and t2 = %d and trend =%d\n",
+		t1, t2, *trend);
+
+exit:
+	return ret;
+}
+
+/**
  * ti_bandgap_tshut_init() - setup and initialize tshut handling
  * @bgp: pointer to struct ti_bandgap
  * @pdev: pointer to device struct platform_device
diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.h b/drivers/staging/ti-soc-thermal/ti-bandgap.h
index e29e357..5f4794a 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.h
@@ -382,6 +382,7 @@ int ti_bandgap_read_temperature(struct ti_bandgap *bgp, int id,
 				  int *temperature);
 int ti_bandgap_set_sensor_data(struct ti_bandgap *bgp, int id, void *data);
 void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id);
+int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend);
 
 #ifdef CONFIG_OMAP4_THERMAL
 extern const struct ti_bandgap_data omap4430_data;
-- 
1.7.7.1.488.ge8e1c

