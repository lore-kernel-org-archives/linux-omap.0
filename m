From: yegorslists@googlemail.com
Subject: [PATCH] ARM: dts: am335x-evmsk: enable dual_emac mode
Date: Wed,  5 Mar 2014 08:29:19 +0100
Message-ID: <1394004559-17862-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:54413 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaCEH3o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 02:29:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

EVM board provides two Ethernet ports, this patch sets them into
dual_emac mode to provide two independent network interfaces.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 40a66bd..144ed07 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -449,6 +449,7 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
+	dual_emac = <1>;
 };
 
 &davinci_mdio {
@@ -460,11 +461,13 @@
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <0>;
 	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <1>;
 };
 
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <2>;
 };
 
 &mmc1 {
-- 
1.7.7

