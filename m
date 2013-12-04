From: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Wed, 4 Dec 2013 17:01:20 +0100
Message-ID: <20131204160119.GA9433@earth.universe>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 04, 2013 at 02:28:27PM +0200, Tomi Valkeinen wrote:
> Here's a new version for DT support to OMAP Display Subsystem. See
> http://article.gmane.org/gmane.linux.ports.arm.omap/102689 for the intro =
of the
> previous version, which contains thoughts about the related problems.
>
> The major change in this version is the use of V4L2 and CDF style port/en=
dpoint
> style in the DT data. However, note that even if the DT data contains pro=
per
> port & endpoint data, the drivers only use the first endpoint. This is to
> simplify the patches, as adding full support for the ports and endpoints =
to the
> drivers will be a big task. This approach still works with more or less a=
ll the
> boards, as the only cases where the simpler model is an issue are the boa=
rds
> with multiple display devices connected to a single output.
>=20
> Laurent, I'd appreciate if you could have a look at the .dts changes, to =
see if
> there's anything that's clearly not CDF compatible.
>=20
> The patches can also be found from:
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt

Will this be ready for 3.14? Depending on that I would handle
omapdss support for the N900 differently. If this code gets merged
into 3.14 I will update the N900 patches [0] accordingly. Otherwise
I would suggest to take the N900 patches as is for 3.14 and I will
take care of adding the omapdss DT support to the panel (and the
N900.dts) separately.

> [...]
> - No binding documentation. I will add them for the next version, if ther=
e are
>   no major changes needed. Hopefully the bindings are quite self-explanat=
ory
>   for people with understanding of the hardware in question.

It is :)

[0] http://marc.info/?l=3Dlinux-omap&m=3D138524030509240&w=3D2

-- Sebastian

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSn1HPAAoJENju1/PIO/qaxsoP/iw2h7eZ2o7IovmQo4dEK/tR
IMyJ9YC39plLGbvVK33WJgzWffcQFsMdKgwYScve8rJE+o479Qe8KCwWGsGk5p4o
HvpZYzmxL4RjmRV9gPKmBEbmcXR3FDkpvrKVyXED726YkMPG2QuUEhgDxgWFig8H
vCMAqqWnpEDTtcFs1jmc6GeRxwLlMfKHa+OzvzcRTr6hDP3f3cZAP2vXSzYQ8BWh
+7p3EEJxsQWv6O8fVtLLUYKiwKi3DEUH4bmA1jc4fH8Lad0tLif3He5DGYtgQIxg
wTa7z6t1ApnVFQMQUQmRoVhk5eGm3sgilShPnlEN4HsIPVcBm+RdpD2RL3pNCWqX
Nl1Nu1Me5CloPZYOtffdRifw2m+N6xClzVxDn9f2GyyhOwcu7lx0WWd47b531Slg
/suhW5MqYwcuEKsLU5OEuGPHb6vTOK5lnyScRcypHfifmVG61mI4xhn19uEa+5M9
0jqfoLZWCN+tF05ijHYhw84EDFYPCboohDokbWW/i9wh8p7TYf6jwgOFrVClsirM
5oLIjako5fJzw/KocgkYWBkIVduGesR9nnzoUa0kNb4wClpkEjmlTJufCDYPnXx2
C5oD3F/nkXt/R9KfoZjt3k7hYUwAR/n5/xlpHQq2mYL8DS3x7KnCSRgMWkxDgQ6E
I38ngL4fvCK+u4h5rV8n
=L5ls
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
