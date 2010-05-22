From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Sat, 22 May 2010 22:58:48 +0100
Message-ID: <20100522215848.GB29889@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39323 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758278Ab0EVV7E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 17:59:04 -0400
Content-Disposition: inline
In-Reply-To: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

I'm going to take a slightly different approach to LMB given the
(unique) problems that OMAP has with converting over to LMB.  I've
been re-ordering my patchset so that we do as many changes as
possible to sanitize the code before introducing LMB.

So, below is a patch to sanitize the code in arch/arm/plat-omap/fb.c.
The logic in this file is rather convoluted, but essentially:

1. region type 0 is SDRAM
2. referring to the code fragment
                if (set_fbmem_region_type(&rg, OMAPFB_MEMTYPE_SDRAM,
                                          sdram_start, sdram_size) < 0 ||
                    (rg.type != OMAPFB_MEMTYPE_SDRAM))
                        continue;
   - if rg.type is not OMAPFB_MEMTYPE_SDRAM, set_fbmem_region_type()
     returns zero immediately (since rg.type is non-zero), and so we
     'continue'.
   - if rg.type is OMAPFB_MEMTYPE_SDRAM, and rg.paddr is zero,
     we fall through.
   - if rg.type is OMAPFB_MEMTYPE_SDRAM, and the region lies within
     SDRAM, we fall through.
   - if rg.type is OMAPFB_MEMTYPE_SDRAM, and the region is not within
     SDRAM, we 'continue'.
3. check_fbmem_region seems unnecessary.
   - we know rg.type is OMAPFB_MEMTYPE_SDRAM
   - we can check rg.size independently
   - bootmem_reserve() can check for overlapping reservations itself
   - we've already validated that the requested region lies within SDRAM.
4. avoid BUG()ing if the region entry is already set; print an error,
   and mark the configuration invalid - at least we'll continue booting
   so the error message has a chance of being logged/visible via serial
   console.

With these changes in place, it makes the code much easier to understand
and hence easier to convert to LMB.  I suggest this should be validated
well before the next merge window.

I'm sure with the SDRAM code simplified like this, the SRAM code can be
cleaned up and some of the complex helper functions killed off.

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index d3eea4f..97db493 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -171,49 +171,76 @@ static int check_fbmem_region(int region_idx, struct omapfb_mem_region *rg,
 	return 0;
 }
 
+static int valid_sdram(unsigned long addr, unsigned long size)
+{
+	struct bootmem_data *bdata = NODE_DATA(0)->bdata;
+	unsigned long sdram_start, sdram_end;
+
+	sdram_start = bdata->node_min_pfn << PAGE_SHIFT;
+	sdram_end = bdata->node_low_pfn << PAGE_SHIFT;
+
+	return addr >= sdram_start && sdram_end - addr >= size;
+}
+
+static int reserve_sdram(unsigned long addr, unsigned long size)
+{
+	return reserve_bootmem(addr, size, BOOTMEM_EXCLUSIVE);
+}
+
 /*
  * Called from map_io. We need to call to this early enough so that we
  * can reserve the fixed SDRAM regions before VM could get hold of them.
  */
 void __init omapfb_reserve_sdram(void)
 {
-	struct bootmem_data	*bdata;
-	unsigned long		sdram_start, sdram_size;
-	unsigned long		reserved;
-	int			i;
+	unsigned long reserved = 0;
+	int i;
 
 	if (config_invalid)
 		return;
 
-	bdata = NODE_DATA(0)->bdata;
-	sdram_start = bdata->node_min_pfn << PAGE_SHIFT;
-	sdram_size = (bdata->node_low_pfn << PAGE_SHIFT) - sdram_start;
-	reserved = 0;
 	for (i = 0; ; i++) {
-		struct omapfb_mem_region	rg;
+		struct omapfb_mem_region rg;
 
 		if (get_fbmem_region(i, &rg) < 0)
 			break;
+
 		if (i == OMAPFB_PLANE_NUM) {
-			printk(KERN_ERR
-				"Extraneous FB mem configuration entries\n");
+			pr_err("Extraneous FB mem configuration entries\n");
 			config_invalid = 1;
 			return;
 		}
+
 		/* Check if it's our memory type. */
-		if (set_fbmem_region_type(&rg, OMAPFB_MEMTYPE_SDRAM,
-				          sdram_start, sdram_size) < 0 ||
-		    (rg.type != OMAPFB_MEMTYPE_SDRAM))
+		if (rg.type != OMAPFB_MEMTYPE_SDRAM)
 			continue;
-		BUG_ON(omapfb_config.mem_desc.region[i].size);
-		if (check_fbmem_region(i, &rg, sdram_start, sdram_size) < 0) {
+
+		/* Check if the region falls within SDRAM */
+		if (rg.paddr && !valid_sdram(rg.paddr, rg.size))
+			continue;
+
+		if (rg.size == 0) {
+			pr_err("Zero size for FB region %d\n", i);
 			config_invalid = 1;
 			return;
 		}
+
 		if (rg.paddr) {
-			reserve_bootmem(rg.paddr, rg.size, BOOTMEM_DEFAULT);
+			if (reserve_sdram(rg.paddr, rg.size)) {
+				pr_err("Trying to use reserved memory for FB region %d\n",
+					i);
+				config_invalid = 1;
+				return;
+			}
 			reserved += rg.size;
 		}
+
+		if (omapfb_config.mem_desc.region[i].size) {
+			pr_err("FB region %d already set\n", i);
+			config_invalid = 1;
+			return;
+		}
+
 		omapfb_config.mem_desc.region[i] = rg;
 		configured_regions++;
 	}
