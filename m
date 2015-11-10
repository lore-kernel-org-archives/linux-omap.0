From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Tue, 10 Nov 2015 10:59:58 +0530
Message-ID: <1447133399-25658-5-git-send-email-vigneshr@ti.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
update the binding documents for the controller to document this change.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/ti_qspi.txt | 14 ++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                       |  7 +++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 601a360531a5..334aa3f32cbc 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -26,3 +26,17 @@ qspi: qspi@4b300000 {
 	spi-max-frequency = <25000000>;
 	ti,hwmods = "qspi";
 };
+
+For dra7xx:
+qspi: qspi@4b300000 {
+	compatible = "ti,dra7xxx-qspi";
+	reg = <0x4b300000 0x100>,
+	      <0x5c000000 0x4000000>,
+	      <0x4a002558 0x4>;
+	reg-names = "qspi_base", "qspi_mmap",
+		    "qspi_ctrlmod";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <48000000>;
+	ti,hwmods = "qspi";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8fedddc35999..ad93fe2ccab8 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1108,8 +1108,11 @@
 
 		qspi: qspi@4b300000 {
 			compatible = "ti,dra7xxx-qspi";
-			reg = <0x4b300000 0x100>;
-			reg-names = "qspi_base";
+			reg = <0x4b300000 0x100>,
+			      <0x5c000000 0x4000000>,
+			      <0x4a002558 0x4>;
+			reg-names = "qspi_base", "qspi_mmap",
+				    "qspi_ctrlmod";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.6.3
