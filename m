From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 08/15] cbus: retu: introduce internal read/write functions
Date: Tue, 15 Feb 2011 10:45:55 +0200
Message-ID: <1297759562-25682-9-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48539 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393Ab1BOIq7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:59 -0500
Received: by mail-gy0-f175.google.com with SMTP id 8so2685312gyd.20
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:54 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

We already have the retu structure in others
parts of the retu driver, so instead of accessing
the_retu all over the place, we can start combining
those accesses.

While at that fix a kerneldoc comment on
retu_write_reg()

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index d2326aa..7e4b7e5 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -73,6 +73,27 @@ struct retu {
 static struct retu *the_retu;
 
 /**
+ * __retu_read_reg - Read a value from a register in Retu
+ * @retu: pointer to retu structure
+ * @reg: the register address to read from
+ */
+static int __retu_read_reg(struct retu *retu, unsigned reg)
+{
+	return cbus_read_reg(retu->devid, reg);
+}
+
+/**
+ * __retu_write_reg - Writes a value to a register in Retu
+ * @retu: pointer to retu structure
+ * @reg: the register address to write to
+ * @val: the value to write to the register
+ */
+static void __retu_write_reg(struct retu *retu, unsigned reg, u16 val)
+{
+	cbus_write_reg(retu->devid, reg, val);
+}
+
+/**
  * retu_read_reg - Read a value from a register in Retu
  * @reg: the register to read from
  *
@@ -81,21 +102,21 @@ static struct retu *the_retu;
 int retu_read_reg(unsigned reg)
 {
 	WARN(!the_retu, "Retu not initialized\n");
-	return cbus_read_reg(the_retu->devid, reg);
+	return __retu_read_reg(the_retu, reg);
 }
 EXPORT_SYMBOL(retu_read_reg);
 
 /**
  * retu_write_reg - Write a value to a register in Retu
  * @reg: the register to write to
- * @reg: the value to write to the register
+ * @val: the value to write to the register
  *
  * This function writes a value to the specified register
  */
 void retu_write_reg(unsigned reg, u16 val)
 {
 	WARN(!the_retu, "Retu not initialized\n");
-	cbus_write_reg(the_retu->devid, reg, val);
+	__retu_write_reg(the_retu, reg, val);
 }
 EXPORT_SYMBOL(retu_write_reg);
 
-- 
1.7.4.rc2

