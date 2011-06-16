From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/4] cbus: drop unneeded headers
Date: Thu, 16 Jun 2011 14:27:16 +0300
Message-ID: <1308223638-9634-2-git-send-email-balbi@ti.com>
References: <1308223638-9634-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55643 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755456Ab1FPL11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 07:27:27 -0400
Received: by mail-fx0-f50.google.com with SMTP id 16so1081079fxm.9
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 04:27:26 -0700 (PDT)
In-Reply-To: <1308223638-9634-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we don't use anything from those headers
so we might as well just drop them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c  |   10 ----------
 drivers/cbus/tahvo.c |   10 ----------
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index be07938..708b811 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -30,21 +30,11 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/device.h>
-#include <linux/miscdevice.h>
-#include <linux/poll.h>
-#include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/cbus.h>
-#include <linux/gpio.h>
-
-#include <asm/uaccess.h>
-#include <asm/mach-types.h>
-
-#include <plat/mux.h>
-#include <plat/board.h>
 
 #include "cbus.h"
 #include "retu.h"
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index bc440bc..d4a89a6 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -29,19 +29,9 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/device.h>
-#include <linux/miscdevice.h>
-#include <linux/poll.h>
-#include <linux/fs.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
-
-#include <asm/uaccess.h>
-#include <asm/mach-types.h>
-
-#include <plat/mux.h>
-#include <plat/board.h>
 
 #include "cbus.h"
 #include "tahvo.h"
-- 
1.7.6.rc1

