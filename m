From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 3/3] ARM: dts: Add OMAP3430 SDP NOR flash memory binding
Date: Sun, 7 Apr 2013 20:17:08 -0500
Message-ID: <1365383828-25627-3-git-send-email-jon-hunter@ti.com>
References: <1365383828-25627-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52715 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934511Ab3DHBR3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Apr 2013 21:17:29 -0400
In-Reply-To: <1365383828-25627-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Add device-tree node for the 128MB NOR on the OMAP3423-SDP board.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap3430-sdp.dts |   51 +++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 44d2191..144ae43 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -45,9 +45,58 @@
 };
 
 &gpmc {
-	ranges = <1 0 0x28000000 0x08000000>,
+	ranges = <0 0 0x10000000 0x08000000>,
+		 <1 0 0x28000000 0x08000000>,
 		 <2 0 0x20000000 0x10000000>;
 
+	nor@0,0 {
+		compatible = "cfi-flash";
+		linux,mtd-name= "intel,pf48f6000m0y1be";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0 0x08000000>;
+		bank-width = <2>;
+
+		gpmc,mux-add-data = <2>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <186>;
+		gpmc,cs-wr-off-ns = <186>;
+		gpmc,adv-on-ns = <12>;
+		gpmc,adv-rd-off-ns = <48>;
+		gpmc,adv-wr-off-ns = <48>;
+		gpmc,oe-on-ns = <54>;
+		gpmc,oe-off-ns = <168>;
+		gpmc,we-on-ns = <54>;
+		gpmc,we-off-ns = <168>;
+		gpmc,rd-cycle-ns = <186>;
+		gpmc,wr-cycle-ns = <186>;
+		gpmc,access-ns = <114>;
+		gpmc,page-burst-access-ns = <6>;
+		gpmc,bus-turnaround-ns = <12>;
+		gpmc,cycle2cycle-delay-ns = <18>;
+		gpmc,wr-data-mux-bus-ns = <90>;
+		gpmc,wr-access-ns = <186>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-diffcsen;
+
+		partition@0 {
+			label = "bootloader-nor";
+			reg = <0 0x40000>;
+		};
+		partition@0x40000 {
+			label = "params-nor";
+			reg = <0x40000 0x40000>;
+		};
+		partition@0x80000 {
+			label = "kernel-nor";
+			reg = <0x80000 0x200000>;
+		};
+		partition@0x280000 {
+			label = "filesystem-nor";
+			reg = <0x240000 0x7d80000>;
+		};
+	};
+
 	nand@1,0 {
 		linux,mtd-name= "micron,mt29f1g08abb";
 		#address-cells = <1>;
-- 
1.7.10.4

