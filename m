From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 04/14] ARM: OMAP: Fix timer posted mode support
Date: Wed, 7 Nov 2012 13:01:20 -0600
Message-ID: <1352314890-22224-5-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36065 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689Ab2KGTBl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 14:01:41 -0500
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently the dmtimer posted mode is being enabled when the function
omap_dm_timer_enable_posted() is called. This function is only being called
for OMAP1 timers and OMAP2+ timers that are being used as system timers. Hence,
for OMAP2+ timers that are NOT being used as a system timer, posted mode is
not enabled but the "timer->posted" variable is still set (incorrectly) in
the omap_dm_timer_prepare() function.

This is a regression introduced by commit 3392cdd3 (ARM: OMAP: dmtimer:
switch-over to platform device driver) which was before the
omap_dm_timer_enable_posted() function was introduced. Although this is a
regression from the original code it only impacts performance and so is not
needed for stable.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4abbbe5..bf484aa 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -124,21 +124,16 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_enable(timer);
 	if (timer->pdev->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
 
 	__omap_dm_timer_reset(timer, 0, 0);
-	omap_dm_timer_enable_posted(timer);
-	omap_dm_timer_disable(timer);
 }
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
-	int ret;
-
 	/*
 	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
 	 * do not call clk_get() for these devices.
@@ -152,13 +147,15 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 		}
 	}
 
+	omap_dm_timer_enable(timer);
+
 	if (timer->capability & OMAP_TIMER_NEEDS_RESET)
 		omap_dm_timer_reset(timer);
 
-	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	omap_dm_timer_enable_posted(timer);
+	omap_dm_timer_disable(timer);
 
-	timer->posted = 1;
-	return ret;
+	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 }
 
 static inline u32 omap_dm_timer_reserved_systimer(int id)
-- 
1.7.9.5

