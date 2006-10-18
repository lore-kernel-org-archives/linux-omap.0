From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-omap] omap2/gpmc updates
Date: Wed, 18 Oct 2006 13:42:14 -0700
Message-ID: <200610181342.14796.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

GPMC updates:
 - bugfixes: wrong/missing flags, omitted write, wrong test
 - don't map memory segments starting at zero
 - improve debug messaging
 - export gpmc_get_fclk_period() since it's needed to calc timings
 - expect gpmc_cs_set_timings() caller to have initialized sync vs async

Note that this API is glitchy; likely the best fix would be to add
a member to "struct gpmc_timings" to hold GPMC_CONFIG1, since that
holds one key aspect of the GPMC timings (the gpmc_fclk divisor,
and sync vs. async == whether that divisor matters).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: h4/include/asm/arch/gpmc.h
===================================================================
--- h4.orig/include/asm/arch/gpmc.h	2006-10-18 01:40:23.000000000 -0700
+++ h4/include/asm/arch/gpmc.h	2006-10-18 01:41:49.000000000 -0700
@@ -23,9 +23,10 @@
 #define GPMC_CS_NAND_DATA	0x24
 
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
-#define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 20)
+#define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
 #define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
 #define GPMC_CONFIG1_READTYPE_SYNC      (1 << 29)
+#define GPMC_CONFIG1_WRITEMULTIPLE_SUPP (1 << 28)
 #define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
 #define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
 #define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
Index: h4/arch/arm/mach-omap2/gpmc.c
===================================================================
--- h4.orig/arch/arm/mach-omap2/gpmc.c	2006-10-18 01:40:23.000000000 -0700
+++ h4/arch/arm/mach-omap2/gpmc.c	2006-10-18 01:41:49.000000000 -0700
@@ -87,7 +87,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
 }
 
 /* TODO: Add support for gpmc_fck to clock framework and use it */
-static unsigned long gpmc_get_fclk_period(void)
+unsigned long gpmc_get_fclk_period(void)
 {
 	/* In picoseconds */
 	return 1000000000 / ((clk_get_rate(gpmc_l3_clk)) / 1000);
@@ -119,15 +119,21 @@ static int set_gpmc_timing_reg(int cs, i
 	else
 		ticks = gpmc_ns_to_ticks(time);
 	nr_bits = end_bit - st_bit + 1;
-	if (ticks >= 1 << nr_bits)
+	if (ticks >= 1 << nr_bits) {
+#ifdef DEBUG
+		printk(KERN_INFO "GPMC CS%d: %-10s* %3d ns, %3d ticks >= %d\n",
+		       cs, name, time, ticks, 1 << nr_bits);
+#endif
 		return -1;
+	}
 
 	mask = (1 << nr_bits) - 1;
 	l = gpmc_cs_read_reg(cs, reg);
 #ifdef DEBUG
-	printk(KERN_INFO "GPMC CS%d: %-10s: %d ticks, %3lu ns (was %i ticks)\n",
+	printk(KERN_INFO
+		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
 	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
-	       (l >> st_bit) & mask);
+	       (l >> st_bit) & mask, time);
 #endif
 	l &= ~(mask << st_bit);
 	l |= ticks << st_bit;
@@ -156,7 +162,7 @@ int gpmc_cs_calc_divider(int cs, unsigne
 	div = l / gpmc_get_fclk_period();
 	if (div > 4)
 		return -1;
-	if (div < 0)
+	if (div <= 0)
 		div = 1;
 
 	return div;
@@ -190,14 +196,19 @@ int gpmc_cs_set_timings(int cs, const st
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
+	/* caller is expected to have initialized CONFIG1 to cover
+	 * at least sync vs async
+	 */
+	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+	if (l & (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {
 #ifdef DEBUG
-	printk(KERN_INFO "GPMC CS%d CLK period is %lu (div %d)\n",
-	       cs, gpmc_get_fclk_period(), div);
+		printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
+		       cs, (div * gpmc_get_fclk_period()) / 1000, div);
 #endif
-
-	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-	l &= ~0x03;
-	l |= (div - 1);
+		l &= ~0x03;
+		l |= (div - 1);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
+	}
 
 	return 0;
 }
@@ -338,19 +349,10 @@ void __init gpmc_mem_init(void)
 	int cs;
 	unsigned long boot_rom_space = 0;
 
-	if (cpu_is_omap242x()) {
-		u32 l;
-		l = omap_readl(OMAP242X_CONTROL_STATUS);
-		/* In case of internal boot the 1st MB is redirected to the
-		 * boot ROM memory space.
-		 */
-		if (l & (1 << 3))
-			boot_rom_space = BOOT_ROM_SPACE;
-	} else
-		/* We assume internal boot if the mode can't be
-		 * determined.
-		 */
-		boot_rom_space = BOOT_ROM_SPACE;
+	/* never allocate the first page, to facilitate bug detection;
+	 * even if we didn't boot from ROM.
+	 */
+	boot_rom_space = BOOT_ROM_SPACE;
 	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
 	gpmc_mem_root.end = GPMC_MEM_END;
 
