From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [CBUS PATCH 1/2] cbus: fix compilation with current mainline
Date: Sat,  1 May 2010 21:01:09 +0300
Message-ID: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44213 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0EASA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 14:00:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <me@felipebalbi.com>

From: Felipe Balbi <me@felipebalbi.com>

commit 5a0e3ad6af8660be21ca98a971cd00f331318c05 broke
compilation of the retu-pwrbutton driver when it dropped
implicit inclusion of slab.h and gfp.h.

Fix it by including slab.h on retu-pwrbutton.c, while at
that, also include slab.h on retu-rtc.c to avoid later
problems with implicit inclusion of that being dropped.

Compile tested with n770_defconfig and n8x0_defconfig

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/cbus/retu-pwrbutton.c |    1 +
 drivers/cbus/retu-rtc.c       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index 2d8cf40..f0cd056 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -34,6 +34,7 @@
 #include <linux/jiffies.h>
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "retu.h"
 
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index b0a0f3d..b3974e2 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -36,6 +36,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/platform_device.h>
-- 
1.7.1.rc2.7.g3e7f1

