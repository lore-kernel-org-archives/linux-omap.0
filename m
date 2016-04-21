From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH] OMAPDSS: HDMI5: Change DDC timings
Date: Wed, 20 Apr 2016 19:02:53 -0500
Message-ID: <1461196973-20370-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, misael.lopez@ti.com
Cc: "Lodes, Jim" <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

From: "Lodes, Jim" <jim.lodes@garmin.com>

The DDC scl high and low times were set to the minimum values
from the i2c specification, but the i2c specification takes into
account the rise time and fall time to calculate the frequency.
To pass HDMI certification DDC can not exceed 100kHz therefore in
a system where the rise times and fall times are negligible the high
and low times for scl need to be 10us.

Signed-off-by: Lodes, Jim <jim.lodes@garmin.com>
Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
---
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c          | 4 ++--
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
index 6a39752..d993f78 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
@@ -51,8 +51,8 @@ static void hdmi_core_ddc_init(struct hdmi_core_data *core)
 {
 	void __iomem *base = core->base;
 	const unsigned long long iclk = 266000000;	/* DSS L3 ICLK */
-	const unsigned ss_scl_high = 4000;		/* ns */
-	const unsigned ss_scl_low = 4700;		/* ns */
+	const unsigned ss_scl_high = 4600;		/* ns */
+	const unsigned ss_scl_low = 5400;		/* ns */
 	const unsigned fs_scl_high = 600;		/* ns */
 	const unsigned fs_scl_low = 1300;		/* ns */
 	const unsigned sda_hold = 1000;			/* ns */
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
index 8ea531d..f3e4b81 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
@@ -51,8 +51,8 @@ static void hdmi_core_ddc_init(struct hdmi_core_data *core)
 {
 	void __iomem *base = core->base;
 	const unsigned long long iclk = 266000000;	/* DSS L3 ICLK */
-	const unsigned ss_scl_high = 4000;		/* ns */
-	const unsigned ss_scl_low = 4700;		/* ns */
+	const unsigned ss_scl_high = 4600;		/* ns */
+	const unsigned ss_scl_low = 5400;		/* ns */
 	const unsigned fs_scl_high = 600;		/* ns */
 	const unsigned fs_scl_low = 1300;		/* ns */
 	const unsigned sda_hold = 1000;			/* ns */
-- 
1.9.1
