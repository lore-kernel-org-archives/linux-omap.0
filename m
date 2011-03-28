From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [pm-core][PATCH v3 21/21] OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
Date: Mon, 28 Mar 2011 14:52:37 +0530
Message-ID: <1301304157-2466-22-git-send-email-santosh.shilimkar@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37694 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061Ab1C1JXB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 05:23:01 -0400
In-Reply-To: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

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
 arch/arm/mach-omap2/pm44xx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 40a44a9..6de5267 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -187,6 +187,11 @@ static int __init omap4_pm_init(void)
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
 
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
+		return -ENODEV;
+	}
+
 	pr_err("Power Management for TI OMAP4.\n");
 
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
-- 
1.6.0.4

