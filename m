From: mathieu.poirier@linaro.org
Subject: [PATCH 8/9] arm: OMAP depends on MMU
Date: Fri, 23 Mar 2012 11:13:55 -0600
Message-ID: <1332522836-29517-9-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40425 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759228Ab2CWROP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 13:14:15 -0400
Received: by mail-yx0-f174.google.com with SMTP id l12so2929343yen.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 10:14:15 -0700 (PDT)
In-Reply-To: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de

From: Arnd Bergmann <arnd@arndb.de>

There is no way to build OMAP kernels without an MMU
at this point because of dependencies on MMU-only functions.

As long as nobody is interested in fixing this, let's just disable
this platforms for nommu kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dfb0312..8124ce0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -939,6 +939,7 @@ config ARCH_DAVINCI
 
 config ARCH_OMAP
 	bool "TI OMAP"
+	depends on MMU
 	select HAVE_CLK
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
-- 
1.7.5.4

