From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/11] ARM: OMAP: Update MMC header to fix compile
Date: Thu,  8 May 2008 15:49:25 -0700
Message-ID: <1210286975-29506-2-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:51916 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761121AbYEHWtj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:39 -0400
In-Reply-To: <1210286975-29506-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Update MMC header from linux-omap tree to match the recent
MMC driver updates.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/asm-arm/arch-omap/mmc.h |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/asm-arm/arch-omap/mmc.h b/include/asm-arm/arch-omap/mmc.h
index c9588f4..6dff38e 100644
--- a/include/asm-arm/arch-omap/mmc.h
+++ b/include/asm-arm/arch-omap/mmc.h
@@ -15,21 +15,16 @@
 #include <linux/device.h>
 #include <linux/mmc/host.h>
 
+#include <asm/arch/board.h>
+
 #define OMAP_MMC_MAX_SLOTS	2
 
 struct omap_mmc_platform_data {
-	struct omap_mmc_conf	conf;
+	struct omap_mmc_conf    conf;
 
-	unsigned enabled:1;
 	/* number of slots on board */
 	unsigned nr_slots:2;
-	/* nomux means "standard" muxing is wrong on this board, and that
-	 * board-specific code handled it before common init logic.
-	 */
-	unsigned nomux:1;
-	/* 4 wire signaling is optional, and is only used for SD/SDIO and
-	 * MMCv4 */
-	unsigned wire4:1;
+
 	/* set if your board has components or wiring that limits the
 	 * maximum frequency on the MMC bus */
 	unsigned int max_freq;
@@ -40,6 +35,11 @@ struct omap_mmc_platform_data {
 	 * not supported */
 	int (* init)(struct device *dev);
 	void (* cleanup)(struct device *dev);
+	void (* shutdown)(struct device *dev);
+
+	/* To handle board related suspend/resume functionality for MMC */
+	int (*suspend)(struct device *dev, int slot);
+	int (*resume)(struct device *dev, int slot);
 
 	struct omap_mmc_slot_data {
 		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
@@ -56,13 +56,19 @@ struct omap_mmc_platform_data {
 
 		const char *name;
 		u32 ocr_mask;
+
+		/* Card detection IRQs */
+		int card_detect_irq;
+		int (* card_detect)(int irq);
+
+		unsigned int ban_openended:1;
+
 	} slots[OMAP_MMC_MAX_SLOTS];
 };
 
 extern void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info);
 
 /* called from board-specific card detection service routine */
-extern void omap_mmc_notify_card_detect(struct device *dev, int slot, int detected);
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot, int is_closed);
 
 #endif
-- 
1.5.3.6

