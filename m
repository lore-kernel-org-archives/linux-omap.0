From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and _od_resume_noirq
Date: Wed, 17 Oct 2012 18:33:59 +0300
Message-ID: <1350488043-5053-2-git-send-email-balbi@ti.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59949 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932303Ab2JQPjq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 11:39:46 -0400
In-Reply-To: <1350488043-5053-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

current implementation doesn't take care about
drivers which don't provide *_noirq methods and we
could fall into a situation where we would suspend/resume
devices even though they haven't asked for it.

One such case happened with the I2C driver which
was getting suspended during suspend_noirq() just
to be resume right after by any other device doing
an I2C transfer on its suspend method.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/omap_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7a7d1f2..935f416 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -804,8 +804,12 @@ static int _od_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int ret;
 
+	if (!pm || !pm->suspend_noirq)
+		return 0;
+
 	/* Don't attempt late suspend on a driver that is not bound */
 	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
 		return 0;
@@ -827,6 +831,10 @@ static int _od_resume_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
+	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+
+	if (!pm || !pm->resume_noirq)
+		return 0;
 
 	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
 	    !pm_runtime_status_suspended(dev)) {
-- 
1.8.0.rc0

