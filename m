From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 1/5] omap:hwmod-hwspinlock-enable
Date: Mon, 19 Jul 2010 11:50:17 -0500
Message-ID: <1279558221-14954-2-git-send-email-h-kanigeri2@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52141 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936426Ab0GSQjd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 12:39:33 -0400
In-Reply-To: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Cousson Benoit <b-cousson@ti.com>, Simon Que <sque@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

From: Simon Que <sque@ti.com>

uncomment the hwmod part for hwspinlock

Signed-off-by: Simon Que <sque@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 03bb3db..41dc77d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4966,7 +4966,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 /*	&omap44xx_smartreflex_iva_hwmod, */
 /*	&omap44xx_smartreflex_mpu_hwmod, */
 	/* spinlock class */
-/*	&omap44xx_spinlock_hwmod, */
+	&omap44xx_spinlock_hwmod,
 	/* timer class */
 	&omap44xx_timer1_hwmod,
 	&omap44xx_timer2_hwmod,
-- 
1.7.0

