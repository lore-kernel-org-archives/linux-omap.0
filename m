From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] ARM: dts: am33xx, change usb ctrl module label
Date: Mon, 14 Oct 2013 14:49:21 +0200
Message-ID: <1381754961-3252-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33552 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab3JNMtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Oct 2013 08:49:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Control module is not usb specific. This patch changes the label to
usb_ctrl_mod.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f9c5da9..14510ee 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -346,7 +346,7 @@
 			ti,hwmods = "usb_otg_hs";
 			status = "disabled";
 
-			ctrl_mod: control@44e10000 {
+			usb_ctrl_mod: control@44e10000 {
 				compatible = "ti,am335x-usb-ctrl-module";
 				reg = <0x44e10620 0x10
 					0x44e10648 0x4>;
@@ -359,7 +359,7 @@
 				reg = <0x47401300 0x100>;
 				reg-names = "phy";
 				status = "disabled";
-				ti,ctrl_mod = <&ctrl_mod>;
+				ti,ctrl_mod = <&usb_ctrl_mod>;
 			};
 
 			usb0: usb@47401000 {
@@ -407,7 +407,7 @@
 				reg = <0x47401b00 0x100>;
 				reg-names = "phy";
 				status = "disabled";
-				ti,ctrl_mod = <&ctrl_mod>;
+				ti,ctrl_mod = <&usb_ctrl_mod>;
 			};
 
 			usb1: usb@47401800 {
-- 
1.8.4.rc3

