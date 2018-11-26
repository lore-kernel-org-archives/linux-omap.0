From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv5 0/6] omapdrm: DSI command mode panel support
Date: Mon, 26 Nov 2018 23:45:39 +0100
Message-ID: <20181126224539.557iafey44mqx3mm@earth.universe>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <d566cd03-8348-ffa9-8798-3483a07741d1@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5oam3d2sfgetcsle"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d566cd03-8348-ffa9-8798-3483a07741d1@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--5oam3d2sfgetcsle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 26, 2018 at 11:34:30AM +0200, Tomi Valkeinen wrote:
> On 21/11/18 18:09, Sebastian Reichel wrote:
> > Here is another round of the DSI command mode panel patchset
> > integrating the feedback from PATCHv4. The patches are based
> > on 4.20-rc1 + fixes from Laurent and Tony. I dropped the patches
> > for OMAP3 support (it needs a workaround for a hardware bug) and
> > for automatic display rotation. They should get their own series,
> > once this patchset has landed.
>=20
> Thanks. I can pick 1, 2 and 4 as fixes.

Feel free to pick up any patches in any order. I can rebase the
remaining ones.

> I need to look at 3 a bit more, but it might also be a valid fix
> for the rcs. Although I believe the correct fix would be to
> implement check_timings for dsi.c, which would return the adjusted
> timings.

I wondered how a proper fix should look like. In the end I just
restored the old behaviour of not checking dispc to fix the
regression.

-- Sebastian

--5oam3d2sfgetcsle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlv8d4wACgkQ2O7X88g7
+prU7Q/9E+gTxeyN4QuuHPd3YImAUddnaKgas2r9KAdB/fmef627iRWf1HGg5CvU
KFuYeP/NxdGqD/FM5TeayBjVSNa8aMSJYZuokjDTxY3VqPDXPB4M/URmAF8A6O4m
Ihw7Ve49y+6jSDStc4VPxrC2fRFlMftBA1U9fnN60fsdvqIFZHR5G1G8n+EwfKav
/RcjDRmeXtnzbOyjRVNYscobumigGF/cTagSrKvBF+cHN8h9UE0jcTvmYsfxsFBy
N6tHNEwXJ2mPT1w3S+pIbDGdswaFI0oPpSxxftEmrMl7G4rdaJsoPRBe4lmqodPj
Y1b4YHF155ZWXDeESCw+tb3+EAGW5dVdRRU6JfobyvnXumd2elnxQBGg4tDDYOgh
aeS7ZAgEaiTbKmPcgzWgy2Bv0WWh/4q7iHsY8vocnJVRVHH3vNDN6YpvyIPGpk0J
E80sHaivcYFCXUvX+NbbtCewg7v+eFLEVTEm1xNOcr4YzGe6bYLReNFhpc1ajTeh
jR98DfMG9/6fDnl0vY0YEahslsaSXlpMtMWahPd1lx8tDT38wLR0WJsYeemiZoZO
6ypnfhzErUzagYZ+9eUj2AQvSooOD4JOGtaaqnF/Ev8CISesHsR4/2ZkZVOi0yIA
lTjFdaSP+gM1/LA4mxv5nrZoTqJVy8vJltMxkZIDapzKZpHZZks=
=LobM
-----END PGP SIGNATURE-----

--5oam3d2sfgetcsle--
