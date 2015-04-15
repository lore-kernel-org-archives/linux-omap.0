From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 23/35] ARM: OMAP3: PM: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:10 +0300
Message-ID: <1429102402-5276-24-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569AbbDOMxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:53:09 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 88721df..de614e7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -408,7 +408,7 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 	return -EINVAL;
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
+static int pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
 
@@ -458,7 +458,7 @@ static void __init pm_errata_configure(void)
 	}
 }
 
-int __init omap3_pm_init(void)
+int omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
 	struct clockdomain *neon_clkdm, *mpu_clkdm, *per_clkdm, *wkup_clkdm;
-- 
1.7.9.5

