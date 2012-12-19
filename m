From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 1/1] ARM: OMAP: Fix build breakage due to missing include in i2c.c
Date: Wed, 19 Dec 2012 12:14:58 +0530
Message-ID: <1355899498-11442-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41809 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab2LSGpR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 01:45:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infrared.org, linux-omap@vger.kernel.org, Vaibhav Bedia <vaibhav.bedia@ti.com>

Merge commit 752451f (Merge branch 'i2c-embedded/for-next' of git://git.pengutronix.de/git/wsa/linux)
resulted in a build breakage for OMAP

...
arch/arm/mach-omap2/i2c.c: In function 'omap_pm_set_max_mpu_wakeup_lat_compat':
arch/arm/mach-omap2/i2c.c:130:2: error: implicit declaration of function 'omap_pm_set_max_mpu_wakeup_lat'
make[1]: *** [arch/arm/mach-omap2/i2c.o] Error 1
...

Fix this by including the appropriate header file with the function prototype

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/i2c.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index df6d6ac..b9074dd 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -22,6 +22,7 @@
 #include "soc.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
+#include "omap-pm.h"
 
 #include "prm.h"
 #include "common.h"
-- 
1.7.0.4

