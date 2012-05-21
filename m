From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 4/4] ARM: OMAP4: CPUidle: Open broadcast clock-event device.
Date: Mon, 21 May 2012 13:02:39 +0530
Message-ID: <1337585559-20250-5-git-send-email-santosh.shilimkar@ti.com>
References: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56463 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab2EUHcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 03:32:55 -0400
In-Reply-To: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ccross@android.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP4 idle driver uses CLOCK_EVT_NOTIFY_BROADCAST_[ENTER/EXIT]
for broadcast clock events. But _ENTER/_EXIT doesn't really open
broadcast clock events and to explicitly setup the broadcast device,
CLOCK_EVT_NOTIFY_BROADCAST_ON should be used.

Add the missing CLOCK_EVT_NOTIFY_BROADCAST_ON clockevent notifications.
This will setup the broadcast timer in either periodic/oneshot modes
correctly. Recent clockevent infrastructure change 77b0d60 {leave the
broadcast device in shutdown mode when not needed} exposed this bug
leading to boot hangs in oneshot mode. Prior to this, periodic broadcast
mode was also broken. This change fixes both the periodic/oneshot broadcast
modes.

Discussion thread :
	https://lkml.org/lkml/2012/4/9/13

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index eb93e45..45e6a54 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -202,6 +202,16 @@ struct cpuidle_driver omap4_idle_driver = {
 	.safe_state_index = 0,
 };
 
+/*
+ * For each cpu, setup the broadcast timer because local timers
+ * stops for the states above C1.
+ */
+static void omap_setup_broadcast_timer(void *arg)
+{
+	int cpu = smp_processor_id();
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
+}
+
 /**
  * omap4_idle_init - Init routine for OMAP4 idle
  *
@@ -224,6 +234,9 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
+	/* Configure the broadcast timer on each cpu */
+	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
+
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		dev = &per_cpu(omap4_idle_dev, cpu_id);
 		dev->cpu = cpu_id;
-- 
1.7.5.4

