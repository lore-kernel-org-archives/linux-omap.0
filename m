From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH v5 06/11] arm/dts: am33xx: Add dt data for usbss
Date: Wed, 25 Jul 2012 17:37:24 +0530
Message-ID: <1343218049-29917-7-git-send-email-ajay.gupta@ti.com>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39568 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab2GYMHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 08:07:43 -0400
In-Reply-To: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Added device tree data for usbss on am33xx. There are two musb controllers
on am33xx platform so have port0_mode and port1_mode additional data.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..08e9a40 100644
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
+			port1_mode = <1>;
+			power = <250>;
+		};
 	};
 };
-- 
1.7.0.4

