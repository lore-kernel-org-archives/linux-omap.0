From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR] [PATCH 6/7] omap3: sr: device: check for dev_attr
Date: Fri, 25 Jun 2010 16:46:39 -0500
Message-ID: <1277502400-9915-7-git-send-email-nm@ti.com>
References: <1277502400-9915-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52912 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563Ab0FYVqq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 17:46:46 -0400
In-Reply-To: <1277502400-9915-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

in the unlikely case that hwmod database is messed up, dont crash
report error and attempt to recover.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 177299a..81d2532 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -131,6 +131,12 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
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

