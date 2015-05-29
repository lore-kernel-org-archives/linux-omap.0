From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix dm816x to use right compatible flag for MUSB
Date: Fri, 29 May 2015 09:27:08 -0700
Message-ID: <1432916828-13171-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:50070 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752493AbbE2Q1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 12:27:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, George Cherian <george.cherian@ti.com>, Felipe Balbi <balbi@ti.com>

With commit 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with
musb_dsps") we need to use the right compatible flag to avoid issues
with FIFO reads.

Cc: Bin Liu <binmlist@gmail.com>
Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: George Cherian <george.cherian@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Fixes: 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with musb_dsps")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index de8427b..289806a 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -382,7 +382,7 @@
 			ti,hwmods = "usb_otg_hs";
 
 			usb0: usb@47401000 {
-				compatible = "ti,musb-am33xx";
+				compatible = "ti,musb-dm816";
 				reg = <0x47401400 0x400
 				       0x47401000 0x200>;
 				reg-names = "mc", "control";
@@ -422,7 +422,7 @@
 			};
 
 			usb1: usb@47401800 {
-				compatible = "ti,musb-am33xx";
+				compatible = "ti,musb-dm816";
 				reg = <0x47401c00 0x400
 				       0x47401800 0x200>;
 				reg-names = "mc", "control";
-- 
2.1.4

