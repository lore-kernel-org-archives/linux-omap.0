From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 04/27] ARM: dts: n900: remove unneeded unit name for dmtimer-pwm
Date: Mon, 27 Jun 2016 15:20:45 -0400
Message-ID: <1467055268-13194-5-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-n900.dtb:

"dmtimer-pwm@9 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5ce4d6fe4cf8..2a6078a8422c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -144,7 +144,7 @@
 		io-channel-names = "temp", "bsi", "vbat";
 	};
 
-	pwm9: dmtimer-pwm@9 {
+	pwm9: dmtimer-pwm {
 		compatible = "ti,omap-dmtimer-pwm";
 		#pwm-cells = <3>;
 		ti,timers = <&timer9>;
-- 
2.5.5
