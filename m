From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH 1/3] OMAP3: PM: include 'mach/irqs.h'
Date: Tue, 17 Mar 2009 16:23:02 +0900
Message-ID: <4d34a0a70903170023l5b94db2an204f1aaae46b14cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:43632 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbZCQHXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 03:23:04 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2378264wfa.4
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 00:23:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: q1.kim@samsung.com, Kevin Hilman <khilman@deeprootsystems.com>, Jouni Hogander <jouni.hogander@nokia.com>, kyungmin.park@samsung.com

This patch fixes this compile error
  CC      arch/arm/mach-omap2/cpuidle34xx.o
arch/arm/mach-omap2/cpuidle34xx.c:100: error: implicit declaration of
function 'omap_irq_pending'
make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1

The omap_irq_pending() function is declared in
'arch/arm/plat-omap/include/mach/irqs.h'

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
b/arch/arm/mach-omap2/cpuidle34xx.c
index 62fbb2e..5e50c46 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -28,6 +28,7 @@
 #include <mach/powerdomain.h>
 #include <mach/control.h>
 #include <mach/serial.h>
+#include <mach/irqs.h>

 #include "pm.h"

-- 
1.5.2.5

-- 
Kyuwon
