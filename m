From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 08/11] arm/dts: am33xx: add dt data for usb nop phy
Date: Thu, 12 Jul 2012 15:23:31 +0530
Message-ID: <1342086814-32181-9-git-send-email-ajay.gupta@ti.com>
References: <1342086814-32181-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36832 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758989Ab2GLJxu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 05:53:50 -0400
In-Reply-To: <1342086814-32181-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

AM33xx has two musb controller and they have one NOP PHY each.
Added the device tree data for NOP PHY.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index b572803..3bd9911 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -155,6 +155,14 @@
 			ti,hwmods = "i2c3";
 		};
 
+		usb0_phy: phy@1 {
+			compatible = "ti,nop-xceiv-usb";
+		};
+
+		usb1_phy: phy@2 {
+			compatible = "ti,nop-xceiv-usb";
+		};
+
 		usb_otg_hs: usb_otg_hs@47400000 {
 			compatible = "ti,musb-am33xx";
 			ti,hwmods = "usb_otg_hs";
-- 
1.7.0.4

