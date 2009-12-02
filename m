From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 07/10] cbus: move EXPORT_SYMBOL close to its exported symbols
Date: Thu,  3 Dec 2009 00:35:49 +0200
Message-ID: <1259793352-29864-8-git-send-email-felipe.balbi@nokia.com>
References: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60613 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905AbZLBWgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:36:16 -0500
In-Reply-To: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

while there, also add a missing static to cbus_bus_init().

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 0bcc211..d73d0c9 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -38,6 +38,7 @@
 #include "cbus.h"
=20
 struct cbus_host *cbus_host =3D NULL;
+EXPORT_SYMBOL(cbus_host);
=20
 #ifdef CONFIG_ARCH_OMAP1
 /* We use our own MPUIO functions to get closer to 1MHz bus speed */
@@ -210,6 +211,7 @@ int cbus_read_reg(struct cbus_host *host, int dev, =
int reg)
 {
 	return cbus_host ? cbus_transfer(host, dev, reg, -1) : -ENODEV;
 }
+EXPORT_SYMBOL(cbus_read_reg);
=20
 /*
  * Write to a given register of the device
@@ -218,8 +220,9 @@ int cbus_write_reg(struct cbus_host *host, int dev,=
 int reg, u16 val)
 {
 	return cbus_host ? cbus_transfer(host, dev, reg, (int)val) : -ENODEV;
 }
+EXPORT_SYMBOL(cbus_write_reg);
=20
-int __init cbus_bus_init(void)
+static int __init cbus_bus_init(void)
 {
 	struct cbus_host *chost;
 	int ret;
@@ -286,10 +289,6 @@ exit1:
=20
 subsys_initcall(cbus_bus_init);
=20
-EXPORT_SYMBOL(cbus_host);
-EXPORT_SYMBOL(cbus_read_reg);
-EXPORT_SYMBOL(cbus_write_reg);
-
 MODULE_DESCRIPTION("CBUS serial protocol");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Juha Yrj=F6l=E4, David Weinehall, and Mikko Ylinen");
--=20
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
