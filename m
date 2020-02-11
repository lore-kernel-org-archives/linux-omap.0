From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/3] ARM: dts: am437x-gp/epos-evm: drop unused panel
 timings
Date: Tue, 11 Feb 2020 13:54:45 +0100
Message-ID: <98da360f-880b-af56-b285-4d9b39f8a342@wizzup.org>
References: <20191114093950.4101-1-tomi.valkeinen@ti.com>
 <20191114093950.4101-3-tomi.valkeinen@ti.com>
 <20191202130459.GH4929@pendragon.ideasonboard.com>
 <20191211165331.GC43123@atomide.com>
 <45dae8f7-2f5e-6948-5a05-dc8a09ace1fa@ti.com>
 <20191212203550.GB4892@pendragon.ideasonboard.com>
 <add3d8af-6977-68e6-fb77-2fa748c4714a@ti.com>
 <b39e52f1-3e73-5f26-6206-0956cf482631@ti.com>
 <20200211110712.GB28355@pendragon.ideasonboard.com>
 <3b4d10c6-7cb2-af53-3a39-31eef441bfdd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KZT1EpggspcG0tcmzDnZipvDwemOXHLMk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:51904 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727723AbgBKMxj (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 07:53:39 -0500
In-Reply-To: <3b4d10c6-7cb2-af53-3a39-31eef441bfdd@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KZT1EpggspcG0tcmzDnZipvDwemOXHLMk
Content-Type: multipart/mixed; boundary="2oFM8B5xF7qabfqonKOfkUABXnZq86qSp"

--2oFM8B5xF7qabfqonKOfkUABXnZq86qSp
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 11/02/2020 12:08, Tomi Valkeinen wrote:
> On 11/02/2020 13:07, Laurent Pinchart wrote:
>=20
>>> Hopefully soon (in five years? =3D) we can say that omapdrm supports =
all
>>> the boards, and we can deprecate omapfb.
>>
>> I'd love to send a patch to remove omapfb, but I'll let you do the
>> honours :-)
>=20
> Not before we add DSI support to omapdrm...

This is probably known, but for devices that would like use PowerVR SGX,
there sometimes is only userspace available that works with omap(l)fb,
and not with DRM. The Nokia N900 is such an example.

There might be a newer release of (closed) userspace coming for the
aging device(s), but as it stands, I don't think it's possible to do 3D
with PowerVR SGX on omapdrm currently.

But I might be wrong...

Cheers,
Merlijn


--2oFM8B5xF7qabfqonKOfkUABXnZq86qSp--

--KZT1EpggspcG0tcmzDnZipvDwemOXHLMk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXkKkFQAKCRAGN09rynK8
WhVUAQCErflCs0d0eyMIWzH6VdVL8AwDzIXvYgTFNk5m9Rd1bQD9F0PUByieJvbO
jtCPZm5iE1fVwDHb5i0gIIsHqDAa0gY=
=Iga1
-----END PGP SIGNATURE-----

--KZT1EpggspcG0tcmzDnZipvDwemOXHLMk--
