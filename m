From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP3: CPUidle: include <linux/export.h>
Date: Mon,  7 Nov 2011 15:58:40 -0800
Message-ID: <1320710320-8279-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35435 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111Ab1KGX6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 18:58:12 -0500
Received: by mail-gx0-f181.google.com with SMTP id v2so1114799ggn.40
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 15:58:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The CPUidle use THIS_MODULE, so needs <linux/export.h>

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, one more for omap/fixes.   This one applies to Linus' master branch,
but also applies to your current omap/fixes.

 arch/arm/mach-omap2/cpuidle34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4bf6e6e..2e0fa5a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/export.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
-- 
1.7.6

