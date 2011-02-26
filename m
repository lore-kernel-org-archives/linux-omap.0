From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-retu: Acquire mutex on write operation
Date: Sun, 27 Feb 2011 00:34:33 +0100
Message-ID: <1298763273.21318.5.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:50117 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab1BZXel (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Feb 2011 18:34:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

The mutex has to be acquired on register write to avoid interference
with a simultaneous retu_set_clear_reg_bits operation.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Tested on n810.


Index: linux-omap-2.6/drivers/cbus/retu.c
===================================================================
--- linux-omap-2.6.orig/drivers/cbus/retu.c	2011-02-23 23:32:26.388763324 +0100
+++ linux-omap-2.6/drivers/cbus/retu.c	2011-02-26 23:27:08.772462280 +0100
@@ -120,7 +120,9 @@
 {
 	struct retu		*retu = dev_get_drvdata(child->parent);
 
+	mutex_lock(&retu->mutex);
 	__retu_write_reg(retu, reg, val);
+	mutex_unlock(&retu->mutex);
 }
 EXPORT_SYMBOL_GPL(retu_write_reg);
 




