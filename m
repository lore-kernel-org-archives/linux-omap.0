From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND PATCH 2/3] arm: Kconfig: remove duplicated SPARSE_IRQ entry
Date: Thu, 20 Jan 2011 08:43:31 +0200
Message-ID: <1295505812-5062-3-git-send-email-balbi@ti.com>
References: <1295505812-5062-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51924 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754269Ab1ATGn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 01:43:56 -0500
Received: by gyf1 with SMTP id 1so82285gyf.35
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:43:55 -0800 (PST)
In-Reply-To: <1295505812-5062-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

SPARSE_IRQ is defined under kernel/irq/Kconfig so
it's safe to remove the duplicated entry.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9756f07..c231192 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -530,7 +530,7 @@ config ARCH_MMP
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
@@ -611,7 +611,7 @@ config ARCH_PXA
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-- 
1.7.4.rc2

