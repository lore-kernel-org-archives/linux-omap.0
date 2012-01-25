From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 04/21] ARM: omap2+: smartreflex: move smartreflex suspend to suspend_noirq
Date: Wed, 25 Jan 2012 16:16:06 +0100
Message-ID: <1327504583-13408-5-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53734 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2AYPQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 10:16:51 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so3871040wer.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 07:16:50 -0800 (PST)
In-Reply-To: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Colin Cross <ccross@android.com>, Jean Pihet <j-pihet@ti.com>

From: Colin Cross <ccross@android.com>

Running without smartreflex for any significant time (on the order
of seconds) is unsafe and can cause thermal runaway.  Move
smartreflex suspend into suspend_noirq, so it happens as late as
possible.  This prevents hangs that occur in a driver suspend
handler from running without smartreflex enabled.  It will also
reduce power used during suspend and resume, as the voltages will
be lowered.

May also indirectly fix imprecise external aborts seen during
suspend, which could be caused by calls to sr_disable racing
from calls to dvfs_scale and omap_sr_disable.

Change-Id: Ia3c1e707bb1022ec102f506dc3ad48906e8890da
Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index fca8df69..95fd228 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1095,7 +1095,10 @@ static int omap_sr_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(omap_sr_dev_pm_ops, omap_sr_suspend, omap_sr_resume);
+const static struct dev_pm_ops omap_sr_dev_pm_ops = {
+	.suspend_noirq = omap_sr_suspend,
+	.resume_noirq = omap_sr_resume,
+};
 
 static struct platform_driver smartreflex_driver = {
 	.remove         = omap_sr_remove,
-- 
1.7.5.4

