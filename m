From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 3/3] OMAP3: omap_device: Add support to associate a device with an initiator
Date: Mon, 21 Mar 2011 16:40:23 +0530
Message-ID: <1300705823-12784-4-git-send-email-rnayak@ti.com>
References: <1300705823-12784-1-git-send-email-rnayak@ti.com>
 <1300705823-12784-2-git-send-email-rnayak@ti.com>
 <1300705823-12784-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51850 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850Ab1CULKd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 07:10:33 -0400
In-Reply-To: <1300705823-12784-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

These api's are meant to to used by drivers to
associate/disassociate a device from a given initiator.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   54 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9bbda9a..0cd05d2 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -662,6 +662,60 @@ int omap_device_shutdown(struct platform_device *pdev)
 	return ret;
 }
 
+static int omap_device_add_initiator_user(struct platform_device *pdev,
+					  u8 init_id)
+{
+	int i;
+	struct omap_device *od;
+
+	od = _find_by_pdev(pdev);
+
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED)
+		return -EINVAL;
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_add_initiator_user(od->hwmods[i], init_id);
+
+	return 0;
+}
+
+inline int omap_device_add_mpu_user(struct platform_device *pdev)
+{
+	return omap_device_add_initiator_user(pdev, OMAP_INIT_MPU);
+}
+
+inline int omap_device_add_iva_user(struct platform_device *pdev)
+{
+	return omap_device_add_initiator_user(pdev, OMAP_INIT_IVA);
+}
+
+static int omap_device_del_initiator_user(struct platform_device *pdev,
+					  u8 init_id)
+{
+	int i;
+	struct omap_device *od;
+
+	od = _find_by_pdev(pdev);
+
+	if (od->_state == OMAP_DEVICE_STATE_ENABLED)
+		return -EINVAL;
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_del_initiator_user(od->hwmods[i], init_id);
+
+	return 0;
+}
+
+inline int omap_device_del_mpu_user(struct platform_device *pdev)
+{
+	return omap_device_del_initiator_user(pdev, OMAP_INIT_MPU);
+}
+
+inline int omap_device_del_iva_user(struct platform_device *pdev)
+{
+	return omap_device_del_initiator_user(pdev, OMAP_INIT_IVA);
+}
+
 /**
  * omap_device_align_pm_lat - activate/deactivate device to match wakeup lat lim
  * @od: struct omap_device *
-- 
1.7.0.4

