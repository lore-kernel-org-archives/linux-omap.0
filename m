From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for effective period and duty cycle
Date: Fri, 29 Jan 2016 23:26:54 -0500
Message-ID: <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: David Rivshin <drivshin@allworx.com>

After going through the math and constraints checking to compute load and
match values, it is helpful to know what the resultant period and duty
cycle are.

Signed-off-by: David Rivshin <drivshin@allworx.com>
---

I found this helpful while testing the other changes, so I included it in
case it may be of use to someone in the future. I would have no issues with
dropping this if it's not considered worthwhile.

 drivers/pwm/pwm-omap-dmtimer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 8c9953c..44e3dca 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -102,7 +102,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	unsigned long clk_rate;
 	bool timer_active;
 
-	dev_dbg(chip->dev, "duty cycle: %d, period %d\n", duty_ns, period_ns);
+	dev_dbg(chip->dev, "requested duty cycle: %dns, period: %dns\n",
+		duty_ns, period_ns);
 
 	mutex_lock(&omap->mutex);
 	if (duty_ns == pwm_get_duty_cycle(pwm) &&
@@ -163,6 +164,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 		duty_cycles = period_cycles - 1;
 	}
 
+	dev_dbg(chip->dev, "effective duty cycle: %lldns, period: %lldns\n",
+		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * duty_cycles,
+				      clk_rate),
+		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * period_cycles,
+				      clk_rate));
+
 	load_value = (DM_TIMER_MAX - period_cycles) + 1;
 	match_value = load_value + duty_cycles - 1;
 
-- 
2.5.0
