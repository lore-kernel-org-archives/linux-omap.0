From: Ash Charles <ashcharles@gmail.com>
Subject: [PATCH 4/5] omap3: overo: Support PoP NAND
Date: Fri, 12 Jun 2015 13:37:25 -0700
Message-ID: <1434141446-11568-5-git-send-email-ashcharles@gmail.com>
References: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33796 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbFLUhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2015 16:37:31 -0400
In-Reply-To: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com

Some Overo COM models include NAND flash in the on-board
package-on-package (PoP) chip.  Add this to the base Overo devicetree.

Most commonly, this is 512MB NAND from the Micron MT29C4G96MAZ family
but, as discussed [1], several different sized are possible. To
support different sizes, the last partition should fill to the end of
the chip (i.e. MTDPART_SIZ_FULL).

With thanks to Florian Vaussard for the original patch [2] and Adam Lee for
updating it here.

Signed-off-by: Ash Charles <ashcharles@gmail.com>

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175760.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175449.html
---
 arch/arm/boot/dts/omap3-overo-base.dtsi | 51 +++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 029e5feb65b4..28430f1596f2 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -222,3 +222,54 @@
 	status = "okay";
 };
 
+&gpmc {
+	ranges = <0 0 0x00000000 0x20000000>;
+
+	nand@0,0 {
+		linux,mtd-name= "micron,mt29c4g96maz";
+		reg = <0 0 0>;
+		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
+		ti,nand-ecc-opt = "bch8";
+
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "SPL";
+			reg = <0 0x80000>; /* 512KiB */
+		};
+		partition@80000 {
+			label = "U-Boot";
+			reg = <0x80000 0x1C0000>; /* 1792KiB */
+		};
+		partition@1c0000 {
+			label = "Environment";
+			reg = <0x240000 0x40000>; /* 256KiB */
+		};
+		partition@280000 {
+			label = "Kernel";
+			reg = <0x280000 0x800000>; /* 8192KiB */
+		};
+		partition@780000 {
+			label = "Filesystem";
+			reg = <0xA80000 0>;
+			/* HACK: MTDPART_SIZ_FULL=0 so fill to end */
+		};
+	};
+};
-- 
2.1.4

