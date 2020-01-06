From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v4 08/11] dt-bindings: sdhci-omap: Add documentation for ti,needs-special-reset property
Date: Mon, 6 Jan 2020 16:31:30 +0530
Message-ID: <20200106110133.13791-9-faiz_abbas@ti.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106110133.13791-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, tony@atomide.com, faiz_abbas@ti.com
List-Id: linux-omap@vger.kernel.org

Some controllers need a special software reset sequence. Document the
ti,needs-special-reset binding to indicate that a controller needs this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 97efb01617dd..0f5389c72bda 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -21,6 +21,7 @@ Optional properties:
 - dma-names:	List of DMA request names. These strings correspond 1:1 with the
 		DMA specifiers listed in dmas. The string naming is to be "tx"
 		and "rx" for TX and RX DMA requests, respectively.
+- ti,needs-special-reset: Requires a special softreset sequence
 
 Example:
 	mmc1: mmc@4809c000 {
-- 
2.19.2
