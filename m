From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/NOT FOR MERGING 2/5] arm: omap: don't forcefully runtime suspend a device
Date: Wed, 17 Oct 2012 18:34:00 +0300
Message-ID: <1350488043-5053-3-git-send-email-balbi@ti.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46580 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203Ab2JQPjr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 11:39:47 -0400
In-Reply-To: <1350488043-5053-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

device drivers should be smart enough to provide
->suspend/->resume callbacks when needed and they
should take care of doing whatever needs to be
done in order to allow a device to be suspended.

Calling pm_runtime_* from system suspend isn't
the right way to achieve that, as it creates a
situation where OMAP's PM has different requirements
and semantics than all other architectures.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/omap_device.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 935f416..cd84eac 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -817,11 +817,9 @@ static int _od_suspend_noirq(struct device *dev)
 	ret = pm_generic_suspend_noirq(dev);
 
 	if (!ret && !pm_runtime_status_suspended(dev)) {
-		if (pm_generic_runtime_suspend(dev) == 0) {
-			if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
-				omap_device_idle(pdev);
-			od->flags |= OMAP_DEVICE_SUSPENDED;
-		}
+		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
+			omap_device_idle(pdev);
+		od->flags |= OMAP_DEVICE_SUSPENDED;
 	}
 
 	return ret;
@@ -841,7 +839,6 @@ static int _od_resume_noirq(struct device *dev)
 		od->flags &= ~OMAP_DEVICE_SUSPENDED;
 		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
 			omap_device_enable(pdev);
-		pm_generic_runtime_resume(dev);
 	}
 
 	return pm_generic_resume_noirq(dev);
-- 
1.8.0.rc0

