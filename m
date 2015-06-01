From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv4 03/10] arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
Date: Mon, 1 Jun 2015 09:23:11 +0300
Message-ID: <1433139798-23450-4-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57665 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758769AbbFAGX7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 02:23:59 -0400
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

We need set-rate-parent flags for the display's clock path so that the
DSS driver can change the clock rate of the PLL.

This patchs adds the ti,set-rate-parent flag to 'dss_dss_clk' clock
node, which is only a gate clock, allowing the setting of the clock rate
to propagate to the PLL.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 470f39c4e326..357bedeebfac 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1531,6 +1531,7 @@
 		clocks = <&dpll_per_h12x2_ck>;
 		ti,bit-shift = <8>;
 		reg = <0x1120>;
+		ti,set-rate-parent;
 	};
 
 	dss_hdmi_clk: dss_hdmi_clk {
-- 
2.1.4

