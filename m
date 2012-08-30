From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v8 08/13] arm/dts: am33xx: Add dt data for usbss
Date: Thu, 30 Aug 2012 16:20:20 +0530
Message-ID: <1346323825-24385-9-git-send-email-ravibabu@ti.com>
References: <1346323825-24385-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34756 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab2H3Kus (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 06:50:48 -0400
In-Reply-To: <1346323825-24385-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, ajayguptaj@gmail.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Added device tree data for usbss on am33xx. There are two musb controllers
on am33xx platform so have port0_mode and port1_mode additional data.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..778b95e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -154,5 +154,16 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
+
+		usb_otg_hs: usb_otg_hs {
+			compatible = "ti,musb-am33xx";
+			ti,hwmods = "usb_otg_hs";
+			multipoint = <1>;
+			num_eps = <16>;
+			ram_bits = <12>;
+			port0_mode = <3>;
+			port1_mode = <3>;
+			power = <250>;
+		};
 	};
 };
-- 
1.7.0.4

