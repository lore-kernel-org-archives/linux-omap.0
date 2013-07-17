From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 4/4] ARM: dts: Use the PWM polarity flags
Date: Thu, 18 Jul 2013 00:54:24 +0200
Message-ID: <1374101664-21112-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:36067 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757879Ab3GQWxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jul 2013 18:53:46 -0400
In-Reply-To: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <linux-arm@overkiz.com>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>

Replace the numerical polarity flags with the PWM_POLARITY_INVERTED
symbolic constant.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 3 ++-
 arch/arm/boot/dts/wm8850-w70v2.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 0c8ad17..62124c7 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "TI AM335x EVM-SK";
@@ -298,7 +299,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&ecap2 0 50000 1>;
+		pwms = <&ecap2 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 58 61 66 75 90 125 170 255>;
 		default-brightness-level = <8>;
 	};
diff --git a/arch/arm/boot/dts/wm8850-w70v2.dts b/arch/arm/boot/dts/wm8850-w70v2.dts
index 90e913f..7a563d2 100644
--- a/arch/arm/boot/dts/wm8850-w70v2.dts
+++ b/arch/arm/boot/dts/wm8850-w70v2.dts
@@ -11,13 +11,14 @@
 
 /dts-v1/;
 /include/ "wm8850.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Wondermedia WM8850-W70v2 Tablet";
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 1>;	/* duty inverted */
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
 
 		brightness-levels = <0 40 60 80 100 130 190 255>;
 		default-brightness-level = <5>;
-- 
1.8.1.5

