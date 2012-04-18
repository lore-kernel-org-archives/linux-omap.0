From: jean.pihet@newoldbits.com
Subject: =?UTF-8?q?=5BPATCH=203/6=5D=20ARM=3A=20OMAP=3A=20omap=5Fdevice=3A=20register=20to=20the=20per-device=20PM=20QoS=20framework?=
Date: Wed, 18 Apr 2012 15:45:17 +0200
Message-ID: <1334756720-29166-4-git-send-email-j-pihet@ti.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61532 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab2DRNpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:45:49 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so7543586wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:45:48 -0700 (PDT)
In-Reply-To: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

=46rom: Jean Pihet <j-pihet@ti.com>

Implement the devices wake-up latency constraints using the global
device PM QoS notification handler which applies the constraints to the
underlying layer by calling the corresponding function at hwmod level.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-=
up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: modified to work with omap_devices with large numbers =
of
 hwmods; moved code to mach-omap2/omap_device.c; added documentation; u=
se
 notifier return codes]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |   81 ++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap=
_device.c
index d50cbc6..fb66879 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -3,6 +3,7 @@
  * omap_device implementation
  *
  * Copyright (C) 2009-2010 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Paul Walmsley, Kevin Hilman
  *
  * Developed in collaboration with (alphabetical order): Benoit
@@ -89,6 +90,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/notifier.h>
+#include <linux/pm_qos.h>
=20
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -401,6 +403,72 @@ static int _omap_device_notifier_call(struct notif=
ier_block *nb,
 	return NOTIFY_DONE;
 }
=20
+/**
+ * _omap_device_pm_qos_handler - interface to the per-device PM QoS fr=
amework
+ * @nb: pointer to omap_device_pm_qos_nb (not used)
+ * @new_value: new maximum wakeup latency constraint for @req->dev (in=
 =C2=B5s)
+ * @req: struct dev_pm_qos_request * passed by the Linux PM QoS code
+ *
+ * Called by the Linux core device PM QoS code to alter the maximum
+ * wakeup latency constraint on a device.  If the underlying device is
+ * an omap_device, then this code will pass the constraint on to the
+ * underlying hwmods.  Returns -EINVAL if this code can't handle the
+ * constraint for some reason, or passes along the return code from th=
e
+ * hwmod wakeup latency constraint functions.
+ */
+static int _omap_device_pm_qos_handler(struct notifier_block *nb,
+				       unsigned long new_value,
+				       void *req)
+{
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	struct dev_pm_qos_request *dev_pm_qos_req =3D req;
+	int ret =3D NOTIFY_OK;
+	int r, i;
+
+	pr_debug("OMAP PM constraints: req@0x%p, new_value=3D%lu\n",
+		 req, new_value);
+
+	/* Look for the platform device for the constraint target device */
+	pdev =3D to_platform_device(dev_pm_qos_req->dev);
+
+	/* Try to catch non platform devices */
+	if (pdev->name =3D=3D NULL) {
+		pr_err("%s: Error: platform device for device %s not valid\n",
+		       __func__, dev_name(dev_pm_qos_req->dev));
+		return NOTIFY_DONE;
+	}
+
+	/* Find the associated omap_device for dev */
+	od =3D to_omap_device(pdev);
+	if (od =3D=3D NULL) {
+		pr_err("%s: Error: no omap_device for device %s\n",
+		       __func__, dev_name(dev_pm_qos_req->dev));
+		return NOTIFY_DONE;
+	}
+
+	pr_debug("OMAP PM constraints: req@0x%p, dev=3D0x%p, new_value=3D%lu\=
n",
+		 req, dev_pm_qos_req->dev, new_value);
+
+	for (i =3D 0; i < od->hwmods_cnt; i++) {
+		oh =3D od->hwmods[i];
+		if (new_value =3D=3D PM_QOS_DEV_LAT_DEFAULT_VALUE)
+			r =3D omap_hwmod_remove_wakeuplat_constraint(
+							oh,
+							dev_pm_qos_req);
+		else
+			r =3D omap_hwmod_set_wakeuplat_constraint(
+							oh,
+							dev_pm_qos_req,
+							new_value);
+
+		if (!r)
+			ret =3D NOTIFY_BAD;
+	}
+
+	return ret;
+}
=20
 /* Public functions for use by core code */
=20
@@ -1117,13 +1185,24 @@ int omap_device_enable_clocks(struct omap_devic=
e *od)
 	return 0;
 }
=20
+static struct notifier_block omap_device_pm_qos_nb =3D {
+	.notifier_call =3D _omap_device_pm_qos_handler,
+};
+
 static struct notifier_block platform_nb =3D {
 	.notifier_call =3D _omap_device_notifier_call,
 };
=20
 static int __init omap_device_init(void)
 {
+	int ret;
+
 	bus_register_notifier(&platform_bus_type, &platform_nb);
-	return 0;
+
+	ret =3D dev_pm_qos_add_global_notifier(&omap_device_pm_qos_nb);
+	if (!ret)
+		pr_err("omap_device: cannot add global notifier for dev PM QoS\n");
+
+	return ret;
 }
 core_initcall(omap_device_init);
--=20
1.7.7.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
