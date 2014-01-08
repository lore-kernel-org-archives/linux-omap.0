From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 0/4] drm/omap: fix issues in omap_drv probe/remove
Date: Wed, 8 Jan 2014 15:22:46 +0200
Message-ID: <52CD5126.60804@ti.com>
References: <1388654394-5708-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hSUQcRLVcRl0DmbfQuIiFEoMsee2Lhbx2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53272 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755717AbaAHNWu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jan 2014 08:22:50 -0500
In-Reply-To: <1388654394-5708-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, dri-devel@lists.freedesktop.org, robdclark@gmail.com
Cc: linux-omap@vger.kernel.org

--hSUQcRLVcRl0DmbfQuIiFEoMsee2Lhbx2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-02 11:19, Archit Taneja wrote:
> At the moment, the omapdrm driver doesn't work on panda/beagle when bui=
lt-in
> the kernel. The problem is that omapdrm doesn't defer probe if resource=
s like
> regulator/I2C etc are missing. The first patch fixes that.
>=20
> The next 3 patches make sure that omapdrm module can be inserted and re=
moved
> successively, and that omapdss is left in a consistent state when omapd=
rm is
> removed.
>=20
> In the previous version of this series, there was a warning related to =
apply_irq
> being registered seen while removing omapdrm. This was a relatively sca=
ry
> warning, therefore, the "change dev_unload order" patch was added to ma=
ke sure
> we don't see that.
>=20
> After these fixes, I still see the warning below once in a while. I don=
't know
> how to fix it at the moment, but it's harmless and omapdrm is now usabl=
e again.
> These are critical fixes which I have posted since 3.12-rcs, it would b=
e nice if
> they can go in as soon as possible.

These look ok to me:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--hSUQcRLVcRl0DmbfQuIiFEoMsee2Lhbx2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzVEmAAoJEPo9qoy8lh71V4oQAKwh7RaYpwBmzPdNLaTn7jRO
AjFOzb6eynUBvbi8UTV4CsyMZ6VP4Fqypw4KUEbuJ4+8SSgoLY089oKOx2Xc6KHP
ujcDGlca7tD0vFJLDRXa0nAyNhusnewg/EzNsndqmpUg7NOuhX6HokYeaeLH8IFO
6n8Jah5RiFhcFAe+UindZmIeye/Dme+5Pu5U3eWoxV+Z1b+yNHR4LnPpemztTQnH
qDv7FRS1jM7XLmqfO3ZuKg7RLjbIFLr0uPqoVR2e2G5W+WUxccT0Q29qd1g7mhK8
rjgfIxVxMkyWMu/vWEyXzihJXJcNy031GIG+vcwDo4QNBQzFKfuW/5AQj0KRKz2r
r/oArncBTAvCNRxJojVxig0V+RgNkQ52hgdj6+nAVC62o3oFI5Iad0fMfWM65lys
7eHsMj/eyegW3Ag7VtEbjs/9DZqDHME/ShWE6DkUa6B8WKlJ0+JyJV1LaqtZBkGz
wCORRLwsLAlkH5qCYBvNe/H30+e6dIdbnmNscU8iw9Y/HB3lBj+fXTOa2xnVO+c8
vLI45f+9vhXIFjsyI7t5JLBli5pXNv4oqkXaC2xA1b8p+izWJg6e50Lagyn/HaeZ
yaP1Ixr3CleKP526w8PVww0WWa5AG/NYWfzhXeBCjrofJmeWqV027roRHS7aCASz
CtRGFarlFqWacg3dHdky
=1L17
-----END PGP SIGNATURE-----

--hSUQcRLVcRl0DmbfQuIiFEoMsee2Lhbx2--
