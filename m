From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 6/6] arm: dts: am335x beagle bone use processor macids
Date: Wed, 18 Dec 2013 17:47:22 +0100
Message-ID: <1387385242-1161-7-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42039 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab3LRQs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 11:48:28 -0500
In-Reply-To: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Use macids stored in the am335x chip.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am335x-bone.dts      | 8 ++++++++
 arch/arm/boot/dts/am335x-boneblack.dts | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 94ee427..9b65a62 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -10,6 +10,14 @@
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
 
+&cpsw_emac0 {
+	ti,mac-address-ctrl = <&cpsw_ctrl_macid 0>;
+};
+
+&cpsw_emac1 {
+	ti,mac-address-ctrl = <&cpsw_ctrl_macid 1>;
+};
+
 &ldo3_reg {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 6b71ad9..f6f0b40 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -10,6 +10,14 @@
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
 
+&cpsw_emac0 {
+	ti,mac-address-ctrl = <&cpsw_ctrl_macid 0>;
+};
+
+&cpsw_emac1 {
+	ti,mac-address-ctrl = <&cpsw_ctrl_macid 1>;
+};
+
 &ldo3_reg {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
1.8.5.1

