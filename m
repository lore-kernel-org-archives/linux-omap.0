From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 2/6] omapdss: add init port functions for different omap
 revs
Date: Tue, 20 May 2014 11:04:49 +0300
Message-ID: <537B0CA1.5060100@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1399540517-17883-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="GhX5XKH4egPTauKiawJr0PPHoW9t8sVXg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60829 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584AbaETIFB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 04:05:01 -0400
In-Reply-To: <1399540517-17883-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--GhX5XKH4egPTauKiawJr0PPHoW9t8sVXg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/05/14 12:15, Archit Taneja wrote:
> The init/uninit port functions are used to set up the DPI and SDI outpu=
ts under
> the dss platform device. A 'reg' property is used to determine whether =
the node
> is DPI or SDI for OMAP34xx DSS revision. For other DSS revisions, only =
DPI
> output exists.
>=20
> For multiple DPI output instances(introduced in DRA7xx DSS), we would u=
se the
> 'reg' property to specify the DPI output number.
>=20
> The current functions work fine if there is only one DPI output instanc=
e in
> DSS. For multiple DPI instances, it would get complicated to figure out=
 whether
> 'reg' is used to specify whether the output is SDI, or a later DPI inst=
ance.
>=20
> Create DSS revision specific init/uninit_port functions such that we ha=
ve a
> separate functions for OMAP34xx, this helps us deal with the SDI case
> separately.

Could we instead have an array of the ports for the said DSS version,
assigned to dss_features? Maybe just something like:

static enum omap_display_type omap34xx_ports[] =3D {
	OMAP_DISPLAY_TYPE_DPI,
	OMAP_DISPLAY_TYPE_SDI,
};

The index on the array tells the matching 'reg' value.

 Tomi



--GhX5XKH4egPTauKiawJr0PPHoW9t8sVXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTewynAAoJEPo9qoy8lh71+aAQAJoZM/PLVRxuKylbZbQ4VPii
LnytDKLQTuyV+As2sy91CRrA3v7TXJLpqTBVh0wSNeyAtw9OwTIovP3cSdx/zIvc
WcK+kqA+69sTx/MJJ5Q2uwADPDO8sI+K1EfDFAZDuDZq0afKbWehNOsRPO6k4Tyb
jL0wPb8R+kOLE+tfUCF+ukcmoC2KCnWcp1hO98Cv3zZP4X/cr4aVAZmN5NhMsahG
XRrqMoRxFEpk3uv+60kCD7j+e5oexNoVymA3+gWcHOn+M37tslajKYoZkf7XAR0H
yz2mpPcB/rChwMf98B6htRWFzujoPntxS+w77ocz1PSpPTkmaHJJECbWsRs6NB92
fziJyQRkRzOzfc3OQLT6gSe+BEaa6NdCfR978tQ07819dRbGBVoWm9JN35IYKhq4
nR2+h/pUkzKTqCbn/Bpd0k5DQY/YoVA3NRaL3mw6GXTIbQg97ERtWMrSQ5XiHMGr
m87FvnwVFxxyblSmMLs8jjKZEVIXgE7t4rBnDHnaP/J1XXhp6UydlCRvFFFNGXFd
rAyRejVeWNXFdep7M1j8IjcMg1cHR9P7mCg59W2JRaAxidcdog5B34BCeRwAfOAR
81zRH208tDLS3qYJimfdl+MktE5Z7R//tvyacyErxYctZGiwZ/bFYsZn/RFDdL8J
fqfQ23VK8bt1gyIn/0zp
=w9Op
-----END PGP SIGNATURE-----

--GhX5XKH4egPTauKiawJr0PPHoW9t8sVXg--
