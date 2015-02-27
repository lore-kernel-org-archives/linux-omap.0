From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 5/8 v4] ARM OMAP2+ GPMC: always program GPMCFCLKDIVIDER
Date: Fri, 27 Feb 2015 16:56:52 +0100
Message-ID: <1425052615-29093-6-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1425052615-29093-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425052615-29093-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

The WAITMONITORINGTIME is expressed as a number of GPMC_CLK clock cycles,
even though the access is defined as asynchronous, and no GPMC_CLK clock
is provided to the external device. Still, GPMCFCLKDIVIDER is used as a divider
for the GPMC clock, so it must be programmed to define the
correct WAITMONITORINGTIME delay.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 drivers/memory/omap-gpmc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 432e638..02e5228 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -499,7 +499,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 
 	l = gpmc_cs_read_reg(cs, reg);
 #ifdef DEBUG
-	printk(KERN_INFO
+	pr_info(
 		"GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
 	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
 			(l >> st_bit) & mask, time);
@@ -571,19 +571,14 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
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
+	pr_info("GPMC CS%d CLK period is %lu ns (div %d)\n",
+			cs, (div * gpmc_get_fclk_period()) / 1000, div);
 #endif
-		l &= ~0x03;
-		l |= (div - 1);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
-	}
+	l &= ~0x03;
+	l |= (div - 1);
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 
 	gpmc_cs_bool_timings(cs, &t->bool_timings);
 	gpmc_cs_show_timings(cs, "after gpmc_cs_set_timings");
-- 
2.3.0
