From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH] OMAP: DSS2: Add back authors of panel-generic.c based drivers
Date: Thu, 18 Nov 2010 09:45:59 +0800
Message-ID: <1290044759-2903-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:56217 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab0KRBqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 20:46:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, hvaibhav@ti.com, mike@compulab.co.il, premi@ti.com

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 6702cf6..07eb30e 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -4,6 +4,16 @@
  * Copyright (C) 2010 Canonical Ltd.
  * Author: Bryan Wu <bryan.wu@canonical.com>
  *
+ * LCD panel driver for Sharp LQ043T1DG01
+ *
+ * Copyright (C) 2009 Texas Instruments Inc
+ * Author: Vaibhav Hiremath <hvaibhav@ti.com>
+ *
+ * LCD panel driver for Toppoly TDO35S
+ *
+ * Copyright (C) 2009 CompuLab, Ltd.
+ * Author: Mike Rapoport <mike@compulab.co.il>
+ *
  * Copyright (C) 2008 Nokia Corporation
  * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
  *
-- 
1.7.1

