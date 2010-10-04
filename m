From: tom.leiming@gmail.com
Subject: [PATCH] OMAP: mmc: remove ifdef in omap_mmc_platform_data defination
Date: Tue,  5 Oct 2010 00:53:21 +0800
Message-ID: <1286211201-31168-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47374 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab0JDQxj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 12:53:39 -0400
Received: by pvg2 with SMTP id 2so1385365pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 09:53:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>

From: Ming Lei <tom.leiming@gmail.com>

The instance of omap_mmc_platform_data is alwasy passed to
mmc omap host driver from board, so remove ifdef in omap_mmc_platform_data
defination to simplify handling it in mmc omap host driver.

The patch fixes the compile error below:

drivers/mmc/host/omap.c: In function 'mmc_omap_new_slot':
drivers/mmc/host/omap.c:1320: error: 'struct omap_mmc_slot_data' has no member named 'wires'
make[3]: *** [drivers/mmc/host/omap.o] Error 1
make[2]: *** [drivers/mmc/host] Error 2
make[1]: *** [drivers/mmc] Error 2
make: *** [drivers] Error 2

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/plat-omap/include/plat/mmc.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 3107892..f57f36a 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -80,12 +80,8 @@ struct omap_mmc_platform_data {
 		 * 4/8 wires and any additional host capabilities
 		 * need to OR'd all capabilities (ref. linux/mmc/host.h)
 		 */
-#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2420)
 		u8  wires;	/* Used for the MMC driver on omap1 and 2420 */
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
 		u32 caps;	/* Used for the MMC driver on 2430 and later */
-#endif
 
 		/*
 		 * nomux means "standard" muxing is wrong on this board, and
-- 
1.7.3

