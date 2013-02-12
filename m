From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 7/8] ARM: omap2: gpmc-onenand: Replace printk KERN_ERR with dev_warn()
Date: Tue, 12 Feb 2013 16:22:23 -0300
Message-ID: <1360696944-3371-8-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47134 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab3BLTWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 14:22:49 -0500
In-Reply-To: <1360696944-3371-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Since the condition is not an error but a warning, replace
printk KERN_ERR with dev_warn.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 4771945..fd6e35b 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -367,7 +367,7 @@ void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 
 	if (cpu_is_omap24xx() &&
 			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
-		printk(KERN_ERR "Onenand using only SYNC_READ on 24xx\n");
+		dev_warn(dev, "OneNAND using only SYNC_READ on 24xx\n");
 		gpmc_onenand_data->flags &= ~ONENAND_SYNC_READWRITE;
 		gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
 	}
-- 
1.7.8.6

