From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] ARM: OMAP2+: select PINCTRL in Kconfig
Date: Mon, 27 Aug 2012 11:30:44 +0530
Message-ID: <1346047244-26909-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120Ab2H0GAy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 02:00:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

Select PINCTRL in Kconfig under Typical OMAP configuration, this
is required to add pinctrl driver to omap2+ family of devices.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dd2db02..a164568 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -18,6 +18,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
 	select HIGHMEM
+	select PINCTRL
 	help
 	  Compile a kernel suitable for booting most boards
 
-- 
1.7.9.5

