From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/11] ARM: OMAP: MMC: Remove unused power_pin
Date: Tue, 14 Apr 2009 14:51:45 -0700
Message-ID: <20090414215145.9878.32222.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58039 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbZDNVvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:51:47 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>

From: Ladislav Michl <ladis@linux-mips.org>

Remove unused power_pin

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/mmc.h |    1 -
 drivers/mmc/host/omap.c               |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 4435bd4..81d5b36 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -79,7 +79,6 @@ struct omap_mmc_platform_data {
 
 		/* use the internal clock */
 		unsigned internal_clock:1;
-		s16 power_pin;
 
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5570849..bfa25c0 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -157,8 +157,6 @@ struct mmc_omap_host {
 	struct timer_list	dma_timer;
 	unsigned		dma_len;
 
-	short			power_pin;
-
 	struct mmc_omap_slot    *slots[OMAP_MMC_MAX_SLOTS];
 	struct mmc_omap_slot    *current_slot;
 	spinlock_t              slot_lock;

