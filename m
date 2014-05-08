From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] arm: dts: fix display clk rate rounding for am33xx & am43xx
Date: Thu, 8 May 2014 12:06:49 +0300
Message-ID: <1399540009-6953-3-git-send-email-tomi.valkeinen@ti.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58349 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397AbaEHJHL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 05:07:11 -0400
In-Reply-To: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add ti,round-rate flag for the display PLLs for both AM33xx and AM43xx.
This is needed so that the display driver can request pixel clocks
freely.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am33xx-clocks.dtsi | 1 +
 arch/arm/boot/dts/am43xx-clocks.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
index 9ccfe508dea2..3e152d0d6bdc 100644
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -266,6 +266,7 @@
 		compatible = "ti,am3-dpll-no-gate-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x0498>, <0x0448>, <0x0454>;
+		ti,round-rate;
 	};
 
 	dpll_disp_m2_ck: dpll_disp_m2_ck {
diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 142009cc9332..23019f3f3fbf 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -218,6 +218,7 @@
 		compatible = "ti,am3-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x2e20>, <0x2e24>, <0x2e2c>;
+		ti,round-rate;
 	};
 
 	dpll_disp_m2_ck: dpll_disp_m2_ck {
-- 
1.9.1

