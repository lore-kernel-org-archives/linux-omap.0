From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/4] ARM: OMAP2+: Sync hwmod state with the pm_runtime and omap_device state
Date: Mon, 22 Jul 2013 15:31:17 +0530
Message-ID: <1374487277-26099-5-git-send-email-rnayak@ti.com>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46123 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757284Ab3GVKCU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Jul 2013 06:02:20 -0400
In-Reply-To: <1374487277-26099-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, balbi@ti.com, mpfj-list@newflow.co.uk, vaibhav.bedia@ti.com, khilman@linaro.org, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, grygorii.strashko@ti.com, Rajendra Nayak <rnayak@ti.com>

Some hwmods which are marked with HWMOD_INIT_NO_IDLE are left in enabled
state post setup(). When a omap_device gets created for such hwmods
make sure the omap_device and pm_runtime states are also in sync for such
hwmods by doing a omap_device_enable() and pm_runtime_set_active() for the
device.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 1c82cde..f99f68e 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -129,6 +129,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	const char *oh_name;
 	int oh_cnt, i, ret = 0;
+	bool device_active = false;
 
 	oh_cnt = of_property_count_strings(node, "ti,hwmods");
 	if (oh_cnt <= 0) {
@@ -152,6 +153,8 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 			goto odbfd_exit1;
 		}
 		hwmods[i] = oh;
+		if (oh->flags & HWMOD_INIT_NO_IDLE)
+			device_active = true;
 	}
 
 	od = omap_device_alloc(pdev, hwmods, oh_cnt);
@@ -172,6 +175,11 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 
 	pdev->dev.pm_domain = &omap_device_pm_domain;
 
+	if (device_active) {
+		omap_device_enable(pdev);
+		pm_runtime_set_active(&pdev->dev);
+	}
+
 odbfd_exit1:
 	kfree(hwmods);
 odbfd_exit:
-- 
1.7.9.5

