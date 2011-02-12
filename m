From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/5] omap4: Enable ARM local timers with OMAP4430 es1.0 exception
Date: Sat, 12 Feb 2011 16:59:44 +0530
Message-ID: <1297510187-31547-3-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46375 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab1BLL36 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Feb 2011 06:29:58 -0500
In-Reply-To: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4430 ES1.0 the local timers are gated by security. Enable the
CONFIG_LOCAL_TIMERS for omap2plus build and handle the OMAP4430 es1.0
exception case.

This patch has dependency on the first patch in this series.
	ARM: smp: Select local timers vs dummy timer support runtime

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig     |    1 +
 arch/arm/mach-omap2/timer-mpu.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1a2cf62..f285dd7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,6 +44,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select LOCAL_TIMERS
 	select PL310_ERRATA_588369
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
index 09c73dc..31c0ac4 100644
--- a/arch/arm/mach-omap2/timer-mpu.c
+++ b/arch/arm/mach-omap2/timer-mpu.c
@@ -28,6 +28,10 @@
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
+	/* Local timers are not supprted on OMAP4430 ES1.0 */
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return -ENXIO;
+
 	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
 	return 0;
-- 
1.6.0.4

