From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 22/25] OMAP4: PM: Add power domain statistics support
Date: Sun, 4 Sep 2011 19:24:23 +0530
Message-ID: <1315144466-9395-23-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47638 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab1IDN4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 09:56:14 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 4dd9d0f..0bc7610 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -253,6 +253,8 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		return -ENXIO;
 	}
 
+	pwrdm_pre_transition();
+
 	/*
 	 * Check MPUSS next state and save interrupt controller if needed.
 	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
@@ -270,6 +272,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	scu_pwrst_prepare(cpu, power_state);
 	l2x0_pwrst_prepare(cpu, save_state);
 
+
 	/*
 	 * Call low level function  with targeted CPU id
 	 * and its low power state.
@@ -286,6 +289,8 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
 
+	pwrdm_post_transition();
+
 	return 0;
 }
 
-- 
1.7.4.1

