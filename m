From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH] ARM: dts: am335x-boneblack: set dcdc1 regulator for 1.35v ddr3
Date: Fri, 10 Oct 2014 15:33:39 -0500
Message-ID: <1412973219-3674-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36643 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaJJUdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2014 16:33:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Vagrant Cascadian <vagrant@debian.org>

The TPS65217C used on the boneblack defaults to 1.5v on startup for dcdc1_reg.
While 1.35v ddr3 memory is actually used. This was discovered by a user during
a schematic review of his beaglebone-black clone, a u-boot patch will also also
be submitted.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Vagrant Cascadian <vagrant@debian.org>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 901739f..e7c8999 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -15,6 +15,13 @@
 	compatible = "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
 };
 
+&dcdc1_reg {
+	/* TPS65217C defaults to 1.5v on powerup while 1.35v DDR3 is used */
+	regulator-min-microvolt = <1350000>;
+	regulator-max-microvolt = <1350000>;
+	regulator-boot-on;
+};
+
 &ldo3_reg {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
2.1.1

