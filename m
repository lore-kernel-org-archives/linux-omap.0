From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] omap: device: improve errors handling
Date: Wed, 04 Aug 2010 14:32:59 +0300
Message-ID: <20100804113259.25027.47129.stgit@baageli.muru.com>
References: <20100804112916.25027.94640.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61203 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab0HDLci (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 07:32:38 -0400
In-Reply-To: <20100804112916.25027.94640.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Do not forget to check the 'platform_device_add_data()' error code
in 'omap_device_build_ss()'.

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Acked-by: Nishanth Menon <nm@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

