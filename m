From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/4] cbus: remove unneded includes
Date: Fri,  1 Oct 2010 15:33:36 +0300
Message-ID: <1285936419-28426-2-git-send-email-balbi@ti.com>
References: <1285936419-28426-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50421 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab0JAMdo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 08:33:44 -0400
In-Reply-To: <1285936419-28426-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we don't use anything from those headers,
thus removing them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/cbus.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 9e745bb..a8bbf42 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -30,15 +30,10 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 
-#include <asm/io.h>
-#include <asm/mach-types.h>
-
-#include <plat/board.h>
 #include <plat/cbus.h>
 
 #include "cbus.h"
-- 
1.7.3.rc0.35.g8ac8c

