From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] pwm: pwm-tiehrpwm: Fix disabling of output of PWMs
Date: Mon, 11 Jun 2018 11:39:56 +0530
Message-ID: <20180611060956.27999-3-vigneshr@ti.com>
References: <20180611060956.27999-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611060956.27999-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

pwm-tiehrpwm driver disables PWM output by putting it in low output
state via active AQCSFRC register in ehrpwm_pwm_disable(). But, the
AQCSFRC shadow register is not updated. Therefore, when shadow AQCSFRC
register is re-enabled in ehrpwm_pwm_enable() (say to enable second PWM
output), previous settings are lost as shadow register value is loaded
into active register. This results in things like PWMA getting enabled
automatically, when PWMB is enabled and vice versa. Fix this by
updating AQCSFRC shadow register as well during ehrpwm_pwm_disable().

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 768176f54d5e..f7b8a86fa5c5 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -381,6 +381,8 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 		aqcsfrc_mask = AQCSFRC_CSFA_MASK;
 	}
 
+	/* Update shadow register first before modifying active register */
+	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 	/*
 	 * Changes to immediate action on Action Qualifier. This puts
 	 * Action Qualifier control on PWM output from next TBCLK
-- 
2.17.1
