From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 7/8] omap3: Use timing data for omap2_init_common_hw on IGEP v2
Date: Wed, 18 Nov 2009 21:20:39 +0100
Message-ID: <1258575640-8169-8-git-send-email-eballetbo@gmail.com>
References: <1258575640-8169-1-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-2-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-3-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-4-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-5-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-6-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-7-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:63735 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449Ab0AMLC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 06:02:59 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so323499ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 03:02:58 -0800 (PST)
In-Reply-To: <1258575640-8169-7-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>


Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 054bc21..c7f8ea5 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -33,6 +33,7 @@
 
 #include "mux.h"
 #include "mmc-twl4030.h"
+#include "sdram-numonyx-m65kxxxxam.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
@@ -340,7 +341,7 @@ static void __init igep2_init_irq(void)
 {
 	omap_board_config = igep2_config;
 	omap_board_config_size = ARRAY_SIZE(igep2_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
-- 
1.5.4.3

