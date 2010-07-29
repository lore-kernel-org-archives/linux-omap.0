From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: [PATCH v2] OMAP: Make set_gpmc_timing_reg aware of the TIMEPARAGRANULARITY flag
Date: Thu, 29 Jul 2010 14:44:26 -0700
Message-ID: <1280439866-32208-1-git-send-email-lwalkera@ieee.org>
References: <876344jjiy.fsf@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og124.obsmtp.com ([64.18.2.26]:43894 "HELO
	exprod7og124.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751424Ab0G2Vym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 17:54:42 -0400
In-Reply-To: <876344jjiy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Laine Walker-Avina <lwalkera@ieee.org>

This patch modifies the math used to convert clock ticks to nanoseconds
so that it is aware of the effect of the TIMEPARAGRANULARITY flag which
acts as a divide by 2 to the GPMC timing registers. This enables the use
of slower devices on the GPMC bus.
---
 arch/arm/mach-omap2/gpmc.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5bc3ca0..6c3a786 100644
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
+		GPMC_CONFIG1_TIME_PARA_GRAN ? 2:1);
 
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
-- 
1.6.3.3

