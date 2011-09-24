From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 14/24] OMAP4: PM: Use custom omap_do_wfi() for default idle.
Date: Sat, 24 Sep 2011 11:44:34 +0530
Message-ID: <1316844884-21700-15-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39741 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab1IXGPK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:10 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Default arch_idle() isn't good enough for OMAP4 because of aync bridge errata
and necessity of NOPs post WFI to avoid speculative prefetch aborts.
Hence Use OMAP4 custom omap_do_wfi() hook for default idle.

Later in the series, async bridge errata work-around patch updates the
omap_do_wfi() with necessary interconnects barriers.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 3805c0c..fdba72a 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -108,6 +108,24 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 }
 
 /**
+ * omap_default_idle - OMAP4 default ilde routine.'
+ *
+ * Implements OMAP4 memory, IO ordering requirements which can't be addressed
+ * with default arch_idle() hook. Used by all CPUs with !CONFIG_CPUIDLE and
+ * by secondary CPU with CONFIG_CPUIDLE.
+ */
+static void omap_default_idle(void)
+{
+	local_irq_disable();
+	local_fiq_disable();
+
+	omap_do_wfi();
+
+	local_fiq_enable();
+	local_irq_enable();
+}
+
+/**
  * omap4_pm_init - Init routine for OMAP4 PM
  *
  * Initializes all powerdomain and clockdomain target states
@@ -175,6 +193,9 @@ static int __init omap4_pm_init(void)
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
 
+	/* Overwrite the default arch_idle() */
+	pm_idle = omap_default_idle;
+
 err2:
 	return ret;
 }
-- 
1.7.4.1

