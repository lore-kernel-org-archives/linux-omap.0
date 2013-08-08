From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] ARM: omap2: Use a consistent AM33XX SoC option description
Date: Thu,  8 Aug 2013 18:32:08 -0300
Message-ID: <1375997528-396-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41088 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966703Ab3HHVcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 17:32:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Fix the option description to match the other TI SoCs.
This is just a cosmetic change.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 76170dd..56021c6 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -64,7 +64,7 @@ config SOC_OMAP5
 	select ARM_ERRATA_798181 if SMP
 
 config SOC_AM33XX
-	bool "AM33XX support"
+	bool "TI AM33XX"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
 	select ARM_CPU_SUSPEND if PM
-- 
1.8.1.5

