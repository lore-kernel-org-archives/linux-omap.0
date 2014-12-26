From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: boot: dts: am437x-idk: add gpio-based power key
Date: Fri, 26 Dec 2014 14:35:16 -0600
Message-ID: <1419626116-12833-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57182 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaLZUgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 15:36:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

AM437x IDK board has a User Switch which we can
program to whatever we want. Because this board
doesn't have a PMIC which can give us power button
presses, let's use this user switch as a gpio-keys
power button.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

depends on [1]. Boot logs at [2]. Note that this can rather easily
be folded into the original patch if so desired.

[1] http://marc.info/?l=linux-omap&m=141928747902983&w=2
[2] http://hastebin.com/xasuyinizu

 arch/arm/boot/dts/am437x-idk-evm.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index b52dd0a..86f6219 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -96,6 +96,18 @@
 		regulator-boot-on;
 		vin-supply = <&v1_5dreg>;
 	};
+
+	gpio_keys: gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch@0 {
+			label = "power-button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &am43xx_pinmux {
-- 
2.2.0

