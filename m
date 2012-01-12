From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: linux-next problems
Date: Thu, 12 Jan 2012 18:05:18 +0200
Message-ID: <1326384318.1896.20.camel@deskari>
References: <1326382689.1896.12.camel@deskari>
	 <CAK=WgbbJsfdcjv86y6PC2w1jxCyApL-LFj8PvoKSQDL2e7m4iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-wflH8xajE0/yCNVVm5eZ"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbbJsfdcjv86y6PC2w1jxCyApL-LFj8PvoKSQDL2e7m4iA@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Tero Kristo <t-kristo@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-wflH8xajE0/yCNVVm5eZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-12 at 17:58 +0200, Ohad Ben-Cohen wrote:
> + Stephen
>=20
> Thanks, Tomi.
>=20
> On Thu, Jan 12, 2012 at 5:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > I was trying to compile linux-next for OMAP, but it doesn't compile wit=
h
> > the default configs.
> ...
> > drivers/remoteproc/remoteproc_rpmsg.c:100:6: error: too few arguments t=
o function 'vring_new_virtqueue'
>=20
> This is due to a recent change in virtio.
>=20
> Stephen, I guess this won't be relevant for more than a few days, but
> can you please take this patch below to linux-next ?
> (alternatively feel free just to squash this to the merge commit.
> whatever is easiest for you.)

Why don't you just update your for-next branch, and it will be included
into linux-next automatically?

 Tomi


--=-wflH8xajE0/yCNVVm5eZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPDwS+AAoJEPo9qoy8lh712UMP/35xMZutftmlyqHv4TJe+nAd
hcMFK/hCCDU2RpSNJMUUS+ps8J7BzS7axxHl28rgZjU26fqBU0HGEaST/h1CdIrn
SiJwBU8m7HYcN+PevKmEZt3eEy2bw/JgSczdm5HGFh/WVT6Uf6d39l11PxWLN1Sc
e7okSVj1OxieVwpGS/Q45cXTsyLyaJ9+lT3SiJ1qF2om18QgZYesOdsV+D5Va7Y5
J27G7bNdcwm9mWZoQGNayWf1LyEjP49YMPx+D27aYMXVvy/FZuJOKNIG0ra/i1CL
XOj27FzNVvUB8fNP3KTvqtjGYWdztvJUnVpy1wL1kJFckTgby4oCTyW/T9u5p2dF
n7sn3oMbJkvd2t99Jy2f1hKZhF+stToggRVq77FsUE7CQv3/uaJ2TQCe5IpgYqze
KBqQji0RsgFO6uNPqBYH/FE/4akPvL0nSOkcanjz5oRmCgTJiPZ3Akdw6I/ioXLU
45Tws7CnwjInfeRq2Cml4XaXrfvR3gEJBJm00oqEwVtWBWzmHCpTOg2dMbQun+aN
YpxrzYdaARuNeRXXibeWm24sQ8nm2Pil05IOXaqqppzlcl1ZvuyID4ns6O4REauw
vHAq4lmWHA+T/1BExur2oEP+j2wwSajiAtJDxWxUO4TIVrxjLOeGJgavkzsGWaXW
QdYsMl7diBObR+HxhcPe
=i58j
-----END PGP SIGNATURE-----

--=-wflH8xajE0/yCNVVm5eZ--
