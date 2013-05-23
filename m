From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH] ARM: dts: omap3-devkit8000: fix NAND memory binding
Date: Thu, 23 May 2013 10:11:37 +0200
Message-ID: <1369296697-22495-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:45538 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751336Ab3EWILs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 04:11:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Florian Vaussard <florian.vaussard@epfl.ch>

Commit d36b4cd 'ARM: OMAP2+: Add additional GPMC timing parameters'
updated GPMC binding, but omap3-devkit8000 was not updated accordingly,
resulting in a broken configuration.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-devkit8000.dts |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 8a5cdcc..e5b35f5 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -123,20 +123,21 @@
 		reg = <0 0 0>; /* CS0, offset 0 */
 		nand-bus-width = <16>;
 
-		gpmc,sync-clk = <0>;
-		gpmc,cs-on = <0>;
-		gpmc,cs-rd-off = <44>;
-		gpmc,cs-wr-off = <44>;
-		gpmc,adv-on = <6>;
-		gpmc,adv-rd-off = <34>;
-		gpmc,adv-wr-off = <44>;
-		gpmc,we-off = <40>;
-		gpmc,oe-off = <54>;
-		gpmc,access = <64>;
-		gpmc,rd-cycle = <82>;
-		gpmc,wr-cycle = <82>;
-		gpmc,wr-access = <40>;
-		gpmc,wr-data-mux-bus = <0>;
+		gpmc,device-nand;
+		gpmc,sync-clki-ps = <0>;
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
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.5.4

