From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH / RFC] Formating changes for Basic OMAP2430 High speed I2C
Date: Mon, 23 Apr 2007 19:49:36 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47BC80E8@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Resubmitting after incorporating review comments

This patch contains the formatting changes.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 drivers/i2c/busses/i2c-omap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
--- linux-omap/drivers/i2c/busses/i2c-omap.c	2007-01-08 =
18:56:31.000000000 -0600
+++ lin_for_hsi2c/drivers/i2c/busses/i2c-omap.c	2007-04-23 =
19:04:50.000000000 -0500
@@ -2,14 +2,16 @@
  * TI OMAP I2C master mode driver
  *
  * Copyright (C) 2003 MontaVista Software, Inc.
- * Copyright (C) 2004 Texas Instruments.
- *
- * Updated to work with multiple I2C interfaces on 24xx by
- * Tony Lindgren <tony@atomide.com> and Imre Deak <imre.deak@nokia.com>
  * Copyright (C) 2005 Nokia Corporation
+ * Copyright (C) 2004 - 2007 Texas Instruments.
  *
- * Cleaned up by Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
- *
+ * Originally written by MontaVista Software, Inc.
+ * Additional contributions by:
+ *	Tony Lindgren <tony@atomide.com>
+ *	Imre Deak <imre.deak@nokia.com>
+ *	Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
+ *	Syed Khasim <x0khasim@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -257,9 +259,9 @@ static int omap_i2c_init(struct omap_i2c
=20
 	/* Enable interrupts */
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
-			   (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			    OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			    OMAP_I2C_IE_AL));
+			(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
+			OMAP_I2C_IE_AL));
 	return 0;
 }
=20
