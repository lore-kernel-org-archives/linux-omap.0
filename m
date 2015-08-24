From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/11] ARM: DTS: dra7: Add McASP3 node
Date: Mon, 24 Aug 2015 10:19:58 +0300
Message-ID: <1440400807-32274-3-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5d65db9ebc2b..07fa4ea5521a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1403,6 +1403,21 @@
 			status = "disabled";
 		};
 
+		mcasp3: mcasp@48468000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp3";
+			reg = <0x48468000 0x2000>;
+			reg-names = "mpu";
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&sdma_xbar 133>, <&sdma_xbar 132>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp3_ahclkx_mux>;
+			clock-names = "fck";
+			status = "disabled";
+		};
+
 		crossbar_mpu: crossbar@4a002a48 {
 			compatible = "ti,irq-crossbar";
 			reg = <0x4a002a48 0x130>;
-- 
2.5.0
