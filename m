From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: [PATCH 2/4] pwm: omap-dmtimer: add sanity checking for load and match values
Date: Fri, 29 Jan 2016 23:26:52 -0500
Message-ID: <1454128014-22866-3-git-send-email-drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: David Rivshin <drivshin@allworx.com>

Add sanity checking to ensure that we do not program load or match values
that are out of range if a user requests period or duty_cycle values which
are not achievable. The match value cannot be less than the load value (but
can be equal), and neither can be 0xffffffff. This means that there must be
at least one fclk cycle between load and match, and another between match
and overflow.

Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
Signed-off-by: David Rivshin <drivshin@allworx.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 0083e75..103d729 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -119,15 +119,13 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	fclk = omap->pdata->get_fclk(omap->dm_timer);
 	if (!fclk) {
 		dev_err(chip->dev, "invalid pmtimer fclk\n");
-		mutex_unlock(&omap->mutex);
-		return -EINVAL;
+		goto err_einval;
 	}
 
 	clk_rate = clk_get_rate(fclk);
 	if (!clk_rate) {
 		dev_err(chip->dev, "invalid pmtimer fclk rate\n");
-		mutex_unlock(&omap->mutex);
-		return -EINVAL;
+		goto err_einval;
 	}
 
 	dev_dbg(chip->dev, "clk rate: %luHz\n", clk_rate);
@@ -142,6 +140,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	 * The non-active time is the remainder: (DM_TIMER_MAX-match_value)
 	 * clock cycles.
 	 *
+	 * NOTE: It is required that: load_value <= match_value < DM_TIMER_MAX
+	 *
 	 * References:
 	 *   OMAP4430/60/70 TRM sections 22.2.4.10 and 22.2.4.11
 	 *   AM335x Sitara TRM sections 20.1.3.5 and 20.1.3.6
@@ -149,6 +149,24 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	period_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, period_ns);
 	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, duty_ns);
 
+	if (period_cycles < 2) {
+		dev_info(chip->dev,
+			"period %dns is too short for clock rate %luHz\n",
+			period_ns, clk_rate);
+		goto err_einval;
+	}
+	if (duty_cycles < 1) {
+		dev_dbg(chip->dev,
+			"duty cycle %dns is too short for clock rate %luHz, using minimum of 1 clock cycle\n",
+			duty_ns, clk_rate);
+		duty_cycles = 1;
+	} else if (duty_cycles >= period_cycles) {
+		dev_dbg(chip->dev,
+			"duty cycle %dns is too long for period %dns at clock rate %luHz, using maximum of 1 clock cycle less than period\n",
+			duty_ns, period_ns, clk_rate);
+		duty_cycles = period_cycles - 1;
+	}
+
 	load_value = (DM_TIMER_MAX - period_cycles) + 1;
 	match_value = load_value + duty_cycles - 1;
 
@@ -179,6 +197,11 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	mutex_unlock(&omap->mutex);
 
 	return 0;
+
+err_einval:
+	mutex_unlock(&omap->mutex);
+
+	return -EINVAL;
 }
 
 static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
-- 
2.5.0
