From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [CBUS PATCH 1/1] CBUS: Fix broken compilation
Date: Wed,  5 May 2010 18:05:29 +0300
Message-ID: <1273071929-17708-1-git-send-email-carlos.chinea@nokia.com>
References: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25276 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934437Ab0EEPCw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:02:52 -0400
In-Reply-To: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

Include explicitly slab.h in:
	drivers/cbus/cbus.c
	drivers/cbus/retu-headset.c
	drivers/cbus/retu-user.c
	drivers/cbus/retu-wdt.c
	drivers/cbus/tahvo-user.c

Compile tested with n8x0_defconfig

Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 drivers/cbus/cbus.c         |    1 +
 drivers/cbus/retu-headset.c |    1 +
 drivers/cbus/retu-user.c    |    1 +
 drivers/cbus/retu-wdt.c     |    1 +
 drivers/cbus/tahvo-user.c   |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 00c3c32..2c74d6e 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -30,6 +30,7 @@
 #include <linux/spinlock.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <asm/io.h>
 #include <asm/mach-types.h>
diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index e798bc2..645679c 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "retu.h"
 
diff --git a/drivers/cbus/retu-user.c b/drivers/cbus/retu-user.c
index 0f35dc5..7bc97d4 100644
--- a/drivers/cbus/retu-user.c
+++ b/drivers/cbus/retu-user.c
@@ -33,6 +33,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 35932dd..fda8b35 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -35,6 +35,7 @@
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 
diff --git a/drivers/cbus/tahvo-user.c b/drivers/cbus/tahvo-user.c
index c0e8daf..b28b015 100644
--- a/drivers/cbus/tahvo-user.c
+++ b/drivers/cbus/tahvo-user.c
@@ -33,6 +33,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 
-- 
1.5.6.5

