From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: omap: fix Kconfig warning
Date: Mon, 08 Sep 2014 17:00:49 +0200
Message-ID: <3763111.OttSKCMuxb@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60554 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbaIHPAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 11:00:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

A small mistake during the recent Kconfig cleanup has led
to a harmless warning for OMAP1:

warning: (ARCH_OMAP1) selects ARCH_OMAP which has unmet direct dependencies (ARCH_MULTI_V6 || ARCH_MULTI_V7)

We can easily avoid that by moving the ARCH_OMAP symbol outside of the
OMAP2 submenu.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e7189dcc9309..30d787e99e1a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,9 +1,9 @@
-menu "TI OMAP/AM/DM/DRA Family"
-	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
-
 config ARCH_OMAP
 	bool
 
+menu "TI OMAP/AM/DM/DRA Family"
+	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
+
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_MULTI_V6

