From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: PM: build sleep/suspend code for idle path also (not only suspend)
Date: Fri,  7 Oct 2011 15:31:26 -0700
Message-ID: <1318026686-20191-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:55335 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758737Ab1JGWbX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 18:31:23 -0400
Received: by pzk33 with SMTP id 33so12365161pzk.5
        for <linux-omap@vger.kernel.org>; Fri, 07 Oct 2011 15:31:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Some platforms (e.g. OMAP) use the same common cpu_suspend/cpu_resume
helpers during idle as well as suspend.

Currently, if suspend is disabled (CONFIG_PM_SLEEP=n) and the platform
idle code is using the common cpu_suspend/cpu_resume functions, the
kernel will not link.

Since platform code commonly uses CONFIG_PM=y to build it's idle code,
build the common sleep/suspend code based on CONFIG_PM instead of
CONFIG_PM_SLEEP.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies on Russell's devel-stable branch, where the new common
suspend/resume code is queued.

 arch/arm/kernel/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 8fa83f5..25d3a0c 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
-obj-$(CONFIG_PM_SLEEP)		+= sleep.o suspend.o
+obj-$(CONFIG_PM)		+= sleep.o suspend.o
 obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
-- 
1.7.6

