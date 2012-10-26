From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 10/16] ARM: OMAP: Make omap_device local to mach-omap2
Date: Fri, 26 Oct 2012 01:27:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210260124360.11251@utopia.booyaka.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local> <20121004220456.26676.31050.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38774 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab2JZB1C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 21:27:02 -0400
In-Reply-To: <20121004220456.26676.31050.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony

On Thu, 4 Oct 2012, Tony Lindgren wrote:

> Let's make omap_device local to mach-omap2 for
> ARM common zImage support.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This one breaks a 5912-only build:

arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_init':
arch/arm/mach-omap1/pm_bus.c:69:2: error: implicit declaration of function 
'cpu_class_is_omap1'
make[1]: *** [arch/arm/mach-omap1/pm_bus.o] Error 1

Fixed by the usual change; it's below.


- Paul

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
-- 
1.7.10.4

