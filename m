From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/6] cbus: fix compile breakage
Date: Wed, 23 Nov 2011 16:00:43 +0200
Message-ID: <1322056848-1188-2-git-send-email-balbi@ti.com>
References: <1322056848-1188-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44943 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755408Ab1KWOAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 09:00:54 -0500
Received: by mail-yw0-f45.google.com with SMTP id 7so1616768ywf.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 06:00:53 -0800 (PST)
In-Reply-To: <1322056848-1188-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we need to include <linux/export.h> and <linux/module.h>

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/cbus.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 486254d..52eab4a 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -26,6 +26,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/export.h>
+#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-- 
1.7.8.rc3

