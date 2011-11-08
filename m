From: tom.leiming@gmail.com
Subject: [PATCH] arm: omap2: fix build failure
Date: Tue,  8 Nov 2011 12:34:09 +0800
Message-ID: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49904 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1KHEfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 23:35:50 -0500
Received: by gyc15 with SMTP id 15so124050gyc.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 20:35:50 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ming Lei <tom.leiming@gmail.com>

From: Ming Lei <tom.leiming@gmail.com>

The patch fixes the compile failure:

  CC      arch/arm/mach-omap2/cpuidle34xx.o
arch/arm/mach-omap2/cpuidle34xx.c:317:12: error: 'THIS_MODULE'
undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1fe35c2..158c17e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/module.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
-- 
1.7.5.4

