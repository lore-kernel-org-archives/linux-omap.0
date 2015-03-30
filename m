From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] arm: dts: omap3: Add #iommu-cells to isp iommu
Date: Tue, 31 Mar 2015 01:13:23 +0200
Message-ID: <1427757203-6347-1-git-send-email-sre@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:36366 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbbC3XOP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2015 19:14:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Add missing #iommu-cells property to the image signal processor's iommu
node. This fixes the binding (property is required according to the
generic iommu binding) and removes the following kernel warning
triggered once the iommu node is referenced:

[    0.647521] /ocp/isp@480bc000: could not get #iommu-cells for /ocp/mmu@480bd400

Signed-off-by: Sebastian Reichel <sre@kernel.org>
Cc: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap3.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index fe0b293..77751ef 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -440,6 +440,7 @@
 		};
 
 		mmu_isp: mmu@480bd400 {
+			#iommu-cells = <0>;
 			compatible = "ti,omap2-iommu";
 			reg = <0x480bd400 0x80>;
 			interrupts = <24>;
-- 
2.1.4

