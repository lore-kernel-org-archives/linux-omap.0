From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 10/14] staging: ti-soc-thermal: Modify update_interval r/w functions to incorporate the OMAP5 feature of COUNTER_DELAY.
Date: Mon, 1 Apr 2013 12:04:42 -0400
Message-ID: <1364832286-17304-11-git-send-email-eduardo.valentin@ti.com>
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

Update ti_bandgap_write_update_interval and ti_bandgap_read_update_interval
functions to incorporate the OMAP5 feature of COUNTER_DELAY. The way we
program the delay between two successive temperature conversions
is different for OMAP5 as when compared with OMAP4. Incorporating
the changes required to program the delay for OMAP5.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-bandgap.c |  165 +++++++++++++++++++++++---
 1 files changed, 146 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.c b/drivers/staging/ti-soc-thermal/ti-bandgap.c
index 62ffea1..cc0c4ba 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.c
@@ -649,6 +649,68 @@ int ti_bandgap_write_tcold(struct ti_bandgap *bgp, int id, int val)
 }
 
 /**
+ * ti_bandgap_read_counter() - read the sensor counter
+ * @bgp: pointer to bandgap instance
+ * @id: sensor id
+ * @interval: resulting update interval in miliseconds
+ */
+static void ti_bandgap_read_counter(struct ti_bandgap *bgp, int id,
+				    int *interval)
+{
+	struct temp_sensor_registers *tsr;
+	int time;
+
+	tsr = bgp->conf->sensors[id].registers;
+	time = ti_bandgap_readl(bgp, tsr->bgap_counter);
+	time = (time & tsr->counter_mask) >>
+					__ffs(tsr->counter_mask);
+	time = time * 1000 / bgp->clk_rate;
+	*interval = time;
+}
+
+/**
+ * ti_bandgap_read_counter_delay() - read the sensor counter delay
+ * @bgp: pointer to bandgap instance
+ * @id: sensor id
+ * @interval: resulting update interval in miliseconds
+ */
+static void ti_bandgap_read_counter_delay(struct ti_bandgap *bgp, int id,
+					  int *interval)
+{
+	struct temp_sensor_registers *tsr;
+	int reg_val;
+
+	tsr = bgp->conf->sensors[id].registers;
+
+	reg_val = ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
+	reg_val = (reg_val & tsr->mask_counter_delay_mask) >>
+				__ffs(tsr->mask_counter_delay_mask);
+	switch (reg_val) {
+	case 0:
+		*interval = 0;
+		break;
+	case 1:
+		*interval = 1;
+		break;
+	case 2:
+		*interval = 10;
+		break;
+	case 3:
+		*interval = 100;
+		break;
+	case 4:
+		*interval = 250;
+		break;
+	case 5:
+		*interval = 500;
+		break;
+	default:
+		dev_warn(bgp->dev, "Wrong counter delay value read from register %X",
+			 reg_val);
+	}
+}
+
+/**
  * ti_bandgap_read_update_interval() - read the sensor update interval
  * @bgp: pointer to bandgap instance
  * @id: sensor id
@@ -659,28 +721,88 @@ int ti_bandgap_write_tcold(struct ti_bandgap *bgp, int id, int val)
 int ti_bandgap_read_update_interval(struct ti_bandgap *bgp, int id,
 				    int *interval)
 {
-	struct temp_sensor_registers *tsr;
-	u32 time;
-	int ret;
+	int ret = 0;
 
 	ret = ti_bandgap_validate(bgp, id);
 	if (ret)
-		return ret;
+		goto exit;
 
-	if (!TI_BANDGAP_HAS(bgp, COUNTER))
-		return -ENOTSUPP;
+	if (!TI_BANDGAP_HAS(bgp, COUNTER) &&
+	    !TI_BANDGAP_HAS(bgp, COUNTER_DELAY)) {
+		ret = -ENOTSUPP;
+		goto exit;
+	}
 
-	tsr = bgp->conf->sensors[id].registers;
-	time = ti_bandgap_readl(bgp, tsr->bgap_counter);
-	time = (time & tsr->counter_mask) >> __ffs(tsr->counter_mask);
-	time = time * 1000 / bgp->clk_rate;
+	if (TI_BANDGAP_HAS(bgp, COUNTER)) {
+		ti_bandgap_read_counter(bgp, id, interval);
+		goto exit;
+	}
 
-	*interval = time;
+	ti_bandgap_read_counter_delay(bgp, id, interval);
+exit:
+	return ret;
+}
+
+/**
+ * ti_bandgap_write_counter_delay() - set the counter_delay
+ * @bgp: pointer to bandgap instance
+ * @id: sensor id
+ * @interval: desired update interval in miliseconds
+ *
+ * Return: 0 on success or the proper error code
+ */
+static int ti_bandgap_write_counter_delay(struct ti_bandgap *bgp, int id,
+					  u32 interval)
+{
+	int rval;
+
+	switch (interval) {
+	case 0: /* Immediate conversion */
+		rval = 0x0;
+		break;
+	case 1: /* Conversion after ever 1ms */
+		rval = 0x1;
+		break;
+	case 10: /* Conversion after ever 10ms */
+		rval = 0x2;
+		break;
+	case 100: /* Conversion after ever 100ms */
+		rval = 0x3;
+		break;
+	case 250: /* Conversion after ever 250ms */
+		rval = 0x4;
+		break;
+	case 500: /* Conversion after ever 500ms */
+		rval = 0x5;
+		break;
+	default:
+		dev_warn(bgp->dev, "Delay %d ms is not supported\n", interval);
+		return -EINVAL;
+	}
+
+	spin_lock(&bgp->lock);
+	RMW_BITS(bgp, id, bgap_mask_ctrl, mask_counter_delay_mask, rval);
+	spin_unlock(&bgp->lock);
 
 	return 0;
 }
 
 /**
+ * ti_bandgap_write_counter() - set the bandgap sensor counter
+ * @bgp: pointer to bandgap instance
+ * @id: sensor id
+ * @interval: desired update interval in miliseconds
+ */
+static void ti_bandgap_write_counter(struct ti_bandgap *bgp, int id,
+				     u32 interval)
+{
+	interval = interval * bgp->clk_rate / 1000;
+	spin_lock(&bgp->lock);
+	RMW_BITS(bgp, id, bgap_counter, counter_mask, interval);
+	spin_unlock(&bgp->lock);
+}
+
+/**
  * ti_bandgap_write_update_interval() - set the update interval
  * @bgp: pointer to bandgap instance
  * @id: sensor id
@@ -693,17 +815,22 @@ int ti_bandgap_write_update_interval(struct ti_bandgap *bgp,
 {
 	int ret = ti_bandgap_validate(bgp, id);
 	if (ret)
-		return ret;
+		goto exit;
 
-	if (!TI_BANDGAP_HAS(bgp, COUNTER))
-		return -ENOTSUPP;
+	if (!TI_BANDGAP_HAS(bgp, COUNTER) &&
+	    !TI_BANDGAP_HAS(bgp, COUNTER_DELAY)) {
+		ret = -ENOTSUPP;
+		goto exit;
+	}
 
-	interval = interval * bgp->clk_rate / 1000;
-	spin_lock(&bgp->lock);
-	RMW_BITS(bgp, id, bgap_counter, counter_mask, interval);
-	spin_unlock(&bgp->lock);
+	if (TI_BANDGAP_HAS(bgp, COUNTER)) {
+		ti_bandgap_write_counter(bgp, id, interval);
+		goto exit;
+	}
 
-	return 0;
+	ret = ti_bandgap_write_counter_delay(bgp, id, interval);
+exit:
+	return ret;
 }
 
 /**
-- 
1.7.7.1.488.ge8e1c

