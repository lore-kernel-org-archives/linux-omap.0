From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
Date: Tue,  4 Jan 2011 14:02:55 +0200
Message-ID: <1294142577-28772-3-git-send-email-balbi@ti.com>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46529 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028Ab1ADMDM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 07:03:12 -0500
Received: by mail-gy0-f177.google.com with SMTP id 4so5527729gyg.8
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 04:03:11 -0800 (PST)
In-Reply-To: <1294142577-28772-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>

GENERIC_HARDIRQS is defined under kernel/irq/Kconfig,
so it's safe to drop the duplicated entry and simply
select HAVE_GENERIC_HARDIRQS.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c0..e6f0f8b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,6 +15,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_GENERIC_HARDIRQS
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
@@ -88,10 +89,6 @@ config MCA
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
 
-config GENERIC_HARDIRQS
-	bool
-	default y
-
 config STACKTRACE_SUPPORT
 	bool
 	default y
@@ -171,9 +168,6 @@ config FIQ
 config ARCH_MTD_XIP
 	bool
 
-config GENERIC_HARDIRQS_NO__DO_IRQ
-	def_bool y
-
 config ARM_L1_CACHE_SHIFT_6
 	bool
 	help
-- 
1.7.3.4.598.g85356

