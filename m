From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/5] dt-bindings: dma: ti-edma: Add option for reserved channel ranges
Date: Fri, 23 Aug 2019 15:56:17 +0300
Message-ID: <20190823125618.8133-5-peter.ujfalusi@ti.com>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, robh+dt@kernel.org
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Similarly to paRAM slots, channels can be used by other cores.

Add optional property to configure the reserved channel ranges.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index 4bbc94d829c8..1198682ada99 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -42,6 +42,9 @@ Optional properties:
 - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
 		the driver, they are allocated to be used by for example the
 		DSP. See example.
+- ti,edma-reserved-chan-ranges: channel ranges which should not be used by
+		the driver, they are allocated to be used by for example the
+		DSP. See example.
 
 ------------------------------------------------------------------------------
 eDMA3 Transfer Controller
@@ -91,6 +94,8 @@ edma: edma@49000000 {
 	ti,edma-memcpy-channels = <20 21>;
 	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
 	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
+	/* The following channels are reserved: 35-44 */
+	ti,edma-reserved-chan-ranges = <35 10>;
 };
 
 edma_tptc0: tptc@49800000 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
