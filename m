From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 6/7] ARM: dts: dra7: Add USB related nodes
Date: Mon, 28 Apr 2014 17:01:26 +0300
Message-ID: <1398693687-13967-7-git-send-email-rogerq@ti.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398693687-13967-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add nodes for the Super Speed USB controllers, omap-control-usb,
USB2 PHY and USB3 PHY devices.

Remove ocp2scp1 address space from hwmod data as it is
now provided via device tree.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi               | 149 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  10 --
 2 files changed, 149 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 149b550..4535e54 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -789,6 +789,155 @@
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
+
+		omap_control_usb2phy1: control-phy@4a002300 {
+			compatible = "ti,control-phy-usb2";
+			reg = <0x4a002300 0x4>;
+			reg-names = "power";
+		};
+
+		omap_control_usb3phy1: control-phy@4a002370 {
+			compatible = "ti,control-phy-pipe3";
+			reg = <0x4a002370 0x4>;
+			reg-names = "power";
+		};
+
+		omap_control_usb2phy2: control-phy@0x4a002e74 {
+			compatible = "ti,control-phy-usb2-dra7";
+			reg = <0x4a002e74 0x4>;
+			reg-names = "power";
+		};
+
+		/* OCP2SCP1 */
+		ocp2scp@4a080000 {
+			compatible = "ti,omap-ocp2scp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			reg = <0x4a080000 0x20>;
+			ti,hwmods = "ocp2scp1";
+
+			usb2_phy1: phy@4a084000 {
+				compatible = "ti,omap-usb2";
+				reg = <0x4a084000 0x400>;
+				ctrl-module = <&omap_control_usb2phy1>;
+				clocks = <&usb_phy1_always_on_clk32k>,
+					 <&usb_otg_ss1_refclk960m>;
+				clock-names =	"wkupclk",
+						"refclk";
+				#phy-cells = <0>;
+			};
+
+			usb2_phy2: phy@4a085000 {
+				compatible = "ti,omap-usb2";
+				reg = <0x4a085000 0x400>;
+				ctrl-module = <&omap_control_usb2phy2>;
+				clocks = <&usb_phy2_always_on_clk32k>,
+					 <&usb_otg_ss2_refclk960m>;
+				clock-names =	"wkupclk",
+						"refclk";
+				#phy-cells = <0>;
+			};
+
+			usb3_phy1: phy@4a084400 {
+				compatible = "ti,omap-usb3";
+				reg = <0x4a084400 0x80>,
+				      <0x4a084800 0x64>,
+				      <0x4a084c00 0x40>;
+				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+				ctrl-module = <&omap_control_usb3phy1>;
+				clocks = <&usb_phy3_always_on_clk32k>,
+					 <&sys_clkin1>,
+					 <&usb_otg_ss1_refclk960m>;
+				clock-names =	"wkupclk",
+						"sysclk",
+						"refclk";
+				#phy-cells = <0>;
+			};
+		};
+
+		omap_dwc3_1@48880000 {
+			compatible = "ti,dwc3";
+			ti,hwmods = "usb_otg_ss1";
+			reg = <0x48880000 0x10000>;
+			interrupts = <0 77 4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <2>;
+			ranges;
+			usb1: usb@48890000 {
+				compatible = "snps,dwc3";
+				reg = <0x48890000 0x17000>;
+				interrupts = <0 76 4>;
+				phys = <&usb2_phy1>, <&usb3_phy1>;
+				phy-names = "usb2-phy", "usb3-phy";
+				tx-fifo-resize;
+				maximum-speed = "super-speed";
+				dr_mode = "otg";
+			};
+		};
+
+		omap_dwc3_2@488c0000 {
+			compatible = "ti,dwc3";
+			ti,hwmods = "usb_otg_ss2";
+			reg = <0x488c0000 0x10000>;
+			interrupts = <0 92 4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <2>;
+			ranges;
+			usb2: usb@488d0000 {
+				compatible = "snps,dwc3";
+				reg = <0x488d0000 0x17000>;
+				interrupts = <0 78 4>;
+				phys = <&usb2_phy2>;
+				phy-names = "usb2-phy";
+				tx-fifo-resize;
+				maximum-speed = "high-speed";
+				dr_mode = "otg";
+			};
+		};
+
+		/* IRQ for DWC3_3 and DWC3_4 need IRQ crossbar */
+		omap_dwc3_3@48900000 {
+			compatible = "ti,dwc3";
+			ti,hwmods = "usb_otg_ss3";
+			reg = <0x48900000 0x10000>;
+		/*	interrupts = <0 TBD 4>; */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <2>;
+			ranges;
+			status = "disabled";
+			usb3: usb@48910000 {
+				compatible = "snps,dwc3";
+				reg = <0x48910000 0x17000>;
+		/*		interrupts = <0 93 4>; */
+				tx-fifo-resize;
+				maximum-speed = "high-speed";
+				dr_mode = "otg";
+			};
+		};
+
+		omap_dwc3_4@48940000 {
+			compatible = "ti,dwc3";
+			ti,hwmods = "usb_otg_ss4";
+			reg = <0x48940000 0x10000>;
+		/*	interrupts = <0 TBD 4>; */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <2>;
+			ranges;
+			status = "disabled";
+			usb4: usb@48950000 {
+				compatible = "snps,dwc3";
+				reg = <0x48950000 0x17000>;
+		/*		interrupts = <0 TBD 4>; */
+				tx-fifo-resize;
+				maximum-speed = "high-speed";
+				dr_mode = "otg";
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 067d322..d6f9709 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2330,21 +2330,11 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mpu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_ocp2scp1_addrs[] = {
-	{
-		.pa_start	= 0x4a080000,
-		.pa_end		= 0x4a08001f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
