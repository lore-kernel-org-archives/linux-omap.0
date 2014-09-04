From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: dts: omap5.dtsi: add DSS RFBI node
Date: Thu, 4 Sep 2014 09:28:32 +0300
Message-ID: <1409812112-19194-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46218 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbaIDG3O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Sep 2014 02:29:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The RFBI node for OMAP DSS was left out when adding the rest of the DSS
nodes, because it was not clear how to set up the clocks for the RFBI.

However, it seems that if there is a HWMOD for a device, we also need a
DT node for it. Otherwise, at boot, we get:

WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2542 _init+0x464/0x4e0()
omap_hwmod: dss_rfbi: doesn't have mpu register target base

Now that v3.17-rc3 contains a fix
(8fd46439e1f5a7f86d76a08733459b74debd9468) for the L3 ICLK required by
the RFBI, let's add the RFBI node to get rid of the warning.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc8df1739f39..1e6ff61a7f12 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -945,6 +945,15 @@
 				clock-names = "fck";
 			};
 
+			rfbi: encoder@58002000  {
+				compatible = "ti,omap5-rfbi";
+				reg = <0x58002000 0x100>;
+				status = "disabled";
+				ti,hwmods = "dss_rfbi";
+				clocks = <&dss_dss_clk>, <&l3_iclk_div>;
+				clock-names = "fck", "ick";
+			};
+
 			dsi1: encoder@58004000 {
 				compatible = "ti,omap5-dsi";
 				reg = <0x58004000 0x200>,
-- 
1.9.1

