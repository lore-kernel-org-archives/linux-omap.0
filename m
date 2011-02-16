From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/6] cbus: retu: set pm_power_off to NULL when removing retu
Date: Wed, 16 Feb 2011 21:42:30 +0200
Message-ID: <1297885350-3462-7-git-send-email-balbi@ti.com>
References: <1297885350-3462-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51290 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753593Ab1BPTmx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:42:53 -0500
Received: by mail-bw0-f43.google.com with SMTP id 14so1935894bwz.16
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:42:52 -0800 (PST)
In-Reply-To: <1297885350-3462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we need to clear pm_power_off otherwise we
will have kernel trying to call an unexistent
function.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index d0454bd..0ca58b7 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -489,6 +489,7 @@ static int __init retu_probe(struct platform_device *pdev)
 	return 0;
 
 err2:
+	pm_power_off = NULL;
 	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 	free_irq(retu->irq, retu);
 
@@ -504,7 +505,8 @@ static int __exit retu_remove(struct platform_device *pdev)
 {
 	struct retu		*retu = platform_get_drvdata(pdev);
 
-	irq = platform_get_irq(pdev, 0);
+	pm_power_off = NULL;
+	the_retu = NULL;
 
 	/* Mask all RETU interrupts */
 	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
@@ -512,7 +514,6 @@ static int __exit retu_remove(struct platform_device *pdev)
 	free_irq(retu->irq, retu);
 	retu_irq_exit(retu);
 	kfree(retu);
-	the_retu = NULL;
 
 	return 0;
 }
-- 
1.7.4.rc2

