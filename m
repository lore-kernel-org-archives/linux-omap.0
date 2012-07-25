From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH v5 08/11] arm/dts: am33xx: add dt data for usb nop phy
Date: Wed, 25 Jul 2012 17:37:26 +0530
Message-ID: <1343218049-29917-9-git-send-email-ajay.gupta@ti.com>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39564 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568Ab2GYMHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 08:07:43 -0400
In-Reply-To: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
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
index 08e9a40..b03a9b5 100644
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

