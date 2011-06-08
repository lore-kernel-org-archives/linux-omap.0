From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP1: enable GENERIC_IRQ_CHIP
Date: Tue,  7 Jun 2011 17:02:46 -0700
Message-ID: <1307491366-28793-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56781 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756143Ab1FHACc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 20:02:32 -0400
Received: by mail-pv0-f170.google.com with SMTP id 10so7683pvh.29
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 17:02:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

OMAP1 needs this also since GPIO driver (common for all OMAPs) is
being converted to use generic IRQ chip.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 49a4c75..9a4a6bf 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -13,6 +13,7 @@ config ARCH_OMAP1
 	bool "TI OMAP1"
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
-- 
1.7.4

