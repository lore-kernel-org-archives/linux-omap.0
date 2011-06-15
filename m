From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND PATCH 1/2] arm: Kconfig: select correct HAVE_SPARSE_IRQ symbol
Date: Wed, 15 Jun 2011 16:02:39 +0300
Message-ID: <1308142960-20767-2-git-send-email-balbi@ti.com>
References: <1308142960-20767-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44855 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753764Ab1FONCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 09:02:49 -0400
Received: by mail-fx0-f43.google.com with SMTP id 3so577781fxm.16
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 06:02:48 -0700 (PDT)
In-Reply-To: <1308142960-20767-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <balbi@ti.com>

commit e2a93ecc7fc469dab52323c11a2d8ceaa62aac7b
(ARM: Use genirq definitions from kernel/irq/Kconfig)
made ARM Kconfig use the generic Kconfig symbols from
kernel/irq/Kconfig but did not fix the boards which
were using the older symbols, fix them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..a061525 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -545,7 +545,7 @@ config ARCH_MMP
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
@@ -617,7 +617,7 @@ config ARCH_PXA
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-- 
1.7.6.rc1

