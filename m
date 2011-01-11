From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] omap3: igep3: Add omap_reserve functionality
Date: Tue, 11 Jan 2011 16:47:54 +0100
Message-ID: <1294760874-28088-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64052 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195Ab1AKPsD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 10:48:03 -0500
Received: by wwa36 with SMTP id 36so1908429wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 07:48:02 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

This patch adds omap_reserve functionality to board-igep0030.c.

This patch is in similar lines to commit id 71ee7dad9b6991, from
Russell king

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0030.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index 11b944f..4dc62a9 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -450,6 +450,7 @@ static void __init igep3_init(void)
 
 MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.boot_params	= 0x80000100,
+	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_irq	= igep3_init_irq,
 	.init_machine	= igep3_init,
-- 
1.7.0.4

