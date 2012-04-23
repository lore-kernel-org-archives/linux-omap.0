From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Provide interface for audio support in DSS
Date: Mon, 23 Apr 2012 13:41:11 +0300
Message-ID: <1335177671.1535.6.camel@lappy>
References: <1332971516-4325-1-git-send-email-ricardo.neri@ti.com>
	 <1332971516-4325-2-git-send-email-ricardo.neri@ti.com>
	 <1334923436.1564.8.camel@lappy>  <4F919AFB.8080105@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-J96pBYFvrBnACMDKQSMx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:43901 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754877Ab2DWKlT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 06:41:19 -0400
Received: by lagz14 with SMTP id z14so11590963lag.14
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 03:41:16 -0700 (PDT)
In-Reply-To: <4F919AFB.8080105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: s-chereau@ti.com, x0055901@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org


--=-J96pBYFvrBnACMDKQSMx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-04-20 at 12:20 -0500, Ricardo Neri wrote:
> Hi Tomi,
>=20
> Thanks for your comments!
>=20
> On 04/20/2012 07:03 AM, Tomi Valkeinen wrote:

> > I can't say anything about the parameters for audio_config, so I trust
> > they are ok. But some comments about the functions:
>=20
> Fwiw, I have been testing this approach on OMAP4 and OMAP5 during the=20
> last week and it seems to work fine. :) Perhaps in the future I can=20
> extend it to cover speaker mapping for the multichannel use-case.

Ok. I'll try to go through the rests of patches from you today.

> > I don't like foo_enable(bool enable) style functions. While it does
> > reduce the amount of code a bit, I think it's much less readable than
> > separate foo_enable() and foo_disable() functions.
>=20
> I will split the functions audio_enable into audio_enable and=20
> audio_disable and audio_start into audio_start and audio_stop.
> >
> > audio_detect sounds a bit misleading to me... You're not detecting
> > anything, but asking if audio is supported. So... "audio_supported()" o=
r
> > something?
>=20
> I was looking for a name that denotes that audio support is dynamic:=20
> while a display may be capable of playing audio, it may be supported=20
> only for some configurations (e.g., VESA vs CEA video timings).=20
> Something like audio_supported_now() would be fully descriptive but I=20
> guess audio_supported() looks nicer.

Right, I see. I agree that audio_supported() doesn't convey all the
information about the context. But audio_supported_now() does sound a
bit odd =3D).

> > Is there need for the audio_config function, or could the audio configs
> > be given with audio_start call?
>=20
> I propose to have separate functions for configuration and audio start=
=20
> to provide full flexibility. The users of the DSS audio interface should=
=20
> be able to decide when to configure and when to start the audio;=20
> otherwise, synchronization issues may arise. For instance, on OMAP HDMI=
=20
> IPs, the audio configuration must be done while the audio wrapper is=20
> disabled; but the DMA transfers must start after enabling the audio=20
> wrapper (or FIFO underflow and audio channel shifting may occur). As the=
=20
> DMA tranfers are started by a different driver (e.g., ASoC), DSS does=20
> control it and, instead, should provide functionality to config and=20
> start audio when required.
>=20
> Furthermore, IMHO, having a config function to effectively configure and=
=20
> a start function to effectively start audio contributes to improve=20
> readability.

Ok, I agree.

 Tomi


--=-J96pBYFvrBnACMDKQSMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPlTHAAAoJEPo9qoy8lh71JnYQAI1+IqN88REdPAIQKwvmH/Dw
e93X9LPHH5EFf4ECPcKAT3XmQ0yY5F8nSIaJzuM3tcPo+aHoXHq+EPdcL4r+cFQP
FC8jkhSMsdmqyUDxXJrr2zEwoQ3bov72SOX2LSHh0b7e98Etb74rjI4VNQhpW9gt
QBTJZtbPscnsMmgb24Ok/fRT2A8oM+uxGSwCmZGpHnTKKEsoOGcwTniIchVo9gjC
Lk8O1PaMDl+m2UYunQJMMZ+vSYSJQ7jF6xiYScqW6vUmg1mTTmjSOpYAXvD8Bh9C
+Q1JBpZ/cnGJCU/w00Lz3gjPQTvUI+CoVI06WHttwKvM/5k3Me7mcPhJi/6wl0sy
iVv1z4bSlc2PobwFCNo0pmqUCXYyT7uu+hr/Z/AOycUy5WRKY6DHYv9duqDctJd9
qbUl8NyCgDUst3B7RIUjemlfw2N8Ca0dACWLoyYqaBrHIWT+dyPBMxM+uMuCkioP
JD9oT6XkhS0KablECWk5KEsr0G+pb6JTHRSbxlHvIXG4fbLpn9g/UmVqHDJ/aBNY
FPzemL987f5eAjVysAltlD/pMxPn8yfgK9K6bMmqEz0xX6OYCIqRH1ziVDIg3aMK
35nAbX7Mjq/34TM95zFcwfAQSRDfYRyxLun2cum7LEucmDf9caiNX1JBerELaOAi
G/r6zxipcNDABA762bi6
=kF59
-----END PGP SIGNATURE-----

--=-J96pBYFvrBnACMDKQSMx--

