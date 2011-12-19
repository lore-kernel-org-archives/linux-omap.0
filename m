From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/6] OMAP: PM: register to the per-device PM
 QoS framework
Date: Mon, 19 Dec 2011 14:12:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112191405310.12660@utopia.booyaka.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
	<1323874304-5001-4-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="155748971-1433855630-1324328824=:12660"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1323874304-5001-4-git-send-email-j-pihet@ti.com>
Content-ID: <alpine.DEB.2.00.1112191411280.12660@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1433855630-1324328824=:12660
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1112191411281.12660@utopia.booyaka.com>

Hi

On Wed, 14 Dec 2011, jean.pihet@newoldbits.com wrote:

> From: Jean Pihet <j-pihet@ti.com>
>=20
> Implement the devices wake-up latency constraints using the global
> device PM QoS notification handler which applies the constraints to the
> underlying layer by calling the corresponding function at hwmod level.
>=20
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
> latency constraints on MPU, CORE and PER.
>=20
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

I've modified this patch to work with omap_devices that contain multiple=20
hwmods, and to move the code to the mach-omap2/omap_device.c code, which=20
seems to make more sense.  Since the hwmod set-constraint and=20
remove-constraint functions are now split, this code also must determine=20
which one to call.

- Paul

From: Jean Pihet <j-pihet@ti.com>
Date: Sun, 18 Dec 2011 16:42:07 -0700
Subject: [PATCH] ARM: OMAP: omap_device: register to the per-device PM QoS
 framework

Implement the devices wake-up latency constraints using the global
device PM QoS notification handler which applies the constraints to the
underlying layer by calling the corresponding function at hwmod level.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: modified to work with omap_devices with large numbers of
 hwmods; moved code to mach-omap2/omap_device.c; added documentation; use
 notifier return codes]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |   74 ++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_dev=
ice.c
index e8d9869..b2c18b7 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -2,6 +2,7 @@
  * omap_device implementation
  *
  * Copyright (C) 2009-2010 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Paul Walmsley, Kevin Hilman
  *
  * Developed in collaboration with (alphabetical order): Benoit
@@ -88,6 +89,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/notifier.h>
+#include <linux/pm_qos.h>
=20
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -409,6 +411,67 @@ static int _omap_device_notifier_call(struct notifier_=
block *nb,
 =09return NOTIFY_DONE;
 }
=20
+/**
+ * _omap_device_pm_qos_handler - interface to the per-device PM QoS framew=
ork
+ * @nb: pointer to omap_device_pm_qos_nb (not used)
+ * @new_value: new maximum wakeup latency constraint for @req->dev (in =B5=
s)
+ * @req: struct dev_pm_qos_request * passed by the Linux PM QoS code
+ *
+ * Called by the Linux core device PM QoS code to alter the maximum
+ * wakeup latency constraint on a device.  If the underlying device is
+ * an omap_device, then this code will pass the constraint on to the
+ * underlying hwmods.  Returns -EINVAL if this code can't handle the
+ * constraint for some reason, or passes along the return code from the
+ * hwmod wakeup latency constraint functions.
+ */
+static int _omap_device_pm_qos_handler(struct notifier_block *nb,
+=09=09=09=09       unsigned long new_value,
+=09=09=09=09       void *req)
+{
+=09struct omap_device *od;
+=09struct omap_hwmod *oh;
+=09struct platform_device *pdev;
+=09struct dev_pm_qos_request *dev_pm_qos_req =3D req;
+=09int ret =3D NOTIFY_OK;
+=09int r, i;
+
+=09pr_debug("OMAP PM constraints: req@0x%p, new_value=3D%lu\n",
+=09=09 req, new_value);
+
+=09/* Look for the platform device for the constraint target device */
+=09pdev =3D to_platform_device(dev_pm_qos_req->dev);
+
+=09/* Try to catch non platform devices */
+=09if (pdev->name =3D=3D NULL) {
+=09=09pr_err("%s: Error: platform device for device %s not valid\n",
+=09=09       __func__, dev_name(dev_pm_qos_req->dev));
+=09=09return NOTIFY_DONE;
+=09}
+
+=09/* Find the associated omap_device for dev */
+=09od =3D to_omap_device(pdev);
+=09if (od =3D=3D NULL) {
+=09=09pr_err("%s: Error: no omap_device for device %s\n",
+=09=09       __func__, dev_name(dev_pm_qos_req->dev));
+=09=09return NOTIFY_DONE;
+=09}
+
+=09pr_debug("OMAP PM constraints: req@0x%p, dev=3D0x%p, new_value=3D%lu\n"=
,
+=09=09 req, dev_pm_qos_req->dev, new_value);
+
+=09for (i =3D 0; i < od->hwmods_cnt; i++) {
+=09=09oh =3D od->hwmods[i];
+=09=09if (new_value =3D=3D PM_QOS_DEV_LAT_DEFAULT_VALUE)
+=09=09=09r =3D omap_hwmod_remove_wakeuplat_constraint(oh, dev_pm_qos_req);
+=09=09else
+=09=09=09r =3D omap_hwmod_set_wakeuplat_constraint(oh, dev_pm_qos_req, new=
_value);
+
+=09=09if (!r)
+=09=09=09ret =3D NOTIFY_BAD;
+=09}
+
+=09return ret;
+}
=20
 /* Public functions for use by core code */
=20
@@ -1135,13 +1198,24 @@ struct device omap_device_parent =3D {
 =09.parent         =3D &platform_bus,
 };
=20
+static struct notifier_block omap_device_pm_qos_nb =3D {
+=09.notifier_call=09=3D _omap_device_pm_qos_handler,
+};
+
 static struct notifier_block platform_nb =3D {
 =09.notifier_call =3D _omap_device_notifier_call,
 };
=20
 static int __init omap_device_init(void)
 {
+=09int ret;
+
 =09bus_register_notifier(&platform_bus_type, &platform_nb);
+
+=09ret =3D dev_pm_qos_add_global_notifier(&omap_device_pm_qos_nb);
+=09if (!ret)
+=09=09pr_err("omap_device: cannot add global notifier for dev PM QoS\n");
+
 =09return device_register(&omap_device_parent);
 }
 core_initcall(omap_device_init);
--=20
1.7.7.3
--155748971-1433855630-1324328824=:12660
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-1433855630-1324328824=:12660--
