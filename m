From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 3/5] ARM: OMAP4: suspend: Program all domains to retention
Date: Thu, 13 Sep 2012 19:36:47 +0300
Message-ID: <1347554209-23378-4-git-send-email-t-kristo@ti.com>
References: <1347554209-23378-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60711 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127Ab2IMQhF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 12:37:05 -0400
In-Reply-To: <1347554209-23378-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Remove the FIXME's in the suspend sequence since
we now intend to support system level RET support.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index e03a3cc..c8965a2 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -96,13 +96,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!strncmp(pwrdm->name, "cpu", 3))
 		return 0;
 
-	/*
-	 * FIXME: Remove this check when core retention is supported
-	 * Only MPUSS power domain is added in the list.
-	 */
-	if (strcmp(pwrdm->name, "mpu_pwrdm"))
-		return 0;
-
 	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
 	if (!pwrst)
 		return -ENOMEM;
-- 
1.7.4.1

