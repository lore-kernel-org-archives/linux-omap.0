From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 4/9] OMAPDSS: APPLY: Don't check manager settings if it is disabled
Date: Wed, 9 May 2012 15:40:51 +0530
Message-ID: <1336558256-26140-5-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336558256-26140-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44784 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2EIKL6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 06:11:58 -0400
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

If a manager is disabled, there is no guarantee at any point in time that all
it's parameters are configured. There is always a chance that some more
parameters are yet to be configured by a user of DSS, or by DSS itself.

However, when the manager is enabled, we can be certain that all the parameters
have been configured, as we can't enable a manager with an incomplete
configuration. Therefore, if a manager is disabled, don't check for the validity
of it's parameters or the parameters of the overlays connected to it. Only check
once it is enabled. Add a check in dss_check_settings_low() to achieve the same.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 57686f6..ad349b3 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -192,6 +192,9 @@ static int dss_check_settings_low(struct omap_overlay_manager *mgr,
 
 	mp = get_mgr_priv(mgr);
 
+	if (!mp->enabled)
+		return 0;
+
 	if (applying && mp->user_info_dirty)
 		mi = &mp->user_info;
 	else
-- 
1.7.5.4

