From: Felix Brack <fb@ltec.ch>
Subject: [PATCH: linux-next] ARM: dts: am33xx: Remove unnecessary properties
Date: Tue, 18 Dec 2018 15:39:31 +0100
Message-ID: <20181218143931.4151-1-fb@ltec.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, Felix Brack <fb@ltec.ch>
List-Id: linux-omap@vger.kernel.org

Remove the unnecessary properties #address-cells and #size-cells
of node pinmux as there are no child-nodes with property reg.

Signed-off-by: Felix Brack <fb@ltec.ch>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 7b818d9d2eab..e957370f8aec 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -288,8 +288,6 @@
 				am33xx_pinmux: pinmux@800 {
 					compatible = "pinctrl-single";
 					reg = <0x800 0x238>;
-					#address-cells = <1>;
-					#size-cells = <0>;
 					#pinctrl-cells = <1>;
 					pinctrl-single,register-width = <32>;
 					pinctrl-single,function-mask = <0x7f>;
-- 
2.17.1
