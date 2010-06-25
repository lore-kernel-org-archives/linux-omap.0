From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR] [PATCH 7/7] omap3: sr: device: fail sr_dev_init should return error
Date: Fri, 25 Jun 2010 16:46:40 -0500
Message-ID: <1277502400-9915-8-git-send-email-nm@ti.com>
References: <1277502400-9915-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53133 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab0FYVqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 17:46:46 -0400
In-Reply-To: <1277502400-9915-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

sr_dev_init should return error on error conditions

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 81d2532..945ff45 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -163,7 +163,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 				__func__, i + 1);
 		i++;
 		kfree(sr_data);
-		return 0;
+		return -ENODATA;
 	}
 	sr_set_nvalues(sr_dev_data, sr_data);
 	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
@@ -173,6 +173,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
 		kfree(sr_data);
+		return PTR_ERR(od);
 	}
 	i++;
 	return 0;
-- 
1.6.3.3

