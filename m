From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rft/rfc/patch-2.6.32-omap1+ 4/6] cbus: don't export the global cbus_host variable
Date: Wed, 16 Dec 2009 01:44:11 +0200
Message-ID: <1260920653-18503-5-git-send-email-felipe.balbi@nokia.com>
References: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19908 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681AbZLOXqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 18:46:45 -0500
In-Reply-To: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

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
index 39493fb..e0c9715 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -75,7 +75,7 @@ static struct retu_irq_handler_desc retu_irq_handlers[MAX_RETU_IRQ_HANDLERS];
 int retu_read_reg(int reg)
 {
 	BUG_ON(!retu_initialized);
-	return cbus_read_reg(cbus_host, RETU_ID, reg);
+	return cbus_read_reg(RETU_ID, reg);
 }
 
 /**
@@ -88,7 +88,7 @@ int retu_read_reg(int reg)
 void retu_write_reg(int reg, u16 val)
 {
 	BUG_ON(!retu_initialized);
-	cbus_write_reg(cbus_host, RETU_ID, reg, val);
+	cbus_write_reg(RETU_ID, reg, val);
 }
 
 void retu_set_clear_reg_bits(int reg, u16 set, u16 clear)
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 51d8128..2761843 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -75,7 +75,7 @@ static struct tahvo_irq_handler_desc tahvo_irq_handlers[MAX_TAHVO_IRQ_HANDLERS];
 int tahvo_read_reg(int reg)
 {
 	BUG_ON(!tahvo_initialized);
-	return cbus_read_reg(cbus_host, TAHVO_ID, reg);
+	return cbus_read_reg(TAHVO_ID, reg);
 }
 
 /**
@@ -88,7 +88,7 @@ int tahvo_read_reg(int reg)
 void tahvo_write_reg(int reg, u16 val)
 {
 	BUG_ON(!tahvo_initialized);
-	cbus_write_reg(cbus_host, TAHVO_ID, reg, val);
+	cbus_write_reg(TAHVO_ID, reg, val);
 }
 
 /**
-- 
1.6.6.rc0

