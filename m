From: Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH] arm: cpuidle34xx.c: Fix compile error
Date: Tue, 8 Nov 2011 17:11:05 +0100
Message-ID: <1320768665-9759-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:22044
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755158Ab1KHQL0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 11:11:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>

Add missing module.h include to provide THIS_MODULE.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1fe35c2..158c17e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/module.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
-- 
1.7.5.4


