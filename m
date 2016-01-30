From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: [PATCH 1/4] pwm: omap-dmtimer: fix inaccurate period/duty_cycle calculation
Date: Fri, 29 Jan 2016 23:26:51 -0500
Message-ID: <1454128014-22866-2-git-send-email-drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: David Rivshin <drivshin@allworx.com>

Fix the calculation of load_value and match_value. Currently they
are slightly too low, which produces a noticeably wrong PWM rate with
sufficiently short periods (i.e. when 1/period approaches clk_rate/2).

Example:
 clk_rate=32768Hz, period=122070ns, duty_cycle=61035ns (8192Hz/50% PWM)
 Correct values: load = 0xfffffffc, match = 0xfffffffd
 Current values: load = 0xfffffffa, match = 0xfffffffc
 effective PWM: period=183105ns, duty_cycle=91553ns (5461Hz/50% PWM)

Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
Signed-off-by: David Rivshin <drivshin@allworx.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 826634e..0083e75 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 
 #define DM_TIMER_LOAD_MIN 0xfffffffe
+#define DM_TIMER_MAX      0xffffffff
 
 struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
@@ -46,13 +47,13 @@ to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
 	return container_of(chip, struct pwm_omap_dmtimer_chip, chip);
 }
 
-static int pwm_omap_dmtimer_calc_value(unsigned long clk_rate, int ns)
+static u32 pwm_omap_dmtimer_get_clock_cycles(unsigned long clk_rate, int ns)
 {
 	u64 c = (u64)clk_rate * ns;
 
 	do_div(c, NSEC_PER_SEC);
 
-	return DM_TIMER_LOAD_MIN - c;
+	return c;
 }
 
 static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
@@ -99,7 +100,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 				   int duty_ns, int period_ns)
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
-	int load_value, match_value;
+	u32 period_cycles, duty_cycles;
+	u32 load_value, match_value;
 	struct clk *fclk;
 	unsigned long clk_rate;
 	bool timer_active;
@@ -133,11 +135,22 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	/*
 	 * Calculate the appropriate load and match values based on the
 	 * specified period and duty cycle. The load value determines the
-	 * cycle time and the match value determines the duty cycle.
+	 * period time and the match value determines the duty time.
+	 *
+	 * The period lasts for (DM_TIMER_MAX-load_value+1) clock cycles.
+	 * Similarly, the active time lasts (match_value-load_value+1) cycles.
+	 * The non-active time is the remainder: (DM_TIMER_MAX-match_value)
+	 * clock cycles.
+	 *
+	 * References:
+	 *   OMAP4430/60/70 TRM sections 22.2.4.10 and 22.2.4.11
+	 *   AM335x Sitara TRM sections 20.1.3.5 and 20.1.3.6
 	 */
-	load_value = pwm_omap_dmtimer_calc_value(clk_rate, period_ns);
-	match_value = pwm_omap_dmtimer_calc_value(clk_rate,
-						  period_ns - duty_ns);
+	period_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, period_ns);
+	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, duty_ns);
+
+	load_value = (DM_TIMER_MAX - period_cycles) + 1;
+	match_value = load_value + duty_cycles - 1;
 
 	/*
 	 * We MUST stop the associated dual-mode timer before attempting to
-- 
2.5.0
