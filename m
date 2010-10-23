From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 2/3] omap3: IGEP v2: Remove igep2_config array.
Date: Sat, 23 Oct 2010 18:48:59 +0200
Message-ID: <1287852540-4951-3-git-send-email-eballetbo@gmail.com>
References: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64262 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab0JWQtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 12:49:12 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so1953708wyf.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Oct 2010 09:49:12 -0700 (PDT)
In-Reply-To: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

omap_board_config_size is implicitly initialized to 0 in
plat-omap/common.c, get_config() won't dereference omap_board_config,
so we can remove the empty igep2_config array.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 20b199f..42dcbf4 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -247,9 +247,6 @@ static inline void __init igep2_init_smsc911x(void)
 static inline void __init igep2_init_smsc911x(void) { }
 #endif
 
-static struct omap_board_config_kernel igep2_config[] __initdata = {
-};
-
 static struct regulator_consumer_supply igep2_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -486,8 +483,6 @@ static struct platform_device *igep2_devices[] __initdata = {
 
 static void __init igep2_init_irq(void)
 {
-	omap_board_config = igep2_config;
-	omap_board_config_size = ARRAY_SIZE(igep2_config);
 	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
-- 
1.7.1

