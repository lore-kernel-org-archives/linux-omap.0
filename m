From: y@ultratronik.de
Subject: [RFC] OMAP: DSS2: Add flag to enable/disable TVOUTBYPASS for VENC
Date: Fri, 18 Sep 2009 16:19:38 +0200
Message-ID: <26810.8001714156$1253285973@news.gmane.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.ultratronik.de ([82.100.224.114]:34801 "EHLO
	buildserver.ultratronik.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751353AbZIRO7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Sep 2009 10:59:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, Matthias Ludwig <mludwig@ultratronik.de>

From: Matthias Ludwig <mludwig@ultratronik.de>

Signed-off-by: Matthias Ludwig <mludwig@ultratronik.de>
---

OMAP CPU can only provide a level of about 0.8V at TVOUT, which is not
compliant with NTSC nor PAL. If one wants to have a compliant signal
external buffers need to be added. This requires TVOUTBYPASS to be set.
This patch implements a simple way to set it from dss platform data.

Is there a more elegant way to get register address?

 arch/arm/plat-omap/include/mach/display.h |    1 +
 drivers/video/omap2/dss/venc.c            |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/display.h b/arch/arm/plat-omap/include/mach/display.h
index 4c7422e..3013be0 100644
--- a/arch/arm/plat-omap/include/mach/display.h
+++ b/arch/arm/plat-omap/include/mach/display.h
@@ -380,6 +380,7 @@ struct omap_dss_device {
 		struct {
 			enum omap_dss_venc_type type;
 			bool invert_polarity;
+			bool bypass_tvout;
 		} venc;
 	} phy;
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index cf7827e..cb35a0d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -35,6 +35,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <mach/display.h>
+#include <mach/control.h>
 #include <mach/cpu.h>
 
 #include "dss.h"
@@ -532,6 +533,21 @@ static void venc_power_on(struct omap_dss_device *dssdev)
 
 	venc_write_reg(VENC_OUTPUT_CONTROL, l);
 
+	if (dssdev->phy.venc.bypass_tvout) {
+		u32 dc1, dc1_addr;
+#ifdef CONFIG_ARCH_OMAP3430
+		dc1_addr = OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1);
+#elif defined(CONFIG_ARCH_OMAP2430)
+		dc1_addr = OMAP243X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1);
+#elif defined(CONFIG_ARCH_OMAP2420)
+		dc1_addr = OMAP242X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1);
+#else
+		bug();
+#endif
+		dc1 = readl(dc1_addr) | OMAP2_TVOUTBYPASS;
+		writel(dc1, dc1_addr);
+	}
+
 	dispc_set_digit_size(dssdev->panel.timings.x_res,
 			dssdev->panel.timings.y_res/2);
 
-- 
1.6.2.5

