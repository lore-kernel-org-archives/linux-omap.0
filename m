From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 07/15] cbus: retu: use the devid from platform_data
Date: Tue, 15 Feb 2011 10:45:54 +0200
Message-ID: <1297759562-25682-8-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:52690 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753877Ab1BOIqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:50 -0500
Received: by gxk27 with SMTP id 27so2636869gxk.17
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:49 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

We are already passing the device ID via
platform_data, all we have to do know is
use it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index b1c8e57..d2326aa 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -49,13 +49,13 @@
 #include "cbus.h"
 #include "retu.h"
 
-#define RETU_ID			0x01
-
 struct retu {
 	/* Device lock */
 	struct mutex		mutex;
 	struct device		*dev;
 
+	int			devid;
+
 	int			irq_base;
 	int			irq_end;
 
@@ -81,7 +81,7 @@ static struct retu *the_retu;
 int retu_read_reg(unsigned reg)
 {
 	WARN(!the_retu, "Retu not initialized\n");
-	return cbus_read_reg(RETU_ID, reg);
+	return cbus_read_reg(the_retu->devid, reg);
 }
 EXPORT_SYMBOL(retu_read_reg);
 
@@ -95,7 +95,7 @@ EXPORT_SYMBOL(retu_read_reg);
 void retu_write_reg(unsigned reg, u16 val)
 {
 	WARN(!the_retu, "Retu not initialized\n");
-	cbus_write_reg(RETU_ID, reg, val);
+	cbus_write_reg(the_retu->devid, reg, val);
 }
 EXPORT_SYMBOL(retu_write_reg);
 
@@ -413,6 +413,7 @@ static int __init retu_probe(struct platform_device *pdev)
 	retu->irq = irq;
 	retu->irq_base = pdata->irq_base;
 	retu->irq_end = pdata->irq_end;
+	retu->devid = pdata->devid;
 
 	retu_irq_init(retu);
 
-- 
1.7.4.rc2

