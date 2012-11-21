From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] watchdog: OMAP: fixup for ARM multiplatform support
Date: Wed, 21 Nov 2012 09:42:22 -0800
Message-ID: <20121121174222.25576.65258.stgit@muffinssi.local>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:63544 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753414Ab2KURmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 12:42:25 -0500
In-Reply-To: <20121121174201.25576.61961.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org

Recent changes to the omap_wdt.c removed the dependencies to
the core omap code, but forgot to remove mach/hardware.h.

We cannot include any plat headers with multiplatform
support enabled.

cc: Wim Van Sebroeck <wim@iguana.be>
cc: linux-watchdog@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/watchdog/omap_wdt.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 477a1d4..e5e7069 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -45,8 +45,6 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
-#include <mach/hardware.h>
-
 #include <linux/platform_data/omap-wd-timer.h>
 
 #include "omap_wdt.h"

