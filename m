From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/11] ARM: OMAP: Update MMC header to fix compile
Date: Fri, 9 May 2008 10:30:45 -0700
Message-ID: <20080509173044.GH24454@atomide.com>
References: <1210286975-29506-1-git-send-email-tony@atomide.com> <1210286975-29506-2-git-send-email-tony@atomide.com> <1d0d774ffcdd0ab0537d3b0917d42144@felipebalbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57599 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401AbYEIRax (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 13:30:53 -0400
Content-Disposition: inline
In-Reply-To: <1d0d774ffcdd0ab0537d3b0917d42144@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Felipe Balbi <me@felipebalbi.com> [080509 02:51]:
> 
> 
> On Thu,  8 May 2008 15:49:25 -0700, Tony Lindgren <tony@atomide.com> wrote:
> > Update MMC header from linux-omap tree to match the recent
> > MMC driver updates.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  include/asm-arm/arch-omap/mmc.h |   26 ++++++++++++++++----------
> >  1 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/asm-arm/arch-omap/mmc.h
> > b/include/asm-arm/arch-omap/mmc.h
> > index c9588f4..6dff38e 100644
> > --- a/include/asm-arm/arch-omap/mmc.h
> > +++ b/include/asm-arm/arch-omap/mmc.h
> > @@ -15,21 +15,16 @@
> >  #include <linux/device.h>
> >  #include <linux/mmc/host.h>
> > 
> > +#include <asm/arch/board.h>
> > +
> >  #define OMAP_MMC_MAX_SLOTS	2
> > 
> >  struct omap_mmc_platform_data {
> > -	struct omap_mmc_conf	conf;
> > +	struct omap_mmc_conf    conf;
> 
> could you revert this line ? you converted the tab into spaces.

Yeah, that should not be there. Updated patch below, also fixed
in linux-omap tree.

Tony

--xHFwDpU9dbj6ez1V
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-ARM-OMAP-Update-MMC-header-to-fix-compile.patch"

>From 0a4b53a22d75efa750f0b93c9b00dd0dc51c0b07 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 8 May 2008 15:30:33 -0700
Subject: [PATCH] ARM: OMAP: Update MMC header to fix compile

Update MMC header from linux-omap tree to match the recent
MMC driver updates.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/asm-arm/arch-omap/mmc.h |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/asm-arm/arch-omap/mmc.h b/include/asm-arm/arch-omap/mmc.h
index c9588f4..7cfc5f2 100644
--- a/include/asm-arm/arch-omap/mmc.h
+++ b/include/asm-arm/arch-omap/mmc.h
@@ -15,21 +15,16 @@
 #include <linux/device.h>
 #include <linux/mmc/host.h>
 
+#include <asm/arch/board.h>
+
 #define OMAP_MMC_MAX_SLOTS	2
 
 struct omap_mmc_platform_data {
 	struct omap_mmc_conf	conf;
 
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


--xHFwDpU9dbj6ez1V--
