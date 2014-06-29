From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 12/13] ARM: dts: am33xx: add the PRUSSv2 device
Date: Sun, 29 Jun 2014 18:21:46 +0200
Message-ID: <1404058907-21112-13-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:34687 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbaF2QWL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:22:11 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..28a7e5d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -409,6 +409,15 @@
 			ti,hwmods = "rtc";
 		};
 
+		pruss: pruss@4a300000 {
+			compatible = "ti,pruss-v2";
+			ti,hwmods = "pruss";
+			reg = <0x4a300000 0x080000>;
+			interrupts = <20 21 22 23 24 25 26 27>;
+			interrupt-parent = <&intc>;
+			status = "disabled";
+		};
+
 		spi0: spi@48030000 {
 			compatible = "ti,omap4-mcspi";
 			#address-cells = <1>;
-- 
2.0.0

