From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 1/2] OMAP3: MMC: Pass pin muxing control flag
Date: Mon, 15 Jun 2009 18:37:38 -0500
Message-ID: <1245109058-31117-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36759 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbZFOXjE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jun 2009 19:39:04 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5FNd1pa018961
	for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 18:39:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Some drivers have a requirement not to do the default pin
muxing for MMC

Those drivers can pass on nomux=1 from twl4030_hsmmc_info
and perform the pin muxing in their board file before call
to funciton twl4030_mmc_init()

Signded-off-by: Vikram Pandita <vikram.pandtia@ti.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    1 +
 arch/arm/mach-omap2/mmc-twl4030.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 9756a87..d14f0b3 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -354,6 +354,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 		mmc->slots[0].name = twl->name;
 		mmc->nr_slots = 1;
 		mmc->slots[0].wires = c->wires;
+		mmc->slots[0].nomux = c->nomux;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
 		mmc->init = twl_mmc_late_init;
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 3807c45..b837588 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -9,6 +9,7 @@
 struct twl4030_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u8	wires;		/* 1/4/8 wires */
+	unsigned nomux:1;	/* control pin muxing */
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
 	bool	cover_only;	/* No card detect - just cover switch */
-- 
1.6.0.3.613.g9f8f13

