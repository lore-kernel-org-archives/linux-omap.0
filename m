From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 20/24] OMAP4: PM: Add power domain statistics support
Date: Sat, 24 Sep 2011 11:44:40 +0530
Message-ID: <1316844884-21700-21-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39755 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab1IXGPT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:19 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 505844f..b146854 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -256,6 +256,8 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		return -ENXIO;
 	}
 
+	pwrdm_pre_transition();
+
 	/*
 	 * Check MPUSS next state and save interrupt controller if needed.
 	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
@@ -288,6 +290,8 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
 
+	pwrdm_post_transition();
+
 	return 0;
 }
 
-- 
1.7.4.1

