From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 03/27] ARM: dts: dm3730-torpedo-devkit: remove unneeded unit names
Date: Mon, 27 Jun 2016 15:20:44 -0400
Message-ID: <1467055268-13194-4-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings:

"dmtimer-pwm@10 has a unit name, but no reg property"
"display@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 015f795a8d19..08cce17a25a0 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -72,7 +72,7 @@
 		};
 	};
 
-	pwm10: dmtimer-pwm@10 {
+	pwm10: dmtimer-pwm {
 		compatible = "ti,omap-dmtimer-pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm_pins>;
@@ -147,7 +147,7 @@
 		gpio = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd INI */
 	};
 
-	lcd0: display@0 {
+	lcd0: display {
 		compatible = "panel-dpi";
 		label = "15";
 		status = "okay";
-- 
2.5.5
