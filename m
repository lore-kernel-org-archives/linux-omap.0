From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 2/4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Mon, 16 Feb 2015 16:48:59 +0100
Message-ID: <1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

GPMC uses GPMCFCLKDIVIDER during synchronous as well as asynchronous accesses
in conjunction with WAITMONITORINGTIME. Thus, it's wrong to only program it for
synchronous accesses. Remove the conditional.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 arch/arm/mach-omap2/gpmc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5c3639c..bae4a20 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -382,19 +382,14 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
 
-	/* caller is expected to have initialized CONFIG1 to cover
-	 * at least sync vs async
-	 */
 	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-	if (l & (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {
 #ifdef DEBUG
-		printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
-				cs, (div * gpmc_get_fclk_period()) / 1000, div);
+	printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
+	       cs, (div * gpmc_get_fclk_period()) / 1000, div);
 #endif
-		l &= ~0x03;
-		l |= (div - 1);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
-	}
+	l &= ~0x03;
+	l |= (div - 1);
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 
 	gpmc_cs_bool_timings(cs, &t->bool_timings);
 
-- 
2.3.0
