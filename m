From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: dts: Add cppi41 support for dm816x MUSB
Date: Tue, 17 Mar 2015 17:19:20 -0700
Message-ID: <1426637961-4197-4-git-send-email-tony@atomide.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from si-002-i66.relay.mailchannels.net ([184.154.112.240]:36411 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753897AbbCRAYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 20:24:44 -0400
In-Reply-To: <1426637961-4197-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>

Looks like we have cppi41 on dm816x just like on am335x.

Cc: Bin Liu <binmlist@gmail.com>
Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index f35715b..de8427b 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -396,6 +396,29 @@
 				mentor,num-eps = <16>;
 				mentor,ram-bits = <12>;
 				mentor,power = <500>;
+
+				dmas = <&cppi41dma  0 0 &cppi41dma  1 0
+					&cppi41dma  2 0 &cppi41dma  3 0
+					&cppi41dma  4 0 &cppi41dma  5 0
+					&cppi41dma  6 0 &cppi41dma  7 0
+					&cppi41dma  8 0 &cppi41dma  9 0
+					&cppi41dma 10 0 &cppi41dma 11 0
+					&cppi41dma 12 0 &cppi41dma 13 0
+					&cppi41dma 14 0 &cppi41dma  0 1
+					&cppi41dma  1 1 &cppi41dma  2 1
+					&cppi41dma  3 1 &cppi41dma  4 1
+					&cppi41dma  5 1 &cppi41dma  6 1
+					&cppi41dma  7 1 &cppi41dma  8 1
+					&cppi41dma  9 1 &cppi41dma 10 1
+					&cppi41dma 11 1 &cppi41dma 12 1
+					&cppi41dma 13 1 &cppi41dma 14 1>;
+				dma-names =
+					"rx1", "rx2", "rx3", "rx4", "rx5", "rx6", "rx7",
+					"rx8", "rx9", "rx10", "rx11", "rx12", "rx13",
+					"rx14", "rx15",
+					"tx1", "tx2", "tx3", "tx4", "tx5", "tx6", "tx7",
+					"tx8", "tx9", "tx10", "tx11", "tx12", "tx13",
+					"tx14", "tx15";
 			};
 
 			usb1: usb@47401800 {
@@ -413,6 +436,43 @@
 				mentor,num-eps = <16>;
 				mentor,ram-bits = <12>;
 				mentor,power = <500>;
+
+				dmas = <&cppi41dma 15 0 &cppi41dma 16 0
+					&cppi41dma 17 0 &cppi41dma 18 0
+					&cppi41dma 19 0 &cppi41dma 20 0
+					&cppi41dma 21 0 &cppi41dma 22 0
+					&cppi41dma 23 0 &cppi41dma 24 0
+					&cppi41dma 25 0 &cppi41dma 26 0
+					&cppi41dma 27 0 &cppi41dma 28 0
+					&cppi41dma 29 0 &cppi41dma 15 1
+					&cppi41dma 16 1 &cppi41dma 17 1
+					&cppi41dma 18 1 &cppi41dma 19 1
+					&cppi41dma 20 1 &cppi41dma 21 1
+					&cppi41dma 22 1 &cppi41dma 23 1
+					&cppi41dma 24 1 &cppi41dma 25 1
+					&cppi41dma 26 1 &cppi41dma 27 1
+					&cppi41dma 28 1 &cppi41dma 29 1>;
+				dma-names =
+					"rx1", "rx2", "rx3", "rx4", "rx5", "rx6", "rx7",
+					"rx8", "rx9", "rx10", "rx11", "rx12", "rx13",
+					"rx14", "rx15",
+					"tx1", "tx2", "tx3", "tx4", "tx5", "tx6", "tx7",
+					"tx8", "tx9", "tx10", "tx11", "tx12", "tx13",
+					"tx14", "tx15";
+			};
+
+			cppi41dma: dma-controller@47402000 {
+				compatible = "ti,am3359-cppi41";
+				reg =  <0x47400000 0x1000
+					0x47402000 0x1000
+					0x47403000 0x1000
+					0x47404000 0x4000>;
+				reg-names = "glue", "controller", "scheduler", "queuemgr";
+				interrupts = <17>;
+				interrupt-names = "glue";
+				#dma-cells = <2>;
+				#dma-channels = <30>;
+				#dma-requests = <256>;
 			};
 		};
 
-- 
2.1.4

