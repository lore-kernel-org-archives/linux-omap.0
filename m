From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] pwm: pwm-tiehrpwm: Don't use emulation mode bits to control PWM output
Date: Mon, 11 Jun 2018 11:39:55 +0530
Message-ID: <20180611060956.27999-2-vigneshr@ti.com>
References: <20180611060956.27999-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611060956.27999-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

As per AM335x TRM SPRUH73P "15.2.2.11 ePWM Behavior During Emulation",
TBCTL[15:14] only have effect during emulation suspend events (IOW,
to stop PWM when debugging using a debugger). These bits have no effect
on PWM output during normal running of system. Hence, remove code
accessing these bits as they have no role in enabling/disabling PWMs.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 4c22cb395040..768176f54d5e 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -33,10 +33,6 @@
 #define TBCTL			0x00
 #define TBPRD			0x0A
 
-#define TBCTL_RUN_MASK		(BIT(15) | BIT(14))
-#define TBCTL_STOP_NEXT		0
-#define TBCTL_STOP_ON_CYCLE	BIT(14)
-#define TBCTL_FREE_RUN		(BIT(15) | BIT(14))
 #define TBCTL_PRDLD_MASK	BIT(3)
 #define TBCTL_PRDLD_SHDW	0
 #define TBCTL_PRDLD_IMDT	BIT(3)
@@ -360,7 +356,7 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Channels polarity can be configured from action qualifier module */
 	configure_polarity(pc, pwm->hwpwm);
 
-	/* Enable TBCLK before enabling PWM device */
+	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
 		dev_err(chip->dev, "Failed to enable TBCLK for %s: %d\n",
@@ -368,9 +364,6 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return ret;
 	}
 
-	/* Enable time counter for free_run */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_FREE_RUN);
-
 	return 0;
 }
 
@@ -400,9 +393,6 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Disabling TBCLK on PWM disable */
 	clk_disable(pc->tbclk);
 
-	/* Stop Time base counter */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_STOP_NEXT);
-
 	/* Disable clock on PWM disable */
 	pm_runtime_put_sync(chip->dev);
 }
-- 
2.17.1
