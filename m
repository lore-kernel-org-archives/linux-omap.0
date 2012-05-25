From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 03/11] arm: omap: device: create a device for system control module
Date: Fri, 25 May 2012 11:25:53 +0300
Message-ID: <1337934361-1606-4-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58564 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290Ab2EYI06 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 May 2012 04:26:58 -0400
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

From: Kishon Vijay Abraham I <kishon@ti.com>

Extracts the device data from hwmod database and create a platform device
using omap device build.

The device build is done during postcore_initcall.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/mach-omap2/devices.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 152c266..9332673 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -40,6 +40,32 @@
 #define L3_MODULES_MAX_LEN 12
 #define L3_MODULES 3
 
+static int omap_init_control(void)
+{
+	struct omap_hwmod		*oh;
+	struct platform_device		*pdev;
+	const char			*oh_name, *name;
+
+	oh_name = "ctrl_module_core";
+	name = "omap-control-core";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not lookup hwmod for %s\n", oh_name);
+		return PTR_ERR(oh);
+	}
+
+	pdev = omap_device_build(name, -1, oh, NULL, 0, NULL, 0, true);
+	if (IS_ERR(pdev)) {
+		pr_err("Could not build omap_device for %s %s\n",
+		       name, oh_name);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+postcore_initcall(omap_init_control);
+
 static int __init omap3_l3_init(void)
 {
 	struct omap_hwmod *oh;
-- 
1.7.7.1.488.ge8e1c

