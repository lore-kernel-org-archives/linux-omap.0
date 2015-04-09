From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Switch GPIO fan number
Date: Thu, 9 Apr 2015 17:33:17 -0500
Message-ID: <1428618797-17190-3-git-send-email-nm@ti.com>
References: <1428618797-17190-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428618797-17190-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

BeagleBoard-X15 pre-production change includes switching the GPIO fan
gpio over from 1 to 2 to allow for a potential fix at a later point in
time for USB client VBUS detection using PMIC VBUS detect capability.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index cea3be3a051c..fe141c47d647 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -83,7 +83,7 @@
 	gpio_fan: gpio_fan {
 		/* Based on 5v 500mA AFB02505HHB */
 		compatible = "gpio-fan";
-		gpios =  <&tps659038_gpio 1 GPIO_ACTIVE_HIGH>;
+		gpios =  <&tps659038_gpio 2 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0     0>,
 				     <13000 1>;
 		#cooling-cells = <2>;
-- 
1.7.9.5
