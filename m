From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/10] OMAP: Devkit8000: Change lcd driver to AT070TN83
Date: Tue, 20 Sep 2011 11:18:19 +0300
Message-ID: <1316506706-18941-4-git-send-email-tomi.valkeinen@ti.com>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51463 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753995Ab1ITISx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 04:18:53 -0400
Received: by bkbzu5 with SMTP id zu5so344648bkb.21
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 01:18:51 -0700 (PDT)
In-Reply-To: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Thomas Weber <weber@corscience.de>

Change lcd driver from generic to AT070TN83.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index d3941e6..da5057e 100644
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
1.7.4.1

