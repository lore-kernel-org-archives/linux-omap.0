From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 27/30] ARM: omap: select L2X0 cache on omap4
Date: Sun,  2 Oct 2011 16:45:57 +0200
Message-ID: <1317566760-25681-28-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55172 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab1JBOrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Oct 2011 10:47:03 -0400
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

The cache controller needs to be enabled for the
cortex-a9 specific errata that are also selected
to work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index fd0ab18..3921a95 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -47,6 +47,7 @@ config ARCH_OMAP4
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
+	select CACHE_L2X0
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI
-- 
1.7.5.4

