From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Fri, 29 Jul 2011 08:49:34 -0500
Message-ID: <20110729134932.GA2258@foobar>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-4-git-send-email-khilman@ti.com>
 <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
 <20110728055346.GA11921@foobar>
 <4E315C9F.1030801@ti.com>
 <CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59803 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754349Ab1G2Ntl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 09:49:41 -0400
Received: by gwb19 with SMTP id 19so3028982gwb.32
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 06:49:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08:31-20110728, Menon, Nishanth wrote:
> On Thu, Jul 28, 2011 at 07:57, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> [...]
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
> >> b/arch/arm/mach-omap2/omap_hwmod.c
> >> index 293fa6c..77d01a2 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> >> @@ -142,6 +142,7 @@
> >> =A0#include "powerdomain.h"
> >> =A0#include<plat/clock.h>
> >> =A0#include<plat/omap_hwmod.h>
> >> +#include<plat/omap_device.h>
> >
> > I'd rather put that code inside the omap_device.c instead of here.
> > The omap_device layer is on top of the omap_hwmod.
> > In order to minimize the dependencies from the low HW description l=
ayer to
> > the omap_device layer, you should maybe define a omap_device_from_h=
wmod()
> > function or something similar.
> Thanks for the review. will check on this.
>=20
> >
> > That being said, do we really need to get the device from the hwmod=
 name?
> > Cannot we use the device name instead?
> > I do not know all the usecases, that why I'm asking.
> mpu.0 , are the device names - which probably lets me walk the kernel
> data structrues instead of omap database to get to the right device,
> Vs using the common names like "mpu" " make things a little easier to
> deal with from driver perspective.
>=20
> as an example, some of the dev_driver_string(dev):dev_name(dev) (in
> bracket hwmod name) I collected from OMAP4 are:
> platform:mpu.0 ("mpu")
> platform:l3_main_1.0 ('l3_main_1")
> pvrsrvkm:pvrsrvkm.0 ("gpu")
> rpres:fdif.0 ("fdif")
> omap_hsi:omap_hsi.0 ("hsi")
> platform:iss.0 ("iss")
> etc..
>=20
> I mean I have'nt been keeping track of the device tree discussions so
> dont know if this function could be better done - but I think I agree
> with the overall idea that instead of spawning off get_xyz_device() w=
e
> need to have some uniform approach to get to the device scaling
> silicon - I hoped we could consider the hwmod database/what ever
> replacing it to do that.
following are a couple of reference patches how this could be done
with omap_device
=46rom f03490456e24f72ca5272303c95a6f0b212494d5 Mon Sep 17 00:00:00 200=
1
=46rom: Nishanth Menon <nm@ti.com>
Date: Wed, 27 Jul 2011 15:02:32 -0500
Subject: [PATCH 1/2] OMAP: PM: omap_device: add omap_hwmod_name_get_ode=
v

An API which translates a standard hwmod name to corresponding
omap_device is useful for drivers when they need to look up the
device associated with a hwmod name to map back into the device
structure pointers. These ideally should be used by drivers in
mach directory. Using a generic hwmod name like "gpu" instead of
the actual device name which could change in the future, allows
us to:
a) Could in effect help replace apis such as omap2_get_mpuss_device,
omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device,
etc..
b) Scale to more devices rather than be restricted to named functions
c) Simplify driver's platform_data from passing additional fields
all doing the same thing with different function pointer names
just for accessing a different device name.

Change-Id: Ib42d22b4a929982c87a79866e3d7dc6e41073a6c
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   32 +++++++++++++++++=
++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/p=
lat-omap/include/plat/omap_device.h
index 70d31d0..7a3c046 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -102,6 +102,7 @@ int omap_device_register(struct omap_device *od);
 int omap_early_device_register(struct omap_device *od);
=20
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
+struct omap_device *omap_hwmod_name_get_odev(const char *oh_name);
=20
 /* OMAP PM interface */
 int omap_device_align_pm_lat(struct platform_device *pdev,
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap=
_device.c
index 92b4496..21df532 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -780,6 +780,38 @@ void __iomem *omap_device_get_rt_va(struct omap_de=
vice *od)
 	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
 }
=20
+/**
+ * omap_hwmod_name_get_odev() - convert a hwmod name to omap_device po=
inter
+ * @oh_name: name of the hwmod device
+ *
+ * returns back a struct omap_device * pointer associated with a hwmod
+ * device represented by a hwmod_name
+ */
+struct omap_device *omap_hwmod_name_get_odev(const char *oh_name)
+{
+	struct omap_hwmod *oh;
+
+	if (!oh_name) {
+		WARN(1, "%s: no hwmod name!\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	oh =3D omap_hwmod_lookup(oh_name);
+	if (IS_ERR_OR_NULL(oh)) {
+		WARN(1, "%s: no hwmod for %s\n", __func__,
+			oh_name);
+		return ERR_PTR(oh ? PTR_ERR(oh) : -ENODEV);
+	}
+	if (IS_ERR_OR_NULL(oh->od)) {
+		WARN(1, "%s: no omap_device for %s\n", __func__,
+			oh_name);
+		return ERR_PTR(oh->od ? PTR_ERR(oh->od) : -ENODEV);
+	}
+
+	return oh->od;
+}
+EXPORT_SYMBOL(omap_hwmod_name_get_odev);
+
 /*
  * Public functions intended for use in omap_device_pm_latency
  * .activate_func and .deactivate_func function pointers
--=20
1.7.4.1

=46rom 51e517c2cb620532a29ec466c32ce1c78663bf43 Mon Sep 17 00:00:00 200=
1
=46rom: Nishanth Menon <nm@ti.com>
Date: Thu, 28 Jul 2011 17:07:28 -0500
Subject: [PATCH 2/2] OMAP: PM: omap_device: add few quick access functi=
ons

Provide a quick set of access functions:
a) Convert omap_device to platform_device - This is the flip of
   to_omap_device for equivalent usage
b) Convert omap_device to device pointer - This is useful for
   most devices that need to go through standard linux functions that
   take device pointer.
c) Convert hwmod to device pointer - This wrapper provides ability for
   drivers to convert directly from hwmod name back to device pointer
   without having to handle this on a driver by driver basis

Change-Id: I0fe16eeb41c32d5b166d5cb3f78af4fda140d398
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/p=
lat-omap/include/plat/omap_device.h
index 7a3c046..11cb471 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -150,5 +150,18 @@ struct omap_device_pm_latency {
=20
 /* Get omap_device pointer from platform_device pointer */
 #define to_omap_device(x) container_of((x), struct omap_device, pdev)
+/* Convert omap_device to platform device pointer */
+#define omap_device_get_pdev(x) (&(x)->pdev)
+/* Convert omap_device to device pointer */
+#define omap_device_get_dev(x) (&omap_device_get_pdev(x)->dev)
+/* Convert omap_hwmod name to device pointer */
+static inline struct device *omap_hwmod_name_get_dev(const char *oh_na=
me)
+{
+	struct omap_device *od;
+	od =3D omap_hwmod_name_get_dev(oh_name);
+	if (IS_ERR_OR_NULL(od))
+		return ERR_PTR(od ? PTR_ERR(od) : -ENODEV);
+	return omap_device_get_dev(od);
+}
=20
 #endif
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
