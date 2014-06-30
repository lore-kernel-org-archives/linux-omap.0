From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/3] ARM: dts: dra7-evm: Add regulator information to USB2 PHYs
Date: Mon, 30 Jun 2014 14:00:38 +0300
Message-ID: <1404126038-19974-4-git-send-email-rogerq@ti.com>
References: <1404126038-19974-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51119 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347AbaF3LAw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2014 07:00:52 -0400
In-Reply-To: <1404126038-19974-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon@ti.com, balbi@ti.com, tony@atomide.com
Cc: nm@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The ldousb_reg regulator provides power to the USB1 and USB2
High Speed PHYs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 4adc280..fd96ced 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -495,3 +495,11 @@
 		};
 	};
 };
+
+&usb2_phy1 {
+	phy-supply = <&ldousb_reg>;
+};
+
+&usb2_phy2 {
+	phy-supply = <&ldousb_reg>;
+};
-- 
1.8.3.2

