From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 30/30] ARM: omap2: select ARM_AMBA for OMAP3_EMU
Date: Sun,  2 Oct 2011 16:46:00 +0200
Message-ID: <1317566760-25681-31-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51780 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab1JBOrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Oct 2011 10:47:05 -0400
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

OMAP3_EMU needs OC_ETM, which needs ARM_AMBA. Since the latter
dependency is getting turned from a 'select' into a 'depends',
omap has to select ARM_AMBA itself in order to have a correct
dependency chain. Alternatively, we could change OMAP3_EMU
to have a 'depends on OC_ETM' instead of selecting it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index fdd45dd..12ae86e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -386,6 +386,7 @@ config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
 	select OC_ETM
+	select ARM_AMBA
 	help
 	  Say Y here to enable debugging hardware of omap3
 
-- 
1.7.5.4

