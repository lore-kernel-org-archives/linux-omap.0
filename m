From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH v2] OMAP4: Pandaboard: Add omap_reserve functionality
Date: Wed,  8 Dec 2010 12:40:47 +0530
Message-ID: <1291792247-26634-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38672 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab0LHHMG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 02:12:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rmk+kernel@arm.linux.org.uk, linux-arm@lists.arm.linux.org.uk

This patch adds omap_reserve functionality to board-omap4panda.c.
Helps in the reserving boot time memory in SDRAM, used here for
framebuffer allocation.

This patch is in similar lines to commit id 71ee7dad9b6991, from
Russell king

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm@lists.arm.linux.org.uk
Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index da24745..0ccc24f 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -393,6 +393,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
 	.map_io		= omap4_panda_map_io,
+	.reserve	= omap_reserve,
 	.init_irq	= omap4_panda_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap_timer,
-- 
1.7.0.4

