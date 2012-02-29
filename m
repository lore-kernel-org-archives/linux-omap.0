From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 4/6] ARM: OMAP3 PM: Enable IO Wake up
Date: Wed, 29 Feb 2012 16:26:59 +0200
Message-ID: <1330525621-29836-5-git-send-email-t-kristo@ti.com>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58383 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab2B2O1W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 09:27:22 -0500
In-Reply-To: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

Enable IO Wake up for OMAP3 as part of PM Init. Currently this has been
managed in cpuidle path which is not the right place. Subsequent patch
will remove IO Daisy chain handling in cpuidle path once daisy chain is
handled as part of hwmod mux.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e97ec3f..e6c2d39 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -793,6 +793,10 @@ static int __init omap3_pm_init(void)
 		goto err1;
 	}
 
+	if (omap3_has_io_wakeup())
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
+					   PM_WKEN);
+
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
-- 
1.7.4.1

