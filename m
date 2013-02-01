From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Fri, 1 Feb 2013 10:38:46 -0600
Message-ID: <1359736726-10193-3-git-send-email-jon-hunter@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51014 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756891Ab3BAQiz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Feb 2013 11:38:55 -0500
In-Reply-To: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>, Jon Hunter <jon-hunter@ti.com>

OMAP2+ devices have an internal ROM that by default is typically mapped
to the first 1MB of the GPMC address space (0x0).

For OMAP24xx devices, GPMC chip-select 0 (CS0) may be mapped to address
0x0 instead of the internal ROM if configured for an external boot mode.
If configured for an internal boot mode then the internal ROM is mapped
to 0x0.

Currently, the function gpmc_mem_init() function reserves the first 1MB
of GPMC address space for the internal OMAP ROM with the exception of
the OMAP2 APOLLON board. This prevents any device (ethernet chip, flash
memories, etc) from using this address range. This causes the GPMC probe
to fail on the OMAP2420 H4 when NOR flash is mapped to address 0x0. Fix
this by testing the boot mode for OMAP24xx devices to see if the
SYS_BOOT3 is low, indicating an external boot, and thus GPMC CS0 is
mapped to 0x0.

Please note that for OMAP3-5 devices, when booting from NOR or NAND
memories connected to CS0, these memories are always mapped to address
0x08000000 and so reserving this memory range does not present any
problems for these devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 441cc63..9486b8e 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -32,6 +32,7 @@
 
 #include "soc.h"
 #include "common.h"
+#include "control.h"
 #include "omap_device.h"
 #include "gpmc.h"
 
@@ -778,18 +779,26 @@ static void gpmc_mem_exit(void)
 static int gpmc_mem_init(void)
 {
 	int cs, rc;
-	unsigned long boot_rom_space = 0;
 
-	/* never allocate the first page, to facilitate bug detection;
-	 * even if we didn't boot from ROM.
+	/*
+	 * The first 1MB of GPMC address space is mapped to the
+	 * internal ROM. OMAP2 devices are an exception to this
+	 * where the first 1MB may be mapped to the GPMC.
 	 */
-	boot_rom_space = BOOT_ROM_SPACE;
-	/* In apollon the CS0 is mapped as 0x0000 0000 */
-	if (machine_is_omap_apollon())
-		boot_rom_space = 0;
-	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
+	gpmc_mem_root.start = GPMC_MEM_START + BOOT_ROM_SPACE;
 	gpmc_mem_root.end = GPMC_MEM_END;
 
+	/*
+	 * OMAP2 devices that boot from external memory devices, will
+	 * map CS0 to the start of the GPMC address space (0x0). We can
+	 * test this by checking if SYS_BOOT3 pin is set. If not set
+	 * then CS0 is mapped to 0x0.
+	 */
+	if (cpu_is_omap24xx())
+		if (!(omap_ctrl_readl(OMAP24XX_CONTROL_STATUS) &
+		      OMAP2_SYSBOOT_3_MASK))
+			gpmc_mem_root.start = GPMC_MEM_START;
+
 	/* Reserve all regions that has been set up by bootloader */
 	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
 		u32 base, size;
-- 
1.7.10.4

