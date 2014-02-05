From: Matt Porter <mporter@linaro.org>
Subject: [PATCH v3 5/6] pwm: enable TI PWMSS if the IIO tiecap driver is selected
Date: Wed,  5 Feb 2014 14:01:40 -0500
Message-ID: <1391626901-31684-6-git-send-email-mporter@linaro.org>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391626901-31684-1-git-send-email-mporter@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Linux IIO List <linux-iio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

The IIO TI ECAP driver depends on the TI PWMSS management
driver in this subsystem. Enable PWMSS when the IIO TI ECAP
driver is selected.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 22f2f28..bd3cc65 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -219,7 +219,7 @@ config  PWM_TIEHRPWM
 
 config  PWM_TIPWMSS
 	bool
-	default y if SOC_AM33XX && (PWM_TIECAP || PWM_TIEHRPWM)
+	default y if SOC_AM33XX && (IIO_TIECAP || PWM_TIECAP || PWM_TIEHRPWM)
 	help
 	  PWM Subsystem driver support for AM33xx SOC.
 
-- 
1.8.4
