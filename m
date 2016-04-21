From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH v2] OMAPDSS: HDMI5: Fix AVI infoframe
Date: Thu, 21 Apr 2016 12:49:00 -0500
Message-ID: <1461260940-6660-1-git-send-email-Linux.HWI@garmin.com>
References: <1461246520-26734-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461246520-26734-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, misael.lopez@ti.com
Cc: Jim Lodes <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

From: Jim Lodes <jim.lodes@garmin.com>

The AVI infoframe R0-R3 in the 2nd data byte represents the
Active Format Aspect Ratio. It is four bits long not two bits.
This fixes that mask used to extract the bits before writing the
bits to the hardware registers.

Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
---
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c          | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
index d993f78..8ab2093 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
@@ -458,7 +458,7 @@ static void hdmi_core_write_avi_infoframe(struct hdmi_core_data *core,
 
 	c = (ptr[1] >> 6) & 0x3;
 	m = (ptr[1] >> 4) & 0x3;
-	r = (ptr[1] >> 0) & 0x3;
+	r = (ptr[1] >> 0) & 0xf;
 
 	itc = (ptr[2] >> 7) & 0x1;
 	ec = (ptr[2] >> 4) & 0x7;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
index f3e4b81..bbfe7e2 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
@@ -442,7 +442,7 @@ static void hdmi_core_write_avi_infoframe(struct hdmi_core_data *core,
 
 	c = (ptr[1] >> 6) & 0x3;
 	m = (ptr[1] >> 4) & 0x3;
-	r = (ptr[1] >> 0) & 0x3;
+	r = (ptr[1] >> 0) & 0xf;
 
 	itc = (ptr[2] >> 7) & 0x1;
 	ec = (ptr[2] >> 4) & 0x7;
-- 
1.9.1
