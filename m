From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] ARM: dts: Add usb support for dm814x and dra62x
Date: Fri,  4 Dec 2015 15:31:06 -0800
Message-ID: <1449271869-7614-4-git-send-email-tony@atomide.com>
References: <1449271869-7614-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449271869-7614-1-git-send-email-tony@atomide.com>
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
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Felipe Balbi <balbi@ti.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The usb is very much like on am33xx, we just put the some of the
componends under scm where they belong.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 125 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 18a8f0d..c254ace 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -21,6 +21,10 @@
 		serial2 = &uart3;
 		ethernet0 = &cpsw_emac0;
 		ethernet1 = &cpsw_emac1;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		phy0 = &usb0_phy;
+		phy1 = &usb1_phy;
 	};
 
 	cpus {
@@ -57,6 +61,113 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
+		usb: usb@47400000 {
+			compatible = "ti,am33xx-usb";
+			reg = <0x47400000 0x1000>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ti,hwmods = "usb_otg_hs";
+
+			usb0_phy: usb-phy@47401300 {
+				compatible = "ti,am335x-usb-phy";
+				reg = <0x47401300 0x100>;
+				reg-names = "phy";
+				ti,ctrl_mod = <&usb_ctrl_mod>;
+			};
+
+			usb0: usb@47401000 {
+				compatible = "ti,musb-am33xx";
+				reg = <0x47401400 0x400
+				       0x47401000 0x200>;
+				reg-names = "mc", "control";
+
+				interrupts = <18>;
+				interrupt-names = "mc";
+				dr_mode = "otg";
+				mentor,multipoint = <1>;
+				mentor,num-eps = <16>;
+				mentor,ram-bits = <12>;
+				mentor,power = <500>;
+				phys = <&usb0_phy>;
+
+				dmas = <&cppi41dma  0 0 &cppi41dma  1 0
+					&cppi41dma  2 0 &cppi41dma  3 0
+					&cppi41dma  4 0 &cppi41dma  5 0
+					&cppi41dma  6 0 &cppi41dma  7 0
+					&cppi41dma  8 0 &cppi41dma  9 0
+					&cppi41dma 10 0 &cppi41dma 11 0
+					&cppi41dma 12 0 &cppi41dma 13 0
+					&cppi41dma 14 0 &cppi41dma  0 1
+					&cppi41dma  1 1 &cppi41dma  2 1
+					&cppi41dma  3 1 &cppi41dma  4 1
+					&cppi41dma  5 1 &cppi41dma  6 1
+					&cppi41dma  7 1 &cppi41dma  8 1
+					&cppi41dma  9 1 &cppi41dma 10 1
+					&cppi41dma 11 1 &cppi41dma 12 1
+					&cppi41dma 13 1 &cppi41dma 14 1>;
+				dma-names =
+					"rx1", "rx2", "rx3", "rx4", "rx5", "rx6", "rx7",
+					"rx8", "rx9", "rx10", "rx11", "rx12", "rx13",
+					"rx14", "rx15",
+					"tx1", "tx2", "tx3", "tx4", "tx5", "tx6", "tx7",
+					"tx8", "tx9", "tx10", "tx11", "tx12", "tx13",
+					"tx14", "tx15";
+			};
+
+			usb1: usb@47401800 {
+				compatible = "ti,musb-am33xx";
+				reg = <0x47401c00 0x400
+					0x47401800 0x200>;
+				reg-names = "mc", "control";
+				interrupts = <19>;
+				interrupt-names = "mc";
+				dr_mode = "otg";
+				mentor,multipoint = <1>;
+				mentor,num-eps = <16>;
+				mentor,ram-bits = <12>;
+				mentor,power = <500>;
+				phys = <&usb1_phy>;
+
+				dmas = <&cppi41dma 15 0 &cppi41dma 16 0
+					&cppi41dma 17 0 &cppi41dma 18 0
+					&cppi41dma 19 0 &cppi41dma 20 0
+					&cppi41dma 21 0 &cppi41dma 22 0
+					&cppi41dma 23 0 &cppi41dma 24 0
+					&cppi41dma 25 0 &cppi41dma 26 0
+					&cppi41dma 27 0 &cppi41dma 28 0
+					&cppi41dma 29 0 &cppi41dma 15 1
+					&cppi41dma 16 1 &cppi41dma 17 1
+					&cppi41dma 18 1 &cppi41dma 19 1
+					&cppi41dma 20 1 &cppi41dma 21 1
+					&cppi41dma 22 1 &cppi41dma 23 1
+					&cppi41dma 24 1 &cppi41dma 25 1
+					&cppi41dma 26 1 &cppi41dma 27 1
+					&cppi41dma 28 1 &cppi41dma 29 1>;
+				dma-names =
+					"rx1", "rx2", "rx3", "rx4", "rx5", "rx6", "rx7",
+					"rx8", "rx9", "rx10", "rx11", "rx12", "rx13",
+					"rx14", "rx15",
+					"tx1", "tx2", "tx3", "tx4", "tx5", "tx6", "tx7",
+					"tx8", "tx9", "tx10", "tx11", "tx12", "tx13",
+					"tx14", "tx15";
+			};
+
+			cppi41dma: dma-controller@47402000 {
+				compatible = "ti,am3359-cppi41";
+				reg =  <0x47400000 0x1000
+					0x47402000 0x1000
+					0x47403000 0x1000
+					0x47404000 0x4000>;
+				reg-names = "glue", "controller", "scheduler", "queuemgr";
+				interrupts = <17>;
+				interrupt-names = "glue";
+				#dma-cells = <2>;
+				#dma-channels = <30>;
+				#dma-requests = <256>;
+			};
+		};
+
 		/*
 		 * See TRM "Table 1-317. L4LS Instance Summary" for hints.
 		 * It shows the module target agent registers though, so the
@@ -227,6 +338,13 @@
 					};
 				};
 
+				usb_ctrl_mod: control@620 {
+					compatible = "ti,am335x-usb-ctrl-module";
+					reg = <0x620 0x10
+						0x648 0x4>;
+					reg-names = "phy_ctrl", "wakeup";
+				};
+
 				edma_xbar: dma-router@f90 {
 					compatible = "ti,am335x-edma-crossbar";
 					reg = <0xf90 0x40>;
@@ -251,6 +369,13 @@
 					pinctrl-single,register-width = <32>;
 					pinctrl-single,function-mask = <0x307ff>;
 				};
+
+				usb1_phy: usb-phy@1b00 {
+					compatible = "ti,am335x-usb-phy";
+					reg = <0x1b00 0x100>;
+					reg-names = "phy";
+					ti,ctrl_mod = <&usb_ctrl_mod>;
+				};
 			};
 
 			prcm: prcm@180000 {
-- 
2.6.2
