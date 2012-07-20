From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv7] arm/dts: omap4-sdp: Add keypad data
Date: Fri, 20 Jul 2012 16:08:35 +0530
Message-ID: <1342780715-25618-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48061 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab2GTKfa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 06:35:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com, Sourav Poddar <sourav.poddar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>

Add keypad data node in omap4 device tree file.
Also fill the device tree binding parameters
with the required value in "omap4-sdp" dts file.

Tested on omap4430 sdp with 3.5-rc6 kernel.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
Changes since v6:
-remove address from the node since reg property
is not used.
 arch/arm/boot/dts/omap4-sdp.dts |   70 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |    5 +++
 2 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 72216e9..80cd016 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -113,6 +113,76 @@
 			"DMic", "Digital Mic",
 			"Digital Mic", "Digital Mic1 Bias";
 	};
+
+	keypad {
+		keypad,num-rows = <8>;
+		keypad,num-columns = <8>;
+		linux,keymap = < 0x00000012
+			0x00010013
+			0x00020014
+			0x00030066
+			0x0004003f
+			0x000500f0
+			0x00060017
+			0x0007002a
+			0x01000020
+			0x01010021
+			0x01020022
+			0x010300e7
+			0x01040040
+			0x010500f0
+			0x01060025
+			0x0107001c
+			0x0200002d
+			0x0201002e
+			0x0202002f
+			0x0203006b
+			0x02040041
+			0x020500f0
+			0x02060034
+			0x0207003a
+			0x0300002c
+			0x0301004e
+			0x03020030
+			0x0303003b
+			0x03040042
+			0x030500f0
+			0x03060018
+			0x03070039
+			0x04000011
+			0x04010015
+			0x04020016
+			0x0403003c
+			0x04040073
+			0x040500f0
+			0x04060026
+			0x04070069
+			0x0500001f
+			0x05010023
+			0x05020024
+			0x0503003d
+			0x05040043
+			0x05050072
+			0x05060032
+			0x0507006a
+			0x06000010
+			0x0601001e
+			0x06020031
+			0x0603009e
+			0x0604000e
+			0x060500f0
+			0x06060019
+			0x06070067
+			0x07000094
+			0x07010095
+			0x070200ca
+			0x070300cb
+			0x0704003e
+			0x070500f0
+			0x07060160
+			0x0707006c >;
+		linux,input-no-autorepeat;
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 04cbbcb..e78a1f1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -296,4 +296,9 @@
 			ti,hwmods = "dmic";
 		};
 	};
+
+	keypad {
+		compatible = "ti,omap4-keypad";
+		ti,hwmods = "kbd";
+	};
 };
-- 
1.7.1

