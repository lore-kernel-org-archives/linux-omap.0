From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: fix CONFIG_CPU_IDLE dependency on CONFIG_PM
Date: Thu, 28 Jun 2012 09:45:14 -0700
Message-ID: <1340901914-771-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:43446 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843Ab2F1QpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 12:45:22 -0400
Received: by dakp5 with SMTP id p5so3823112dak.14
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 09:45:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Lezcano <daniel.lezcano@linaro.org>

commit 164e0cbf60 (ARM: OMAP3/4: consolidate cpuidle Makefile) added
an OMAP-specific dependency from CPU_IDLE to CONFIG_PM.  This causes
some randconfig warnings when CONFIG_PM has unmet dependencies:

warning: (ARCH_OMAP3 && ARCH_OMAP4) selects PM which has unmet direct dependencies (PM_SLEEP || PM_RUNTIME)
warning: (ARCH_OMAP3 && ARCH_OMAP4) selects PM which has unmet direct dependencies (PM_SLEEP || PM_RUNTIME)
warning: (ARCH_OMAP3 && ARCH_OMAP4) selects PM which has unmet direct dependencies (PM_SLEEP || PM_RUNTIME)

Fix this by making the dependency on CONFIG_PM_RUNTIME (which in turn
will enable CONFIG_PM.)

Reported-by: Tony Lindgren <tony@atomide.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, this fixes the randconfig problems you mentioned.  It applies on
top of your testing-board branch, where the commit that introduced this
problem is applied.

 arch/arm/mach-omap2/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f83dd91..6b7e028 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -35,7 +35,7 @@ config ARCH_OMAP3
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARCH_HAS_OPP
-	select PM if CPU_IDLE
+	select PM_RUNTIME if CPU_IDLE
 	select PM_OPP if PM
 	select ARM_CPU_SUSPEND if PM
 	select MULTI_IRQ_HANDLER
@@ -53,7 +53,7 @@ config ARCH_OMAP4
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
-	select PM if CPU_IDLE
+	select PM_RUNTIME if CPU_IDLE
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
-- 
1.7.9.2

