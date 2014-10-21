From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/4] ARM: dts: dra72-evm: Add regulator information to USB2 PHYs
Date: Tue, 21 Oct 2014 13:41:20 +0300
Message-ID: <1413888080-2669-5-git-send-email-rogerq@ti.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52896 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041AbaJUKl7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2014 06:41:59 -0400
In-Reply-To: <1413888080-2669-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, nsekhar@ti.com, george.cherian@ti.com, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

The ldo4_reg regulator provides power to the USB1 and USB2
High Speed PHYs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index ad6ec4a..b135aab 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -270,6 +270,14 @@
 	};
 };
 
+&usb2_phy1 {
+	phy-supply = <&ldo4_reg>;
+};
+
+&usb2_phy2 {
+	phy-supply = <&ldo4_reg>;
+};
+
 &usb1 {
 	dr_mode = "peripheral";
 	pinctrl-names = "default";
-- 
1.8.3.2

