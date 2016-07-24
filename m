From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] ARM: dts: overo: fix gpmc nand on boards with ethernet
Date: Sun, 24 Jul 2016 14:11:00 +0200
Message-ID: <1469362260-20066-4-git-send-email-johan@kernel.org>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469362260-20066-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

The gpmc ranges property for NAND at CS0 was being overridden by later
includes that defined gpmc ethernet nodes, effectively breaking NAND on
these systems:

	omap-gpmc 6e000000.gpmc: /ocp/gpmc@6e000000/nand@0,0 has
	malformed 'reg' property

Instead of redefining the NAND range in every such dtsi, define all
currently used ranges in omap3-overo-base.dtsi.

Fixes: 98ce6007efb4 ("ARM: dts: overo: Support PoP NAND")
Cc: stable <stable@vger.kernel.org> # 4.3
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi              | 4 +++-
 arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi | 2 --
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi       | 2 --
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi    | 3 ---
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index b15c435439fb..3e946cac55f3 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -223,7 +223,9 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x1000000>;	/* CS0 */
+	ranges = <0 0 0x30000000 0x1000000>,	/* CS0 */
+		 <4 0 0x2b000000 0x1000000>,	/* CS4 */
+		 <5 0 0x2c000000 0x1000000>;	/* CS5 */
 
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
diff --git a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
index 7df27926ead2..4f4c6efbd518 100644
--- a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
@@ -55,8 +55,6 @@
 #include "omap-gpmc-smsc9221.dtsi"
 
 &gpmc {
-	ranges = <5 0 0x2c000000 0x1000000>;	/* CS5 */
-
 	ethernet@gpmc {
 		reg = <5 0 0xff>;
 		interrupt-parent = <&gpio6>;
diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index 9e24b6a1d07b..1b304e2f1bd2 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -27,8 +27,6 @@
 #include "omap-gpmc-smsc9221.dtsi"
 
 &gpmc {
-	ranges = <5 0 0x2c000000 0x1000000>;	/* CS5 */
-
 	ethernet@gpmc {
 		reg = <5 0 0xff>;
 		interrupt-parent = <&gpio6>;
diff --git a/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
index 334109e14613..82e98ee3023a 100644
--- a/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
@@ -15,9 +15,6 @@
 #include "omap-gpmc-smsc9221.dtsi"
 
 &gpmc {
-	ranges = <4 0 0x2b000000 0x1000000>,	/* CS4 */
-		 <5 0 0x2c000000 0x1000000>;	/* CS5 */
-
 	smsc1: ethernet@gpmc {
 		reg = <5 0 0xff>;
 		interrupt-parent = <&gpio6>;
-- 
2.7.3
