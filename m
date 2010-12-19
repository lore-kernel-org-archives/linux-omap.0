From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap: pandora: fix wifi support
Date: Mon, 20 Dec 2010 00:33:36 +0200
Message-ID: <1292798016-11098-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33944 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0LSWdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Dec 2010 17:33:42 -0500
Received: by wyb28 with SMTP id 28so2334982wyb.19
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 14:33:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Grazvydas Ignotas <notasas@gmail.com>

After commit ed919b0 "mmc: sdio: fix runtime PM anomalies by introducing
MMC_CAP_POWER_OFF_CARD" it is required to specify MMC_CAP_POWER_OFF_CARD
to have runtime PM support. As the wl1251 driver expects card to be
powered down when it's not used, wifi will no longer work after interface
is brought down at least once without functioning runtime PM.

Fix this by declaring MMC_CAP_POWER_OFF_CARD for MMC3.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
this is a fix but can go for 2.6.38 as wl1251 runtime PM support
is only queued for .38 .

 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 89ed1be..12c0bbb 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -293,7 +293,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	},
 	{
 		.mmc		= 3,
-		.caps		= MMC_CAP_4_BIT_DATA,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.init_card	= pandora_wl1251_init_card,
-- 
1.6.3.3

