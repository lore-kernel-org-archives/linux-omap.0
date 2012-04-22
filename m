From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH] Fix build breakage in omap-usb-host.c
Date: Sun, 22 Apr 2012 01:48:18 -0700
Message-ID: <1335084498-17918-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57311 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab2DVIs3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Apr 2012 04:48:29 -0400
Received: by obbta14 with SMTP id ta14so11362612obb.19
        for <linux-omap@vger.kernel.org>; Sun, 22 Apr 2012 01:48:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Keshava Munegowda <Keshava_mgowda@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Russ Dill <Russ.Dill@ti.com>

'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' removes the include for
linux/gpio.h from omap-usb-host.c. This include indirectly includes plat/cpu.h
which is required by omap-usb-host.c. Fix the build breakage by including
it directly.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 drivers/mfd/omap-usb-host.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index c8aae66..7e96bb2 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -25,6 +25,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
+#include <plat/cpu.h>
 #include <plat/usb.h>
 #include <linux/pm_runtime.h>
 
-- 
1.7.9.5

