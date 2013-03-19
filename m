From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 16/18] ARM: OMAP2+: Remove unnecesssary GPMC definitions and variable
Date: Tue, 19 Mar 2013 11:35:54 -0500
Message-ID: <1363710956-26773-17-git-send-email-jon-hunter@ti.com>
References: <1363710956-26773-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42965 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757098Ab3CSQgv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 12:36:51 -0400
In-Reply-To: <1363710956-26773-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

With commit 21cc2bd (ARM: OMAP2+: Remove apollon board support) the
variable "boot_rom_space" is now not needed and the code surrounding
this variable can be cleaned up and simplified. Remove unnecessary
definitions and clean-up the comment as well.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9797f46..ebb88cf 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -92,9 +92,7 @@
 #define GPMC_CS_SIZE		0x30
 #define	GPMC_BCH_SIZE		0x10
 
-#define GPMC_MEM_START		0x00000000
 #define GPMC_MEM_END		0x3FFFFFFF
-#define BOOT_ROM_SPACE		0x100000	/* 1MB */
 
 #define GPMC_CHUNK_SHIFT	24		/* 16 MB */
 #define GPMC_SECTION_SHIFT	28		/* 128 MB */
@@ -790,13 +788,13 @@ static void gpmc_mem_exit(void)
 static int gpmc_mem_init(void)
 {
 	int cs, rc;
-	unsigned long boot_rom_space = 0;
 
-	/* never allocate the first page, to facilitate bug detection;
-	 * even if we didn't boot from ROM.
+	/*
+	 * The first 1MB of GPMC address space is typically mapped to
+	 * the internal ROM. Never allocate the first page, to
+	 * facilitate bug detection; even if we didn't boot from ROM.
 	 */
-	boot_rom_space = BOOT_ROM_SPACE;
-	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
+	gpmc_mem_root.start = SZ_1M;
 	gpmc_mem_root.end = GPMC_MEM_END;
 
 	/* Reserve all regions that has been set up by bootloader */
-- 
1.7.10.4

