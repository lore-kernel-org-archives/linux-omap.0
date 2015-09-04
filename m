From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2] ARM: dts: <omap2/omap4/omap5/dra7>>: fix address translation for pbias
Date: Fri, 4 Sep 2015 17:38:24 +0530
Message-ID: <1441368504-21304-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

"ARM: dts: <omap2/omap4/omap5/dra7>: add minimal l4 bus
layout with control module support" moved pbias_regulator dt node
from being a child node of ocp to be the child node of
'syscon'. Since 'syscon' doesn't have the 'ranges' property,
address translation fails while trying to convert the address
to resource. Fix it here by populating 'ranges' property in
syscon dt node.

Fixes: 72b10ac00eb1 ("ARM: dts: omap24xx: add minimal l4 bus
layout with control module support")

Fixes: 7415b0b4c645 ("ARM: dts: omap4: add minimal l4 bus layout
with control module support")

Fixes: ed8509edddeb ("ARM: dts: omap5: add minimal l4 bus
layout with control module support")

Fixes: d919501feffa ("ARM: dts: dra7: add minimal l4 bus
layout with control module support")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v1:
*) squashed [1] to a single patch
[1] -> https://lkml.org/lkml/2015/9/3/166

 arch/arm/boot/dts/dra7.dtsi     |    1 +
 arch/arm/boot/dts/omap2430.dtsi |    1 +
 arch/arm/boot/dts/omap4.dtsi    |    1 +
 arch/arm/boot/dts/omap5.dtsi    |    1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d6bc6db..5896896 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -120,6 +120,7 @@
 					reg = <0x0 0x1400>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x0 0x1400>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-dra7", "ti,pbias-omap";
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 3961a6f..798dda0 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -56,6 +56,7 @@
 					reg = <0x270 0x240>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x270 0x240>;
 
 					scm_clocks: clocks {
 						#address-cells = <1>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 5aad7f3..5a206c1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -196,6 +196,7 @@
 					reg = <0x5a0 0x170>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x5a0 0x170>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-omap4", "ti,pbias-omap";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 76ef595..dd7a0e8 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -185,6 +185,7 @@
 					reg = <0x5a0 0xec>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x5a0 0xec>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-omap5", "ti,pbias-omap";
-- 
1.7.9.5
