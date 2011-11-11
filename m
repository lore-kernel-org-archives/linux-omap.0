From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] OMAP2+: Fix compilation break when cpuidle pm is selected
Date: Fri, 11 Nov 2011 12:27:21 +0530
Message-ID: <1320994641-18808-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51781 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab1KKG5l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 01:57:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

When cpuidle pm is selected the following compilation break is seen
fix the same.

arch/arm/mach-omap2/cpuidle34xx.c:312: error: 'THIS_MODULE' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 6b4ed89..8ca1ddb 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/module.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
-- 
1.7.4.1

