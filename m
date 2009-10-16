From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/14] omap: Use ioremap in dmtimer.c
Date: Fri, 16 Oct 2009 16:40:53 -0700
Message-ID: <20091016234053.2463.45156.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50247 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbZJPXkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:40:49 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Use ioremap in dmtimer.c

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index d325b54..e4e848e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -742,16 +742,17 @@ EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 int __init omap_dm_timer_init(void)
 {
 	struct omap_dm_timer *timer;
-	int i;
+	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
 
 	if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
 		return -ENODEV;
 
 	spin_lock_init(&dm_timer_lock);
 
-	if (cpu_class_is_omap1())
+	if (cpu_class_is_omap1()) {
 		dm_timers = omap1_dm_timers;
-	else if (cpu_is_omap24xx()) {
+		map_size = SZ_2K;
+	} else if (cpu_is_omap24xx()) {
 		dm_timers = omap2_dm_timers;
 		dm_source_names = omap2_dm_source_names;
 		dm_source_clocks = omap2_dm_source_clocks;
@@ -774,10 +775,11 @@ int __init omap_dm_timer_init(void)
 
 	for (i = 0; i < dm_timer_count; i++) {
 		timer = &dm_timers[i];
-		if (cpu_class_is_omap1())
-			timer->io_base = OMAP1_IO_ADDRESS(timer->phys_base);
-		else
-			timer->io_base = OMAP2_IO_ADDRESS(timer->phys_base);
+
+		/* Static mapping, never released */
+		timer->io_base = ioremap(timer->phys_base, map_size);
+		BUG_ON(!timer->io_base);
+
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 					defined(CONFIG_ARCH_OMAP4)
 		if (cpu_class_is_omap2()) {

