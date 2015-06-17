From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Provide supply for usb2_phy2
Date: Wed, 17 Jun 2015 17:46:18 +0300
Message-ID: <1434552378-11825-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45390 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbbFQOqZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 10:46:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, "v3.19+" <stable@vger.kernel>

Without this USB2 breaks if USB1 is disabled or USB1
initializes after USB2 e.g. due to deferred probing.

Fixes: 5a0f93c6576a ("ARM: dts: Add am57xx-beagle-x15")
Signed-off-by: Roger Quadros <rogerq@ti.com>
Cc: stable@vger.kernel (v3.19+)
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 7128fad..c9df40e 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -544,6 +544,10 @@
 	phy-supply = <&ldousb_reg>;
 };
 
+&usb2_phy2 {
+	phy-supply = <&ldousb_reg>;
+};
+
 &usb1 {
 	dr_mode = "host";
 	pinctrl-names = "default";
-- 
2.1.4

