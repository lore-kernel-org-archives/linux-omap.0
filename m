From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/8] ARM: OMAP: Define omap_dm_timer_prepare function as static
Date: Tue, 13 Nov 2012 12:13:17 -0600
Message-ID: <1352830403-1706-3-git-send-email-jon-hunter@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57208 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261Ab2KMSNe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 13:13:34 -0500
In-Reply-To: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The omap_dm_timer_prepare function is a local function only used in the
dmtimer.c file. Therefore, make this a static function and remove its
declaration from the dmtimer.h file.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4c28452..efe4774 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -128,7 +128,7 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	return 0;
 }
 
-int omap_dm_timer_prepare(struct omap_dm_timer *timer)
+static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
 	int rc;
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index c5c890d..40383b6 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -286,8 +286,6 @@ struct omap_dm_timer {
 	struct list_head node;
 };
 
-int omap_dm_timer_prepare(struct omap_dm_timer *timer);
-
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 						int posted)
 {
-- 
1.7.9.5

