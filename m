From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 5/5] arm: dts: am33xx, Add device node for cpsw-ctrl-macid
Date: Sat, 15 Mar 2014 14:07:44 +0100
Message-ID: <1394888864-11007-6-git-send-email-mpa@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44265 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbaCONJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Mar 2014 09:09:02 -0400
In-Reply-To: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Add cpsw-ctrl-macid to the am33xx dtsi file. It does not change the
behaviour of boards with a provided mac-address, so it is safe to add it
for all boards with this CPU.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6d95d3d..5aff257 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -690,11 +690,13 @@
 			cpsw_emac0: slave@4a100200 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
+				ti,mac-address-ctrl = <&cpsw_ctrl_macid 0>;
 			};
 
 			cpsw_emac1: slave@4a100300 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
+				ti,mac-address-ctrl = <&cpsw_ctrl_macid 1>;
 			};
 
 			phy_sel: cpsw-phy-sel@44e10650 {
@@ -702,6 +704,13 @@
 				reg= <0x44e10650 0x4>;
 				reg-names = "gmii-sel";
 			};
+
+			cpsw_ctrl_macid: cpsw-ctrl-macid@44e10630 {
+				compatible = "ti,am3352-cpsw-ctrl-macid";
+				#ti,mac-address-ctrl-cells = <1>;
+				reg = <0x44e10630 0x10>;
+				reg-names = "ctrl-macid";
+			};
 		};
 
 		ocmcram: ocmcram@40300000 {
-- 
1.9.0

