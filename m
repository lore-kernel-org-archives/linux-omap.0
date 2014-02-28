From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 2/4] ARM: dts: OMAP3: Add IVA IOMMU node
Date: Fri, 28 Feb 2014 14:49:52 -0600
Message-ID: <1393620594-14957-3-git-send-email-s-anna@ti.com>
References: <1393620594-14957-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41830 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbaB1UuZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 15:50:25 -0500
In-Reply-To: <1393620594-14957-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

From: Florian Vaussard <florian.vaussard@epfl.ch>

Add the DT node for the IOMMU within the DSP subsystem. The entry
is disabled to keep in line with the hwmod usage as intended by
the deprecated CONFIG_OMAP_IOMMU_IVA2 flag.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
[s-anna@ti.com: split the entry and disable the node]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index f7a47e3..9574a9e 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -418,6 +418,14 @@
 			ti,#tlb-entries = <8>;
 		};
 
+		mmu_iva: mmu@5d000000 {
+			compatible = "ti,omap2-iommu";
+			reg = <0x5d000000 0x80>;
+			interrupts = <28>;
+			ti,hwmods = "mmu_iva";
+			status = "disabled";
+		};
+
 		wdt2: wdt@48314000 {
 			compatible = "ti,omap3-wdt";
 			reg = <0x48314000 0x80>;
-- 
1.9.0

