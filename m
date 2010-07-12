From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] omap: device: improve errors handling
Date: Mon, 12 Jul 2010 16:38:07 +0300
Message-ID: <1278941887.16634.85.camel@localhost>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21944 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab0GLNnJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 09:43:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgen <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "ext Menon, Nishanth" <nm@ti.com>, Thara Gopinath <thara@ti.com>

From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Do not forget to check the 'platform_device_add_data()' error code
in 'omap_device_build_ss()'.

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index ea0d659..d2b1609 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -407,7 +407,9 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pdev.num_resources = res_count;
 	od->pdev.resource = res;
 
-	platform_device_add_data(&od->pdev, pdata, pdata_len);
+	ret = platform_device_add_data(&od->pdev, pdata, pdata_len);
+	if (ret)
+		goto odbs_exit4;
 
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
-- 
1.7.1.1




