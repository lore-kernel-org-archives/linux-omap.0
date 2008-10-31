From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP: Fix define for twl4030 irqs
Date: Thu, 30 Oct 2008 19:11:18 -0700
Message-ID: <1225419078-32213-5-git-send-email-tony@atomide.com>
References: <1225419078-32213-1-git-send-email-tony@atomide.com>
 <1225419078-32213-2-git-send-email-tony@atomide.com>
 <1225419078-32213-3-git-send-email-tony@atomide.com>
 <1225419078-32213-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54089 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbYJaCL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:11:27 -0400
In-Reply-To: <1225419078-32213-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Otherwise twl4030 gpios won't work.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index a2929ac..bed5274 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -372,7 +372,7 @@
 
 /* External TWL4030 gpio interrupts are optional */
 #define TWL4030_GPIO_IRQ_BASE	TWL4030_PWR_IRQ_END
-#ifdef	CONFIG_TWL4030_GPIO
+#ifdef	CONFIG_GPIO_TWL4030
 #define TWL4030_GPIO_NR_IRQS	18
 #else
 #define	TWL4030_GPIO_NR_IRQS	0
-- 
1.5.6.rc3.21.g8c6b5

