From: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 5/6] pwm: enable TI PWMSS if the IIO tiecap driver is selected
Date: Mon,  3 Feb 2014 08:40:31 -0500
Message-ID: <1391434832-23807-6-git-send-email-mporter@linaro.org>
References: <1391434832-23807-1-git-send-email-mporter@linaro.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391434832-23807-1-git-send-email-mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux IIO List <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The IIO TI ECAP driver depends on the TI PWMSS management
driver in this subsystem. Enable PWMSS when the IIO TI ECAP
driver is selected.

Signed-off-by: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
