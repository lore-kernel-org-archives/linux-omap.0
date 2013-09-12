From: Koen Kooi <koen@dominion.thruhere.net>
Subject: [PATCH 3/4] ARM: am335x-bone-common: switch mmc1 to 4-bit mode
Date: Thu, 12 Sep 2013 17:42:11 +0200
Message-ID: <1379000532-27376-4-git-send-email-koen@dominion.thruhere.net>
References: <1379000532-27376-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:50371 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab3ILPmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Sep 2013 11:42:25 -0400
Received: by mail-wg0-f54.google.com with SMTP id m15so763866wgh.9
        for <linux-omap@vger.kernel.org>; Thu, 12 Sep 2013 08:42:24 -0700 (PDT)
In-Reply-To: <1379000532-27376-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Koen Kooi <koen@dominion.thruhere.net>

The micro-SD slot hooks up all four data pins so lets' use them.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index cfec441..80407ff 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -290,6 +290,7 @@
 
 &mmc1 {
 	status = "okay";
+	bus-width = <0x4>;
 	vmmc-supply = <&ldo3_reg>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-- 
1.8.2.1

