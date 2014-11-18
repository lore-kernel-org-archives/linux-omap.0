From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 4/9] ARM: dts: cm-t3x: add EEPROM support
Date: Tue, 18 Nov 2014 11:13:19 +0200
Message-ID: <1416302004-22199-5-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:46865 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbaKRJNq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 04:13:46 -0500
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add at24 EEPROM chip support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 3636fed..58205f0 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -155,12 +155,22 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
 	clock-frequency = <400000>;
+
+	at24@50 {
+		compatible = "at24,24c02";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
 };
 
 &i2c3 {
 	clock-frequency = <400000>;
 };
+
 &usbhshost {
 	port1-mode = "ehci-phy";
 	port2-mode = "ehci-phy";
-- 
1.7.5.4

