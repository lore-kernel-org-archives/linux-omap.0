From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] staging: drm/omap: fix missing include on omap_crtc
Date: Wed, 28 Nov 2012 13:55:00 +0100
Message-ID: <1354107300-26619-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56343 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232Ab2K1Mzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 07:55:37 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so5513654wib.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Nov 2012 04:55:36 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org, rob@ti.com, laurent.pinchart@ideasonboard.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

This fixes following error:

| ...
| CC [M]  drivers/staging/omapdrm/omap_crtc.o
| .../omapdrm/omap_crtc.c:22:22: fatal error: drm_mode.h: No such file or directory
| ...

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/staging/omapdrm/omap_crtc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/omapdrm/omap_crtc.c
index 732f2ad..1d54fe9 100644
--- a/drivers/staging/omapdrm/omap_crtc.c
+++ b/drivers/staging/omapdrm/omap_crtc.c
@@ -17,9 +17,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "omap_drv.h"
+#include <drm/drm_mode.h>
 
-#include "drm_mode.h"
+#include "omap_drv.h"
 #include "drm_crtc.h"
 #include "drm_crtc_helper.h"
 
-- 
1.7.5.4

