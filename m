From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/6] cbus: retu: replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL
Date: Wed, 16 Feb 2011 21:42:28 +0200
Message-ID: <1297885350-3462-5-git-send-email-balbi@ti.com>
References: <1297885350-3462-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47411 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753115Ab1BPTmq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:42:46 -0500
Received: by mail-bw0-f53.google.com with SMTP id 12so2665352bwg.40
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:42:45 -0800 (PST)
In-Reply-To: <1297885350-3462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

We don't want non-GPL retu children, so force
all exported symbols to be GPL-only.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index af4d96a..4c8a7ea 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -106,7 +106,7 @@ int retu_read_reg(struct device *child, unsigned reg)
 
 	return __retu_read_reg(retu, reg);
 }
-EXPORT_SYMBOL(retu_read_reg);
+EXPORT_SYMBOL_GPL(retu_read_reg);
 
 /**
  * retu_write_reg - Write a value to a register in Retu
@@ -122,7 +122,7 @@ void retu_write_reg(struct device *child, unsigned reg, u16 val)
 
 	__retu_write_reg(retu, reg, val);
 }
-EXPORT_SYMBOL(retu_write_reg);
+EXPORT_SYMBOL_GPL(retu_write_reg);
 
 /**
  * retu_set_clear_reg_bits - helper function to read/set/clear bits
@@ -185,7 +185,7 @@ int retu_read_adc(struct device *child, int channel)
 
 	return res;
 }
-EXPORT_SYMBOL(retu_read_adc);
+EXPORT_SYMBOL_GPL(retu_read_adc);
 
 static irqreturn_t retu_irq_handler(int irq, void *_retu)
 {
-- 
1.7.4.rc2

