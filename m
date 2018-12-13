From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: dts: Cosmetic fix for omap5 USB node names
Date: Wed, 12 Dec 2018 18:18:01 -0800
Message-ID: <20181213021801.49938-2-tony@atomide.com>
References: <20181213021801.49938-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213021801.49938-1-tony@atomide.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

These should be now using offset from the module base and not the
full physical address.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-l4.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -195,7 +195,7 @@
 				#size-cells = <1>;
 				utmi-mode = <2>;
 				ranges = <0 0 0x20000>;
-				dwc3: dwc3@4a030000 {
+				dwc3: dwc3@10000 {
 					compatible = "snps,dwc3";
 					reg = <0x10000 0x10000>;
 					interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
@@ -332,14 +332,14 @@
 					      "refclk_60m_ext_p1",
 					      "refclk_60m_ext_p2";
 
-				usbhsohci: ohci@4a064800 {
+				usbhsohci: ohci@800 {
 					compatible = "ti,ohci-omap3";
 					reg = <0x800 0x400>;
 					interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 					remote-wakeup-connected;
 				};
 
-				usbhsehci: ehci@4a064c00 {
+				usbhsehci: ehci@c00 {
 					compatible = "ti,ehci-omap";
 					reg = <0xc00 0x400>;
 					interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.19.2
