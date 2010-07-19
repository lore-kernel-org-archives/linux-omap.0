From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 4/5] omap:hwspinlock-add build support
Date: Mon, 19 Jul 2010 11:50:20 -0500
Message-ID: <1279558221-14954-5-git-send-email-h-kanigeri2@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936440Ab0GSQjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jul 2010 12:39:36 -0400
In-Reply-To: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Cousson Benoit <b-cousson@ti.com>, Simon Que <sque@ti.com>

From: Simon Que <sque@ti.com>

Patch to add suport to build hwspinlock modules

Signed-off-by: Simon Que <sque@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 ++
 arch/arm/plat-omap/Makefile  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 13825a2..d29ea57 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -177,3 +177,5 @@ smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
 obj-y					+= $(smc91x-m) $(smc91x-y)
 
 obj-$(CONFIG_LEDS_PWM)			+= twl6030_pwm.o
+
+obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlocks.o
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 87e5124..5d08f1c 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -38,3 +38,5 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
 obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
+
+obj-$(CONFIG_ARCH_OMAP4) += hwspinlock.o
-- 
1.7.0

