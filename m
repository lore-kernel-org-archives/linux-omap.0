From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] ARM: OMAP1: fix build breakage introduced by commit
 25c7d49ed48b4843da7dea56a81ae7f620211ee0
Date: Fri, 26 Oct 2012 14:08:27 -0600
Message-ID: <20121026200826.16521.10431.stgit@dusk.lan>
References: <20121026200413.16521.88985.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40893 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966363Ab2JZUJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:09:02 -0400
In-Reply-To: <20121026200413.16521.88985.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Commit 25c7d49ed48b4843da7dea56a81ae7f620211ee0 ("ARM: OMAP: Make
omap_device local to mach-omap2") broke an OMAP5912-only build here:

arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_init':
arch/arm/mach-omap1/pm_bus.c:69:2: error: implicit declaration of function
'cpu_class_is_omap1'
make[1]: *** [arch/arm/mach-omap1/pm_bus.o] Error 1

Fix by adding a missing include.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/pm_bus.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 16bf2f9..3f2d396 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -19,6 +19,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
+#include "soc.h"
+
 #ifdef CONFIG_PM_RUNTIME
 static int omap1_pm_runtime_suspend(struct device *dev)
 {


