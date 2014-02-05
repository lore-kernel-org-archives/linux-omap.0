From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 3/5] ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
Date: Wed, 5 Feb 2014 18:58:32 +0530
Message-ID: <1391606914-9947-4-git-send-email-pekon@ti.com>
References: <1391606914-9947-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56508 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaBEN2p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Feb 2014 08:28:45 -0500
In-Reply-To: <1391606914-9947-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

This patch updated MTD/NAND DT node binding to replace deprecated bindings
as per following commit.
    commit ac65caf514ec3e55e8d3d510ee37f80dd97418fe
    ARM: OMAP2+: cleaned-up DT support of various ECC schemes
    Also Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts   | 5 ++---
 arch/arm/boot/dts/omap3430-sdp.dts | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 17c3cc0..07d61bb 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -434,9 +434,9 @@
 	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
 	nand@0,0 {
 		reg = <0 0 0>; /* CS0, offset 0 */
-		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
-		gpmc,device-nand = "true";
+		ti,elm-id = <&elm>;
+		nand-bus-width = <8>;
 		gpmc,device-width = <1>;
 		gpmc,sync-clk-ps = <0>;
 		gpmc,cs-on-ns = <0>;
@@ -460,7 +460,6 @@
 		gpmc,wait-monitoring-ns = <0>;
 		gpmc,wr-access-ns = <40>;
 		gpmc,wr-data-mux-bus-ns = <0>;
-		elm_id = <&elm>;
 		/* MTD partition table */
 		/* All SPL-* partitions are sized to minimal length
 		 * which can be independently programmable. For
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 281914e..d48c085 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -103,9 +103,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <1 0 0x08000000>;
+		ti,nand-ecc-opt = "ham1";
 		nand-bus-width = <8>;
-
-		ti,nand-ecc-opt = "sw";
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <36>;
 		gpmc,cs-wr-off-ns = <36>;
-- 
1.8.5.1.163.gd7aced9

