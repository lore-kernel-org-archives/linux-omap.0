From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP: Fix kernel panic in dmtimer probe
Date: Thu, 8 Nov 2012 18:17:23 -0600
Message-ID: <1352420243-31803-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43496 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab2KIAR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 19:17:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

When booting with device-tree the kernel is panicing in the probe of the
DMTIMER driver. The panic is caused because the pointer to platform_data
structure is NULL when booting with device-tree and the driver is
attempting to access the structure without checking if the pointer is
valid.

Fix this by moving the code that accesses the platform data structure
under the "else" clause of the "if (dev->of_node)" statement because
here the pointer to platform_data is guaranteed to be valid. The code
accessing the "timer_capability" member of the platform data is simply
removed as this is already handled under the else clause.

This regression was introduced while integrating commit "ARM: OMAP: Add
DT support for timer driver" to add device-tree support to the DMTIMER
driver and commit "ARM: OMAP: Move omap-pm-noop.c local to mach-omap2"
to prepare for single zImage support.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 38c12ef..9dca23e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -799,12 +799,11 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		timer->id = pdev->id;
 		timer->capability = pdata->timer_capability;
 		timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
+		timer->get_context_loss_count = pdata->get_context_loss_count;
 	}
 
 	timer->irq = irq->start;
 	timer->pdev = pdev;
-	timer->capability = pdata->timer_capability;
-	timer->get_context_loss_count = pdata->get_context_loss_count;
 
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
-- 
1.7.9.5

