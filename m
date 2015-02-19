From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: boot: dts: am437x-idk: fix sleep pinctrl state
Date: Thu, 19 Feb 2015 13:57:08 -0600
Message-ID: <1424375828-26535-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36395 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbbBST5u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Feb 2015 14:57:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

we have i2c0 sleep pinctrl state but were passing
default state anyhow. Fix that.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 22c2031dea17..378344271746 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -254,7 +254,7 @@
 	status = "okay";
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c0_pins_default>;
-	pinctrl-1 = <&i2c0_pins_default>;
+	pinctrl-1 = <&i2c0_pins_sleep>;
 	clock-frequency = <400000>;
 
 	at24@50 {
-- 
2.3.0

