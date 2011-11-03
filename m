From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context lost count if supported
Date: Thu, 3 Nov 2011 16:24:25 +0530
Message-ID: <1320317665-6381-4-git-send-email-rnayak@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36801 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab1KCKyz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 06:54:55 -0400
In-Reply-To: <1320317665-6381-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Now that OMAP4 has hwmod/module level context lost counters, make
omap_hwmod_get_context_loss_count() return them on platforms where they
exist, else fall back on the pwrdm level counters for older platforms.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ac17748..9d140c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2658,9 +2658,14 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 	struct powerdomain *pwrdm;
 	int ret = 0;
 
-	pwrdm = omap_hwmod_get_pwrdm(oh);
-	if (pwrdm)
-		ret = pwrdm_get_context_loss_count(pwrdm);
+	if (oh->prcm.omap4.context_offs) {
+		/* Support for per-hwmod context register */
+		ret = oh->prcm.omap4.context_lost_counter;
+	} else {
+		pwrdm = omap_hwmod_get_pwrdm(oh);
+		if (pwrdm)
+			ret = pwrdm_get_context_loss_count(pwrdm);
+	}
 
 	return ret;
 }
-- 
1.7.1

