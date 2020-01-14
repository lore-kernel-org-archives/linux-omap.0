From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Configure omap5 AESS
Date: Tue, 14 Jan 2020 07:09:37 -0800
Message-ID: <20200114150937.18304-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50864 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgANPJn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 14 Jan 2020 10:09:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, "H . Nikolaus Schaller" <hns@goldelico.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>

We are missing AESS for omap5. Looks like it's similar to what we have
for omap4, and this gets ti-sysc interconnect target module driver to
detect it properly.

Note that we currently have no child device driver available for it.

Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Note that this depends on "[PATCH] clk: ti: omap5: Add missing AESS clock".

 arch/arm/boot/dts/omap5-l4-abe.dtsi | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-l4-abe.dtsi b/arch/arm/boot/dts/omap5-l4-abe.dtsi
--- a/arch/arm/boot/dts/omap5-l4-abe.dtsi
+++ b/arch/arm/boot/dts/omap5-l4-abe.dtsi
@@ -426,8 +426,20 @@ target-module@c0000 {			/* 0x401c0000, ap 30 1e.0 */
 		};
 
 		target-module@f1000 {			/* 0x401f1000, ap 32 20.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0xf1000 0x4>,
+			      <0xf1010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			/* Domains (V, P, C): iva, abe_pwrdm, abe_clkdm */
+			clocks = <&abe_clkctrl OMAP5_AESS_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xf1000 0x1000>,
-- 
2.24.1
