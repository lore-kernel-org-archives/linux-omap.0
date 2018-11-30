From: Felix Brack <fb@ltec.ch>
Subject: [PATCH] ARM: dts: am335x-pdu001: Fix polarity of card detection input
Date: Fri, 30 Nov 2018 15:54:46 +0100
Message-ID: <20181130145446.3819-1-fb@ltec.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, Felix Brack <fb@ltec.ch>
List-Id: linux-omap@vger.kernel.org

When a micro SD card is inserted in the PDU001 card cage, the card
detection switch is opened and the corresponding GPIO input is driven
by a pull-up. Hence change the active level of the card detection
input from low to high.

Signed-off-by: Felix Brack <fb@ltec.ch>
---
 arch/arm/boot/dts/am335x-pdu001.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-pdu001.dts b/arch/arm/boot/dts/am335x-pdu001.dts
index 6dd9d487aaeb..ae43d61f4e8b 100644
--- a/arch/arm/boot/dts/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/am335x-pdu001.dts
@@ -585,7 +585,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
-	cd-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
 };
 
 &sham {
-- 
2.17.1
