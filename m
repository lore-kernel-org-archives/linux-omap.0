From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: [PATCH 2/2] ARM: dts: omap3-evm: Add OMAP3530 specific device tree processor data
Date: Sat,  2 Sep 2017 19:38:16 -0500
Message-ID: <20170903003816.5536-3-woods.technical@gmail.com>
References: <20170903003816.5536-1-woods.technical@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170903003816.5536-1-woods.technical@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, "Derald D. Woods" <woods.technical@gmail.com>
List-Id: linux-omap@vger.kernel.org

This commit allows OMAP3530 variants to use common data that is
available in 'omap3-evm-processor-common.dtsi'. It adds proper pinmux
macros for 'omap3_pmx_core2' on OMAP3430. The Micron NAND chip is also
added for the TMDSEVM3530 processor module.
---
 arch/arm/boot/dts/omap3-evm.dts | 76 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index 99b2bfcd1059..21a3b88aef0c 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -9,13 +9,81 @@
 
 #include "omap34xx.dtsi"
 #include "omap3-evm-common.dtsi"
+#include "omap3-evm-processor-common.dtsi"
 
 / {
 	model = "TI OMAP35XX EVM (TMDSEVM3530)";
-	compatible = "ti,omap3-evm", "ti,omap3";
+	compatible = "ti,omap3-evm", "ti,omap3430", "ti,omap3";
+};
+
+&omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hsusb2_2_pins>;
+
+	ehci_phy_pins: pinmux_ehci_phy_pins {
+		pinctrl-single,pins = <
+
+		/* EHCI PHY reset GPIO etk_d7.gpio_21 */
+		OMAP3430_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)
+
+		/* EHCI VBUS etk_d8.gpio_22 */
+		OMAP3430_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)
+		>;
+	};
+
+	/* Used by OHCI and EHCI. OHCI won't work without external phy */
+	hsusb2_2_pins: pinmux_hsusb2_2_pins {
+		pinctrl-single,pins = <
+
+		/* etk_d10.hsusb2_clk */
+		OMAP3430_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)
+
+		/* etk_d11.hsusb2_stp */
+		OMAP3430_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)
+
+		/* etk_d12.hsusb2_dir */
+		OMAP3430_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)
+
+		/* etk_d13.hsusb2_nxt */
+		OMAP3430_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)
+
+		/* etk_d14.hsusb2_data0 */
+		OMAP3430_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)
+
+		/* etk_d15.hsusb2_data1 */
+		OMAP3430_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)
+		>;
+	};
+};
+
+&gpmc {
+	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		linux,mtd-name= "micron,mt29f2g16abdhc";
+		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
+		ti,nand-ecc-opt = "bch8";
+
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
 
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>; /* 256 MB */
+		#address-cells = <1>;
+		#size-cells = <1>;
 	};
 };
-- 
2.14.1
