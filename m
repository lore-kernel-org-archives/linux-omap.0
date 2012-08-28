From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: =?UTF-8?q?=5BRFC=20PATCH=202/5=5D=20mfd=3A=20introduce=20retu-mfd=20driver?=
Date: Wed, 29 Aug 2012 00:34:24 +0300
Message-ID: <1346189667-32330-3-git-send-email-aaro.koskinen@iki.fi>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:43268 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab2H1Vea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Aug 2012 17:34:30 -0400
In-Reply-To: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com

Retu is a multi-function device found on Nokia Internet Tablets
implementing at least watchdog, RTC, headset detection and power button
functionality.

This patch implements a minimum functionality providing only register
access functions.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: sameo@linux.intel.com
---
 drivers/mfd/Kconfig      |    8 +++
 drivers/mfd/Makefile     |    1 +
 drivers/mfd/retu-mfd.c   |  114 ++++++++++++++++++++++++++++++++++++++=
++++++++
 include/linux/mfd/retu.h |   20 ++++++++
 4 files changed, 143 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/retu-mfd.c
 create mode 100644 include/linux/mfd/retu.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b1a1462..8ca1270 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1003,6 +1003,14 @@ config MFD_PALMAS
 	  If you say yes here you get support for the Palmas
 	  series of PMIC chips from Texas Instruments.
=20
+config MFD_RETU
+	tristate "Support for Retu multi-function device"
+	select MFD_CORE
+	depends on I2C
+	help
+	  Retu is a multi-function device found on Nokia Internet Tables
+	  (770, N800 and N810).
+
 endmenu
 endif
=20
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 79dd22d..962ec9d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -132,3 +132,4 @@ obj-$(CONFIG_MFD_RC5T583)	+=3D rc5t583.o rc5t583-ir=
q.o
 obj-$(CONFIG_MFD_SEC_CORE)	+=3D sec-core.o sec-irq.o
 obj-$(CONFIG_MFD_ANATOP)	+=3D anatop-mfd.o
 obj-$(CONFIG_MFD_LM3533)	+=3D lm3533-core.o lm3533-ctrlbank.o
+obj-$(CONFIG_MFD_RETU)		+=3D retu-mfd.o
diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
new file mode 100644
index 0000000..f0097d7
--- /dev/null
+++ b/drivers/mfd/retu-mfd.c
@@ -0,0 +1,114 @@
+/*
+ * Retu MFD driver
+ *
+ * Copyright (C) 2004, 2005 Nokia Corporation
+ *
+ * Based on code written by Juha Yrj=C3=B6l=C3=A4, David Weinehall and=
 Mikko Ylinen.
+ * Rewritten to MFD/I2C driver by Aaro Koskinen.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of thi=
s
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/retu.h>
+#include <linux/moduleparam.h>
+
+/* Registers */
+#define RETU_REG_ASICR		0x00		/* ASIC ID and revision */
+#define RETU_REG_ASICR_VILMA	(1 << 7)	/* Bit indicating Vilma */
+
+static struct mfd_cell retu_devs[] =3D {
+	{ .name =3D "retu-wdt" },
+};
+
+int retu_read(struct retu_dev *rdev, u8 reg)
+{
+	return i2c_smbus_read_word_data(rdev->i2c, reg);
+}
+EXPORT_SYMBOL_GPL(retu_read);
+
+int retu_write(struct retu_dev *rdev, u8 reg, u16 data)
+{
+	return i2c_smbus_write_word_data(rdev->i2c, reg, data);
+}
+EXPORT_SYMBOL_GPL(retu_write);
+
+static int __devinit retu_probe(struct i2c_client *i2c,
+				const struct i2c_device_id *id)
+{
+	struct retu_dev *rdev;
+	int ret;
+
+	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (rdev =3D=3D NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, rdev);
+	rdev->dev =3D &i2c->dev;
+	rdev->i2c =3D i2c;
+
+	ret =3D retu_read(rdev, RETU_REG_ASICR);
+	if (ret < 0) {
+		dev_err(rdev->dev, "could not read Retu revision: %d\n", ret);
+		return -EIO;
+	}
+
+	dev_info(rdev->dev, "Retu%s v%d.%d found\n",
+		 (ret & RETU_REG_ASICR_VILMA) ? " & Vilma" : "",
+		 (ret >> 4) & 0x7, ret & 0xf);
+
+	ret =3D mfd_add_devices(rdev->dev, -1, retu_devs, ARRAY_SIZE(retu_dev=
s),
+			      NULL, 0);
+	if (ret < 0)
+		goto error;
+
+	return ret;
+
+error:
+	kfree(rdev);
+	return ret;
+}
+
+static int __devexit retu_remove(struct i2c_client *i2c)
+{
+	struct retu_dev *rdev =3D i2c_get_clientdata(i2c);
+
+	mfd_remove_devices(rdev->dev);
+	kfree(rdev);
+
+	return 0;
+}
+
+static const struct i2c_device_id retu_id[] =3D {
+	{ "retu-mfd", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, retu_id);
+
+static struct i2c_driver retu_driver =3D {
+	.driver		=3D {
+		.name =3D "retu-mfd",
+		.owner =3D THIS_MODULE,
+	},
+	.probe		=3D retu_probe,
+	.remove		=3D retu_remove,
+	.id_table	=3D retu_id,
+};
+module_i2c_driver(retu_driver);
+
+MODULE_DESCRIPTION("Retu MFD driver");
+MODULE_AUTHOR("Aaro Koskinen <aaro.koskinen@iki.fi>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/retu.h b/include/linux/mfd/retu.h
new file mode 100644
index 0000000..e1b3600
--- /dev/null
+++ b/include/linux/mfd/retu.h
@@ -0,0 +1,20 @@
+/*
+ * Retu MFD driver interface
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of thi=
s
+ * archive for more details.
+ */
+
+#ifndef __LINUX_MFD_RETU_H
+#define __LINUX_MFD_RETU_H
+
+struct retu_dev {
+	struct device *dev;
+	struct i2c_client *i2c;
+};
+
+int retu_read(struct retu_dev *, u8);
+int retu_write(struct retu_dev *, u8, u16);
+
+#endif /* __LINUX_MFD_RETU_H */
--=20
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
