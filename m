From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH V3 5/6] ARM: am4372.dtsi: add omapdss information
Date: Mon, 24 Mar 2014 16:31:55 +0530
Message-ID: <1395658916-9032-6-git-send-email-sathyap@ti.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48678 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbaCXLCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Mar 2014 07:02:10 -0400
In-Reply-To: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Sathya Prakash M R <sathyap@ti.com>

Add DT data for the display subsystem, which contains the following
blocks:
    dss - the wrapper/glue for the display modules
    dispc - display controller
    rfbi - MIPI DBI encoder
dss subsystem of am43x is re use from omap3.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ea55a4e..58fb78b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -684,6 +684,41 @@
 			num-cs = <4>;
                         status = "disabled";
                 };
+
+		dss: dss@4832A000 {
+			compatible = "ti,omap3-dss", "simple-bus";
+			reg = <0x4832A000 0x200>;
+			status = "disabled";
+			ti,hwmods = "dss_core";
+			clocks = <&disp_clk>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@4832A400 {
+				compatible = "ti,omap3-dispc";
+				reg = <0x4832A400 0x400>;
+				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dispc";
+				clocks = <&disp_clk>;
+				clock-names = "fck";
+			};
+
+			dpi: encoder@0 {
+				compatible = "ti,omap3-dpi";
+			};
+
+			rfbi: rfbi@4832A800 {
+				compatible = "ti,omap3-rfbi";
+				reg = <0x4832A800 0x100>;
+				ti,hwmods = "dss_rfbi";
+				clocks = <&disp_clk>;
+				clock-names = "fck";
+			};
+
+		};
+
 	};
 
 	clocks {
-- 
1.7.9.5

