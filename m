From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH] ARM: Kconfig: NR_GPIO AM43x default
Date: Fri, 2 Aug 2013 19:24:11 +0530
Message-ID: <1375451651-27173-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42165 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab3HBNyl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 09:54:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

On an AM43x only config, currently default ARCH_NR_GPIO would be zero.
Default it to that supported by the SoC.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 37c0f4e..c5356c5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1605,6 +1605,7 @@ config ARCH_NR_GPIO
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_SUNXI
 	default 264 if MACH_H4700
+	default 192 if SOC_AM43XX
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
-- 
1.7.9.5

