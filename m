From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/23] ARM: dts: omap5-clocks.dtsi: add dss iclk
Date: Thu, 24 Apr 2014 13:17:04 +0300
Message-ID: <1398334639-14172-9-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59021 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396AbaDXKTI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:08 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>

Add missing DSS interface clock node.

Note: The TRM says DSS's interface clock is DSS_L3_GICLK, but it is not
clear to me from reading the TRM and looking at the
arch/arm/boot/dts/omap54xx-clocks.dtsi whether using 'l3_iclk_div' as
the parent for 'dss_l3_iclk' is the correct clock.

The clock is explicitly used only by the RFBI, and we don't have any
boards using the RFBI, so I have no means to test it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
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

