From: Adam YH Lee <adam.yh.lee@gmail.com>
Subject: [PATCH] ARM: Gumstix DuoVero: Bind vdac regulator to hdmi node
Date: Thu, 13 Nov 2014 10:04:33 -0800
Message-ID: <1415901873-5304-1-git-send-email-adam.yh.lee@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38937 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866AbaKMSFE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2014 13:05:04 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so946101pad.3
        for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2014 10:05:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: florian.vaussard@epfl.ch, Adam YH Lee <adam.yh.lee@gmail.com>

The HDMI node does not have a power supply attached. As a result its
power regulator, VDAC, shuts off on boot and screen loses signal.
This attaches VDAC (vdda_hdmi_dac) to HDMI's vdda-supply.

Signed-off-by: Adam YH Lee <adam.yh.lee@gmail.com>
---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index 6dc84d9..1a78f01 100644
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -177,6 +177,7 @@
 
 &hdmi {
 	status = "ok";
+	vdda-supply = <&vdac>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss_hdmi_pins>;
-- 
1.9.1

