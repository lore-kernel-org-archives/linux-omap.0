From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 28/30] ARM: omap: select CPU_FREQ_TABLE where needed
Date: Sun,  2 Oct 2011 16:45:58 +0200
Message-ID: <1317566760-25681-29-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60623 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab1JBOrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Oct 2011 10:47:07 -0400
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

The omap platform requires CPU_FREQ_TABLE support to be enabled for its
CPU_FREQ implementations, so automatically select that when CPU_FREQ
is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-omap/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index bb8f4a6..f7ef9f4 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -217,6 +217,11 @@ config OMAP_PM_NOOP
 
 endchoice
 
+config OMAP_CPU_FREQ
+	def_bool "y"
+	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
+
 endmenu
 
 endif
-- 
1.7.5.4

