From: Arun Murthy <arun.murthy@stericsson.com>
Subject: [PATCH 7/7] pwm: Modify backlight and led Kconfig aligning to pwm core
Date: Tue, 28 Sep 2010 16:05:34 +0530
Message-ID: <1285670134-18063-8-git-send-email-arun.murthy__3214.5525249236$1285670272$gmane$org@stericsson.com>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:44577 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751391Ab0I1KgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Sep 2010 06:36:18 -0400
In-Reply-To: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lars@metafoo.de, akpm@linux-foundation.org, kernel@pengutronix.de, philipp.zabel@gmail.com, robert.jarzmik@free.fr, marek.vasut@gmail.com, eric.y.miao@gmail.com, rpurdi
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, arun.murthy@stericsson.com, STEricsson_nomadik_linux@list.st.com

PWM based backlight and led driver will not be calling the pwm drivers
through the pwm core driver and hence adding dependancy on the same.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/leds/Kconfig            |    2 +-
 drivers/pwm/Kconfig             |    2 --
 drivers/video/backlight/Kconfig |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e411262..eba388f 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -244,7 +244,7 @@ config LEDS_DAC124S085
 
 config LEDS_PWM
 	tristate "PWM driven LED Support"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM_CORE
 	help
 	  This option enables support for pwm driven LEDs
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e347365..1f8cbc0 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -17,7 +17,6 @@ if PWM_DEVICES
 config AB8500_PWM
 	bool "AB8500 PWM support"
 	depends on AB8500_CORE
-	select HAVE_PWM
 	help
 	  This driver exports functions to enable/disble/config/free Pulse
 	  Width Modulation in the Analog Baseband Chip AB8500.
@@ -26,7 +25,6 @@ config AB8500_PWM
 config TWL6030_PWM
 	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
 	depends on TWL4030_CORE
-	select HAVE_PWM
 	default n
 	help
 	  Say yes here if you want support for TWL6030 PWM.
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index e54a337..73fc17b 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -217,7 +217,7 @@ config BACKLIGHT_CARILLO_RANCH
 
 config BACKLIGHT_PWM
 	tristate "Generic PWM based Backlight Driver"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM_CORE
 	help
 	  If you have a LCD backlight adjustable by PWM, say Y to enable
 	  this driver.
-- 
1.7.2.dirty

