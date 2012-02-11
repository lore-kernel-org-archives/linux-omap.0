From: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH] arm: omap4: allow disabling MPU local timer if 32K timer is enabled
Date: Sat, 11 Feb 2012 16:31:25 +0800
Message-ID: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43854 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab2BKIbh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Feb 2012 03:31:37 -0500
Received: by pbcun15 with SMTP id un15so3092576pbc.19
        for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 00:31:37 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ming Lei <tom.leiming@gmail.com>

With 32K gp timer, tick can be driven and system can run well, so
allow MPU local timer to be disabled if someone requires it, otherwise
MPU local timer is always chosen as the default clock_event_device.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d965da4..12cd602 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -46,7 +46,7 @@ config ARCH_OMAP4
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_SMP
-	select LOCAL_TIMERS if SMP
+	select LOCAL_TIMERS if (SMP && !OMAP_32K_TIMER)
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
-- 
1.7.9

