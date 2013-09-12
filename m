From: Koen Kooi <koen@dominion.thruhere.net>
Subject: [PATCH v4 3/4] ARM: dts: am335x-bone-common: switch mmc1 to 4-bit mode
Date: Thu, 12 Sep 2013 20:35:34 +0200
Message-ID: <1379010935-25943-4-git-send-email-koen@dominion.thruhere.net>
References: <1379010935-25943-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40437 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab3ILSfq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Sep 2013 14:35:46 -0400
Received: by mail-wg0-f42.google.com with SMTP id m15so883911wgh.3
        for <linux-omap@vger.kernel.org>; Thu, 12 Sep 2013 11:35:45 -0700 (PDT)
In-Reply-To: <1379010935-25943-1-git-send-email-koen@dominion.thruhere.net>
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
index bc8d1a2..303df81 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -291,6 +291,7 @@
 
 &mmc1 {
 	status = "okay";
+	bus-width = <0x4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
-- 
1.8.2.1

