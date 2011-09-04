From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 15/25] OMAP4: Remove __INIT from omap_secondary_startup() to re-use it for hotplug.
Date: Sun, 4 Sep 2011 19:24:16 +0530
Message-ID: <1315144466-9395-16-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36807 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab1IDN4G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:56:06 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Remove the __INIT from omap_secondary_startup() so that it can
be re-used for CPU hotplug.

While at this, remove the un-used AUXBOOT register reference.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
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

