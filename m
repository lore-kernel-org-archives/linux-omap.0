From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 01/12] ARM: OMAP: Remove unnecessary clk structure
Date: Tue, 5 Jun 2012 12:34:49 -0500
Message-ID: <1338917700-29174-2-git-send-email-jon-hunter@ti.com>
References: <1338917700-29174-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53006 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983Ab2FERfF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jun 2012 13:35:05 -0400
In-Reply-To: <1338917700-29174-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

In the plat/dmtimer.h there is a structure named "clk" declared. This structure
is not used and appears to be left over from previous code. Hence, remove this
unused structure.

Verified that both omap1 and omap2plus kernel configurations build with this
change.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 5da7356..5fdfaa4 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -71,7 +71,6 @@ struct omap_timer_capability_dev_attr {
 };
 
 struct omap_dm_timer;
-struct clk;
 
 struct timer_regs {
 	u32 tidr;
-- 
1.7.9.5

