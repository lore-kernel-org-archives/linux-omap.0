From: Alexander Shishkin <ash@koowaldah.org>
Subject: [PATCH] cbus: fix comilation breakage
Date: Wed, 21 Apr 2010 17:26:07 +0300
Message-ID: <1271859967-12914-1-git-send-email-ash@koowaldah.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60794 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab0DUO1J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 10:27:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Alexander Shishkin <ash@koowaldah.org>

Just tried to build n8x0_defconfig on the current master and
got cbus failing to compile due to implicit kzalloc() (and
others from slab.h) references. I'm not sure that including
slab.h directly is the right thing to do here, though.

Signed-off-by: Alexander Shishkin <ash@koowaldah.org>
---
 drivers/cbus/cbus.c         |    1 +
 drivers/cbus/retu-headset.c |    1 +
 drivers/cbus/retu-user.c    |    1 +
 drivers/cbus/retu-wdt.c     |    1 +
 drivers/cbus/tahvo-user.c   |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 00c3c32..18260f2 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/gpio.h>
diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index e798bc2..c38abf1 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
diff --git a/drivers/cbus/retu-user.c b/drivers/cbus/retu-user.c
index 0f35dc5..1a29492 100644
--- a/drivers/cbus/retu-user.c
+++ b/drivers/cbus/retu-user.c
@@ -23,6 +23,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 35932dd..79585d8 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
diff --git a/drivers/cbus/tahvo-user.c b/drivers/cbus/tahvo-user.c
index c0e8daf..01e7f20 100644
--- a/drivers/cbus/tahvo-user.c
+++ b/drivers/cbus/tahvo-user.c
@@ -23,6 +23,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/init.h>
-- 
1.5.6.5

