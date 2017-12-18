From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] pwm: omap-dmtimer: Fix frequency when using prescaler
Date: Mon, 18 Dec 2017 12:38:41 +0100
Message-ID: <20171218113841.GA18801@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, t-kristo@ti.com, j-keerthy@ti.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Prescaler setting is currently not taken into account.
Fix that by introducing freq member variable and initialize
it at device probe time. This also avoids frequency
recomputing at each pwm configure time.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/pwm/pwm-omap-dmtimer.c | 66 +++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 3b27aff585b7..0a23d1c1b153 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -40,6 +40,7 @@ struct pwm_omap_dmtimer_chip {
 	pwm_omap_dmtimer *dm_timer;
 	struct omap_dm_timer_ops *pdata;
 	struct platform_device *dm_timer_pdev;
+	unsigned long freq;
 };
 
 static inline struct pwm_omap_dmtimer_chip *
@@ -99,8 +100,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 	u32 period_cycles, duty_cycles;
 	u32 load_value, match_value;
-	struct clk *fclk;
-	unsigned long clk_rate;
 	bool timer_active;
 
 	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
@@ -114,19 +113,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 		return 0;
 	}
 
-	fclk = omap->pdata->get_fclk(omap->dm_timer);
-	if (!fclk) {
-		dev_err(chip->dev, "invalid pmtimer fclk\n");
-		goto err_einval;
-	}
-
-	clk_rate = clk_get_rate(fclk);
-	if (!clk_rate) {
-		dev_err(chip->dev, "invalid pmtimer fclk rate\n");
-		goto err_einval;
-	}
-
-	dev_dbg(chip->dev, "clk rate: %luHz\n", clk_rate);
 
 	/*
 	 * Calculate the appropriate load and match values based on the
@@ -144,35 +130,35 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	 *   OMAP4430/60/70 TRM sections 22.2.4.10 and 22.2.4.11
 	 *   AM335x Sitara TRM sections 20.1.3.5 and 20.1.3.6
 	 */
-	period_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, period_ns);
-	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, duty_ns);
+	period_cycles = pwm_omap_dmtimer_get_clock_cycles(omap->freq, period_ns);
+	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(omap->freq, duty_ns);
 
 	if (period_cycles < 2) {
 		dev_info(chip->dev,
 			 "period %d ns too short for clock rate %lu Hz\n",
-			 period_ns, clk_rate);
+			 period_ns, omap->freq);
 		goto err_einval;
 	}
 
 	if (duty_cycles < 1) {
 		dev_dbg(chip->dev,
 			"duty cycle %d ns is too short for clock rate %lu Hz\n",
-			duty_ns, clk_rate);
+			duty_ns, omap->freq);
 		dev_dbg(chip->dev, "using minimum of 1 clock cycle\n");
 		duty_cycles = 1;
 	} else if (duty_cycles >= period_cycles) {
 		dev_dbg(chip->dev,
 			"duty cycle %d ns is too long for period %d ns at clock rate %lu Hz\n",
-			duty_ns, period_ns, clk_rate);
+			duty_ns, period_ns, omap->freq);
 		dev_dbg(chip->dev, "using maximum of 1 clock cycle less than period\n");
 		duty_cycles = period_cycles - 1;
 	}
 
 	dev_dbg(chip->dev, "effective duty cycle: %lld ns, period: %lld ns\n",
 		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * duty_cycles,
-				      clk_rate),
+				      omap->freq),
 		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * period_cycles,
-				      clk_rate));
+				      omap->freq));
 
 	load_value = (DM_TIMER_MAX - period_cycles) + 1;
 	match_value = load_value + duty_cycles - 1;
@@ -248,6 +234,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	struct dmtimer_platform_data *timer_pdata;
 	struct omap_dm_timer_ops *pdata;
 	pwm_omap_dmtimer *dm_timer;
+	struct clk *fclk;
 	u32 v;
 	int status;
 
@@ -311,12 +298,37 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
 		omap->pdata->stop(omap->dm_timer);
 
-	if (!of_property_read_u32(pdev->dev.of_node, "ti,prescaler", &v))
-		omap->pdata->set_prescaler(omap->dm_timer, v);
-
 	/* setup dmtimer clock source */
-	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v))
-		omap->pdata->set_source(omap->dm_timer, v);
+	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v)) {
+		status = omap->pdata->set_source(omap->dm_timer, v);
+		if (status) {
+			dev_err(&pdev->dev, "invalid clock-source\n");
+			return status;
+		}
+	}
+
+	fclk = omap->pdata->get_fclk(omap->dm_timer);
+	if (!fclk) {
+		dev_err(&pdev->dev, "invalid fclk\n");
+		return -EINVAL;
+	}
+
+	omap->freq = clk_get_rate(fclk);
+	if (!omap->freq) {
+		dev_err(&pdev->dev, "invalid fclk rate\n");
+		return -EINVAL;
+	}
+
+	if (!of_property_read_u32(pdev->dev.of_node, "ti,prescaler", &v)) {
+		status = omap->pdata->set_prescaler(omap->dm_timer, v);
+		if (status) {
+			dev_err(&pdev->dev, "invalid prescaler\n");
+			return status;
+		}
+		omap->freq >>= v + 1;
+	}
+
+	dev_dbg(&pdev->dev, "clk rate: %luHz\n", omap->freq);
 
 	omap->chip.dev = &pdev->dev;
 	omap->chip.ops = &pwm_omap_dmtimer_ops;
-- 
2.15.1
