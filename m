From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 7/7] arm: dts: am33xx, Add syscon phandle to cpsw node
Date: Sat, 16 Aug 2014 17:18:35 +0200
Message-ID: <1408202315-20006-8-git-send-email-mpa@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44804 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbaHPPT3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Aug 2014 11:19:29 -0400
In-Reply-To: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

There are 2 MACIDs stored in the control module of the am33xx. These are
read by the cpsw driver if no valid MACID was found in the devicetree.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index cb1113bcc290..5e9bfb3b9f1d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -692,6 +692,7 @@
 			 */
 			interrupts = <40 41 42 43>;
 			ranges;
+			syscon = <&cm>;
 			status = "disabled";
 
 			davinci_mdio: mdio@4a101000 {
-- 
2.0.1

