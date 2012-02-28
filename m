From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 8/8] ARM: OMAP2+: timer: use a proper interface to get
 hwmod data
Date: Mon, 27 Feb 2012 22:37:10 -0700
Message-ID: <20120228053707.16278.35928.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab2B1Fhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 00:37:47 -0500
In-Reply-To: <20120228053524.16278.59430.stgit@dusk>
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
 arch/arm/mach-omap2/timer.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5c9acea..f073016 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -145,8 +145,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 {
 	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
 	struct omap_hwmod *oh;
+	struct resource irq_rsrc, mem_rsrc;
 	size_t size;
 	int res = 0;
+	int r;
 
 	sprintf(name, "timer%d", gptimer_id);
 	omap_hwmod_setup_one(name);
@@ -154,9 +156,16 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (!oh)
 		return -ENODEV;
 
-	timer->irq = oh->mpu_irqs[0].irq;
-	timer->phys_base = oh->slaves[0]->addr->pa_start;
-	size = oh->slaves[0]->addr->pa_end - timer->phys_base;
+	r = omap_hwmod_get_resource_byname(oh, IORESOURCE_IRQ, NULL, &irq_rsrc);
+	if (r)
+		return -ENXIO;
+	timer->irq = irq_rsrc.start;
+
+	r = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM, NULL, &mem_rsrc);
+	if (r)
+		return -ENXIO;
+	timer->phys_base = mem_rsrc.start;
+	size = mem_rsrc.end - mem_rsrc.start;
 
 	/* Static mapping, never released */
 	timer->io_base = ioremap(timer->phys_base, size);


