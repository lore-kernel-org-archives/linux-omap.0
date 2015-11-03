From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 5/5] ARM: dts: AM4372: add entry for qspi mmap region
Date: Tue, 3 Nov 2015 15:36:14 +0530
Message-ID: <1446545174-14193-6-git-send-email-vigneshr@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add qspi memory mapped region entries for AM43xx based SoCs. Also,
update the binding documents for the controller to document this change.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/spi/ti_qspi.txt | 5 +++--
 arch/arm/boot/dts/am4372.dtsi                     | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index f05dd631bef1..05488970060b 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -17,9 +17,10 @@ Recommended properties:
 
 Example:
 
+For am4372:
 qspi: qspi@4b300000 {
-	compatible = "ti,dra7xxx-qspi";
-	reg = <0x47900000 0x100>, <0x30000000 0x3ffffff>;
+	compatible = "ti,am4372-qspi";
+	reg = <0x47900000 0x100>, <0x30000000 0x4000000>;
 	reg-names = "qspi_base", "qspi_mmap";
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0447c04a40cc..1b2c545f3f2c 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -962,7 +962,9 @@
 
 		qspi: qspi@47900000 {
 			compatible = "ti,am4372-qspi";
-			reg = <0x47900000 0x100>;
+			reg = <0x47900000 0x100>,
+			      <0x30000000 0x4000000>;
+			reg-names = "qspi_base", "qspi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.6.2
