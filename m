From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] ARM: dts: igep0033: Add mmc1 node for SDCARD support.
Date: Sat, 19 Oct 2013 22:55:19 +0200
Message-ID: <1382216119-14125-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58959 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab3JSU5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 16:57:24 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so5057027wes.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Oct 2013 13:57:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Add mmc1 dt node to IGEP COM AQUILA board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/boot/dts/am335x-igep0033.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 06eba07..6196244 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -44,6 +44,13 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-boot-on;
 	};
+
+	vmmc: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &am33xx_pinmux {
@@ -180,6 +187,12 @@
 	};
 };
 
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+};
+
 &uart0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.1.2

