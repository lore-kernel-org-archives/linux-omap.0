From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ARM: OMAP2: reboot: Include common.h to fix build error
Date: Thu, 20 Jun 2013 01:46:41 +0800
Message-ID: <1371664001.9848.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54882 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab3FSRqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 13:46:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so5410720pab.11
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 10:46:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Robin Holt <holt@sgi.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Include common.h which will include linux/reboot.h to fix below build error.

  CC      arch/arm/mach-omap2/omap4-restart.o
arch/arm/mach-omap2/omap4-restart.c:21:28: warning: 'enum reboot_mode' declared inside parameter list [enabled by default]
arch/arm/mach-omap2/omap4-restart.c:21:28: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
arch/arm/mach-omap2/omap4-restart.c:21:40: error: parameter 1 ('mode') has incomplete type
arch/arm/mach-omap2/omap4-restart.c:21:6: warning: function declaration isn't a prototype [-Wstrict-prototypes]
make[1]: *** [arch/arm/mach-omap2/omap4-restart.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Seems this build error is introduced by commit 7507d035f3cf40c
"reboot: arm: change reboot_mode to use enum reboot_mode"

This patch is against linux-next 20130619.

 arch/arm/mach-omap2/omap4-restart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
index 652adde..7306d9b 100644
--- a/arch/arm/mach-omap2/omap4-restart.c
+++ b/arch/arm/mach-omap2/omap4-restart.c
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include "prminst44xx.h"
+#include "common.h"
 
 /**
  * omap44xx_restart - trigger a software restart of the SoC
-- 
1.8.1.2



