From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] Documentation: dt: update properties in TI GPMC NAND example
Date: Tue, 9 Apr 2013 12:23:35 -0500
Message-ID: <1365528215-5030-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34040 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab3DIRX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 13:23:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The GPMC timing properties for device-tree have been updated
by adding a "-ns" or "-ps" suffix to indicate the units of
time the property represents. Therefore, update the timing
property names for TI GPMC NAND example.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          |   28 ++++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index e7f8d7e..6a983c1 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -56,20 +56,20 @@ Example for an AM33xx board:
 			nand-bus-width = <16>;
 			ti,nand-ecc-opt = "bch8";
 
-			gpmc,sync-clk = <0>;
-			gpmc,cs-on = <0>;
-			gpmc,cs-rd-off = <44>;
-			gpmc,cs-wr-off = <44>;
-			gpmc,adv-on = <6>;
-			gpmc,adv-rd-off = <34>;
-			gpmc,adv-wr-off = <44>;
-			gpmc,we-off = <40>;
-			gpmc,oe-off = <54>;
-			gpmc,access = <64>;
-			gpmc,rd-cycle = <82>;
-			gpmc,wr-cycle = <82>;
-			gpmc,wr-access = <40>;
-			gpmc,wr-data-mux-bus = <0>;
+			gpmc,sync-clk-ps = <0>;
+			gpmc,cs-on-ns = <0>;
+			gpmc,cs-rd-off-ns = <44>;
+			gpmc,cs-wr-off-ns = <44>;
+			gpmc,adv-on-ns = <6>;
+			gpmc,adv-rd-off-ns = <34>;
+			gpmc,adv-wr-off-ns = <44>;
+			gpmc,we-off-ns = <40>;
+			gpmc,oe-off-ns = <54>;
+			gpmc,access-ns = <64>;
+			gpmc,rd-cycle-ns = <82>;
+			gpmc,wr-cycle-ns = <82>;
+			gpmc,wr-access-ns = <40>;
+			gpmc,wr-data-mux-bus-ns = <0>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.7.10.4

