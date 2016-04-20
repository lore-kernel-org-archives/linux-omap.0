From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 2/2] ARM: dts: dra7x: Support QSPI MODE-0 operation at 64MHz
Date: Wed, 20 Apr 2016 17:03:00 +0530
Message-ID: <1461151980-28139-3-git-send-email-vigneshr@ti.com>
References: <1461151980-28139-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461151980-28139-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Vignesh R <vigneshr@ti.com>, nsekhar@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

According to Data Manual(SPRS915P) of AM57x, TI QSPI controller on
DRA74(rev 1.1+)/DRA72 EVM can support up to 64MHz in MODE-0, whereas
MODE-3 is limited to 48MHz. Hence, switch to MODE-0 for better
throughput.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: rebased on linux-next 20160419 to include moving to
dra72-evm-common.dtsi


 Documentation/devicetree/bindings/spi/ti_qspi.txt | 7 +++++++
 arch/arm/boot/dts/dra7-evm.dts                    | 6 ++----
 arch/arm/boot/dts/dra72-evm-common.dtsi           | 6 ++----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index cc8304aa64ac..50b14f6b53a3 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -19,6 +19,13 @@ Optional properties:
 - syscon-chipselects: Handle to system control region contains QSPI
 		      chipselect register and offset of that register.
 
+NOTE: TI QSPI controller requires different pinmux and IODelay
+paramaters for Mode-0 and Mode-3 operations, which needs to be set up by
+the bootloader (U-Boot). Default configuration only supports Mode-0
+operation. Hence, "spi-cpol" and "spi-cpha" DT properties cannot be
+specified in the slave nodes of TI QSPI controller without appropriate
+modification to bootloader.
+
 Example:
 
 For am4372:
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 47d0745a08ad..507a8ec0a268 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -664,15 +664,13 @@
 &qspi {
 	status = "okay";
 
-	spi-max-frequency = <48000000>;
+	spi-max-frequency = <64000000>;
 	m25p80@0 {
 		compatible = "s25fl256s1";
-		spi-max-frequency = <48000000>;
+		spi-max-frequency = <64000000>;
 		reg = <0>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
-		spi-cpol;
-		spi-cpha;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index beef82502ea0..e53b1ef8c7aa 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -681,15 +681,13 @@
 &qspi {
 	status = "okay";
 
-	spi-max-frequency = <48000000>;
+	spi-max-frequency = <64000000>;
 	m25p80@0 {
 		compatible = "s25fl256s1";
-		spi-max-frequency = <48000000>;
+		spi-max-frequency = <64000000>;
 		reg = <0>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
-		spi-cpol;
-		spi-cpha;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-- 
2.8.1
