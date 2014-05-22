From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 5/5] ARM: dts: OMAP3 a83x: fix duplicate usb pin config
Date: Fri, 23 May 2014 01:06:26 +0200
Message-ID: <1400799986-20043-6-git-send-email-chf.fritz@googlemail.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:57470 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbaEVXHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 19:07:03 -0400
Received: by mail-la0-f50.google.com with SMTP id b8so3293516lan.37
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2014 16:07:02 -0700 (PDT)
In-Reply-To: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Node usbhshost is supporting pinctrl, so the deprecated
quirk call can be removed.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index 2b3af90..d973088 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -176,9 +176,6 @@
 
 &omap3_pmx_core2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-			&hsusb1_2_pins
-	>;
 
 	hsusb1_2_pins: pinmux_hsusb1_2_pins {
 		pinctrl-single,pins = <
-- 
1.7.10.4

