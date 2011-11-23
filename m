From: Felipe Balbi <balbi@ti.com>
Subject: =?UTF-8?q?=5BPATCH=202/6=5D=20cbus=3A=20move=20the=20module=5Fplatform=5Fdriver=20where=20possible?=
Date: Wed, 23 Nov 2011 16:00:44 +0200
Message-ID: <1322056848-1188-3-git-send-email-balbi@ti.com>
References: <1322056848-1188-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:51703 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755408Ab1KWOA4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 09:00:56 -0500
Received: by mail-gx0-f178.google.com with SMTP id k4so1615015ggn.37
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 06:00:55 -0800 (PST)
In-Reply-To: <1322056848-1188-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

this allows us to delete a bunch of boilerplate code
from the drivers. While at that, also add missing
MODULE_ALIAS().

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/cbus.c           |   19 +++++--------------
 drivers/cbus/retu-headset.c   |   21 ++++++---------------
 drivers/cbus/retu-pwrbutton.c |   20 ++++++--------------
 drivers/cbus/retu-rtc.c       |   18 +++++-------------
 drivers/cbus/retu-wdt.c       |   19 +++++--------------
 drivers/cbus/retu.c           |   13 ++-----------
 drivers/cbus/tahvo-usb.c      |   21 +++++++++++----------
 drivers/cbus/tahvo.c          |   13 ++-----------
 8 files changed, 42 insertions(+), 102 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 52eab4a..c7ed881 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -247,7 +247,7 @@ int cbus_write_reg(struct device *child, unsigned d=
ev, unsigned reg,
 }
 EXPORT_SYMBOL(cbus_write_reg);
=20
-static int __init cbus_bus_probe(struct platform_device *pdev)
+static int __devinit cbus_bus_probe(struct platform_device *pdev)
 {
 	struct cbus_host *chost;
 	struct cbus_host_platform_data *pdata =3D pdev->dev.platform_data;
@@ -296,7 +296,7 @@ exit1:
 	return ret;
 }
=20
-static void __exit cbus_bus_remove(struct platform_device *pdev)
+static void __devexit cbus_bus_remove(struct platform_device *pdev)
 {
 	struct cbus_host	*chost =3D platform_get_drvdata(pdev);
=20
@@ -308,23 +308,14 @@ static void __exit cbus_bus_remove(struct platfor=
m_device *pdev)
 }
=20
 static struct platform_driver cbus_driver =3D {
-	.remove		=3D __exit_p(cbus_bus_remove),
+	.probe		=3D cbus_bus_probe,
+	.remove		=3D __devexit_p(cbus_bus_remove),
 	.driver		=3D {
 		.name	=3D "cbus",
 	},
 };
=20
-static int __init cbus_bus_init(void)
-{
-	return platform_driver_probe(&cbus_driver, cbus_bus_probe);
-}
-subsys_initcall(cbus_bus_init);
-
-static void __exit cbus_bus_exit(void)
-{
-	platform_driver_unregister(&cbus_driver);
-}
-module_exit(cbus_bus_exit);
+module_platform_driver(cbus_driver);
=20
 MODULE_DESCRIPTION("CBUS serial protocol");
 MODULE_LICENSE("GPL");
diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index 3b8e138..576b0e6 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -222,7 +222,7 @@ static void retu_headset_detect_timer(unsigned long=
 arg)
 	spin_unlock_irqrestore(&hs->lock, flags);
 }
=20
-static int __init retu_headset_probe(struct platform_device *pdev)
+static int __devinit retu_headset_probe(struct platform_device *pdev)
 {
 	struct retu_headset *hs;
 	int irq;
@@ -291,7 +291,7 @@ err1:
 	return r;
 }
=20
-static int retu_headset_remove(struct platform_device *pdev)
+static int __devexit retu_headset_remove(struct platform_device *pdev)
 {
 	struct retu_headset *hs =3D platform_get_drvdata(pdev);
=20
@@ -333,7 +333,8 @@ static int retu_headset_resume(struct platform_devi=
ce *pdev)
 }
=20
 static struct platform_driver retu_headset_driver =3D {
-	.remove		=3D retu_headset_remove,
+	.probe		=3D retu_headset_probe,
+	.remove		=3D __devexit_p(retu_headset_remove),
 	.suspend	=3D retu_headset_suspend,
 	.resume		=3D retu_headset_resume,
 	.driver		=3D {
@@ -341,19 +342,9 @@ static struct platform_driver retu_headset_driver =
=3D {
 	},
 };
=20
-static int __init retu_headset_init(void)
-{
-	return platform_driver_probe(&retu_headset_driver, retu_headset_probe=
);
-}
-
-static void __exit retu_headset_exit(void)
-{
-	platform_driver_unregister(&retu_headset_driver);
-}
-
-module_init(retu_headset_init);
-module_exit(retu_headset_exit);
+module_platform_driver(retu_headset_driver);
=20
+MODULE_ALIAS("platform:retu-headset");
 MODULE_DESCRIPTION("Retu/Vilma headset detection");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Juha Yrj=F6l=E4");
diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutto=
n.c
index a5a3069..98ad005 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -72,7 +72,7 @@ static irqreturn_t retubutton_irq(int irq, void *_pwr=
)
 	return IRQ_HANDLED;
 }
=20
-static int __init retubutton_probe(struct platform_device *pdev)
+static int __devinit retubutton_probe(struct platform_device *pdev)
 {
 	struct retu_pwrbutton		*pwr;
 	int				ret =3D 0;
@@ -127,7 +127,7 @@ err0:
 	return ret;
 }
=20
-static int __exit retubutton_remove(struct platform_device *pdev)
+static int __devexit retubutton_remove(struct platform_device *pdev)
 {
 	struct retu_pwrbutton		*pwr =3D platform_get_drvdata(pdev);
=20
@@ -140,24 +140,16 @@ static int __exit retubutton_remove(struct platfo=
rm_device *pdev)
 }
=20
 static struct platform_driver retu_pwrbutton_driver =3D {
-	.remove		=3D __exit_p(retubutton_remove),
+	.probe		=3D retubutton_probe,
+	.remove		=3D __devexit_p(retubutton_remove),
 	.driver		=3D {
 		.name	=3D "retu-pwrbutton",
 	},
 };
=20
-static int __init retubutton_init(void)
-{
-	return platform_driver_probe(&retu_pwrbutton_driver, retubutton_probe=
);
-}
-module_init(retubutton_init);
-
-static void __exit retubutton_exit(void)
-{
-	platform_driver_unregister(&retu_pwrbutton_driver);
-}
-module_exit(retubutton_exit);
+module_platform_driver(retu_pwrbutton_driver);
=20
+MODULE_ALIAS("platform:retu-pwrbutton");
 MODULE_DESCRIPTION("Retu Power Button");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ari Saastamoinen");
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 488849c..965ee55 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -199,7 +199,7 @@ static struct rtc_class_ops retu_rtc_ops =3D {
 	.set_alarm		=3D retu_rtc_set_alarm,
 };
=20
-static int __init retu_rtc_probe(struct platform_device *pdev)
+static int __devinit retu_rtc_probe(struct platform_device *pdev)
 {
 	struct retu_rtc		*rtc;
 	int			r;
@@ -261,24 +261,16 @@ static int __devexit retu_rtc_remove(struct platf=
orm_device *pdev)
 }
=20
 static struct platform_driver retu_rtc_driver =3D {
-	.remove		=3D __exit_p(retu_rtc_remove),
+	.probe		=3D retu_rtc_probe,
+	.remove		=3D __devexit_p(retu_rtc_remove),
 	.driver		=3D {
 		.name	=3D "retu-rtc",
 	},
 };
=20
-static int __init retu_rtc_init(void)
-{
-	return platform_driver_probe(&retu_rtc_driver, retu_rtc_probe);
-}
-module_init(retu_rtc_init);
-
-static void __exit retu_rtc_exit(void)
-{
-	platform_driver_unregister(&retu_rtc_driver);
-}
-module_exit(retu_rtc_exit);
+module_platform_driver(retu_rtc_driver);
=20
+MODULE_ALIAS("platform:retu-rtc");
 MODULE_DESCRIPTION("Retu RTC");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul Mundt");
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 3eb388f..7557bc1 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -193,7 +193,7 @@ static const struct file_operations retu_wdt_fops =3D=
 {
 	.release	=3D retu_wdt_release,
 };
=20
-static int __init retu_wdt_probe(struct platform_device *pdev)
+static int __devinit retu_wdt_probe(struct platform_device *pdev)
 {
 	struct retu_wdt_dev *wdev;
 	int ret;
@@ -248,25 +248,16 @@ static int __devexit retu_wdt_remove(struct platf=
orm_device *pdev)
 }
=20
 static struct platform_driver retu_wdt_driver =3D {
-	.remove		=3D __exit_p(retu_wdt_remove),
+	.probe		=3D retu_wdt_probe,
+	.remove		=3D __devexit_p(retu_wdt_remove),
 	.driver		=3D {
 		.name	=3D "retu-wdt",
 	},
 };
=20
-static int __init retu_wdt_init(void)
-{
-	return platform_driver_probe(&retu_wdt_driver, retu_wdt_probe);
-}
-
-static void __exit retu_wdt_exit(void)
-{
-	platform_driver_unregister(&retu_wdt_driver);
-}
-
-module_init(retu_wdt_init);
-module_exit(retu_wdt_exit);
+module_platform_driver(retu_wdt_driver);
=20
+MODULE_ALIAS("platform:retu-wdt");
 MODULE_DESCRIPTION("Retu WatchDog");
 MODULE_AUTHOR("Amit Kucheria");
 MODULE_LICENSE("GPL");
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 437a309..5bd88c6 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -518,18 +518,9 @@ static struct platform_driver retu_driver =3D {
 	},
 };
=20
-static int __init retu_init(void)
-{
-	return platform_driver_register(&retu_driver);
-}
-subsys_initcall(retu_init);
-
-static void __exit retu_exit(void)
-{
-	platform_driver_unregister(&retu_driver);
-}
-module_exit(retu_exit);
+module_platform_driver(retu_driver);
=20
+MODULE_ALIAS("platform:retu");
 MODULE_DESCRIPTION("Retu ASIC control");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Juha Yrj=F6l=E4");
diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index 41e39ca..15da853 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -189,7 +189,7 @@ static int tahvo_otg_init(void)
 	return 0;
 }
=20
-static int __init omap_otg_probe(struct platform_device *pdev)
+static int __devinit omap_otg_probe(struct platform_device *pdev)
 {
 	int ret;
=20
@@ -205,7 +205,7 @@ static int __init omap_otg_probe(struct platform_de=
vice *pdev)
 			   tahvo_usb_device);
 }
=20
-static int __exit omap_otg_remove(struct platform_device *pdev)
+static int __devexit omap_otg_remove(struct platform_device *pdev)
 {
 	free_irq(tahvo_otg_dev->resource[1].start, tahvo_usb_device);
 	tahvo_otg_dev =3D NULL;
@@ -214,10 +214,11 @@ static int __exit omap_otg_remove(struct platform=
_device *pdev)
 }
=20
 struct platform_driver omap_otg_driver =3D {
+	.probe		=3D omap_otg_probe,
+	.remove		=3D __devexit_p(omap_otg_remove),
 	.driver		=3D {
 		.name	=3D "omap_otg",
 	},
-	.remove		=3D __exit_p(omap_otg_remove),
 };
=20
 /*
@@ -588,7 +589,7 @@ static ssize_t otg_mode_store(struct device *device=
,
 static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
 #endif
=20
-static int __init tahvo_usb_probe(struct platform_device *pdev)
+static int __devinit tahvo_usb_probe(struct platform_device *pdev)
 {
 	struct tahvo_usb *tu;
 	struct device *dev =3D &pdev->dev;
@@ -680,7 +681,7 @@ err_free_tu:
 	return ret;
 }
=20
-static int __exit tahvo_usb_remove(struct platform_device *pdev)
+static int __devexit tahvo_usb_remove(struct platform_device *pdev)
 {
 	struct tahvo_usb *tu =3D platform_get_drvdata(pdev);
=20
@@ -703,21 +704,22 @@ static int __exit tahvo_usb_remove(struct platfor=
m_device *pdev)
 }
=20
 static struct platform_driver tahvo_usb_driver =3D {
+	.probe		=3D tahvo_usb_probe,
+	.remove		=3D __devexit_p(tahvo_usb_remove),
 	.driver		=3D {
 		.name	=3D "tahvo-usb",
 	},
-	.remove		=3D __exit_p(tahvo_usb_remove),
 };
=20
 static int __init tahvo_usb_init(void)
 {
 	int ret =3D 0;
=20
-	ret =3D platform_driver_probe(&tahvo_usb_driver, tahvo_usb_probe);
+	ret =3D platform_driver_register(&tahvo_usb_driver);
 	if (ret)
 		return ret;
=20
-	ret =3D platform_driver_probe(&omap_otg_driver, omap_otg_probe);
+	ret =3D platform_driver_register(&omap_otg_driver);
 	if (ret) {
 		platform_driver_unregister(&tahvo_usb_driver);
 		return ret;
@@ -725,8 +727,7 @@ static int __init tahvo_usb_init(void)
=20
 	return 0;
 }
-
-subsys_initcall(tahvo_usb_init);
+module_init(tahvo_usb_init);
=20
 static void __exit tahvo_usb_exit(void)
 {
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 5de3d8d..7f7c712 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -401,18 +401,9 @@ static struct platform_driver tahvo_driver =3D {
 	},
 };
=20
-static int __init tahvo_init(void)
-{
-	return platform_driver_register(&tahvo_driver);
-}
-subsys_initcall(tahvo_init);
-
-static void __exit tahvo_exit(void)
-{
-	platform_driver_unregister(&tahvo_driver);
-}
-module_exit(tahvo_exit);
+module_platform_driver(tahvo_driver);
=20
+MODULE_ALIAS("platform:tahvo");
 MODULE_DESCRIPTION("Tahvo ASIC control");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Juha Yrj=F6l=E4");
--=20
1.7.8.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
