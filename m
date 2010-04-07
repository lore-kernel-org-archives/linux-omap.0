From: felipe.balbi@nokia.com
Subject: [RFC PATCH 07/37] cbus: add read/write flag to cbus_transfer
Date: Wed,  7 Apr 2010 19:03:58 +0300
Message-ID: <1270656268-7034-8-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58483 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932621Ab0DGQFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:18 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58ek004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:16 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

=46rom: Felipe Balbi <felipe.balbi@nokia.com>

don't do magic tricks with the data to be written, it's simpler
to pass down a flag which will for sure tell us if we're reading
or writing.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 35f7c71..53b43e1 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -3,12 +3,15 @@
  *
  * Support functions for CBUS serial protocol
  *
- * Copyright (C) 2004, 2005 Nokia Corporation
+ * Copyright (C) 2004-2010 Nokia Corporation
+ * Contact: Felipe Balbi <felipe.balbi@nokia.com>
  *
  * Written by Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>,
  *	      David Weinehall <david.weinehall@nokia.com>, and
  *	      Mikko Ylinen <mikko.k.ylinen@nokia.com>
  *
+ * Several updates and cleanups by Felipe Balbi <felipe.balbi@nokia.co=
m>
+ *
  * This file is subject to the terms and conditions of the GNU General
  * Public License. See the file "COPYING" in the main directory of thi=
s
  * archive for more details.
@@ -39,6 +42,9 @@
=20
 #include "cbus.h"
=20
+#define CBUS_XFER_READ		1
+#define CBUS_XFER_WRITE		0
+
 static struct cbus_host *cbus_host;
=20
 static void cbus_send_bit(struct cbus_host *host, int bit, int set_to_=
input)
@@ -64,14 +70,11 @@ static u8 cbus_receive_bit(struct cbus_host *host)
 	return ret;
 }
=20
-static int cbus_transfer(struct cbus_host *host, int dev, int reg, int=
 data)
+static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned=
 dev,
+		unsigned reg, unsigned data)
 {
-	int i;
-	int is_read =3D 0;
 	unsigned long flags;
-
-	if (data < 0)
-		is_read =3D 1;
+	int i;
=20
 	/* We don't want interrupts disturbing our transfer */
 	spin_lock_irqsave(&host->lock, flags);
@@ -87,24 +90,23 @@ static int cbus_transfer(struct cbus_host *host, in=
t dev, int reg, int data)
 		cbus_send_bit(host, dev & (1 << (i - 1)), 0);
=20
 	/* Send the rw flag */
-	cbus_send_bit(host, is_read, 0);
+	cbus_send_bit(host, rw, 0);
=20
 	/* Send the register address */
 	for (i =3D 5; i > 0; i--) {
 		int set_to_input =3D 0;
=20
-		if (is_read && i =3D=3D 1)
+		if (rw && i =3D=3D 1)
 			set_to_input =3D 1;
=20
 		cbus_send_bit(host, reg & (1 << (i - 1)), set_to_input);
 	}
=20
-	if (!is_read) {
+	if (!rw) {
 		for (i =3D 16; i > 0; i--)
 			cbus_send_bit(host, data & (1 << (i - 1)), 0);
 	} else {
 		gpio_set_value(host->clk_gpio, 1);
-		data =3D 0;
=20
 		for (i =3D 16; i > 0; i--) {
 			u8 bit =3D cbus_receive_bit(host);
@@ -129,7 +131,7 @@ static int cbus_transfer(struct cbus_host *host, in=
t dev, int reg, int data)
  */
 int cbus_read_reg(int dev, int reg)
 {
-	return cbus_transfer(cbus_host, dev, reg, -1);
+	return cbus_transfer(cbus_host, CBUS_XFER_READ, dev, reg, 0);
 }
 EXPORT_SYMBOL(cbus_read_reg);
=20
@@ -138,7 +140,7 @@ EXPORT_SYMBOL(cbus_read_reg);
  */
 int cbus_write_reg(int dev, int reg, int val)
 {
-	return cbus_transfer(cbus_host, dev, reg, val);
+	return cbus_transfer(cbus_host, CBUS_XFER_WRITE, dev, reg, val);
 }
 EXPORT_SYMBOL(cbus_write_reg);
=20
@@ -214,7 +216,6 @@ static int __init cbus_bus_init(void)
 {
 	return platform_driver_probe(&cbus_driver, cbus_bus_probe);
 }
-
 subsys_initcall(cbus_bus_init);
=20
 static void __exit cbus_bus_exit(void)
@@ -228,4 +229,5 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Juha Yrj=F6l=E4");
 MODULE_AUTHOR("David Weinehall");
 MODULE_AUTHOR("Mikko Ylinen");
+MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
=20
--=20
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
