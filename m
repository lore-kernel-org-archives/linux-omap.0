From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH 1/1] arm: n950: Add missing regulator definitions
Date: Sun,  4 May 2014 03:23:08 +0300
Message-ID: <1399162988-4946-1-git-send-email-sakari.ailus@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:54411 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753350AbaEDATk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 May 2014 20:19:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: aaro.koskinen@iki.fi

The N950/N9 uses two additional regulators from the twl 4030 for CSI-2
receiver (vaux2) and cameras (vaux3).

Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 5c26c18..7d64f30 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -67,6 +67,20 @@
 	ti,pulldowns	= <0x008106>; /* BIT(1) | BIT(2) | BIT(8) | BIT(15) */
 };
 
+/* CSI-2 receiver */
+&vaux2 {
+	regulator-name = "vaux2"; 
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
+/* Cameras */
+&vaux3 {
+	regulator-name = "vaux3"; 
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 };
-- 
1.7.10.4

