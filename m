From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP4: PM: Warn users about usage of older bootloaders
Date: Mon, 4 Feb 2013 17:54:43 +0530
Message-ID: <1359980683-12079-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59256 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab3BDMY6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 07:24:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, R Sricharan <r.sricharan@ti.com>

OMAP4 CHIP level PM works only with newer bootloaders. The
dependency on the bootloader comes from the fact that the
kernel is missing reset and initialization code for some
devices.

While the right thing to do is to add reset and init code in
the kernel, for some co-processor IP blocks like DSP and IVA
it means downloading firmware into each one of them to execute
idle instructions.

While a feasible solution is worked upon on how such IP blocks
can be better handled in the kernel, in the interim, to avoid
any further frustration to users testing PM on OMAP4 and finding
it broken, warn them about the bootloader being a possible
cause.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index aa6fd98..45ca053 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -77,8 +77,18 @@ static int omap4_pm_suspend(void)
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
 		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->saved_logic_state);
 	}
-	if (ret)
+	if (ret) {
 		pr_crit("Could not enter target state in pm_suspend\n");
+		/*
+		 * OMAP4 chip PM currently works only with certain (newer)
+		 * versions of bootloaders. This is due to missing code in the
+		 * kernel to properly reset and initialize some devices.
+		 * Warn the user about the bootloader version being one of the
+		 * possible causes.
+		 */
+		pr_warn("One of the possible cause could be an old bootloder\n"
+			"Use version v2012.07 (or later)\n");
+	}
 	else
 		pr_info("Successfully put all powerdomains to target state\n");
 
@@ -146,6 +156,12 @@ int __init omap4_pm_init(void)
 	}
 
 	pr_err("Power Management for TI OMAP4.\n");
+	/*
+	 * OMAP4 chip PM currently works only with certain (newer)
+	 * versions of bootloaders. This is due to missing code in the
+	 * kernel to properly reset and initialize some devices.
+	 */
+	pr_warn("Use Bootloader version v2012.07 (or later) for full PM support\n");
 
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
-- 
1.7.9.5

