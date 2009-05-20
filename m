From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 01/13] Revert "ARM: OMAP: Mask interrupts when disabling interrupts, v2"
Date: Wed, 20 May 2009 16:19:24 -0700
Message-ID: <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:37575 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757363AbZETXTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:19:39 -0400
Received: by wf-out-1314.google.com with SMTP id 26so241368wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:19:40 -0700 (PDT)
In-Reply-To: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

This reverts commit 5461af5af5c6a7fee78978aafe720541bf3a2f55.

Adding a disable hook to the irq_chip is not the way to fix the
problem being addressed by this patch.  Instead, we need to fix
support for [enable|disable]_irq_wake().

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 998c5c4..08a3b99 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -134,7 +134,6 @@ static struct irq_chip omap_irq_chip = {
 	.ack	= omap_mask_ack_irq,
 	.mask	= omap_mask_irq,
 	.unmask	= omap_unmask_irq,
-	.disable = omap_mask_irq,
 };
 
 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
-- 
1.6.2.2

