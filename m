From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Thu, 28 Jul 2011 15:59:54 +0300
Message-ID: <20110728125954.GE9069@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
	<20110728055346.GA11921@foobar> <4E315C9F.1030801@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1300831852=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E315C9F.1030801@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Balbi,
	Felipe" <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============1300831852==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BtLpl2nkGUzqmEOn"
Content-Disposition: inline


--BtLpl2nkGUzqmEOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 28, 2011 at 02:57:03PM +0200, Cousson, Benoit wrote:
> Hi Nishanth,
>=20
> On 7/28/2011 7:53 AM, Menon, Nishanth wrote:
> >On 11:57-20110722, Felipe Balbi wrote:
> >[...]
> >>>  	/* Custom OPP enabled for all xM versions */
> >>>  	if (cpu_is_omap3630()) {
> >>>-		struct omap_hwmod *mh =3D omap_hwmod_lookup("mpu");
> >>>-		struct omap_hwmod *dh =3D omap_hwmod_lookup("iva");
> >>>-		struct device *dev;
> >>>+		struct device *mpu_dev, *iva_dev;
> >>>
> >>>-		if (!mh || !dh) {
> >>>+		mpu_dev =3D omap2_get_mpuss_device();
> >>>+		iva_dev =3D omap2_get_iva_device();
> >>
> >>out of curiosity again, nothing to do with this patch.
> >>
> >>Maybe it would be nicer to have an api such as:
> >>
> >>omap2_get_device(name);
> >>
> >>there are already four devices to be gotten, if that number grows any
> >>bigger, so will the number of helper functions.
> >I agree, in fact, on a different topic, I hit the same requirement
> >here is the patch I had done:
> > From 9f226def811bd50e4bac02f427604034cef77706 Mon Sep 17 00:00:00 2001
> >From: Nishanth Menon<nm@ti.com>
> >Date: Wed, 27 Jul 2011 15:02:32 -0500
> >Subject: [PATCH] OMAP: hwmod: add omap_hwmod_to_device
> >
> >omap_hwmod_to_device is useful for drivers when they need to
> >look up the device associated with a hwmod name to map back
> >into the device structure pointers. These ideally should
> >be used by drivers in mach directory. This could in effect
> >replace apis such as omap2_get_mpuss_device,
> >omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device
> >etc..
> >
> >Signed-off-by: Nishanth Menon<nm@ti.com>
> >---
> >  arch/arm/mach-omap2/omap_hwmod.c             |   33 ++++++++++++++++++=
++++++++
> >  arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
> >  2 files changed, 35 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap=
_hwmod.c
> >index 293fa6c..77d01a2 100644
> >--- a/arch/arm/mach-omap2/omap_hwmod.c
> >+++ b/arch/arm/mach-omap2/omap_hwmod.c
> >@@ -142,6 +142,7 @@
> >  #include "powerdomain.h"
> >  #include<plat/clock.h>
> >  #include<plat/omap_hwmod.h>
> >+#include<plat/omap_device.h>
>=20
> I'd rather put that code inside the omap_device.c instead of here.
> The omap_device layer is on top of the omap_hwmod.
> In order to minimize the dependencies from the low HW description
> layer to the omap_device layer, you should maybe define a
> omap_device_from_hwmod() function or something similar.
>=20
> That being said, do we really need to get the device from the hwmod
> name? Cannot we use the device name instead?
> I do not know all the usecases, that why I'm asking.

that's a good question, I only suggested the above given the fact that
we already have four functions to grab four different devices. It was
only a way to combine all of those with a simple argument.

--=20
balbi

--BtLpl2nkGUzqmEOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMV1KAAoJEAv8Txj19kN16C4IAI6F17Ljz8WI9yvZQ7Y/GXW1
T4ytF9UdQ3WQ5ZW0AQpF7W369TtsONItGj0kjCqr1dqo68rn4Vpgrxk5it1c60Fh
VzwkEWif057ln7U5YvNm936CLThfecXAokm+CvW9hGGkpg9TFPTGptjlCiNqSHhZ
Ff8A5TEXhTQ9NLzlotRuHdwv+9SpvA9Z28EkLSufZm0XSNebwk9S7g/tRscQYxdP
qqrZSAZb7otKb+Wg66dQwJnk+J41JOjT1c4lnxJRLb5ZsEZ2jIJlTZxJ61oksnQl
nEbO7gh83ZLsQsAG5obtlSd43n/IXe6b33E9xB9MKqwnb3BJMOJdvaZPMoEHeBg=
=HSQq
-----END PGP SIGNATURE-----

--BtLpl2nkGUzqmEOn--


--===============1300831852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1300831852==--
