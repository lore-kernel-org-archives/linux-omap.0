From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Questions about DSS device tree adaptation
Date: Thu, 23 Feb 2012 14:56:13 +0200
Message-ID: <1330001773.1820.129.camel@deskari>
References: <1329912443.2070.58.camel@deskari>  <4F462658.9080404@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-7MwaeD28EyNM/UUUYDDy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39286 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751684Ab2BWNVZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 08:21:25 -0500
Received: by lamf4 with SMTP id f4so1775590lam.0
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 05:21:22 -0800 (PST)
In-Reply-To: <4F462658.9080404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-7MwaeD28EyNM/UUUYDDy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-02-23 at 12:43 +0100, Cousson, Benoit wrote:
> Hi Tomi,
>=20
> On 2/22/2012 1:07 PM, Tomi Valkeinen wrote:

> > 	dsi1: dsi@1 {
> > 		compatible =3D "ti,omap4-dsi";
> > 		ti,hwmods =3D "dss_dsi1";
> > 		id =3D<0>;
>=20
> Fixed id should be avoided. In theory you should not need that, and if=
=20
> it is needed like for the UART because Linux is expecting a tty<id>, you=
=20
> should create an alias to map the node to the numbered alias. Just check=
=20
> what was done for UART.

We need to know the ID of the DSI block in the driver for pinmuxing,
clock configuration, and possibly some dsi configurations (i.e. max
buffer on DSI1 could be higher than on DSI2). Isn't the alias just,
well, textual alias to be shown to the user?

For cases like buffer size it's easy to add a property, and define the
buffer size in the DT data.

Pinmuxing is handled with control module's register, we need to set
certain bits for DSI1 and some other for DSI2.

Clock config depends also on DSI ID, as the DSS internal clocks differ
for the DSI modules, and the clock muxing is done in DSS core. So, for
example, when DSI2 wants to use the clock from DSI2 PLL, it needs to
call DSS core and tell it to switch DSI2's source clock from PRCM to
DSI2 PLL.

Do you have any suggestions how pinmuxing or clock config could be
handled without explicit id?

> > dispc is not an output interface (so it won't have any children), it
> > doesn't have anything to customize in the dt data, and it's present on
> > all OMAPs. Should it still be present in the DT data, or should the
> > device be created dynamically in platform code?
>=20
> For consistency, it is still better to have it. You will then be able to=
=20
> use the DT compatible mechanism to identify properly the various DISPC=
=20
> version if needed.
>=20
> Don't you have a functional dependency between the DISPC and some other=
=20
> nodes like DSI, SDI, DPI?

Yes, all output devices, DSI, DPI, etc, depend on DISPC (well, in theory
not always). Should that be somehow visible in DT data?

> > dpi and sdi are not hwmods as the rest of the nodes. They are, from HW
> > point of view, more or less parts of DSS or perhaps DISPC.
>=20
> This is fine, hwmod is really needed only for the IP under PRCM control=
=20
> mostly. Other device can then be regular platform_device.
>=20
> I even think that I will get rid of the other hwmod as soon as the clock=
=20
> binding will be there in DT. Because for the PRCM point of view, there=
=20
> is only one DSS node. The other ones were created artificially to expose=
=20
> the clocks to the proper device. They should not be there.

But each DSS submodule has their own sysconfig & related stuff. Isn't
that handled by hwmod code?

> > How about the actual panel devices. Above there's the "ti,tfp410"
> > device. The panel devices are not plain platform devices, so I need to
> > handle those myself. Can I somehow handle that in the platform code,
> > creating omap_dss_devices at boot time, or do I need to create those
> > devices in, for example in this case, dpi-driver's probe?
>=20
> That does not look right to me. Why cannot they be platform_device?

Legacy reasons. I don't think there are other reasons.

I fear that changing the panel devices to platform devices will be a
huge change. I think the easiest way would be to change the current
omap_dss_device to contain a platform_device instead of a device. But
I'm not sure if that works, I didn't find any other driver using
platform_device in that way.

Well, I need to look at this more.

 Tomi


--=-7MwaeD28EyNM/UUUYDDy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPRjdtAAoJEPo9qoy8lh71g2oP/isbTEj3f9XyBffX7/rQVBmU
ypBsZt0Y1a2j7SeDtiPfF0JbZUtBmQZT7wcMoxf8bwRwhHs5yeCMbweVC8+nNzWh
9qbIf1cVXjWFCy7+986zEzvXgj2XxAaBSMnSyqOpMygNSzoDvRFfnQSEmbQUvcOM
59DNL2+Ycya94QFTS9ehpfhpZUEUYo1l6v1joMvD5YxMH3pwZOGwCyGoYwY8UvmO
JnNIZ9tqy0c/5x7Mw4wd6wmB7SWS2ufQ9WaiWbfr+Sn3uPXvBm4thMvpRlhLqvYm
d0r8XUJSi/p6Y79DaFuYwp4aoskTfxXevN0W8jV2g4WhLpekJz5gK3XpCdWb0N6H
uJwdY5GVfH/qDrzTYARF3hZ2o0dRXCZcHlGh5KjgbKks5i1giWGb2gxYVsSPvRKc
PiI1TIoLpF4+Mj2+GynWjcnOGN7lsvyfpl0LjTtDq7Fg7IY0OO2sQ1+8t7J9XMby
50Ozn/TBe7IWe08knPX/sDCuYjyMHOQZPFMsFhvmW2ivBAOvoZ39EWGIpNLF88QK
mvplynInupcUFOXc80WCv3X1biZBqXohLbGRk3nqne1KfA9cSgR9M6POZY++g+Ct
+vX70Dl27jcPXYIdad+GCzPsjgst18JHhXtW8CX1R2o/C1XUfRfob25OLBc3CKFq
U2MHUe+VAXYs88y5NXcm
=Ilq/
-----END PGP SIGNATURE-----

--=-7MwaeD28EyNM/UUUYDDy--

