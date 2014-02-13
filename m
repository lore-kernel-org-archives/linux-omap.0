From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/4] ARM: dts: OMAP5: Add IOMMU nodes
Date: Thu, 13 Feb 2014 12:22:56 -0600
Message-ID: <1392315776-33197-5-git-send-email-s-anna@ti.com>
References: <1392315776-33197-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42281 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbaBMSYL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 13:24:11 -0500
In-Reply-To: <1392315776-33197-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The IOMMU DT nodes have been added for the DSP and IPU
subsystems. The MMUs in OMAP5 are identical to those in
OMAP4, including the bus error back capability on IPU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a..a78fdaa 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -513,6 +513,23 @@
 			dma-names = "tx", "rx";
 		};
 
+		mmu_dsp: mmu@4a066000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x4a066000 0xff>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_dsp";
+			dma-window = <0x20000000 0xdffff000>;
+		};
+
+		mmu_ipu: mmu@55082000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x55082000 0xff>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu";
+			dma-window = <0 0xdffff000>;
+			ti,iommu-bus-err-back;
+		};
+
 		keypad: keypad@4ae1c000 {
 			compatible = "ti,omap4-keypad";
 			reg = <0x4ae1c000 0x400>;
-- 
1.8.5.3

