From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 5/7] ARM: dts: Complete data for isp iommu
Date: Tue, 17 Dec 2013 13:53:36 +0100
Message-ID: <1387284818-28739-6-git-send-email-florian.vaussard@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:36778 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325Ab3LQMyP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 07:54:15 -0500
In-Reply-To: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Hiroshi Doyu <hdoyu@nvidia.com>, Florian Vaussard <florian.vaussard@epfl.ch>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add missing information required to probe the iommu for the camera
subsystem.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99..610d084 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -371,11 +371,13 @@
 			dma-names = "tx", "rx";
 		};
 
-		mmu_isp: mmu@480bd400 {
+		mmu_isp: mmu_isp@480bd400 {
 			compatible = "ti,omap3-mmu-isp";
 			ti,hwmods = "mmu_isp";
 			reg = <0x480bd400 0x80>;
 			interrupts = <8>;
+			ti,#tlb-entries = <8>;
+			dma-window = <0 0xfffff000>;	/* IOVA start & length */
 		};
 
 		wdt2: wdt@48314000 {
-- 
1.8.1.2

