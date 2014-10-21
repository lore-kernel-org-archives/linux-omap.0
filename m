From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/5] ARM: OMAP2+: gpmc: Print error message in set_gpmc_timing_reg()
Date: Tue, 21 Oct 2014 15:41:45 +0300
Message-ID: <1413895309-9152-2-git-send-email-rogerq@ti.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbaJUMl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2014 08:41:57 -0400
In-Reply-To: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>

Simplify set_gpmc_timing_reg() and always print error message
if the requested timing cannot be achieved due to a too fast
GPMC functional clock, irrespective if whether DEBUG is defined
or not. This should help us debug timing configuration issues,
which were otherwise simply not being displayed in the kernel log.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5fa3755..45f680f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -283,13 +283,8 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
 			   p->cycle2cyclediffcsen);
 }
 
-#ifdef DEBUG
 static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 			       int time, const char *name)
-#else
-static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
-			       int time)
-#endif
 {
 	u32 l;
 	int ticks, mask, nr_bits;
@@ -299,15 +294,15 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	else
 		ticks = gpmc_ns_to_ticks(time);
 	nr_bits = end_bit - st_bit + 1;
-	if (ticks >= 1 << nr_bits) {
-#ifdef DEBUG
-		printk(KERN_INFO "GPMC CS%d: %-10s* %3d ns, %3d ticks >= %d\n",
-				cs, name, time, ticks, 1 << nr_bits);
-#endif
+	mask = (1 << nr_bits) - 1;
+
+	if (ticks > mask) {
+		pr_err("%s: GPMC error! CS%d: %s: %d ns, %d ticks > %d\n",
+		       __func__, cs, name, time, ticks, mask);
+
 		return -1;
 	}
 
-	mask = (1 << nr_bits) - 1;
 	l = gpmc_cs_read_reg(cs, reg);
 #ifdef DEBUG
 	printk(KERN_INFO
@@ -322,16 +317,10 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	return 0;
 }
 
-#ifdef DEBUG
 #define GPMC_SET_ONE(reg, st, end, field) \
 	if (set_gpmc_timing_reg(cs, (reg), (st), (end),		\
 			t->field, #field) < 0)			\
 		return -1
-#else
-#define GPMC_SET_ONE(reg, st, end, field) \
-	if (set_gpmc_timing_reg(cs, (reg), (st), (end), t->field) < 0) \
-		return -1
-#endif
 
 int gpmc_calc_divider(unsigned int sync_clk)
 {
-- 
1.8.3.2

