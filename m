From: Jani Nikula <ext-jani.1.nikula@Nokia.com>
Subject: [PATCH v2 07/21] OMAP: DSS2: Taal: Remove ESD work cancel from driver probe error handling
Date: Mon,  3 May 2010 09:18:27 +0300
Message-ID: <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34452 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab0ECGSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:53 -0400
In-Reply-To: <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@Nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@Nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

ESD work is never queued in probe, no need to cancel it on probe error.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 98f882a..3f4687a 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -627,7 +627,6 @@ err4:
 err3:
 	backlight_device_unregister(bldev);
 err2:
-	cancel_delayed_work_sync(&td->esd_work);
 	destroy_workqueue(td->esd_wq);
 err1:
 	kfree(td);
-- 
1.6.5.2

