From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/4] OMAP2/3: GPMC: ensure valid clock pointer
Date: Thu, 28 Jan 2010 09:17:14 -0800
Message-ID: <1264699036-5491-3-git-send-email-khilman@deeprootsystems.com>
References: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:54167 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab0A1RRW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 12:17:22 -0500
Received: by mail-pw0-f42.google.com with SMTP id 21so625474pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 09:17:22 -0800 (PST)
In-Reply-To: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ensure valud clock pointer during GPMC init.  Fixes compiler
warning about potential use of uninitialized variable.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/gpmc.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 3f1334f..7027cdc 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -505,7 +505,7 @@ static void __init gpmc_mem_init(void)
 void __init gpmc_init(void)
 {
 	u32 l;
-	char *ck;
+	char *ck = NULL;
 
 	if (cpu_is_omap24xx()) {
 		ck = "core_l3_ck";
@@ -521,6 +521,9 @@ void __init gpmc_init(void)
 		l = OMAP44XX_GPMC_BASE;
 	}
 
+	if (WARN_ON(!ck))
+		return;
+
 	gpmc_l3_clk = clk_get(NULL, ck);
 	if (IS_ERR(gpmc_l3_clk)) {
 		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
-- 
1.6.6

