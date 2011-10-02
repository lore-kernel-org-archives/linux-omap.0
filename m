From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 25/30] ARM: OMAP depends on MMU
Date: Sun,  2 Oct 2011 16:45:55 +0200
Message-ID: <1317566760-25681-26-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55222 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab1JBOrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Oct 2011 10:47:03 -0400
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

There is no way to build OMAP kernels without an MMU
at this point because of dependencies on MMU-only functions.

As long as nobody is interested in fixing this, let's just disable
this platforms for nommu kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ebc5d9..e688ca4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -875,6 +875,7 @@ config ARCH_DAVINCI
 
 config ARCH_OMAP
 	bool "TI OMAP"
+	depends on MMU
 	select HAVE_CLK
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
-- 
1.7.5.4

