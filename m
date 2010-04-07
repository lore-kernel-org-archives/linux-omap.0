From: felipe.balbi@nokia.com
Subject: [RFC PATCH 04/37] cbus: don't export the global cbus_host variable
Date: Wed,  7 Apr 2010 19:03:55 +0300
Message-ID: <1270656268-7034-5-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58473 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab0DGQFQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:16 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58eg004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:13 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

we can keep it static to cbus.c and refer to it when
calling cbus_transfer().

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c  |   11 +++++------
 drivers/cbus/cbus.h  |    6 ++----
 drivers/cbus/retu.c  |    4 ++--
 drivers/cbus/tahvo.c |    4 ++--
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index e1be8c7..c976f49 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -39,8 +39,7 @@
 
 #include "cbus.h"
 
-struct cbus_host *cbus_host = NULL;
-EXPORT_SYMBOL(cbus_host);
+static struct cbus_host *cbus_host;
 
 #ifdef CONFIG_ARCH_OMAP1
 /* We use our own MPUIO functions to get closer to 1MHz bus speed */
@@ -211,18 +210,18 @@ static int cbus_transfer(struct cbus_host *host, int dev, int reg, int data)
 /*
  * Read a given register from the device
  */
-int cbus_read_reg(struct cbus_host *host, int dev, int reg)
+int cbus_read_reg(int dev, int reg)
 {
-	return cbus_host ? cbus_transfer(host, dev, reg, -1) : -ENODEV;
+	return cbus_transfer(cbus_host, dev, reg, -1);
 }
 EXPORT_SYMBOL(cbus_read_reg);
 
 /*
  * Write to a given register of the device
  */
-int cbus_write_reg(struct cbus_host *host, int dev, int reg, u16 val)
+int cbus_write_reg(int dev, int reg, int val)
 {
-	return cbus_host ? cbus_transfer(host, dev, reg, (int)val) : -ENODEV;
+	return cbus_transfer(cbus_host, dev, reg, val);
 }
 EXPORT_SYMBOL(cbus_write_reg);
 
diff --git a/drivers/cbus/cbus.h b/drivers/cbus/cbus.h
index 90c7617..4cd68fd 100644
--- a/drivers/cbus/cbus.h
+++ b/drivers/cbus/cbus.h
@@ -34,9 +34,7 @@ struct cbus_host {
 	int	sel_gpio;
 };
 
-extern struct cbus_host *cbus_host;
-
-extern int cbus_read_reg(struct cbus_host *host, int dev, int reg);
-extern int cbus_write_reg(struct cbus_host *host, int dev, int reg, u16 val);
+extern int cbus_read_reg(int dev, int reg);
+extern int cbus_write_reg(int dev, int reg, int val);
 
 #endif /* __DRIVERS_CBUS_CBUS_H */
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index c0e7cf3..35fdd11 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -81,7 +81,7 @@ EXPORT_SYMBOL(retu_get_status);
 int retu_read_reg(int reg)
 {
 	BUG_ON(!retu_initialized);
-	return cbus_read_reg(cbus_host, RETU_ID, reg);
+	return cbus_read_reg(RETU_ID, reg);
 }
 
 /**
@@ -94,7 +94,7 @@ int retu_read_reg(int reg)
 void retu_write_reg(int reg, u16 val)
 {
 	BUG_ON(!retu_initialized);
-	cbus_write_reg(cbus_host, RETU_ID, reg, val);
+	cbus_write_reg(RETU_ID, reg, val);
 }
 
 void retu_set_clear_reg_bits(int reg, u16 set, u16 clear)
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 8bd5ede..6828acc 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -81,7 +81,7 @@ EXPORT_SYMBOL(tahvo_get_status);
 int tahvo_read_reg(int reg)
 {
 	BUG_ON(!tahvo_initialized);
-	return cbus_read_reg(cbus_host, TAHVO_ID, reg);
+	return cbus_read_reg(TAHVO_ID, reg);
 }
 
 /**
@@ -94,7 +94,7 @@ int tahvo_read_reg(int reg)
 void tahvo_write_reg(int reg, u16 val)
 {
 	BUG_ON(!tahvo_initialized);
-	cbus_write_reg(cbus_host, TAHVO_ID, reg, val);
+	cbus_write_reg(TAHVO_ID, reg, val);
 }
 
 /**
-- 
1.7.0.rc0.33.g7c3932

