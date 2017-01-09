From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH] ARM: dts: OMAP5 / DRA7: indicate that SATA port 0 is available.
Date: Mon, 9 Jan 2017 13:22:15 +0100
Message-ID: <1483964535-4298-1-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: rogerq@ti.com, Jean-Jacques Hiblot <jjhiblot@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

AHCI provides the register PORTS_IMPL to let the software know which port
is supported. The register must be initialized by the bootloader. However
in some cases u-boot doesn't properly initialize this value (if it is not
compiled with SATA support for example or if the SATA initialization fails).
The DTS entry "ports-implemented" can be used to override the value in
PORTS_IMPL.
Adding this entry in the dts allows us no to worry about what is done by
the bootloader.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>

Cc: <stable@vger.kernel.org> # v4.6+
---
 arch/arm/boot/dts/dra7.dtsi  | 1 +
 arch/arm/boot/dts/omap5.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1faf24a..5ba1616 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1378,6 +1378,7 @@
 			phy-names = "sata-phy";
 			clocks = <&sata_ref_clk>;
 			ti,hwmods = "sata";
+			ports-implemented = <0x1>;
 		};
 
 		rtc: rtc@48838000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 7cd92ba..0844737 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -988,6 +988,7 @@
 			phy-names = "sata-phy";
 			clocks = <&sata_ref_clk>;
 			ti,hwmods = "sata";
+			ports-implemented = <0x1>;
 		};
 
 		dss: dss@58000000 {
-- 
1.9.1
