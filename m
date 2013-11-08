From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 2/2] ARM: dts: doc: Document missing binding for ti-sdma controller
Date: Fri, 8 Nov 2013 16:08:49 +0530
Message-ID: <1383907129-7325-2-git-send-email-r.sricharan@ti.com>
References: <1383907129-7325-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50616 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638Ab3KHKjV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Nov 2013 05:39:21 -0500
In-Reply-To: <1383907129-7325-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, santosh.shilimkar@ti.com, r.sricharan@ti.com

The binding and support for system DMA module present in OMAP2+ Socs
and DRA7 with dma-engine is already present. So adding the missing
documentation for the same.

Cc: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-sdma.txt |   28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/ti-sdma.txt b/Documentation/devicetree/bindings/dma/ti-sdma.txt
new file mode 100644
index 0000000..7fb2342
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti-sdma.txt
@@ -0,0 +1,28 @@
+TI SDMA
+
+Required Properties:
+- compatible :	Should be "ti,omap2420-sdma", "ti,omap2430-sdma" for OMAP2
+		Should be "ti,omap3430-sdma", "ti,omap3630-sdma" for OMAP3
+		Should be "ti,omap4430-sdma" for OMAP4, OMAP5 and DRA7
+- reg: Memory map for accessing module
+- interrupts: Interrupt request number from the dma controller to
+	      interrupt controller
+- dma-cells: Should be set to <1>
+- dma-channels: Total number of logical DMA channels supported by the
+		controller
+- dma-requests: Total number of dma request signals supported by the
+		controller
+
+Example:
+
+sdma: dma-controller@48056000 {
+	compatible = "ti,omap4430-sdma";
+	reg = <0x48056000 0x1000>;
+	interrupts = <12>,
+		     <13>,
+		     <14>,
+		     <15>;
+	#dma-cells = <1>;
+	#dma-channels = <32>;
+	#dma-requests = <64>;
+};
-- 
1.7.9.5

