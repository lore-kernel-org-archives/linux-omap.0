From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND/PATCH 1/2] arm: Kconfig: select correct HAVE_SPARSE_IRQ symbol
Date: Tue, 17 May 2011 02:46:11 +0300
Message-ID: <1305589572-5812-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:56521 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753718Ab1EPXqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 19:46:24 -0400
Received: by mail-bw0-f43.google.com with SMTP id 14so84874bwz.16
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 16:46:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>

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
index 377a7a5..416b02f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -541,7 +541,7 @@ config ARCH_MMP
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
@@ -622,7 +622,7 @@ config ARCH_PXA
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
-	select SPARSE_IRQ
+	select HAVE_SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-- 
1.7.4.1.343.ga91df

