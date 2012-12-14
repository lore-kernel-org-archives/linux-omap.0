From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2+: PMU: Remove unused header
Date: Fri, 14 Dec 2012 12:08:26 -0600
Message-ID: <1355508506-21448-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36899 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754461Ab2LNSIc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 13:08:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Commit 2ac29a1 (ARM: PMU: fix runtime PM enable) moved the call to
pm_runtime_enable() from the OMAP2+ PMU code into the ARM PERF core
code. However, header for pm_runtime which should have been removed
from the OMAP2+ PMU code was not. It is no longer necessary to include
this header in the OMAP2+ PMU code and so remove it.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 250d909..eb78ae7 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -11,8 +11,6 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-#include <linux/pm_runtime.h>
-
 #include <asm/pmu.h>
 
 #include "soc.h"
-- 
1.7.10.4

