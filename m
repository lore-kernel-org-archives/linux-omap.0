From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 03/11] ARM: DTS: dra7: Enable eDMA
Date: Thu, 25 Feb 2016 16:50:19 +0200
Message-ID: <1456411827-23962-4-git-send-email-peter.ujfalusi@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

DRA7 family has eDMA available along with the sDMA and in some cases it is
better suited for servicing peripherals.

Add the needed nodes for eDMA to be usable:
edma-tpcc, edma-tptc0/1 and the edma-xbar.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 114286dbee25..d2d2568b5695 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -170,6 +170,15 @@
 					ti,dma-safe-map = <0>;
 					dma-masters = <&sdma>;
 				};
+
+				edma_xbar: dma-router@c78 {
+					compatible = "ti,dra7-dma-crossbar";
+					reg = <0xc78 0x7c>;
+					#dma-cells = <2>;
+					dma-requests = <204>;
+					ti,dma-safe-map = <0>;
+					dma-masters = <&edma>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon@5000 {
@@ -324,6 +333,45 @@
 			dma-requests = <127>;
 		};
 
+		edma: edma@43300000 {
+			compatible = "ti,edma3-tpcc";
+			ti,hwmods = "tpcc";
+			reg = <0x43300000 0x100000>;
+			reg-names = "edma3_cc";
+			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_ccint", "emda3_mperr",
+					  "edma3_ccerrint";
+			dma-requests = <64>;
+			#dma-cells = <2>;
+
+			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 0>;
+
+			/*
+			 * memcpy is disabled, can be enabled with:
+			 * ti,edma-memcpy-channels = <20 21>;
+			 * for example. Note that these channels need to be
+			 * masked in the xbar as well.
+			 */
+		};
+
+		edma_tptc0: tptc@43400000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc0";
+			reg =	<0x43400000 0x100000>;
+			interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
+		edma_tptc1: tptc@43500000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc1";
+			reg =	<0x43500000 0x100000>;
+			interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
 		gpio1: gpio@4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
-- 
2.7.1
