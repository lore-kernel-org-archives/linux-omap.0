From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2] arm: dts: omap3: Add #iommu-cells to isp and iva iommu
Date: Tue, 31 Mar 2015 03:28:10 +0200
Message-ID: <1427765290-4148-1-git-send-email-sre@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:39680 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929AbbCaB2j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2015 21:28:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Add missing #iommu-cells property to the isp and iva iommu nodes. This
fixes the binding (property is required according to the generic iommu
binding) and removes the following kernel warning triggered once the
iommu nodes are referenced:

[    0.647521] /ocp/isp@480bc000: could not get #iommu-cells for /ocp/mmu@480bd400

Signed-off-by: Sebastian Reichel <sre@kernel.org>
Cc: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since PATCHv1:

 * Also add property to mmu_iva
---
 arch/arm/boot/dts/omap3.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index fe0b293..eb96cf9 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -440,6 +440,7 @@
 		};
 
 		mmu_isp: mmu@480bd400 {
+			#iommu-cells = <0>;
 			compatible = "ti,omap2-iommu";
 			reg = <0x480bd400 0x80>;
 			interrupts = <24>;
@@ -448,6 +449,7 @@
 		};
 
 		mmu_iva: mmu@5d000000 {
+			#iommu-cells = <0>;
 			compatible = "ti,omap2-iommu";
 			reg = <0x5d000000 0x80>;
 			interrupts = <28>;
-- 
2.1.4

