From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: ARM: OMAP2: fix apollon gpmc initialization
Date: Mon, 23 Oct 2006 13:49:49 +0900
Message-ID: <001e01c6f65e$abe0e840$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[PATCH] ARM: OMAP2: fix apollon gpmc initialization

After update gpmc patch, apollon can't boot since gpmc init. In Apollon,
the CS0 uses 0x0000 0000.
If we don't modify boot_rom_space, we have to update all bootloaders. But
as you know it's difficult.

  Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 73989d4..d0fb9c4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 
 #include <asm/io.h>
+#include <asm/mach-types.h>
 #include <asm/arch/gpmc.h>
 
 #undef DEBUG
@@ -353,6 +354,9 @@ void __init gpmc_mem_init(void)
 	 * even if we didn't boot from ROM.
 	 */
 	boot_rom_space = BOOT_ROM_SPACE;
+	/* In apollon the CS0 is mapped as 0x0000 0000 */
+	if (machine_is_omap_apollon())
+		boot_rom_space = 0;
 	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
 	gpmc_mem_root.end = GPMC_MEM_END;
 
