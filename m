From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/11] ARM: dts: am4372.dtsi: add DSS information
Date: Fri, 9 May 2014 14:56:11 +0300
Message-ID: <1399636579-8062-4-git-send-email-tomi.valkeinen@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53768 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbaEIL5F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 07:57:05 -0400
In-Reply-To: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Sathya Prakash M R <sathyap@ti.com>

Add DT data for the display subsystem for AM4372. The DSS on AM4372 is
basically OMAP3's DSS, without DSI and VENC blocks.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d1f8707ff1df..8fd413d6d14b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -735,6 +735,36 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		dss: dss@4832a000 {
+			compatible = "ti,omap3-dss";
+			reg = <0x4832a000 0x200>;
+			status = "disabled";
+			ti,hwmods = "dss_core";
+			clocks = <&disp_clk>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@4832a400 {
+				compatible = "ti,omap3-dispc";
+				reg = <0x4832a400 0x400>;
+				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dispc";
+				clocks = <&disp_clk>;
+				clock-names = "fck";
+			};
+
+			rfbi: rfbi@4832a800 {
+				compatible = "ti,omap3-rfbi";
+				reg = <0x4832a800 0x100>;
+				ti,hwmods = "dss_rfbi";
+				clocks = <&disp_clk>;
+				clock-names = "fck";
+			};
+
+		};
 	};
 };
 
-- 
1.9.1

