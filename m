From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 3/4] ARM: OMAP3 PM: Enable IO Wake up
Date: Tue, 4 Oct 2011 23:22:03 +0530
Message-ID: <1317750724-32553-4-git-send-email-vishwanath.bs@ti.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58502 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933285Ab1JDR7L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 13:59:11 -0400
In-Reply-To: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

Enable IO Wake up for OMAP3 as part of PM Init.
Currently this has been managed in cpuidle path which is not the right place.
Subsequent patch will remove IO Daisy chain handling in cpuidle path once daisy
chain is handled as part of hwmod mux.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 61f1a5b..6c80988 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -885,6 +885,9 @@ static int __init omap3_pm_init(void)
 		goto err1;
 	}
 
+	if (omap3_has_io_wakeup())
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
+
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
-- 
1.7.0.4

