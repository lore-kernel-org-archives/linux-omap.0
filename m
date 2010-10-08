From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: fix scratchpad memory accesses for off-mode
Date: Fri,  8 Oct 2010 15:43:45 -0700
Message-ID: <1286577825-22029-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61965 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0JHWns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 18:43:48 -0400
Received: by pwj4 with SMTP id 4so306562pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 15:43:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jean.pihet@newoldbits.com, "G, Manjunath Kondaiah" <manjugk@ti.com>

Commit 914bab936fe0388a529079679e2f137aa4ff548d (OMAP: mach-omap2: Fix
incorrect assignment warnings) changed a pointer from 'u32 *' to
'void *' without also fixing up the pointer arithmetic.

Fix the scratchpad offsets so they are byte offsets instead of
word offsets and thus work correctly with a void pointer base.

Special thanks to Jean Pihet for taking the time track down this
problem and propose an initial solution.

Tested with off-idle and off-suspend on 36xx/Zoom3 and 34xx/omap3evm.

Cc: G, Manjunath Kondaiah <manjugk@ti.com>
Reported-by: Jean Pihet <jean.pihet@newoldbits.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Tony, we need this queued for 2.6.37 as this is a regression fix.

 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8c8f1ac..75c0cd1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -50,9 +50,9 @@
 #include "control.h"
 
 /* Scratchpad offsets */
-#define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
-#define OMAP343X_TABLE_VALUE_OFFSET	   0x30
-#define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
+#define OMAP343X_TABLE_ADDRESS_OFFSET	   0xc4
+#define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
+#define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
 
 struct power_state {
 	struct powerdomain *pwrdm;
-- 
1.7.2.1

