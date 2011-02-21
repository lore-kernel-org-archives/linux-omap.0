From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/6] omap3: Initialise the l3 device with the hwmod data.
Date: Mon, 21 Feb 2011 19:16:26 +0530
Message-ID: <1298295990-1070-3-git-send-email-santosh.shilimkar@ti.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33910 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756019Ab1BUNqg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:46:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LDkXV1031753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 07:46:35 -0600
In-Reply-To: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: balbi@ti.com, b-cousson@ti.com, r.sricharan@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: sricharan <r.sricharan@ti.com>

The l3 interconnect device is build with all the data required
to handle the error logging. The data is extracted from the
hwmod database.

Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: sricharan <r.sricharan@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/devices.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 381f4eb..2d46f55 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -34,6 +34,29 @@
 #include "mux.h"
 #include "control.h"
 
+static int __init omap3_l3_init(void)
+{
+	int l;
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	char oh_name[10];
+
+	l = snprintf(oh_name, 10, "l3_main");
+
+	oh = omap_hwmod_lookup(oh_name);
+
+	if (!oh)
+		pr_err("could not look up %s\n", oh_name);
+
+	od = omap_device_build("omap3-l3-interconnect", 0, oh, NULL, 0,
+							   NULL, 0, 0);
+
+	WARN(IS_ERR(od), "could not build omap_device for %s\n", oh_name);
+
+	return PTR_ERR(od);
+}
+postcore_initcall(omap3_l3_init);
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
-- 
1.7.0.4

