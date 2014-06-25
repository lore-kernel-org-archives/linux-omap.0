From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH] ARM: dts: Fix TI CPSW Phy mode selection on IGEP COM AQUILA.
Date: Wed, 25 Jun 2014 13:42:05 +0200
Message-ID: <1403696525-10099-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:47328 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170AbaFYLmn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 07:42:43 -0400
Received: by mail-wg0-f41.google.com with SMTP id a1so1768843wgh.0
        for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2014 04:42:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

As this board use external clock for RMII interface we should specify 'rmii'
phy mode and 'rmii-clock-ext' to make ethernet working.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/am335x-igep0033.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 8a0a72d..a1a0cc5 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -105,10 +105,16 @@
 
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rmii";
 };
 
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rmii";
+};
+
+&phy_sel {
+	rmii-clock-ext;
 };
 
 &elm {
-- 
1.9.1

