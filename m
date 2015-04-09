From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 2/8] Documentation: devicetree: dma: Binding documentation
 for TI DMA crossbar
Date: Thu, 9 Apr 2015 12:35:48 +0300
Message-ID: <1428572154-3548-3-git-send-email-peter.ujfalusi@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: nm@ti.com, devicetree@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, robh+dt@kernel.org, grant.likely@linaro.org, maxime.ripard@free-electrons.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The DRA7x has more peripherals with DMA requests than the sDMA can handle:
205 vs 127. All DMA requests are routed through the DMA crossbar, which can
be configured to route selected incoming DMA requests to specific request
line of the DMA controller.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt

diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
new file mode 100644
index 000000000000..63a48928f3a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
@@ -0,0 +1,52 @@
+Texas Instruments DMA Crossbar (DMA request router)
+
+Required properties:
+- compatible:	"ti,dra7-dma-crossbar" for DRA7xx DMA crossbar
+- reg:		Memory map for accessing module
+- #dma-cells:	Should be set to <1>.
+		Clients should use the crossbar request number (input)
+- dma-requests:	Number of DMA requests the crossbar can receive
+- dma-masters:	phandle pointing to the DMA controller
+
+The DMA controller node need to have the following poroperties:
+- dma-requests:	Number of DMA requests the controller can handle
+
+Optional properties:
+- ti,dma-safe-map: Safe routing value for unused request lines
+
+Example:
+
+/* DMA controller */
+sdma: dma-controller@4a056000 {
+	compatible = "ti,omap4430-sdma";
+	reg = <0x4a056000 0x1000>;
+	interrupts =	<GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	#dma-cells = <1>;
+	dma-channels = <32>;
+	dma-requests = <127>;
+};
+
+/* DMA crossbar */
+sdma_xbar: dma-router@4a002b78 {
+	compatible = "ti,dra7-dma-crossbar";
+	reg = <0x4a002b78 0xfc>;
+	#dma-cells = <1>;
+	dma-requests = <205>;
+	ti,dma-safe-map = <0>;
+	dma-masters = <&sdma>;
+};
+
+/* DMA client */
+uart1: serial@4806a000 {
+	compatible = "ti,omap4-uart";
+	reg = <0x4806a000 0x100>;
+	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+	ti,hwmods = "uart1";
+	clock-frequency = <48000000>;
+	status = "disabled";
+	dmas = <&sdma_xbar 49>, <&sdma_xbar 50>;
+	dma-names = "tx", "rx";
+};
-- 
2.3.5
