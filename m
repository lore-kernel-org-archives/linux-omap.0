From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH] OMAP4: Pandaboad: Add omap_reserve functionality
Date: Tue,  7 Dec 2010 17:55:34 +0530
Message-ID: <1291724734-25070-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59917 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab0LGM0d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 07:26:33 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB7CQU75028880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 7 Dec 2010 06:26:33 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oB7CQTDw022320
	for <linux-omap@vger.kernel.org>; Tue, 7 Dec 2010 17:56:30 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds omap_reserve functionality to board-omap4panda.c.
Helps in the reserving boot time memory in SDRAM, used here for
framebuffer allocation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1ecd0a6..ad6b5cc 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -392,6 +392,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
 	.map_io		= omap4_panda_map_io,
+	.reserve	= omap_reserve,
 	.init_irq	= omap4_panda_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap_timer,
-- 
1.7.0.4

