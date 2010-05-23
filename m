From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: omap: Build failure with tip of Linus' tree
Date: Sun, 23 May 2010 03:11:08 +0300
Message-ID: <20100523001108.GB15859@matterhorn.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UHN/qo2QbUvPLonB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47855 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516Ab0EWAKr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 20:10:47 -0400
Received: by fxm5 with SMTP id 5so1688268fxm.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 17:10:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ajay.gupta@ti.com


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Tony,

I see the following build failure with the latest tip from Linus. I'm not
sure if something is yet to be merged for other subsystem trees before -rc1,
but a patch to fix the build is attached.

Cheers,
Amit

--UHN/qo2QbUvPLonB
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-omap-fix-build-failure-due-to-missing-include-dma-ma.patch"

>From 0222c29661c9a36dcf3a1b2786b62b0080b9dc88 Mon Sep 17 00:00:00 2001
Message-Id: <0222c29661c9a36dcf3a1b2786b62b0080b9dc88.1274572962.git.amit.kucheria@canonical.com>
From: Amit Kucheria <amit.kucheria@canonical.com>
Date: Sun, 23 May 2010 03:00:51 +0300
Subject: [PATCH] omap: fix build failure due to missing include dma-mapping.h

Fixes following error,

CC      arch/arm/mach-omap2/usb-ehci.o
arch/arm/mach-omap2/usb-ehci.c:263: error: implicit declaration of function
'DMA_BIT_MASK'
arch/arm/mach-omap2/usb-ehci.c:263: error: initializer element is not constant
make[1]: *** [arch/arm/mach-omap2/usb-ehci.o] Error 1

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/mach-omap2/usb-ehci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index c68f799..d72d1ac 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -20,6 +20,8 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+
 #include <asm/io.h>
 #include <plat/mux.h>
 
-- 
1.7.0.4


--UHN/qo2QbUvPLonB--
