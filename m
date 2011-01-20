From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND PATCH 1/3] arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
Date: Thu, 20 Jan 2011 08:43:30 +0200
Message-ID: <1295505812-5062-2-git-send-email-balbi@ti.com>
References: <1295505812-5062-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51874 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754269Ab1ATGns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 01:43:48 -0500
Received: by yxl31 with SMTP id 31so83155yxl.0
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:43:47 -0800 (PST)
In-Reply-To: <1295505812-5062-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

GENERIC_HARDIRQS is defined under kernel/irq/Kconfig,
so it's safe to drop the duplicated entry and simply
select HAVE_GENERIC_HARDIRQS.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..9756f07 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -17,6 +17,7 @@ config ARM
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_GENERIC_HARDIRQS
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
-- 
1.7.4.rc2

