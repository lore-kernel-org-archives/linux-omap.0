From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 04/12] omap3: sr: device: cleanup pr_xxx
Date: Thu,  5 Aug 2010 17:24:04 -0500
Message-ID: <1281047052-21346-5-git-send-email-nm@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36956 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759308Ab0HEWYS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:18 -0400
In-Reply-To: <1281047052-21346-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

Strings in c dont need to be split accross multiple lines with \
. instead they can be put as "abc " "def " and it is equivalent to
"abc def".

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index dbf7603..7d13704 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -151,8 +151,9 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	sr_dev_data->volts_supported = omap_get_voltage_table(i,
 				&sr_dev_data->volt_data);
 	if (!sr_dev_data->volts_supported) {
-		pr_warning("%s: No Voltage table registerd fo VDD%d.Something \
-				really wrong\n\n", __func__, i + 1);
+		pr_warning("%s: No Voltage table registerd fo VDD%d. "
+				"Something is really wrong\n",
+				__func__, i + 1);
 		i++;
 		kfree(sr_data);
 		return 0;
-- 
1.6.3.3

