From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
Date: Fri, 11 Mar 2011 17:26:41 +0530
Message-ID: <1299844601-13248-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35955 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab1CKL4v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 06:56:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>

On OMAP4430 ES1.0, Power Management features are not supported.
Avoid omap4_pm_init() on ES1.0 silicon so that we can continue
to use same kernel binary to boot on all OMAP4 silicons.

The ES1.0 boot failure with OMAP4 PM series was because of
the clockdomain initialisation code. Hardware supervised
clockdomain mode isn't functional for all clockdomains
on OMAP4430 ES1.0 silicon so avoid the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Kevin Hilman <khilman@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
Patch applies on top of OMAP4 PM series

 arch/arm/mach-omap2/pm44xx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index e887a5d..2e18c1d 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -203,6 +203,11 @@ static int __init omap4_pm_init(void)
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
 
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
+		return -ENODEV;
+	}
+
 	pr_err("Power Management for TI OMAP4.\n");
 
 #ifdef CONFIG_PM
-- 
1.6.0.4

