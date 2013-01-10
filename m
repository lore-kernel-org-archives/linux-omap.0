From: Paolo Pisati <paolo.pisati@canonical.com>
Subject: [PATCH] staging/omapdrm: garbage collect OMAP_DSS_DISPLAY_SUSPENDED
Date: Thu, 10 Jan 2013 21:42:27 +0100
Message-ID: <1357850547-32270-1-git-send-email-paolo.pisati@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, YAMANE Toshiaki <yamanetoshi@gmail.com>, Jani Nikula <jani.nikula@intel.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

Compilation fix - leftover from:

commit 998c336d4c7183301ed6a6ca93952f63e3cf694f
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Wed May 30 13:26:00 2012 +0300

    OMAPDSS: remove omap_dss_device's suspend/resume

Cc: stable <stable@vger.kernel.org> # v3.7
Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
---
 drivers/staging/omapdrm/omap_connector.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
index 91edb3f..ff25467 100644
--- a/drivers/staging/omapdrm/omap_connector.c
+++ b/drivers/staging/omapdrm/omap_connector.c
@@ -113,9 +113,6 @@ static void omap_connector_dpms(struct drm_connector *connector, int mode)
 	if (mode == DRM_MODE_DPMS_ON) {
 		/* store resume info for suspended displays */
 		switch (dssdev->state) {
-		case OMAP_DSS_DISPLAY_SUSPENDED:
-			dssdev->activate_after_resume = true;
-			break;
 		case OMAP_DSS_DISPLAY_DISABLED: {
 			int ret = dssdev->driver->enable(dssdev);
 			if (ret) {
-- 
1.7.9.5
