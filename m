From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/9] ARM: OMAP: Remove unnecessary clk structure
Date: Tue, 15 May 2012 18:35:21 -0500
Message-ID: <1337124921-19957-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39522 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966132Ab2EOXfU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 19:35:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

In the plat/dmtimer.h there is a structure named "clk" declared. This structure
is not used and appears to be left over from previous code. Hence, remove this
unused structure.

Verified that both omap1 and omap2plus kernel configurations build with this
change.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

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
1.7.5.4

