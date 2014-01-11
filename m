From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] arm: dtsi: am335x-bone-common, usb0 is peripheral only
Date: Sat, 11 Jan 2014 15:00:51 +0100
Message-ID: <1389448851-20010-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45013 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaAKOBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Jan 2014 09:01:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

The PMIC is using usb0 vbus line as power source. It is also connected
to the am335x processor as vbus sense. But there is no possibility to
pullup usb0 vbus to operate as host. This patch fixes the dr_mode of usb0.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index e3f27ec..da2db9b 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -197,6 +197,7 @@
 
 	usb@47401000 {
 		status = "okay";
+		dr_mode = "peripheral";
 	};
 
 	usb@47401800 {
-- 
1.8.5.2

