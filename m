From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: [PATCH 5/5] OMAP: Make set_gpmc_timing_reg aware of the TIMEPARAGRANULARITY flag
Date: Tue,  6 Apr 2010 09:51:08 -0700
Message-ID: <1270572668-2336-6-git-send-email-lwalkera@ieee.org>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-2-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-3-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-4-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-5-git-send-email-lwalkera@ieee.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og124.obsmtp.com ([64.18.2.26]:56497 "HELO
	exprod7og124.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754845Ab0DFRCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:02:32 -0400
In-Reply-To: <1270572668-2336-5-git-send-email-lwalkera@ieee.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Laine Walker-Avina <lwalkera@ieee.org>


Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>
---
 arch/arm/mach-omap2/gpmc.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5bc3ca0..9fa80e3 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -171,12 +171,15 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 #endif
 {
 	u32 l;
-	int ticks, mask, nr_bits;
+	int ticks, mask, nr_bits, para_gran;
+
+	para_gran = (gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1) &
+		GPMC_CONFIG1_TIME_PARA_GRAN ? 2 : 1);
 
 	if (time == 0)
 		ticks = 0;
 	else
-		ticks = gpmc_ns_to_ticks(time);
+		ticks = gpmc_ns_to_ticks(time/para_gran);
 	nr_bits = end_bit - st_bit + 1;
 	if (ticks >= 1 << nr_bits) {
 #ifdef DEBUG
@@ -191,8 +194,8 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 #ifdef DEBUG
 	printk(KERN_INFO
 		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
-	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
-			(l >> st_bit) & mask, time);
+	       cs, name, ticks, gpmc_get_fclk_period() * para_gran *
+		   ticks / 1000, (l >> st_bit) & mask, time);
 #endif
 	l &= ~(mask << st_bit);
 	l |= ticks << st_bit;
@@ -231,6 +234,9 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 {
 	int div;
 	u32 l;
+#ifdef DEBUG
+	printk(KERN_INFO "GPMC_FCLK: %ld\n", gpmc_get_fclk_period());
+#endif
 
 	div = gpmc_cs_calc_divider(cs, t->sync_clk);
 	if (div < 0)
-- 
1.6.3.3

