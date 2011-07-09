From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] OMAP3+: SR: ensure pm-runtime callbacks can be invoked with IRQ disabled
Date: Sat,  9 Jul 2011 14:37:21 -0700
Message-ID: <1310247441-2709-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50645 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754814Ab1GIVhe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 17:37:34 -0400
Received: by yxl31 with SMTP id 31so1438096yxl.13
        for <linux-omap@vger.kernel.org>; Sat, 09 Jul 2011 14:37:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

SmartReflex should be disabled while entering low power mode due to
a) SmartReflex values are not defined for retention voltageFurther
b) with SmartReflex enabled, if CPU enters lower c-states, FSM will try
to bump the voltage to current OPP's voltage for which it has entered c-state;
hence SmartReflex needs to be disabled for MPU, CORE and IVA voltage
domains in idle path before enabling auto retention voltage achievement
on the device.

However, since the current pm_runtime setup for SmartReflex devices are
setup to allow callbacks to be invoked with interrupts enabled, calling
SmartReflex enable/disable from other contexts such as idle paths
where preemption is disabled causes warnings such as the following
indicating of a potential race.
[   82.023895] [<c04d079c>] (__irq_svc+0x3c/0x120) from [<c04d0484>] (_raw_spin_unlock_irq+0x28/0x2c)
[   82.023895] [<c04d0484>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c0323234>] (rpm_callback+0x4c/0x68)
[   82.023956] [<c0323234>] (rpm_callback+0x4c/0x68) from [<c0323f7c>] (rpm_resume+0x338/0x53c)
[   82.023956] [<c0323f7c>] (rpm_resume+0x338/0x53c) from [<c03243f4>] (__pm_runtime_resume+0x48/0x60)
[   82.023986] [<c03243f4>] (__pm_runtime_resume+0x48/0x60) from [<c008aee0>] (sr_enable+0xa8/0x19c)
[   82.023986] [<c008aee0>] (sr_enable+0xa8/0x19c) from [<c008b2fc>] (omap_sr_enable+0x50/0x90)
[   82.024017] [<c008b2fc>] (omap_sr_enable+0x50/0x90) from [<c00888c0>] (omap4_enter_sleep+0x138/0x168)

Instead, we use pm_runtime_irq_safe to tell the PM core that callbacks can be
invoked in interrupt disabled contexts.

Acked-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f8c6305..444c5b2 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -862,6 +862,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
 
 	sr_info->pdev = pdev;
 	sr_info->srid = pdev->id;
-- 
1.7.1

