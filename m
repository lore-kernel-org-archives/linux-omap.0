From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] pwm: twl: Reliably disable TWL6030 PWMs
Date: Tue, 29 Mar 2016 20:55:45 +0200
Message-ID: <1459277745-16878-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

The current TWL6030 code for the TWL PWM driver does not reliably disable the
PWM output, as tested with LEDs. The previous commit to that driver introduced
that regression.

However, it does make sense to disable the PWM clock after resetting the PWM,
but for some obscure reason, doing it all at once simply doesn't work.

The TWL6030 datasheet mentions that PWMs have to be disabled in two distinct
steps. However, clearing the clock enable bit in a second step (after issuing a
reset first) does not work.

The only approach that works is the one that was in place before the previous
commit to the driver. It consists in enabling the PWM clock after issuing a
reset. This is what TI kernel trees and production code seem to be using.

However, adding an extra step to disable the PWM clock seems to work reliably,
despite looking quite odd.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/pwm/pwm-twl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 04f7672..7a993b0 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -269,6 +269,22 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 		goto out;
 	}
 
+	val |= TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXEN);
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
+	if (ret < 0) {
+		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		goto out;
+	}
+
+	val &= ~TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXEN);
+
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
+	if (ret < 0) {
+		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		goto out;
+	}
+
 	twl->twl6030_toggle3 = val;
 out:
 	mutex_unlock(&twl->mutex);
-- 
2.7.4
