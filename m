From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 3/4] ARM: dts: OMAP4: Add IOMMU nodes
Date: Fri, 28 Feb 2014 14:49:53 -0600
Message-ID: <1393620594-14957-4-git-send-email-s-anna@ti.com>
References: <1393620594-14957-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58496 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbaB1Uu2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 15:50:28 -0500
In-Reply-To: <1393620594-14957-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

From: Florian Vaussard <florian.vaussard@epfl.ch>

Add the IOMMU nodes for the DSP and IPU subsystems. The MMU
within the IPU sub-system also supports a bus error back
capability, not available on the DSP MMU.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
[s-anna@ti.com: IPU bus error back addition]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..ab7be95 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -461,6 +461,21 @@
 			dma-names = "tx", "rx";
 		};
 
+		mmu_dsp: mmu@4a066000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x4a066000 0xff>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_dsp";
+		};
+
+		mmu_ipu: mmu@55082000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x55082000 0xff>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu";
+			ti,iommu-bus-err-back;
+		};
+
 		wdt2: wdt@4a314000 {
 			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
 			reg = <0x4a314000 0x80>;
-- 
1.9.0

