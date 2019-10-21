From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4] ARM: dts: am: Rename "ocmcram" node to "sram"
Date: Mon, 21 Oct 2019 18:17:52 +0200
Message-ID: <20191021161752.21502-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-omap@vger.kernel.org

The device node name should reflect generic class of a device so rename
the "ocmcram" node and its children to "sram".  This will be also in
sync with upcoming DT schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Rename also children.

v3 is here:
https://lore.kernel.org/linux-arm-kernel/20191002164316.14905-9-krzk@kernel.org/
---
 arch/arm/boot/dts/am33xx.dtsi | 6 +++---
 arch/arm/boot/dts/am4372.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index fb6b8aa12cc5..765963de5d41 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -393,20 +393,20 @@
 			};
 		};
 
-		ocmcram: ocmcram@40300000 {
+		ocmcram: sram@40300000 {
 			compatible = "mmio-sram";
 			reg = <0x40300000 0x10000>; /* 64k */
 			ranges = <0x0 0x40300000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			pm_sram_code: pm-sram-code@0 {
+			pm_sram_code: pm-code-sram@0 {
 				compatible = "ti,sram";
 				reg = <0x0 0x1000>;
 				protect-exec;
 			};
 
-			pm_sram_data: pm-sram-data@1000 {
+			pm_sram_data: pm-data-sram@1000 {
 				compatible = "ti,sram";
 				reg = <0x1000 0x1000>;
 				pool;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 848e2a8884e2..3e3ae48c2e5a 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -349,20 +349,20 @@
 			};
 		};
 
-		ocmcram: ocmcram@40300000 {
+		ocmcram: sram@40300000 {
 			compatible = "mmio-sram";
 			reg = <0x40300000 0x40000>; /* 256k */
 			ranges = <0x0 0x40300000 0x40000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			pm_sram_code: pm-sram-code@0 {
+			pm_sram_code: pm-code-sram@0 {
 				compatible = "ti,sram";
 				reg = <0x0 0x1000>;
 				protect-exec;
 			};
 
-			pm_sram_data: pm-sram-data@1000 {
+			pm_sram_data: pm-data-sram@1000 {
 				compatible = "ti,sram";
 				reg = <0x1000 0x1000>;
 				pool;
-- 
2.17.1
