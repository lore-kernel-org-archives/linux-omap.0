From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/11] ARM: dts: omap5-clocks.dtsi: add dss iclk
Date: Fri, 9 May 2014 14:56:15 +0300
Message-ID: <1399636579-8062-8-git-send-email-tomi.valkeinen@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39222 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756367AbaEIL5Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 07:57:16 -0400
In-Reply-To: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add missing DSS interface clock node.

Note: The TRM says DSS's interface clock is DSS_L3_GICLK, but it is not
clear to me from reading the TRM and looking at the
arch/arm/boot/dts/omap54xx-clocks.dtsi whether using 'l3_iclk_div' as
the parent for 'dss_l3_iclk' is the correct clock.

The clock is explicitly used only by the RFBI, and we don't have any
boards using the RFBI, so I have no means to test it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index d487fdab3921..26c02f9e92c4 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -418,6 +418,14 @@
 		clock-div = <1>;
 	};
 
+	dss_l3_iclk: dss_l3_iclk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&l3_iclk_div>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
+
 	slimbus1_slimbus_clk: slimbus1_slimbus_clk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-- 
1.9.1

