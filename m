From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 1/4] ARM OMAP2+ GPMC: fix debug output alignment
Date: Mon, 16 Feb 2015 16:48:58 +0100
Message-ID: <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

GPMC debug output is aligned to 10 characters for field names.
However, some fields have bigger names, screwing up the alignment.
Consequently, alignment was changed to longest field name (17 chars) for now.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 arch/arm/mach-omap2/gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1ab6bc0..5c3639c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -296,7 +296,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	nr_bits = end_bit - st_bit + 1;
 	if (ticks >= 1 << nr_bits) {
 #ifdef DEBUG
-		printk(KERN_INFO "GPMC CS%d: %-10s* %3d ns, %3d ticks >= %d\n",
+		printk(KERN_INFO "GPMC CS%d: %-17s* %3d ns, %3d ticks >= %d\n",
 				cs, name, time, ticks, 1 << nr_bits);
 #endif
 		return -1;
@@ -306,7 +306,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	l = gpmc_cs_read_reg(cs, reg);
 #ifdef DEBUG
 	printk(KERN_INFO
-		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
+		"GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
 	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
 			(l >> st_bit) & mask, time);
 #endif
-- 
2.3.0
