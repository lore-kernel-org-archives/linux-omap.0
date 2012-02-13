From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/4] ARM: OMAP2+: omap_device: Replace dev_warn by dev_dbg in omap_device_build_from_dt
Date: Mon, 13 Feb 2012 17:30:23 +0100
Message-ID: <1329150625-8604-3-git-send-email-b-cousson@ti.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57669 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149Ab2BMQbI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 11:31:08 -0500
In-Reply-To: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

This warning becomes a little bit too verbose with the increase of
device nodes in some DTS files.

Change it to debug only.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 80d5e4c..125de17 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -343,7 +343,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 
 	oh_cnt = of_property_count_strings(node, "ti,hwmods");
 	if (!oh_cnt || IS_ERR_VALUE(oh_cnt)) {
-		dev_warn(&pdev->dev, "No 'hwmods' to build omap_device\n");
+		dev_dbg(&pdev->dev, "No 'hwmods' to build omap_device\n");
 		return -ENODEV;
 	}
 
-- 
1.7.0.4

