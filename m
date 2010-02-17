From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH v2] omap: Remove DEBUGFS dependency for mux name checking
Date: Wed, 17 Feb 2010 22:47:01 +0530
Message-ID: <1266427021-10990-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32938 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab0BQRRJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 12:17:09 -0500
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
 arch/arm/mach-omap2/mux.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 986077f..b4ca84e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -961,16 +961,14 @@ static void __init omap_mux_init_list(struct omap_mux *superset)
 	while (superset->reg_offset !=  OMAP_MUX_TERMINATOR) {
 		struct omap_mux *entry;
 
-#ifndef CONFIG_OMAP_MUX
-		/* Skip pins that are not muxed as GPIO by bootloader */
-		if (!OMAP_MODE_GPIO(omap_mux_read(superset->reg_offset))) {
+#ifdef CONFIG_OMAP_MUX
+		if (!superset->muxnames || !superset->muxnames[0]) {
 			superset++;
 			continue;
 		}
-#endif
-
-#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)
-		if (!superset->muxnames || !superset->muxnames[0]) {
+#else
+		/* Skip pins that are not muxed as GPIO by bootloader */
+		if (!OMAP_MODE_GPIO(omap_mux_read(superset->reg_offset))) {
 			superset++;
 			continue;
 		}
-- 
1.6.2.4

