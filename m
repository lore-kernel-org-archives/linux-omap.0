From: Matt Porter <mporter@konsulko.com>
Subject: [PATCH] ARM: dts: am335x-boneblack: enable aes and sham
Date: Wed, 25 Feb 2015 12:07:50 -0500
Message-ID: <1424884070-25891-1-git-send-email-mporter@konsulko.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43471 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbbBYRH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 12:07:56 -0500
Received: by iebtr6 with SMTP id tr6so6620939ieb.10
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 09:07:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Beaglebone Black doesn't have AES and SHAM enabled like the
original Beaglebone White dts. This breaks applications that
leverage the crypto blocks so fix this by enabling these nodes.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 5c42d25..00853ff 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -33,6 +33,14 @@
 	status = "okay";
 };
 
+&sham {
+	status = "okay";
+};
+
+&aes {
+	status = "okay";
+};
+
 &am33xx_pinmux {
 	nxp_hdmi_bonelt_pins: nxp_hdmi_bonelt_pins {
 		pinctrl-single,pins = <
-- 
1.8.4

