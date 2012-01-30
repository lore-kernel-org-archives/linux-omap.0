From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/7] ARM: OMAP2+: timer: use a proper interface to get hwmod
 data
Date: Mon, 30 Jan 2012 03:18:18 -0700
Message-ID: <20120130101817.10450.23726.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42212 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab2A3KSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 05:18:44 -0500
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

arch/arm/mach-omap2/timer.c pokes around inside the hwmod data
structures.  Since the hwmod data structures are about to change, this
code will break.  This patch modifies the timer code to use
recently-added hwmod functions instead.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 6eeff0e..499d884 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -145,6 +145,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 {
 	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
 	struct omap_hwmod *oh;
+	u32 pa_start, pa_end;
 	size_t size;
 	int res = 0;
 
@@ -154,9 +155,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (!oh)
 		return -ENODEV;
 
-	timer->irq = oh->mpu_irqs[0].irq;
-	timer->phys_base = oh->slaves[0]->addr->pa_start;
-	size = oh->slaves[0]->addr->pa_end - timer->phys_base;
+	timer->irq = omap_hwmod_get_mpu_irq(oh);
+	omap_hwmod_get_mpu_rt_pa(oh, &pa_start, &pa_end);
+	timer->phys_base = pa_start;
+	size = pa_end - pa_start;
 
 	/* Static mapping, never released */
 	timer->io_base = ioremap(timer->phys_base, size);


