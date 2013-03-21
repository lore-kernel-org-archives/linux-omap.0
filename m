From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH] ARM: OMAP4: Enable fix for Cortex-A9 erratas
Date: Thu, 21 Mar 2013 20:12:17 +0530
Message-ID: <1363876938-31724-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33439 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933538Ab3CUOm1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Mar 2013 10:42:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, r.sricharan@ti.com

This enables the fixes for the below erratas
applicable for OMAP4 Socs.

754322: Faulty MMU translations following ASID switch

775420: A data cache maintenance operation which aborts,
        followed by an ISB, without any DSB in-between,
        might lead to deadlock

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index c3477e7..c4a3f3f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,8 @@ config ARCH_OMAP4
 	select PM_RUNTIME if CPU_IDLE
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select COMMON_CLK
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
 
 config SOC_OMAP5
 	bool "TI OMAP5"
-- 
1.7.9.5

