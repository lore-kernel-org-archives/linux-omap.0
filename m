From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 5/6] arm: dts: am33xx, Add device node for cpsw-ctrl-macid
Date: Wed, 18 Dec 2013 17:47:21 +0100
Message-ID: <1387385242-1161-6-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42018 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab3LRQsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 11:48:19 -0500
In-Reply-To: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f6d8ffe..4e1bf08 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -676,6 +676,13 @@
 				reg= <0x44e10650 0x4>;
 				reg-names = "gmii-sel";
 			};
+
+			cpsw_ctrl_macid: cpsw-ctrl-macid@44e10630 {
+				compatible = "ti,am3352-cpsw-ctrl-macid";
+				#ti,mac-address-ctrl-cells = <1>;
+				reg = <0x44e10630 0x16>;
+				reg-names = "ctrl-macid";
+			};
 		};
 
 		ocmcram: ocmcram@40300000 {
-- 
1.8.5.1

