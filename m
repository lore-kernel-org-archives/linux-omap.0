From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 09/10] OMAP4: Enabling smartrefles class 3 driver.
Date: Wed, 18 Aug 2010 16:46:30 +0530
Message-ID: <1282130191-9062-10-git-send-email-thara@ti.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51683 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764Ab0HRLQp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:16:45 -0400
In-Reply-To: <1282130191-9062-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch enables smartreflex class3 mode of operation for OMAP4430 SDP board.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..3395e61 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -36,6 +36,7 @@
 #include <plat/usb.h>
 #include <plat/mmc.h>
 #include "hsmmc.h"
+#include "smartreflex-class3.h"
 
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
@@ -182,6 +183,7 @@ static void __init omap_4430sdp_init_irq(void)
 #endif
 	gic_init_irq();
 	omap_gpio_init();
+	sr_class3_init();
 }
 
 static struct omap_musb_board_data musb_board_data = {
-- 
1.7.1.GIT

