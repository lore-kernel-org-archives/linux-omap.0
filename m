From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 2/3] OMAP: Devkit8000: Change lcd driver to AT070TN83
Date: Thu,  1 Sep 2011 15:05:08 +0200
Message-ID: <1314882308-25915-2-git-send-email-weber@corscience.de>
References: <1314859332.1933.4.camel@deskari>
 <1314882308-25915-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58986 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab1IANFn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 09:05:43 -0400
In-Reply-To: <1314882308-25915-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Change lcd driver from generic to AT070TN83.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 4b1f6c6..a3b8e81 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -139,7 +139,7 @@ static struct regulator_consumer_supply devkit8000_vio_supply[] = {
 };
 
 static struct panel_generic_dpi_data lcd_panel = {
-	.name			= "generic",
+	.name			= "innolux_at070tn83",
 	.platform_enable        = devkit8000_panel_enable_lcd,
 	.platform_disable       = devkit8000_panel_disable_lcd,
 };
-- 
1.7.6.1

