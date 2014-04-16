From: Archit Taneja <archit@ti.com>
Subject: [RFC 2/4] ARM: dts: Add ctrl-core DT node for DRA7
Date: Wed, 16 Apr 2014 18:44:21 +0530
Message-ID: <1397654063-8055-2-git-send-email-archit@ti.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54827 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589AbaDPNPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Apr 2014 09:15:50 -0400
In-Reply-To: <1397654063-8055-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

Add DT node for the ctrl-core sub module of the DRA7 control module. We map the
CTRL_MODULE_CORE address region up to 0x4a002d60, this region contains register
fields which configure clocks. The remainder of the registers are related to
pad configurations or cross-bar configurations, and therefore aren't mapped.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1c0f8e1..58bbdf3 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -148,6 +148,19 @@
 			};
 		};
 
+		ctrl_core: ctrl_core@4a002000 {
+			compatible = "ti,dra7-ctrl-core";
+			reg = <0x4a002000 0x6d0>;
+
+			ctrl_core_clocks: clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			ctrl_core_clockdomains: clockdomains {
+			};
+		};
+
 		counter32k: counter@4ae04000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x4ae04000 0x40>;
-- 
1.8.3.2

