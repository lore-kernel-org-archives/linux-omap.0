From: Felipe Balbi <balbi@ti.com>
Subject: Re: dwc3 gadget fails on dra7-evm
Date: Thu, 15 Jan 2015 09:31:00 -0600
Message-ID: <20150115153100.GB16409@saruman>
References: <54B68EC8.9000003@ti.com>
 <20150114165733.GC16533@saruman>
 <54B7B52D.6080008@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36653 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbbAOPbo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2015 10:31:44 -0500
Content-Disposition: inline
In-Reply-To: <54B7B52D.6080008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, George Cherian <george.cherian@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 02:40:13PM +0200, Roger Quadros wrote:
> On 14/01/15 18:57, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Wed, Jan 14, 2015 at 05:44:08PM +0200, Roger Quadros wrote:
> >> In 3.19-rc4 on dra7-evm or dra72-evm
> >>
> >> modprobe g_zero
> >> [   34.680683] zero gadget: Gadget Zero, version: Cinco de Mayo 2008
> >> [   34.687074] zero gadget: zero ready
> >> [   34.694133] dwc3 48890000.usb: failed to enable ep0out
> >> [   34.701600] zero 48890000.usb: failed to start zero: -110
> >> ERROR: could not insert 'g_zero': Connection timed out
> >>
> >> my u-boot version is v2015.01
> >=20
> > hmm... it could be that DRA7x also needs the suspend phy quirk. Can you
> > try this ?
>=20
> The issue goes away with this patch. Thanks.

alright, patch coming.

--=20
balbi

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt900AAoJEIaOsuA1yqREUpcQAKuiNWbgfoXN56eZwrAZ05PI
b5zLW2eoM/h5GShAWzYw2kzIeIuKUoKP3qQQ0ebjS75ZaNgYpbNlg+SQM0KnoU7I
WZSHUSFbjVSLy4ZeScnC0P/6YMi7AbO+wUumhkxhcDcxonMVX2cgwc2tQ93KuiFI
zcUz93mD4SL//JI8qJvz43NV/z1yhOs2a5W5wCnH82uDfOiRasazIIq+9wPh8aLB
Kl+guE+H6InosTmj1PEwaf7eaEI6XQ+mZMCdVYIEBg5hJwMx+A5pOKhi1/JOLzxn
6SyWryaejgOaDxetTUF5fz8/J/FkVR3hE8ZFYhNtRlBhHk0a0XKrh/osVDPYmsn0
fNCgzCbtLUuR6+E7AsHDReXOv/o78k3iyz4mtWVadAis6sZjDrQ49GlmZdgzl62Y
TOdxSmrcGHjUGSTnDILyAMaq82OzxqM5lDiBYLlBcgYOkxBv5C03TXEBkei7PQtL
7hsR9zLb1QyDLpvPRZd6fpv+n5sSZrWOciCDBzCg0woOH9dDIkCEMpr6WSJqxpA7
bj+wS6oK/HfbyI0Kdo5o168nEhFv7pU9VbhErmZp0DpXS3FOmWJw5yt33OG2IlXC
xcr/vERJuPWuZeNsKHgu2p82WQeK+qmqCrcCi+SOM2hReyzQu0Eb+Xzh2TPP2r8l
iLU2Oh+GOx/Vra1omzv7
=ZnQG
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
