From: Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH] ARM: dts: am43x-epos-evm: set data pin directions for spi0 and spi1
Date: Sun, 19 Jan 2020 16:58:59 +0530
Message-ID: <1579433339-10663-1-git-send-email-raagjadav@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Raag Jadav <raagjadav@gmail.com>
List-Id: linux-omap@vger.kernel.org

Set d0 and d1 pin directions for spi0 and spi1 as per their pinmux.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 078cb47..a6fbc08 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -848,6 +848,7 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&spi0_pins_default>;
 	pinctrl-1 = <&spi0_pins_sleep>;
+	ti,pindir-d0-out-d1-in = <1>;
 };
 
 &spi1 {
@@ -855,6 +856,7 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&spi1_pins_default>;
 	pinctrl-1 = <&spi1_pins_sleep>;
+	ti,pindir-d0-out-d1-in = <1>;
 };
 
 &usb2_phy1 {
-- 
2.7.4
