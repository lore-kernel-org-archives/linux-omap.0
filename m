From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] ARM: DTS: omap3-n900.dts: fix i2c bus numbering
Date: Sun,  8 Feb 2015 17:48:56 +0200
Message-ID: <1423410536-16579-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:40791 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbbBHPtU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2015 10:49:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

With legacy boot i2c buses on Nokia N900 are numbered i2c1, i2c2 and i2c3.
Commit 20b80942ef4e ("ARM: dts: OMAP3+: Add i2c aliases") fixed the
numbering with DT boot, but introduced a regression on N900 - aliases
become i2c0, i2c1 and i2c2. Fix that by providing the correct aliases in
the board dts.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index b550c41..68bf3cd 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -16,6 +16,13 @@
 	model = "Nokia N900";
 	compatible = "nokia,omap3-n900", "ti,omap3430", "ti,omap3";
 
+	aliases {
+		i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+	};
+
 	cpus {
 		cpu@0 {
 			cpu0-supply = <&vcc>;
-- 
1.9.1

