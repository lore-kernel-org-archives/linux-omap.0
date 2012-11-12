From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 07/13] ARM: OMAP: Fix dmtimer reset for timer1
Date: Mon, 12 Nov 2012 12:20:38 -0600
Message-ID: <1352744444-2633-8-git-send-email-jon-hunter@ti.com>
References: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56632 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab2KLSVA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 13:21:00 -0500
In-Reply-To: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

In commit e32f7ec2 (ARM: OMAP: Fix 32 kHz timer and modify GP timer to use GPT1)
a fix was added to prevent timer1 being reset in the function
omap_dm_timer_reset() because timer1 was being used as the system timer for
OMAP2 devices. Although timer1 is still used by most OMAP2+ devices as a system
timer, the function omap_dm_timer_reset() is now only being called for OMAP1
devices and OMAP1 does not use timer1 as a system timer. Therefore, remove the
check in omap_dm_timer_reset() so that timer1 is reset for OMAP1 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 10ec31b..d4f9541 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -121,11 +121,8 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
-	if (timer->pdev->id != 1) {
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
-		omap_dm_timer_wait_for_reset(timer);
-	}
-
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
+	omap_dm_timer_wait_for_reset(timer);
 	__omap_dm_timer_reset(timer, 0, 0);
 }
 
-- 
1.7.9.5

