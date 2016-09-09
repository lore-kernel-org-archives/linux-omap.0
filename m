From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Configure omap5 OTG ID pin
Date: Fri,  9 Sep 2016 14:04:28 -0700
Message-ID: <20160909210428.19607-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The ID pin GPIO comes from the PMIC. Let's configure it as a GPIO
for the driver to use, and also make sure the PMIC GPIO pin muxing
is correct. The PMIC pad1 and 2 values for omap5-uevm and igepv5 are
0x5a and 0x1b, we only need to clear bit 2 in pad1 register to make
the ID pin GPIO work.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 9 +++++++++
 arch/arm/boot/dts/omap5.dtsi              | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 6c5b0f8..10a466b 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -393,14 +393,23 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,system-power-controller;
+		ti,mux-pad1 = <0xa1>;
+		ti,mux-pad2 = <0x1b>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&palmas_sys_nirq_pins &palmas_msecure_pins>;
 
+		palmas_gpio: gpio {
+			compatible = "ti,palmas-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		extcon_usb3: palmas_usb {
 			compatible = "ti,palmas-usb-vid";
 			ti,enable-vbus-detection;
 			ti,enable-id-detection;
 			ti,wakeup;
+			id-gpios = <&palmas_gpio 0 GPIO_ACTIVE_HIGH>;
 		};
 
 		clk32kgaudio: palmas_clk32k@1 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -863,7 +863,7 @@
 			#size-cells = <1>;
 			utmi-mode = <2>;
 			ranges;
-			dwc3@4a030000 {
+			dwc3: dwc3@4a030000 {
 				compatible = "snps,dwc3";
 				reg = <0x4a030000 0x10000>;
 				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.9.3
