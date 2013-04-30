From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: dts: OMAP2+: Simplify NAND support
Date: Tue, 30 Apr 2013 09:11:22 -0500
Message-ID: <1367331082-27944-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54511 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759128Ab3D3OLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Apr 2013 10:11:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Commit 8c8a777 (ARM: OMAP2+: Add function to read GPMC settings from
device-tree) added a device-tree property "gpmc,device-nand" to indicate
is the GPMC child device is NAND. This commit should have updated the
GPMC NAND documentation (Documentation/devicetree/bindings/mtd/gpmc-nand.txt)
to list the property "gpmc,device-nand" as a required property and also
updated the example. However, this property is redundant and not needed
because the GPMC child device node for NAND is called "nand". Therefore,
remove this property.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 Documentation/devicetree/bindings/bus/ti-gpmc.txt |    1 -
 arch/arm/boot/dts/omap3430-sdp.dts                |    1 -
 arch/arm/mach-omap2/gpmc-nand.c                   |    4 ++--
 arch/arm/mach-omap2/gpmc.c                        |    1 -
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
index 4b87ea1..704be93 100644
--- a/Documentation/devicetree/bindings/bus/ti-gpmc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
@@ -95,7 +95,6 @@ GPMC chip-select settings properties for child nodes. All are optional.
 - gpmc,burst-wrap	Enables wrap bursting
 - gpmc,burst-read	Enables read page/burst mode
 - gpmc,burst-write	Enables write page/burst mode
-- gpmc,device-nand	Device is NAND
 - gpmc,device-width	Total width of device(s) connected to a GPMC
 			chip-select in bytes. The GPMC supports 8-bit
 			and 16-bit devices and so this property must be
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 144ae43..6076d01 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -105,7 +105,6 @@
 		nand-bus-width = <8>;
 
 		ti,nand-ecc-opt = "sw";
-		gpmc,device-nand;
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <36>;
 		gpmc,cs-wr-off-ns = <36>;
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index c8044b0..662c7fd 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -102,8 +102,6 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		if (gpmc_nand_data->of_node) {
 			gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
 		} else {
-			s.device_nand = true;
-
 			/* Enable RD PIN Monitoring Reg */
 			if (gpmc_nand_data->dev_ready) {
 				s.wait_on_read = true;
@@ -111,6 +109,8 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 			}
 		}
 
+		s.device_nand = true;
+
 		if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
 			s.device_width = GPMC_DEVWIDTH_16BIT;
 		else
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 6c4da12..6f1beb4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1245,7 +1245,6 @@ void gpmc_read_settings_dt(struct device_node *np, struct gpmc_settings *p)
 
 	p->sync_read = of_property_read_bool(np, "gpmc,sync-read");
 	p->sync_write = of_property_read_bool(np, "gpmc,sync-write");
-	p->device_nand = of_property_read_bool(np, "gpmc,device-nand");
 	of_property_read_u32(np, "gpmc,device-width", &p->device_width);
 	of_property_read_u32(np, "gpmc,mux-add-data", &p->mux_add_data);
 
-- 
1.7.10.4

