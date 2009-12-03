From: Belisko Marek <marek.belisko@gmail.com>
Subject: [PATCH] Fix include problem. Signed-off-by: Marek Belisko
	<marek.belisko@gmail.com>
Date: Thu, 3 Dec 2009 14:28:21 +0100
Message-ID: <e7c6a05e0912030528k1f9c9493y11d55812a054b030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:37918 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZLCN2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:28:15 -0500
Received: by iwn1 with SMTP id 1so872831iwn.33
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 05:28:21 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

when make htcherald_defconfig on current linux-omap tree
(82f1d8f22f2c65e70206e40a6f17688bf64a892c) compilation fails
in drivers/video/omap/lcd_htcherald.c.

Following patch fixed this problem.

---
 drivers/video/omap/lcd_htcherald.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_htcherald.c
b/drivers/video/omap/lcd_htcherald.c
index 2e0c81e..a9007c5 100644
--- a/drivers/video/omap/lcd_htcherald.c
+++ b/drivers/video/omap/lcd_htcherald.c
@@ -29,7 +29,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>

-#include <plat/omapfb.h>
+#include "omapfb.h"

 static int htcherald_panel_init(struct lcd_panel *panel,
 					struct omapfb_device *fbdev)
-- 
1.6.4.2
