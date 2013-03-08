From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 6/9] ARM: dts: Add OMAP3430 SDP flash memory bindings
Date: Fri, 8 Mar 2013 11:27:30 -0600
Message-ID: <1362763654-9660-7-git-send-email-jon-hunter@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933093Ab3CHR2D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 12:28:03 -0500
In-Reply-To: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Add the device-tree nodes for the 128MB ONENAND flash and 256MB NAND
flash memories found on the OMAP3430 SDP board.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap3430-sdp.dts |   95 ++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index be0650d..c313762 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -44,3 +44,98 @@
 &mmc3 {
 	status = "disabled";
 };
+
+&gpmc {
+	ranges = <1 0 0x28000000 0x08000000>,
+		 <2 0 0x20000000 0x10000000>;
+
+	nand@1,0 {
+		linux,mtd-name= "micron,mt29f1g08abb";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <1 0 0x08000000>;
+		nand-bus-width = <8>;
+
+		gpmc,device_nand;
+		gpmc,cs-on = <0>;
+		gpmc,cs-rd-off = <36>;
+		gpmc,cs-wr-off = <36>;
+		gpmc,adv-on = <6>;
+		gpmc,adv-rd-off = <24>;
+		gpmc,adv-wr-off = <36>;
+		gpmc,oe-on = <6>;
+		gpmc,oe-off = <48>;
+		gpmc,we-on = <6>;
+		gpmc,we-off = <30>;
+		gpmc,rd-cycle = <72>;
+		gpmc,wr-cycle = <72>;
+		gpmc,access = <54>;
+		gpmc,wr-access = <30>;
+
+		partition@0 {
+			label = "xloader-nand";
+			reg = <0 0x80000>;
+		};
+		partition@0x80000 {
+			label = "bootloader-nand";
+			reg = <0x80000 0x140000>;
+		};
+		partition@0x1c0000 {
+			label = "params-nand";
+			reg = <0x1c0000 0xc0000>;
+		};
+		partition@0x280000 {
+			label = "kernel-nand";
+			reg = <0x280000 0x500000>;
+		};
+		partition@0x780000 {
+			label = "filesystem-nand";
+			reg = <0x780000 0x7880000>;
+		};
+	};
+
+	onenand@2,0 {
+		linux,mtd-name= "samsung,kfm2g16q2m-deb8";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <2 0 0x10000000>;
+
+		gpmc,device-width = <2>;
+		gpmc,mux-add-data = <2>;
+		gpmc,cs-on = <0>;
+		gpmc,cs-rd-off = <84>;
+		gpmc,cs-wr-off = <72>;
+		gpmc,adv-on = <0>;
+		gpmc,adv-rd-off = <18>;
+		gpmc,adv-wr-off = <18>;
+		gpmc,oe-on = <30>;
+		gpmc,oe-off = <84>;
+		gpmc,we-on = <0>;
+		gpmc,we-off = <42>;
+		gpmc,rd-cycle = <108>;
+		gpmc,wr-cycle = <96>;
+		gpmc,access = <78>;
+		gpmc,wr-data-mux-bus = <30>;
+
+		partition@0 {
+			label = "xloader-onenand";
+			reg = <0 0x80000>;
+		};
+		partition@0x80000 {
+			label = "bootloader-onenand";
+			reg = <0x80000 0x40000>;
+		};
+		partition@0xc0000 {
+			label = "params-onenand";
+			reg = <0xc0000 0x20000>;
+		};
+		partition@0xe0000 {
+			label = "kernel-onenand";
+			reg = <0xe0000 0x200000>;
+		};
+		partition@0x2e0000 {
+			label = "filesystem-onenand";
+			reg = <0x2e0000 0xfd20000>;
+		};
+	};
+};
-- 
1.7.10.4

