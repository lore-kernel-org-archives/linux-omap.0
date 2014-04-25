From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH] ARM: dts: am335x-boneblack: remove use of ti,vcc-aux-disable-is-sleep
Date: Fri, 25 Apr 2014 15:36:26 +0200
Message-ID: <1398432986-30585-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
List-Id: linux-omap@vger.kernel.org

Remove use of property ti,vcc-aux-disable-is-sleep, which does not
exist.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 6b71ad95a5cf..305975d3f531 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -26,7 +26,6 @@
 	pinctrl-0 = <&emmc_pins>;
 	bus-width = <8>;
 	status = "okay";
-	ti,vcc-aux-disable-is-sleep;
 };
 
 &am33xx_pinmux {
-- 
1.8.3.2
