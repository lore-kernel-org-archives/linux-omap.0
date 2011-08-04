From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/6] OMAP2+: Kconfig: don't select PM in OMAP2PLUS_TYPICAL
Date: Thu,  4 Aug 2011 08:45:05 -0700
Message-ID: <1312472710-31758-2-git-send-email-khilman@ti.com>
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:38576 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663Ab1HDPok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 11:44:40 -0400
Received: by mail-yi0-f47.google.com with SMTP id 18so1286554yib.20
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 08:44:39 -0700 (PDT)
In-Reply-To: <1312472710-31758-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

CONFIG_PM is no longer a user-selectable Kconfig option.  Rather it is
automatically enabled if either CONFIG_SUSPEND or CONFIG_RUNTIME_PM is
enabled, so having a 'select PM' here is redunant when 'select
CONFIG_PM_RUNTIME' is present.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4ae6257..57b66d5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -7,7 +7,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	default y
 	select AEABI
 	select REGULATOR
-	select PM
 	select PM_RUNTIME
 	select VFP
 	select NEON if ARCH_OMAP3 || ARCH_OMAP4
-- 
1.7.6

