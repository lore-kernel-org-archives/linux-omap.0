From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: gpmc: removed 'gpmc,device-nand'. type determined from node-name
Date: Fri, 31 May 2013 17:31:31 +0530
Message-ID: <1370001691-29320-2-git-send-email-pekon@ti.com>
References: <1370001691-29320-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39803 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756263Ab3EaMBs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 08:01:48 -0400
In-Reply-To: <1370001691-29320-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jgchunter@gmail.com>, "Gupta, Pekon" <pekon@ti.com>

From: "Gupta, Pekon" <pekon@ti.com>

GPMC supports multiple types of child devices like NAND, NOR, OneNand, Ethernet
This patch removes 'gpmc,device-nand', used explicitely to specify NAND type
gpmc-child. Instead gpmc-child type can be inferred from gpmc->child->name.

Signed-off-by: Gupta, Pekon <pekon@ti.com>
---
 Documentation/devicetree/bindings/bus/ti-gpmc.txt | 1 -
 arch/arm/boot/dts/am335x-evm.dts                  | 1 -
 arch/arm/mach-omap2/gpmc-nand.c                   | 3 +--
 arch/arm/mach-omap2/gpmc-onenand.c                | 2 ++
 arch/arm/mach-omap2/gpmc.c                        | 1 -
 5 files changed, 3 insertions(+), 5 deletions(-)

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
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 7d2be9c..c71bb77 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -136,7 +136,6 @@
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
 				ti,nand-ecc-opt = "bch8";
-				gpmc,device-nand = "true";
 				gpmc,device-width = <1>;
 				gpmc,sync-clk-ps = <0>;
 				gpmc,cs-on-ns = <0>;
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index d9c2719..dc50391 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -140,14 +140,13 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		if (gpmc_nand_data->of_node) {
 			gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
 		} else {
-			s.device_nand = true;
-
 			/* Enable RD PIN Monitoring Reg */
 			if (gpmc_nand_data->dev_ready) {
 				s.wait_on_read = true;
 				s.wait_on_write = true;
 			}
 		}
+		s.device_nand = true;
 
 		if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
 			s.device_width = GPMC_DEVWIDTH_16BIT;
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 64b5a83..cea4b6d 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -275,6 +275,7 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 	if (gpmc_onenand_data->of_node)
 		gpmc_read_settings_dt(gpmc_onenand_data->of_node,
 				      &onenand_async);
+	onenand_async.device_nand = false;
 
 	omap2_onenand_set_async_mode(onenand_base);
 
@@ -315,6 +316,7 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 		if (!cpu_is_omap34xx())
 			onenand_sync.wait_on_read = true;
 	}
+	onenand_sync.device_nand = false;
 
 	omap2_onenand_calc_sync_timings(&t, gpmc_onenand_data->flags, freq);
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 490bca8..fb6f241 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1249,7 +1249,6 @@ void gpmc_read_settings_dt(struct device_node *np, struct gpmc_settings *p)
 
 	p->sync_read = of_property_read_bool(np, "gpmc,sync-read");
 	p->sync_write = of_property_read_bool(np, "gpmc,sync-write");
-	p->device_nand = of_property_read_bool(np, "gpmc,device-nand");
 	of_property_read_u32(np, "gpmc,device-width", &p->device_width);
 	of_property_read_u32(np, "gpmc,mux-add-data", &p->mux_add_data);
 
-- 
1.8.1

