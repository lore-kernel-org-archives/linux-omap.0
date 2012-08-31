From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v9 09/13] arm/dts: am33xx: add dt data for usb nop phy
Date: Fri, 31 Aug 2012 16:39:55 +0530
Message-ID: <1346411399-23964-10-git-send-email-ravibabu@ti.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48266 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab2HaLKL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 07:10:11 -0400
In-Reply-To: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

AM33xx has two musb controller and they have one NOP PHY each.
Added the device tree data for NOP PHY.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bdde9c9..4b3a2b7 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -155,6 +155,14 @@
 			ti,hwmods = "i2c3";
 		};
 
+		usb0_phy: phy0 {
+			compatible = "nop-xceiv-usb";
+		};
+
+		usb1_phy: phy1 {
+			compatible = "nop-xceiv-usb";
+		};
+
 		usb_otg_hs: usb_otg_hs {
 			compatible = "ti,musb-am33xx";
 			ti,hwmods = "usb_otg_hs";
-- 
1.7.0.4

