From: felipe.balbi@nokia.com
Subject: [RFC PATCH 10/37] cbus: move cbus_host definition to C source
Date: Wed,  7 Apr 2010 19:04:01 +0300
Message-ID: <1270656268-7034-11-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58487 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932848Ab0DGQFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:19 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58em004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:17 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

no-one else besides cbus.c wants to deal with
struct cbus_host, so move the definition to
the C source interested in it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |    9 +++++++++
 drivers/cbus/cbus.h |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index c219d54..285bf23 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -45,6 +45,15 @@
 #define CBUS_XFER_READ		1
 #define CBUS_XFER_WRITE		0
 
+struct cbus_host {
+	/* host lock */
+	spinlock_t lock;
+
+	int	clk_gpio;
+	int	dat_gpio;
+	int	sel_gpio;
+};
+
 static struct cbus_host *cbus_host;
 
 static void cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
diff --git a/drivers/cbus/cbus.h b/drivers/cbus/cbus.h
index 62f1874..d53bb70 100644
--- a/drivers/cbus/cbus.h
+++ b/drivers/cbus/cbus.h
@@ -23,15 +23,6 @@
 #ifndef __DRIVERS_CBUS_CBUS_H
 #define __DRIVERS_CBUS_CBUS_H
 
-struct cbus_host {
-	/* host lock */
-	spinlock_t lock;
-
-	int	clk_gpio;
-	int	dat_gpio;
-	int	sel_gpio;
-};
-
 extern int cbus_read_reg(unsigned dev, unsigned reg);
 extern int cbus_write_reg(unsigned dev, unsigned reg, unsigned val);
 
-- 
1.7.0.rc0.33.g7c3932

