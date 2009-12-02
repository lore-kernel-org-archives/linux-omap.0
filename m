From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 09/10] cbus: move to platform_driver
Date: Thu,  3 Dec 2009 00:28:31 +0200
Message-ID: <1259792912-11328-10-git-send-email-felipe.balbi@nokia.com>
References: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63866 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbZLBW24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:28:56 -0500
In-Reply-To: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

also add the platform_device to 770 and n8x0 board files.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    6 ++++++
 arch/arm/mach-omap2/board-n8x0.c     |    7 +++++++
 drivers/cbus/cbus.c                  |   34 ++++++++++++++++++++++++++=
+++++++-
 3 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1=
/board-nokia770.c
index db9a1de..a8debf3 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -97,8 +97,14 @@ static struct platform_device nokia770_kp_device =3D=
 {
 	.resource	=3D nokia770_kp_resources,
 };
=20
+static struct platform_device nokia770_cbus_device =3D {
+	.name		=3D "cbus",
+	.id		=3D -1,
+};
+
 static struct platform_device *nokia770_devices[] __initdata =3D {
 	&nokia770_kp_device,
+	&nokia770_cbus_device,
 };
=20
 static void mipid_shutdown(struct mipid_platform_data *pdata)
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/boa=
rd-n8x0.c
index 764ab1e..22eda61 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -77,6 +77,11 @@ static struct mtd_partition onenand_partitions[] =3D=
 {
 	},
 };
=20
+static struct platform_device n8x0_cbus_device =3D {
+	.name		=3D "cbus",
+	.id		=3D -1,
+};
+
 static struct omap_onenand_platform_data board_onenand_data =3D {
 	.cs		=3D 0,
 	.gpio_irq	=3D 26,
@@ -111,6 +116,8 @@ static void __init n8x0_init_irq(void)
=20
 static void __init n8x0_init_machine(void)
 {
+	platform_device_register(&n8x0_cbus_device);
+
 	/* FIXME: add n810 spi devices */
 	spi_register_board_info(n800_spi_board_info,
 				ARRAY_SIZE(n800_spi_board_info));
diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 145e760..a35941e 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
=20
 #include <asm/io.h>
 #include <asm/mach-types.h>
@@ -222,7 +223,7 @@ int cbus_write_reg(struct cbus_host *host, int dev,=
 int reg, u16 val)
 }
 EXPORT_SYMBOL(cbus_write_reg);
=20
-static int __init cbus_bus_init(void)
+static int __init cbus_bus_probe(struct platform_device *pdev)
 {
 	struct cbus_host *chost;
 	int ret;
@@ -275,6 +276,8 @@ static int __init cbus_bus_init(void)
 	gpio_set_value(chost->clk_gpio, 1);
 	gpio_set_value(chost->clk_gpio, 0);
=20
+	platform_set_drvdata(pdev, chost);
+
 	cbus_host =3D chost;
=20
 	return 0;
@@ -284,13 +287,42 @@ exit2:
 	gpio_free(chost->clk_gpio);
 exit1:
 	kfree(chost);
+
 	return ret;
 }
=20
+static void __exit cbus_bus_remove(struct platform_device *pdev)
+{
+	struct cbus_host	*chost =3D platform_get_drvdata(pdev);
+
+	gpio_free(chost->dat_gpio);
+	gpio_free(chost->clk_gpio);
+	kfree(chost);
+}
+
+static struct platform_driver cbus_driver =3D {
+	.remove		=3D __exit_p(cbus_bus_remove),
+	.driver		=3D {
+		.name	=3D "cbus",
+	},
+};
+
+static int __init cbus_bus_init(void)
+{
+	return platform_driver_probe(&cbus_driver, cbus_bus_probe);
+}
+
 subsys_initcall(cbus_bus_init);
=20
+static void __exit cbus_bus_exit(void)
+{
+	platform_driver_unregister(&cbus_driver);
+}
+module_exit(cbus_bus_exit);
+
 MODULE_DESCRIPTION("CBUS serial protocol");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Juha Yrj=F6l=E4");
 MODULE_AUTHOR("David Weinehall");
 MODULE_AUTHOR("Mikko Ylinen");
+
--=20
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
