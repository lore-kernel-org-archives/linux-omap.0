From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 1/7] ARM: OMAP2+: Fix selection of clockevent timer when using device-tree
Date: Mon, 4 Feb 2013 11:43:00 -0600
Message-ID: <1359999786-8740-2-git-send-email-jon-hunter@ti.com>
References: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49822 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754410Ab3BDRnM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 12:43:12 -0500
In-Reply-To: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Jon Hunter <jon-hunter@ti.com>

Commit 9725f44 (ARM: OMAP: Add DT support for timer driver) added
device-tree support for selecting a clockevent timer by property.
However, the code is currently ignoring the property passed and
selecting the first available timer found. Hence, for the OMAP3 beagle
board timer-12 is not being selected as expected. Fix this problem
by ensuring the timer property is passed to omap_get_timer_dt().

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2822833..72c2ca1 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -227,7 +227,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	int r = 0;
 
 	if (of_have_populated_dt()) {
-		np = omap_get_timer_dt(omap_timer_match, NULL);
+		np = omap_get_timer_dt(omap_timer_match, property);
 		if (!np)
 			return -ENODEV;
 
-- 
1.7.10.4

