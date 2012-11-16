From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: HDMI: Relocate audio platform device
 creation
Date: Fri, 16 Nov 2012 09:38:30 +0200
Message-ID: <50A5ED76.4040308@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com> <1353029819-21809-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig192DBA5546B76A61C23409F8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab2KPHih (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 02:38:37 -0500
In-Reply-To: <1353029819-21809-2-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

--------------enig192DBA5546B76A61C23409F8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2012-11-16 03:36, Ricardo Neri wrote:
> Creating the accessory devices (such as audio) from the HDMI driver,
> allows to regard HDMI as a single entity with audio an display
> functionality. This intends to follow the design of drivers such
> as MFD-type, in which a single entity handles the creation of the acces=
sory
> devices. Such devices are then used by domain-specific drivers (audio i=
n
> this case). This is in line with the DT implementation of HDMI, in whic=
h
> we will have a single node to describe this feature of the OMAP SoC. Ot=
herwise,
> we would need to have separate nodes for audio and video functionality.=

>=20
> Previously, the platform device for the audio driver was created in
> arch/arm/mach-omap2/devices.c. Thus, this is removed.
>=20
> Also, as the platform device for audio created by the OMAPDSS HDMI now =
provides
> a resource for the DMA port for audio samples, we do not need to specif=
y
> any offset in the ASoC HDMI CPU DAI driver.

If you notice yourself writing "also, the patch does this" in the patch
description, it's usually a sign that the patch needs to be split =3D).

That's perhaps not so important when a patch only deals with one
subsystem or one file, but when the patch changes arch, video and audio
drivers at the same time I would like to have the patches as simple as
possible.

Here I suggest you handle the DMA port change in a separate patch.

 Tomi



--------------enig192DBA5546B76A61C23409F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpe12AAoJEPo9qoy8lh71d2oP/2MDSXYGvJs98COpjMhLkBmZ
AAnzmn1o6mFpTk13UbH+wy2+qdTpnDQPSvlC3o3vlCO+ImbLWB14WbM+TwkWsCxr
lSjvfkNE7/0X0pMSX6CFAjO6wsEpME3VkjUUuAC8P62kAEN/uyIPbRfaPD+ywcpp
42z7iozwKa6lET/IQypGQ8BUbVh6O89RS4XmI2E291Ow8fazkB4E1kBWku9wHt0m
VbJxYXOqHDSXCkH9d7kAvt3VBMwL5Gkz8JCXgpTwM/ln7LZIVynG8SC3g2kYAUUz
eW2tK6Be7Z3xxds/rdkVDDR0TQLsBJYi3ERZsPl0tRmI0iNq18i8cx6mc1uTAHqp
p2+HoNjuB0Kp61E73HK+Afcs9Zi+OzrQWOmSjSaknYofxQ5bEPdz8RA2vBVzOBS5
o9SDteXu2sn2tk0Dkn8wGGeknh48rquBpQW0AViRQqcEUuFsqA7KL41yl0LWtIHQ
xvRs7z5RR5RrxSBWB0v62pT7ZBVrxhR5p66Lb7P92uCbuIP8AeXc0xUMRfVdvYKP
qGZBfBSOGQLVNEAxZIjsP3yGHkRADktIXSBCNlkQZ9fNUqiV9Qumx5KJHdD41OeA
53zsdPdvCfwD76ZGH1+X1dgds2UMMrA9BcSrlYh2VALWu4onurV7W3QV+5ZtnlNS
7q8cwWRIcyc5YOln7stG
=3Azt
-----END PGP SIGNATURE-----

--------------enig192DBA5546B76A61C23409F8--
