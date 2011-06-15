From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND PATCH 2/2] arm: Kconfig: allow OMAP to use sparse IRQ numbering
Date: Wed, 15 Jun 2011 16:02:40 +0300
Message-ID: <1308142960-20767-3-git-send-email-balbi@ti.com>
References: <1308142960-20767-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39642 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753764Ab1FONDK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 09:03:10 -0400
Received: by fxm8 with SMTP id 8so478339fxm.40
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 06:03:08 -0700 (PDT)
In-Reply-To: <1308142960-20767-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <balbi@ti.com>

Select HAVE_SPARSE_IRQ to allow OMAP to use
sparse IRQ numbering scheme. The main difference
is that irq_descs will be added to a radix tree
instead of a static array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a061525..bdb6244 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -850,6 +850,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.6.rc1

