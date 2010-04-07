From: felipe.balbi@nokia.com
Subject: [RFC PATCH 08/37] cbus: don't type case when issuing read/write
Date: Wed,  7 Apr 2010 19:03:59 +0300
Message-ID: <1270656268-7034-9-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62351 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932884Ab0DGQFc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:32 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5Psl007673
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:31 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

avoid type casting, fix the types used.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c  |    4 ++--
 drivers/cbus/cbus.h  |    4 ++--
 drivers/cbus/retu.c  |    6 +++---
 drivers/cbus/retu.h  |    6 +++---
 drivers/cbus/tahvo.c |    6 +++---
 drivers/cbus/tahvo.h |    6 +++---
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 53b43e1..06ab81f 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -129,7 +129,7 @@ static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 /*
  * Read a given register from the device
  */
-int cbus_read_reg(int dev, int reg)
+int cbus_read_reg(unsigned dev, unsigned reg)
 {
 	return cbus_transfer(cbus_host, CBUS_XFER_READ, dev, reg, 0);
 }
@@ -138,7 +138,7 @@ EXPORT_SYMBOL(cbus_read_reg);
 /*
  * Write to a given register of the device
  */
-int cbus_write_reg(int dev, int reg, int val)
+int cbus_write_reg(unsigned dev, unsigned reg, unsigned val)
 {
 	return cbus_transfer(cbus_host, CBUS_XFER_WRITE, dev, reg, val);
 }
diff --git a/drivers/cbus/cbus.h b/drivers/cbus/cbus.h
index fbaca09..62f1874 100644
--- a/drivers/cbus/cbus.h
+++ b/drivers/cbus/cbus.h
@@ -32,7 +32,7 @@ struct cbus_host {
 	int	sel_gpio;
 };
 
-extern int cbus_read_reg(int dev, int reg);
-extern int cbus_write_reg(int dev, int reg, int val);
+extern int cbus_read_reg(unsigned dev, unsigned reg);
+extern int cbus_write_reg(unsigned dev, unsigned reg, unsigned val);
 
 #endif /* __DRIVERS_CBUS_CBUS_H */
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 35fdd11..80a2acc 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -78,7 +78,7 @@ EXPORT_SYMBOL(retu_get_status);
  *
  * This function returns the contents of the specified register
  */
-int retu_read_reg(int reg)
+int retu_read_reg(unsigned reg)
 {
 	BUG_ON(!retu_initialized);
 	return cbus_read_reg(RETU_ID, reg);
@@ -91,13 +91,13 @@ int retu_read_reg(int reg)
  *
  * This function writes a value to the specified register
  */
-void retu_write_reg(int reg, u16 val)
+void retu_write_reg(unsigned reg, u16 val)
 {
 	BUG_ON(!retu_initialized);
 	cbus_write_reg(RETU_ID, reg, val);
 }
 
-void retu_set_clear_reg_bits(int reg, u16 set, u16 clear)
+void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 {
 	unsigned long flags;
 	u16 w;
diff --git a/drivers/cbus/retu.h b/drivers/cbus/retu.h
index fbd1981..cf3cf20 100644
--- a/drivers/cbus/retu.h
+++ b/drivers/cbus/retu.h
@@ -58,9 +58,9 @@
 #define	MAX_RETU_IRQ_HANDLERS	16
 
 int retu_get_status(void);
-int retu_read_reg(int reg);
-void retu_write_reg(int reg, u16 val);
-void retu_set_clear_reg_bits(int reg, u16 set, u16 clear);
+int retu_read_reg(unsigned reg);
+void retu_write_reg(unsigned reg, u16 val);
+void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear);
 int retu_read_adc(int channel);
 int retu_request_irq(int id, void *irq_handler, unsigned long arg, char *name);
 void retu_free_irq(int id);
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 6828acc..d8fa90a 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -78,7 +78,7 @@ EXPORT_SYMBOL(tahvo_get_status);
  *
  * This function returns the contents of the specified register
  */
-int tahvo_read_reg(int reg)
+int tahvo_read_reg(unsigned reg)
 {
 	BUG_ON(!tahvo_initialized);
 	return cbus_read_reg(TAHVO_ID, reg);
@@ -91,7 +91,7 @@ int tahvo_read_reg(int reg)
  *
  * This function writes a value to the specified register
  */
-void tahvo_write_reg(int reg, u16 val)
+void tahvo_write_reg(unsigned reg, u16 val)
 {
 	BUG_ON(!tahvo_initialized);
 	cbus_write_reg(TAHVO_ID, reg, val);
@@ -104,7 +104,7 @@ void tahvo_write_reg(int reg, u16 val)
  *
  * This function sets and clears the specified Tahvo register bits atomically
  */
-void tahvo_set_clear_reg_bits(int reg, u16 set, u16 clear)
+void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 {
 	unsigned long flags;
 	u16 w;
diff --git a/drivers/cbus/tahvo.h b/drivers/cbus/tahvo.h
index b4c6f50..97d6583 100644
--- a/drivers/cbus/tahvo.h
+++ b/drivers/cbus/tahvo.h
@@ -40,9 +40,9 @@
 #define MAX_TAHVO_IRQ_HANDLERS	8
 
 int tahvo_get_status(void);
-int tahvo_read_reg(int reg);
-void tahvo_write_reg(int reg, u16 val);
-void tahvo_set_clear_reg_bits(int reg, u16 set, u16 clear);
+int tahvo_read_reg(unsigned reg);
+void tahvo_write_reg(unsigned reg, u16 val);
+void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear);
 int tahvo_request_irq(int id, void *irq_handler, unsigned long arg, char *name);
 void tahvo_free_irq(int id);
 void tahvo_enable_irq(int id);
-- 
1.7.0.rc0.33.g7c3932

