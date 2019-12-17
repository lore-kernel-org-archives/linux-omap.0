From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/14] ARM: dts: Add generic compatible for omap sdma instances
Date: Mon, 16 Dec 2019 16:19:12 -0800
Message-ID: <20191217001925.44558-2-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vinod Koul <vinod.koul@intel.com>, Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We need this to pass auxdata to all the sdma instances.

Cc: devicetree@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi  | 2 +-
 arch/arm/boot/dts/omap4-l4.dtsi | 2 +-
 arch/arm/boot/dts/omap5-l4.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -212,7 +212,7 @@ SYSC_OMAP2_SOFTRESET |
 			ranges = <0x0 0x56000 0x1000>;
 
 			sdma: dma-controller@0 {
-				compatible = "ti,omap4430-sdma";
+				compatible = "ti,omap4430-sdma", "ti,omap-sdma";
 				reg = <0x0 0x1000>;
 				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -160,7 +160,7 @@ SYSC_OMAP2_SOFTRESET |
 			ranges = <0x0 0x56000 0x1000>;
 
 			sdma: dma-controller@0 {
-				compatible = "ti,omap4430-sdma";
+				compatible = "ti,omap4430-sdma", "ti,omap-sdma";
 				reg = <0x0 0x1000>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -237,7 +237,7 @@ SYSC_OMAP2_SOFTRESET |
 			ranges = <0x0 0x56000 0x1000>;
 
 			sdma: dma-controller@0 {
-				compatible = "ti,omap4430-sdma";
+				compatible = "ti,omap4430-sdma", "ti,omap-sdma";
 				reg = <0x0 0x1000>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.24.1
