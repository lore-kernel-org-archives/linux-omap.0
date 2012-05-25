From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 06/11] OMAP2+: use control module mfd driver in omap_type
Date: Fri, 25 May 2012 11:25:56 +0300
Message-ID: <1337934361-1606-7-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38569 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944Ab2EYI1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 04:27:11 -0400
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

OMAP system control module can be probed early, then
omap_type is safe to use its APIs.

TODO: add support for other omap versions

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/mach-omap2/id.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 5bb9746..acfd698 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mfd/omap_control.h>
 
 #include <asm/cputype.h>
 
@@ -40,8 +41,14 @@ EXPORT_SYMBOL(omap_rev);
 
 int omap_type(void)
 {
+	struct device *scm;
+	int ret = 0;
 	u32 val = 0;
 
+	scm = omap_control_get();
+	if (IS_ERR_OR_NULL(scm))
+		return 0;
+
 	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
 	} else if (cpu_is_am33xx()) {
@@ -49,16 +56,23 @@ int omap_type(void)
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
-		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
+		ret = omap_control_readl(scm, OMAP4_CTRL_MODULE_CORE_STATUS,
+					 &val);
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
 	}
 
+	if (ret) {
+		pr_err("problem while fetching omap type\n");
+		goto out;
+	}
+
 	val &= OMAP2_DEVICETYPE_MASK;
 	val >>= 8;
 
 out:
+	omap_control_put(scm);
 	return val;
 }
 EXPORT_SYMBOL(omap_type);
-- 
1.7.7.1.488.ge8e1c

