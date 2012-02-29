From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 1/4] ARM: OMAP4: suspend: Program all domains to retention
Date: Wed, 29 Feb 2012 17:25:03 +0200
Message-ID: <1330529106-10423-2-git-send-email-t-kristo@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48498 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756866Ab2B2PZd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 10:25:33 -0500
In-Reply-To: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
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

