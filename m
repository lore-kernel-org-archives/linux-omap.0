From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] ARM: dts: Update edma bindings on dm814x to use edma_xbar
Date: Thu,  3 Dec 2015 17:25:30 -0800
Message-ID: <1449192335-10137-3-git-send-email-tony@atomide.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449192335-10137-1-git-send-email-tony@atomide.com>
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
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The edma is the same as on am33xx, except it has four tptc
instances. And we need the edma_xbar for at least mmc3, so
let's use the edma_xbar and the new binding as suggested by
Peter Ujfalusi <peter.ujfalusi@ti.com>.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 68 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index ca92346..9d81980e 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -126,8 +126,8 @@
 				interrupts = <65>;
 				ti,spi-num-cs = <4>;
 				ti,hwmods = "mcspi1";
-				dmas = <&edma 16 &edma 17
-					&edma 18 &edma 19>;
+				dmas = <&edma 16 0 &edma 17 0
+					&edma 18 0 &edma 19 0>;
 				dma-names = "tx0", "rx0", "tx1", "rx1";
 			};
 
@@ -145,7 +145,7 @@
 				reg = <0x20000 0x2000>;
 				clock-frequency = <48000000>;
 				interrupts = <72>;
-				dmas = <&edma 26 &edma 27>;
+				dmas = <&edma 26 0 &edma 27 0>;
 				dma-names = "tx", "rx";
 			};
 
@@ -155,7 +155,7 @@
 				reg = <0x22000 0x2000>;
 				clock-frequency = <48000000>;
 				interrupts = <73>;
-				dmas = <&edma 28 &edma 29>;
+				dmas = <&edma 28 0 &edma 29 0>;
 				dma-names = "tx", "rx";
 			};
 
@@ -165,7 +165,7 @@
 				reg = <0x24000 0x2000>;
 				clock-frequency = <48000000>;
 				interrupts = <74>;
-				dmas = <&edma 30 &edma 31>;
+				dmas = <&edma 30 0 &edma 31 0>;
 				dma-names = "tx", "rx";
 			};
 
@@ -205,6 +205,14 @@
 					};
 				};
 
+				edma_xbar: dma-router@f90 {
+					compatible = "ti,am335x-edma-crossbar";
+					reg = <0xf90 0x40>;
+					#dma-cells = <3>;
+					dma-requests = <32>;
+					dma-masters = <&edma>;
+				};
+
 				/*
 				 * Note that silicon revision 2.1 and older
 				 * require input enabled (bit 18 set) for all
@@ -272,12 +280,52 @@
 		};
 
 		edma: edma@49000000 {
-			compatible = "ti,edma3";
-			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
-			reg =	<0x49000000 0x10000>,
-				<0x44e10f90 0x40>;
+			compatible = "ti,edma3-tpcc";
+			ti,hwmods = "tpcc";
+			reg =	<0x49000000 0x10000>;
+			reg-names = "edma3_cc";
 			interrupts = <12 13 14>;
-			#dma-cells = <1>;
+			interrupt-names = "edma3_ccint", "emda3_mperr",
+					  "edma3_ccerrint";
+			dma-requests = <64>;
+			#dma-cells = <2>;
+
+			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
+				   <&edma_tptc2 3>, <&edma_tptc3 0>;
+
+			ti,edma-memcpy-channels = /bits/ 16 <20 21>;
+		};
+
+		edma_tptc0: tptc@49800000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc0";
+			reg =	<0x49800000 0x100000>;
+			interrupts = <112>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
+		edma_tptc1: tptc@49900000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc1";
+			reg =	<0x49900000 0x100000>;
+			interrupts = <113>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
+		edma_tptc2: tptc@49a00000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc2";
+			reg =	<0x49a00000 0x100000>;
+			interrupts = <114>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
+		edma_tptc3: tptc@49b00000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc3";
+			reg =	<0x49b00000 0x100000>;
+			interrupts = <115>;
+			interrupt-names = "edma3_tcerrint";
 		};
 
 		/* See TRM "Table 1-318. L4HS Instance Summary" */
-- 
2.6.2
