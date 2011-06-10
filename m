From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] OMAP3+: Kconfig: has EHCI only if USB present
Date: Fri, 10 Jun 2011 10:14:33 -0500
Message-ID: <1307718873-27652-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49507 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757526Ab1FJPOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 11:14:40 -0400
Received: by mail-iw0-f173.google.com with SMTP id 42so3287234iwl.18
        for <linux-omap@vger.kernel.org>; Fri, 10 Jun 2011 08:14:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, felipe <balbi@ti.com>, Nishanth Menon <nm@ti.com>

Attempting to disable USB generates the following warning at the moment:
warning: (ARCH_OMAP3 && ARCH_OMAP4) selects USB_ARCH_HAS_EHCI which has unmet direct dependencies (USB_SUPPORT)

Signed-off-by: Nishanth Menon <nm@ti.com>
---
based on 3.0-rc2
 arch/arm/mach-omap2/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ef7e12f..d5cf1a8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -33,7 +33,7 @@ config ARCH_OMAP3
 	depends on ARCH_OMAP2PLUS
 	default y
 	select CPU_V7
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
@@ -50,7 +50,7 @@ config ARCH_OMAP4
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
-- 
1.7.1

