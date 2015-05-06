From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/2] ARM: dts: am4372: Add emif node
Date: Wed, 6 May 2015 12:25:33 -0500
Message-ID: <1430933133-33412-3-git-send-email-d-gerlach@ti.com>
References: <1430933133-33412-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45330 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190AbbEFR0K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 May 2015 13:26:10 -0400
In-Reply-To: <1430933133-33412-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>

Add node for TI AM4372 EMIF.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt | 1 +
 arch/arm/boot/dts/am4372.dtsi                                    | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
index 938f8e1..0db6047 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -8,6 +8,7 @@ of the EMIF IP and memory parts attached to it.
 Required properties:
 - compatible	: Should be of the form "ti,emif-<ip-rev>" where <ip-rev>
   is the IP revision of the specific EMIF instance.
+		  For am437x should be ti,emif-am4372.
 
 - phy-type	: <u32> indicating the DDR phy type. Following are the
   allowed values
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e2..9521a38 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -132,6 +132,12 @@
 			};
 		};
 
+		emif: emif@4c000000 {
+			compatible = "ti,emif-am4372";
+			reg = <0x4c000000 0x1000000>;
+			ti,hwmods = "emif";
+		};
+
 		edma: edma@49000000 {
 			compatible = "ti,edma3";
 			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
-- 
2.3.6

