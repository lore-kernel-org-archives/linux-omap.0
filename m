From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] OMAP: dmtimer: enable all timers to be wakeup events
Date: Sat, 04 Apr 2009 14:54:09 -0600
Message-ID: <20090404205409.12269.94966.stgit@localhost.localdomain>
References: <20090404205333.12269.76287.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38011 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080AbZDDUzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 16:55:08 -0400
In-Reply-To: <20090404205333.12269.76287.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

All GP timers on OMAP2/3 can generate wakeup events.  The wakeup status is
cleared in the PRCM interrupt handler.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h |    4 ++--
 arch/arm/plat-omap/dmtimer.c    |    6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 72003f7..88c5acb 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -625,8 +625,8 @@ static struct clk func_32k_ck = {
 	.clkdm_name	= "wkup_clkdm",
 };
 
-static struct clk secure_32k_fck = {
-	.name		= "secure_32k_fck",
+static struct clk secure_32k_ck = {
+	.name		= "secure_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
 	.flags		= RATE_FIXED,
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index bf2b8ea..55bb996 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -321,11 +321,9 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
 
 	/*
-	 * Enable wake-up only for GPT1 on OMAP2 CPUs.
-	 * FIXME: All timers should have wake-up enabled and clear
-	 * PRCM status.
+	 * Enable wake-up on OMAP2 CPUs.
 	 */
-	if (cpu_class_is_omap2() && (timer == &dm_timers[0]))
+	if (cpu_class_is_omap2())
 		l |= 1 << 2;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
 


