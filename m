From: Nathan Lynch <nathan_lynch@mentor.com>
Subject: [PATCH v2] ARM: dts: OMAP5: add pmu node
Date: Wed, 19 Mar 2014 10:45:53 -0500
Message-ID: <1395243953-11856-1-git-send-email-nathan_lynch@mentor.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:59903 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297AbaCSPqV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 11:46:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, bcousson@baylibre.com

Expose the PMU on OMAP5.

Tested with perf on OMAP5 uEVM.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---

Changes since v1:
- Use symbolic constants.

 arch/arm/boot/dts/omap5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a9663e..ccb38944c85a 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -76,6 +76,12 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	gic: interrupt-controller@48211000 {
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
-- 
1.8.3.1

