From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 06/12] omap3: sr: device: fail sr_dev_init should return error
Date: Thu,  5 Aug 2010 17:24:06 -0500
Message-ID: <1281047052-21346-7-git-send-email-nm@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57509 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760819Ab0HEWYT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:19 -0400
In-Reply-To: <1281047052-21346-1-git-send-email-nm@ti.com>
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
index 6f70da6..8fb60d8 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -162,7 +162,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 				__func__, i + 1);
 		i++;
 		kfree(sr_data);
-		return 0;
+		return -ENODATA;
 	}
 	sr_set_nvalues(sr_dev_data, sr_data);
 	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
@@ -172,6 +172,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
 		kfree(sr_data);
+		return PTR_ERR(od);
 	}
 	i++;
 	return 0;
-- 
1.6.3.3

