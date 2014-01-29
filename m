From: Nathan Lynch <nathan_lynch@mentor.com>
Subject: [PATCH] ARM: dts: OMAP5: add pmu node
Date: Wed, 29 Jan 2014 10:56:41 -0600
Message-ID: <1391014601-31663-1-git-send-email-nathan_lynch@mentor.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:35111 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbaA2Q46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jan 2014 11:56:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Expose the PMU on OMAP5.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---

Notes:
    Briefly tested with perf on OMAP5 UEVM with next-20140124.

 arch/arm/boot/dts/omap5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a9663e..fbf4661436e2 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -76,6 +76,12 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <0 131 4>,
+			     <0 132 4>;
+	};
+
 	gic: interrupt-controller@48211000 {
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
-- 
1.8.3.1

