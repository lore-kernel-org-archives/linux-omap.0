From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] ARM: dts: Typo s/interrupts-names/interrupt-names/g
Date: Tue, 22 Apr 2014 20:40:24 +0200
Message-ID: <1398192025-31523-3-git-send-email-geert+renesas@glider.be>
References: <1398192025-31523-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398192025-31523-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc: kernel@stlinux.com, Geert Uytterhoeven <geert+renesas@glider.be>, Srinivas Kandagatla <srinivas.kandagatla@st.com>, linux-kernel@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Cc: linux-omap@vger.kernel.org
Cc: kernel@stlinux.com
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/am33xx.dtsi          |    4 ++--
 arch/arm/boot/dts/am4372.dtsi          |    4 ++--
 arch/arm/boot/dts/stih415-pinctrl.dtsi |   10 +++++-----
 arch/arm/boot/dts/stih416-pinctrl.dtsi |   10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 07f283c20eb1..cb6811e5ae5a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -802,7 +802,7 @@
 			      <0x46000000 0x400000>;
 			reg-names = "mpu", "dat";
 			interrupts = <80>, <81>;
-			interrupts-names = "tx", "rx";
+			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 8>,
 				<&edma 9>;
@@ -816,7 +816,7 @@
 			      <0x46400000 0x400000>;
 			reg-names = "mpu", "dat";
 			interrupts = <82>, <83>;
-			interrupts-names = "tx", "rx";
+			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 10>,
 				<&edma 11>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 36d523a26831..d1f8707ff1df 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -691,7 +691,7 @@
 			      <0x46000000 0x400000>;
 			reg-names = "mpu", "dat";
 			interrupts = <80>, <81>;
-			interrupts-names = "tx", "rx";
+			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 8>,
 			       <&edma 9>;
@@ -705,7 +705,7 @@
 			      <0x46400000 0x400000>;
 			reg-names = "mpu", "dat";
 			interrupts = <82>, <83>;
-			interrupts-names = "tx", "rx";
+			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 10>,
 			       <&edma 11>;
diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/dts/stih415-pinctrl.dtsi
index f09fb10a3791..81df870e5ee6 100644
--- a/arch/arm/boot/dts/stih415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
@@ -49,7 +49,7 @@
 			reg 		= <0xfe61f080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges 		= <0 0xfe610000 0x5000>;
 
 			PIO0: gpio@fe610000 {
@@ -187,7 +187,7 @@
 			reg 		= <0xfee0f080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges		= <0 0xfee00000 0x8000>;
 
 			PIO5: gpio@fee00000 {
@@ -282,7 +282,7 @@
 			reg 		= <0xfe82f080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges		= <0 0xfe820000 0x8000>;
 
 			PIO13: gpio@fe820000 {
@@ -423,7 +423,7 @@
 			reg 		= <0xfd6bf080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges		= <0 0xfd6b0000 0x3000>;
 
 			PIO100: gpio@fd6b0000 {
@@ -460,7 +460,7 @@
 			reg 		= <0xfd33f080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges		= <0 0xfd330000 0x5000>;
 
 			PIO103: gpio@fd330000 {
diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index aeea304086eb..250d5ecc951e 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -53,7 +53,7 @@
 			reg 		= <0xfe61f080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges		= <0 0xfe610000 0x6000>;
 
 			PIO0: gpio@fe610000 {
@@ -201,7 +201,7 @@
 			reg 		= <0xfee0f080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges		= <0 0xfee00000 0x10000>;
 
 			PIO5: gpio@fee00000 {
@@ -333,7 +333,7 @@
 			reg 		= <0xfe82f080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges 		= <0 0xfe820000 0x6000>;
 
 			PIO13: gpio@fe820000 {
@@ -461,7 +461,7 @@
 			reg 		= <0xfd6bf080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges		= <0 0xfd6b0000 0x3000>;
 
 			PIO100: gpio@fd6b0000 {
@@ -498,7 +498,7 @@
 			reg 		= <0xfd33f080 0x4>;
 			reg-names	= "irqmux";
 			interrupts 	= <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts-names = "irqmux";
+			interrupt-names	= "irqmux";
 			ranges			= <0 0xfd330000 0x5000>;
 
 			PIO103: gpio@fd330000 {
-- 
1.7.9.5
