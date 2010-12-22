From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP2: PM: fix compile error when !CONFIG_SUSPEND
Date: Wed, 22 Dec 2010 15:04:17 -0800
Message-ID: <1293059057-16490-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41234 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab0LVXEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 18:04:21 -0500
Received: by pzk9 with SMTP id 9so1840907pzk.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 15:04:20 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Charles Manning <manningc2@actrix.gen.nz>

When CONFIG_SUSPEND is not enabled, none of the system PM methods are
used, so do not compile them in.

Thanks to Charles Manning for reporting the problem and proposing
an initial patch.

Reported-by: Charles Manning <manningc2@actrix.gen.nz>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies on Tony's omap-for-linus branch.

 arch/arm/mach-omap2/pm24xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2844b84..dac2d1d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -299,6 +299,7 @@ out:
 	local_irq_enable();
 }
 
+#ifdef CONFIG_SUSPEND
 static int omap2_pm_begin(suspend_state_t state)
 {
 	disable_hlt();
@@ -355,6 +356,9 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.end		= omap2_pm_end,
 	.valid		= suspend_valid_only_mem,
 };
+#else
+static const struct platform_suspend_ops __initdata omap_pm_ops;
+#endif /* CONFIG_SUSPEND */
 
 /* XXX This function should be shareable between OMAP2xxx and OMAP3 */
 static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
-- 
1.7.3.4

