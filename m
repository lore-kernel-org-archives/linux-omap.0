From: tom.leiming@gmail.com
Subject: [PATCH -next] arm: omap2: fix compile failure on arch/arm/mach-omap2/cpuidle34xx.c
Date: Thu, 17 Nov 2011 11:03:41 +0800
Message-ID: <1321499021-23764-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45507 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab1KQDEC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 22:04:02 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so1521694iag.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Nov 2011 19:04:02 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ming Lei <tom.leiming@gmail.com>

From: Ming Lei <tom.leiming@gmail.com>

  CC      arch/arm/mach-omap2/cpuidle34xx.o
arch/arm/mach-omap2/cpuidle34xx.c: In function 'omap3_enter_idle':
arch/arm/mach-omap2/cpuidle34xx.c:117:2: error: implicit declaration of
function 'omap_irq_pending'
make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 158c17e..0f49834 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -34,6 +34,7 @@
 
 #include "pm.h"
 #include "control.h"
+#include "common.h"
 
 #ifdef CONFIG_CPU_IDLE
 
-- 
1.7.5.4

