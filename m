From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] omap2+: pm: fix compilation break.
Date: Thu, 29 Mar 2012 15:39:22 +0530
Message-ID: <1333015762-476-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38266 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069Ab2C2KJj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 06:09:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

Fix the compilation break observed on latest mainline.

Fixes below compilation break:

arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
arch/arm/mach-omap2/pm.c:239: error: implicit declaration of function 'disable_hlt'
arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
arch/arm/mach-omap2/pm.c:247: error: implicit declaration of function 'enable_hlt'

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index a7bdec6..70da4f7 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -16,6 +16,7 @@
 #include <linux/opp.h>
 #include <linux/export.h>
 #include <linux/suspend.h>
+#include <asm/system_misc.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
-- 
1.7.5.4

