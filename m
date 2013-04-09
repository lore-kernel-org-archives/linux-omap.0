From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] Documentation: dt: update TI GPMC ethernet binding properties
Date: Tue,  9 Apr 2013 14:11:30 +0200
Message-ID: <1365509490-26991-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60859 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758387Ab3DIMLp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 08:11:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The GPMC timing properties for device-tree have been updated
by adding a "-ns" or "-ps" suffix to indicate the units of
time the property represents. Therefore, update the timing
property names for TI GPMC ethernet binding.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Jon, Benoit:

Sorry that I didn't send this patch before but I just realized
that the GPMC timing properties changed after

commit 5330dc16 ("ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes")

got queued.

Tony,

Is still possible to queue this patch on your omap-for-v3.10/gpmc branch
or it is too late?

Thanks a lot and best regards,
Javier

 Documentation/devicetree/bindings/net/gpmc-eth.txt |   56 ++++++++++----------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt b/Documentation/devicetree/bindings/net/gpmc-eth.txt
index 24cb4e4..ace4a64 100644
--- a/Documentation/devicetree/bindings/net/gpmc-eth.txt
+++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
@@ -26,16 +26,16 @@ Required properties:
 - bank-width: 		Address width of the device in bytes. GPMC supports 8-bit
 			and 16-bit devices and so must be either 1 or 2 bytes.
 - compatible:		Compatible string property for the ethernet child device.
-- gpmc,cs-on:		Chip-select assertion time
-- gpmc,cs-rd-off:	Chip-select de-assertion time for reads
-- gpmc,cs-wr-off:	Chip-select de-assertion time for writes
-- gpmc,oe-on:		Output-enable assertion time
-- gpmc,oe-off		Output-enable de-assertion time
-- gpmc,we-on:		Write-enable assertion time
-- gpmc,we-off:		Write-enable de-assertion time
-- gpmc,access:		Start cycle to first data capture (read access)
-- gpmc,rd-cycle:	Total read cycle time
-- gpmc,wr-cycle:	Total write cycle time
+- gpmc,cs-on-ns:	Chip-select assertion time
+- gpmc,cs-rd-off-ns:	Chip-select de-assertion time for reads
+- gpmc,cs-wr-off-ns:	Chip-select de-assertion time for writes
+- gpmc,oe-on-ns:	Output-enable assertion time
+- gpmc,oe-off-ns:	Output-enable de-assertion time
+- gpmc,we-on-ns:	Write-enable assertion time
+- gpmc,we-off-ns:	Write-enable de-assertion time
+- gpmc,access-ns:	Start cycle to first data capture (read access)
+- gpmc,rd-cycle-ns:	Total read cycle time
+- gpmc,wr-cycle-ns:	Total write cycle time
 - reg:			Chip-select, base address (relative to chip-select)
 			and size of the memory mapped for the device.
 			Note that base address will be typically 0 as this
@@ -65,24 +65,24 @@ gpmc: gpmc@6e000000 {
 		bank-width = <2>;
 
 		gpmc,mux-add-data;
-		gpmc,cs-on = <0>;
-		gpmc,cs-rd-off = <186>;
-		gpmc,cs-wr-off = <186>;
-		gpmc,adv-on = <12>;
-		gpmc,adv-rd-off = <48>;
-		gpmc,adv-wr-off = <48>;
-		gpmc,oe-on = <54>;
-		gpmc,oe-off = <168>;
-		gpmc,we-on = <54>;
-		gpmc,we-off = <168>;
-		gpmc,rd-cycle = <186>;
-		gpmc,wr-cycle = <186>;
-		gpmc,access = <114>;
-		gpmc,page-burst-access = <6>;
-		gpmc,bus-turnaround = <12>;
-		gpmc,cycle2cycle-delay = <18>;
-		gpmc,wr-data-mux-bus = <90>;
-		gpmc,wr-access = <186>;
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
 		gpmc,cycle2cycle-samecsen;
 		gpmc,cycle2cycle-diffcsen;
 
-- 
1.7.7.6

