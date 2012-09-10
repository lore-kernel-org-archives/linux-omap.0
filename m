From: Matt Porter <mporter@ti.com>
Subject: [PATCH v2 2/2] ARM: dts: AM33XX: adjust leds to use the corrected gpio label
Date: Mon, 10 Sep 2012 15:45:12 -0400
Message-ID: <1347306312-31533-3-git-send-email-mporter@ti.com>
References: <1347306312-31533-1-git-send-email-mporter@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347306312-31533-1-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Vaibhav Hiremath <hvaibhav@ti.com>, AnilKumar <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

With the am33xx.dtsi now using gpio labels that match the AM33xx
documentation, we need to refer to GPIO1 by the "gpio1" label.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index b0a7409..fa0c9d5 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -41,27 +41,27 @@
 
 			heartbeat {
 				label = "beaglebone:green:usr0";
-				gpios = <&gpio2 21 0>;
+				gpios = <&gpio1 21 0>;
 				linux,default-trigger = "heartbeat";
 				default-state = "off";
 			};
 
 			mmc {
 				label = "beaglebone:green:usr1";
-				gpios = <&gpio2 22 0>;
+				gpios = <&gpio1 22 0>;
 				linux,default-trigger = "mmc0";
 				default-state = "off";
 			};
 
 			led2 {
 				label = "beaglebone:green:usr2";
-				gpios = <&gpio2 23 0>;
+				gpios = <&gpio1 23 0>;
 				default-state = "off";
 			};
 
 			led3 {
 				label = "beaglebone:green:usr3";
-				gpios = <&gpio2 24 0>;
+				gpios = <&gpio1 24 0>;
 				default-state = "off";
 			};
 		};
-- 
1.7.9.5
