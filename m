From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] omap: Remove DEBUGFS dependency for mux name checking
Date: Wed, 17 Feb 2010 11:48:07 +0530
Message-ID: <1266387487-27588-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36755 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104Ab0BQGSO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 01:18:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, ranjithl@ti.com

The check for a valid mux name should be performed regardless of whether
DEBUGFS is enabled or not.

This fixes the issue currently seen with boards not booting up
if DEBUGFS is not enabled in defconfig.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/mach-omap2/mux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 986077f..1a6ff8f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -969,7 +969,7 @@ static void __init omap_mux_init_list(struct omap_mux *superset)
 		}
 #endif
 
-#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)
+#ifdef CONFIG_OMAP_MUX
 		if (!superset->muxnames || !superset->muxnames[0]) {
 			superset++;
 			continue;
-- 
1.6.2.4

