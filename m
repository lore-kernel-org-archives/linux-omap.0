From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/2] ARM: dts: Add omap3-overo NAND flash memory binding
Date: Thu, 23 May 2013 10:09:11 +0200
Message-ID: <1369296552-22281-2-git-send-email-florian.vaussard@epfl.ch>
References: <1369296552-22281-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:34954 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755504Ab3EWIJo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 04:09:44 -0400
In-Reply-To: <1369296552-22281-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Florian Vaussard <florian.vaussard@epfl.ch>

Add device-tree node for the on-board NAND memory.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |   50 ++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index a626c50..be81303 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -33,6 +33,56 @@
 	};
 };
 
+&gpmc {
+	ranges = <0 0 0x30000000 0x00000004>;       /* CS0: NAND */
+
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width = <16>;
+
+		ti,nand-ecc-opt = "sw";
+
+		gpmc,device-nand;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <36>;
+		gpmc,cs-wr-off-ns = <36>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <24>;
+		gpmc,adv-wr-off-ns = <36>;
+		gpmc,we-off-ns = <30>;
+		gpmc,oe-off-ns = <48>;
+		gpmc,access-ns = <54>;
+		gpmc,rd-cycle-ns = <72>;
+		gpmc,wr-cycle-ns = <72>;
+		gpmc,wr-access-ns = <30>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		xloader@0 {
+			reg = <0x00000000 0x00080000>; /* 4 * SZ_128K */
+		};
+
+		uboot@80000 {
+			reg = <0x00080000 0x001c0000>; /* 14 * SZ_128K */
+		};
+
+		ubootenv@240000 {
+			reg = <0x00240000 0x00040000>; /* 2 * SZ_128K */
+		};
+
+		linux@280000 {
+			reg = <0x00280000 0x00400000>; /* 32 * SZ_128K */
+		};
+
+		rootfs@680000 {
+			reg = <0x00680000 0x00000000>; /* MTDPART_SIZ_FULL */
+		};
+	};
+};
+
 &i2c1 {
 	clock-frequency = <2600000>;
 
-- 
1.7.5.4

