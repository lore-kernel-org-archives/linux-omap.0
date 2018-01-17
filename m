From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/3] pwm: pwm-omap-dmtimer: Fix frequency when using prescaler
Date: Wed, 17 Jan 2018 22:47:37 +0100
Message-ID: <20180117214737.GC11952@lenoch>
References: <20180117214629.GA11952@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180117214629.GA11952@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: t-kristo@ti.com, grygorii.strashko@ti.com, aaro.koskinen@iki.fi, tony@atomide.com, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, narmstrong@baylibre.com, thierry.reding@gmail.com, sebastian.reichel@collabora.co.uk, Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Prescaler setting is currently not taken into account.
Fix that by introducing freq member variable and initialize
it at device probe time. This also avoids frequency
recomputing at each pwm configure time.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/pwm/pwm-omap-dmtimer.c |   92 +++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index cc485d9946f3..81c79e41a167 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -40,6 +40,7 @@ struct pwm_omap_dmtimer_chip {
 	pwm_omap_dmtimer *dm_timer;
 	struct omap_dm_timer_ops *pdata;
 	struct platform_device *dm_timer_pdev;
+	unsigned long freq;
 };
 
 static inline struct pwm_omap_dmtimer_chip *
@@ -48,9 +49,10 @@ to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
 	return container_of(chip, struct pwm_omap_dmtimer_chip, chip);
 }
 
-static u32 pwm_omap_dmtimer_get_clock_cycles(unsigned long clk_rate, int ns)
+static inline u32
+pwm_omap_dmtimer_get_clock_cycles(struct pwm_omap_dmtimer_chip *omap, int ns)
 {
-	return DIV_ROUND_CLOSEST_ULL((u64)clk_rate * ns, NSEC_PER_SEC);
+	return DIV_ROUND_CLOSEST_ULL((u64)omap->freq * ns, NSEC_PER_SEC);
 }
 
 static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
@@ -99,8 +101,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 	u32 period_cycles, duty_cycles;
 	u32 load_value, match_value;
-	struct clk *fclk;
-	unsigned long clk_rate;
 	bool timer_active;
 
 	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
@@ -114,19 +114,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
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
@@ -144,35 +131,35 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	 *   OMAP4430/60/70 TRM sections 22.2.4.10 and 22.2.4.11
 	 *   AM335x Sitara TRM sections 20.1.3.5 and 20.1.3.6
 	 */
-	period_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, period_ns);
-	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, duty_ns);
+	period_cycles = pwm_omap_dmtimer_get_clock_cycles(omap, period_ns);
+	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(omap, duty_ns);
 
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
@@ -248,8 +235,9 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	struct dmtimer_platform_data *timer_pdata;
 	struct omap_dm_timer_ops *pdata;
 	pwm_omap_dmtimer *dm_timer;
+	struct clk *fclk;
 	u32 v;
-	int status, ret;
+	int ret;
 
 	timer = of_parse_phandle(np, "ti,timers", 0);
 	if (!timer)
@@ -302,9 +290,8 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
 	if (!omap) {
-		pdata->free(dm_timer);
 		ret = -ENOMEM;
-		goto put;
+		goto free;
 	}
 
 	omap->pdata = pdata;
@@ -315,15 +302,42 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	 * Ensure that the timer is stopped before we allow PWM core to call
 	 * pwm_enable.
 	 */
-	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
-		omap->pdata->stop(omap->dm_timer);
-
-	if (!of_property_read_u32(pdev->dev.of_node, "ti,prescaler", &v))
-		omap->pdata->set_prescaler(omap->dm_timer, v);
+	if (pm_runtime_active(&timer_pdev->dev))
+		pdata->stop(dm_timer);
 
 	/* setup dmtimer clock source */
-	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v))
-		omap->pdata->set_source(omap->dm_timer, v);
+	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v)) {
+		ret = pdata->set_source(dm_timer, v);
+		if (ret) {
+			dev_err(&pdev->dev, "invalid clock-source\n");
+			goto free;
+		}
+	}
+
+	fclk = pdata->get_fclk(dm_timer);
+	if (!fclk) {
+		dev_err(&pdev->dev, "invalid fclk\n");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	omap->freq = clk_get_rate(fclk);
+	if (!omap->freq) {
+		dev_err(&pdev->dev, "invalid fclk rate\n");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (!of_property_read_u32(pdev->dev.of_node, "ti,prescaler", &v)) {
+		ret = pdata->set_prescaler(dm_timer, v);
+		if (ret) {
+			dev_err(&pdev->dev, "invalid prescaler\n");
+			goto free;
+		}
+		omap->freq >>= v + 1;
+	}
+
+	dev_dbg(&pdev->dev, "clk rate: %luHz\n", omap->freq);
 
 	omap->chip.dev = &pdev->dev;
 	omap->chip.ops = &pwm_omap_dmtimer_ops;
@@ -334,18 +348,18 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	mutex_init(&omap->mutex);
 
-	status = pwmchip_add(&omap->chip);
-	if (status < 0) {
+	ret = pwmchip_add(&omap->chip);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM\n");
-		omap->pdata->free(omap->dm_timer);
-		ret = status;
-		goto put;
+		goto free;
 	}
 
 	platform_set_drvdata(pdev, omap);
 
 	return 0;
 
+free:
+	pdata->free(dm_timer);
 put:
 	of_node_put(timer);
