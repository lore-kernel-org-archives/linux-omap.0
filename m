From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v5 5/5] ARM: dts: AM4372: add entry for qspi mmap region
Date: Fri, 11 Dec 2015 09:40:00 +0530
Message-ID: <1449807000-6457-6-git-send-email-vigneshr@ti.com>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Add qspi memory mapped region entries for AM43xx based SoCs. Also,
update the binding documents for the controller to document this change.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v5: No changes.

 Documentation/devicetree/bindings/spi/ti_qspi.txt | 5 +++--
 arch/arm/boot/dts/am4372.dtsi                     | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index 809c3f334316..cc8304aa64ac 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -21,9 +21,10 @@ Optional properties:
 
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
index d83ff9c9701e..e32d164102d1 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -963,7 +963,9 @@
 
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
2.6.3
