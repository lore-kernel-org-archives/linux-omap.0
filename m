From: Matthias Ludwig <mludwig@ultratronik.de>
Subject: Re: [RFC] OMAP: DSS2: Add flag to enable/disable TVOUTBYPASS for
	VENC
Date: Mon, 21 Sep 2009 10:37:06 +0200
Message-ID: <20090921083706.GA26102@ultratronik.de>
References: <1253517007.4690.11.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.ultratronik.de ([82.100.224.114]:58001 "EHLO
	buildserver.ultratronik.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754798AbZIUIgT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Sep 2009 04:36:19 -0400
Content-Disposition: inline
In-Reply-To: <1253517007.4690.11.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Where does OMAP2_TVOUTBYPASS come from? It doesn't exist in my tree.

Ohh, i missed that in the patch, sorry. I added to
arch/arm/plat-omap/include/mach/control.h (see new patch attached).

> A flag in the omap_dss_device would be the proper way to do it, as you
> did, but I think venc.c should call some function somewhere in arch/arm/
> to actually do the setup.

Where would you place this function?

best regards,
Matthias

---
 arch/arm/plat-omap/include/mach/control.h |    1 +
 arch/arm/plat-omap/include/mach/display.h |    1 +
 drivers/video/omap2/dss/venc.c            |   16 ++++++++++++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 826d317..969d3bc 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -167,6 +167,7 @@
 
 /* CONTROL_DEVCONF1 bits */
 #define OMAP243X_MMC1_ACTIVE_OVERWRITE	(1 << 31)
+#define OMAP2_TVOUTBYPASS		(1 << 18)
 #define OMAP2_MMCSDIO2ADPCLKISEL	(1 << 6) /* MMC2 loop back clock */
 #define OMAP2_MCBSP5_CLKS_MASK		(1 << 4) /* > 242x */
 #define OMAP2_MCBSP4_CLKS_MASK		(1 << 2) /* > 242x */
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
 
