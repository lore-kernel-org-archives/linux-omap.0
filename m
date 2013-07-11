From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 1/2] ARM i.MX53: mba53: Fix PWM backlight DT node
Date: Thu, 11 Jul 2013 16:37:47 +0200
Message-ID: <1373553468-6564-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48332 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986Ab3GKOhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 10:37:16 -0400
In-Reply-To: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Boris BREZILLON <linux-arm@overkiz.com>, Tomasz Figa <t.figa@samsung.com>, Philip Avinash <avinashphilip@ti.com>, Tony Prisk <linux@prisktech.co.nz>, linux-pwm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The i.MX53 PWM controller uses two cells to describe the PWM specifier.
Remove the extra unused values from the backlight DT node pwms property.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/imx53-mba53.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index aaa33bc..a630902 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -27,7 +27,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 50000 0 0>;
+		pwms = <&pwm2 0 50000>;
 		brightness-levels = <0 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100>;
 		default-brightness-level = <10>;
 		enable-gpios = <&gpio7 7 0>;
-- 
1.8.1.5

