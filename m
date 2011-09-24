From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 11/24] OMAP4: Remove __INIT from omap_secondary_startup() to re-use it for hotplug.
Date: Sat, 24 Sep 2011 11:44:31 +0530
Message-ID: <1316844884-21700-12-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41301 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab1IXGPH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:07 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Remove the __INIT from omap_secondary_startup() so that it can
be re-used for CPU hotplug.

While at this, remove the un-used AUXBOOT register reference.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 4ee6aec..b13ef7e 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -18,11 +18,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-/* Physical address needed since MMU not enabled yet on secondary core */
-#define OMAP4_AUX_CORE_BOOT1_PA			0x48281804
-
-	__INIT
-
 /*
  * OMAP4 specific entry point for secondary CPU to jump from ROM
  * code.  This routine also provides a holding flag into which
-- 
1.7.4.1

