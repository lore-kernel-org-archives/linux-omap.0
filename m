From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] omapfb/dss: wait_for_completion_interruptible_timeout expects long
Date: Mon, 25 Jul 2016 19:12:47 +0200
Message-ID: <1469466767-23352-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Luis de Bethencourt <luisbg@osg.samsung.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-omap@vger.kernel.org

wait_for_completion_timeout_interruptible returns long not unsigned long.
an appropriately typed variable is introduced and assignments fixed up.

Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

API non-compliance was located by coccinelle

This is mostly cosmetic since the returned value is only compared 
at present, however if remaining time (completion occurred) where ever 
used, then a signal received would be interpreted as a large remaining 
jiffies left, which would be wrong.

Compile tested with: omap2plus_defconfig (implies CONFIG_FB_OMAP2_DSS)

Patch is against 4.7.0-rc7 (localversion-next -next-20160724)

 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
index 3691bde..a864608 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
@@ -644,6 +644,7 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 {
 
 	int r;
+	long time_left;
 	DECLARE_COMPLETION_ONSTACK(completion);
 
 	r = omap_dispc_register_isr(dispc_irq_wait_handler, &completion,
@@ -652,15 +653,15 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 	if (r)
 		return r;
 
-	timeout = wait_for_completion_interruptible_timeout(&completion,
+	time_left = wait_for_completion_interruptible_timeout(&completion,
 			timeout);
 
 	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
 
-	if (timeout == 0)
+	if (time_left == 0)
 		return -ETIMEDOUT;
 
-	if (timeout == -ERESTARTSYS)
+	if (time_left == -ERESTARTSYS)
 		return -ERESTARTSYS;
 
 	return 0;
-- 
2.1.4
