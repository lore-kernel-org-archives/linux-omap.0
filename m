From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 05/12] omap3: sr: device: check for dev_attr
Date: Thu,  5 Aug 2010 17:24:05 -0500
Message-ID: <1281047052-21346-6-git-send-email-nm@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36959 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760831Ab0HEWYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:20 -0400
In-Reply-To: <1281047052-21346-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

In the unlikely case that hwmod database is messed up, dont crash
report error and attempt to recover.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 7d13704..6f70da6 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -130,6 +130,12 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	}
 
 	sr_dev_data = (struct omap_sr_dev_data *)oh->dev_attr;
+	if (unlikely(!sr_dev_data)) {
+		pr_err("%s: Bad oh->dev_attr!\n", __func__);
+		kfree(sr_data);
+		return -EINVAL;
+	}
+
 	/*
 	 * OMAP3430 ES3.1 chips by default come with Efuse burnt
 	 * with parameters required for full functionality of
-- 
1.6.3.3

