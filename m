From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/6 v2] cbus: retu: set pm_power_off to NULL when removing retu
Date: Wed, 16 Feb 2011 22:01:21 +0200
Message-ID: <1297886481-26098-7-git-send-email-balbi@ti.com>
References: <1297886481-26098-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:47801 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754168Ab1BPUI6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 15:08:58 -0500
Received: by bwz12 with SMTP id 12so1821693bwz.13
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 12:08:55 -0800 (PST)
In-Reply-To: <1297886481-26098-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we need to clear pm_power_off otherwise we
will have kernel trying to call an unexistent
function.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index a4c565b..0ca58b7 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -489,6 +489,7 @@ static int __init retu_probe(struct platform_device *pdev)
 	return 0;
 
 err2:
+	pm_power_off = NULL;
 	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 	free_irq(retu->irq, retu);
 
@@ -504,13 +505,15 @@ static int __exit retu_remove(struct platform_device *pdev)
 {
 	struct retu		*retu = platform_get_drvdata(pdev);
 
+	pm_power_off = NULL;
+	the_retu = NULL;
+
 	/* Mask all RETU interrupts */
 	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 
 	free_irq(retu->irq, retu);
 	retu_irq_exit(retu);
 	kfree(retu);
-	the_retu = NULL;
 
 	return 0;
 }
-- 
1.7.4.rc2

