From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 3/6] OMAP1: enable GENERIC_IRQ_CHIP
Date: Thu,  4 Aug 2011 08:45:07 -0700
Message-ID: <1312472710-31758-4-git-send-email-khilman@ti.com>
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49710 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753895Ab1HDPon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 11:44:43 -0400
Received: by mail-yw0-f53.google.com with SMTP id 8so1546533ywa.40
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 08:44:42 -0700 (PDT)
In-Reply-To: <1312472710-31758-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

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
1.7.6

