From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/6] arm: omap4: suspend: Program all domains to RET
Date: Thu, 23 Feb 2012 15:21:55 +0200
Message-ID: <1330003320-17400-2-git-send-email-t-kristo@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47955 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab2BWNWS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 08:22:18 -0500
In-Reply-To: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Remove the FIXME's in the suspend sequence since
we now intend to support system level RET support.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index c264ef7..1ab30a3 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -151,12 +151,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!strncmp(pwrdm->name, "cpu", 3))
 		return 0;
 
-	/*
-	 * FIXME: Remove this check when core retention is supported
-	 * Only MPUSS power domain is added in the list.
-	 */
-	if (strcmp(pwrdm->name, "mpu_pwrdm"))
-		return 0;
 
 	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
 	if (!pwrst)
-- 
1.7.4.1

