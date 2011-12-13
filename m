From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 63/65] OMAPDSS: APPLY: add checking of ovls/mgrs
 settings
Date: Tue, 13 Dec 2011 13:16:21 +0200
Message-ID: <1323774981.1877.53.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-64-git-send-email-tomi.valkeinen@ti.com>
	 <4EDF64AF.6040008@ti.com> <1323332965.1867.20.camel@deskari>
	 <4EE722B5.3070606@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-gs34kQ0ZqG51mBvsQgem"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42433 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751634Ab1LMLQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 06:16:27 -0500
In-Reply-To: <4EE722B5.3070606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-gs34kQ0ZqG51mBvsQgem
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-12-13 at 15:32 +0530, Archit Taneja wrote:
> Hi,
>=20
> On Thursday 08 December 2011 01:59 PM, Tomi Valkeinen wrote:
> > On Wed, 2011-12-07 at 18:35 +0530, Archit Taneja wrote:
> >> Hi,
> >>
> >> On Tuesday 22 November 2011 02:52 PM, Tomi Valkeinen wrote:
> >>> Add checks for overlay and manager settings. The checks are a bit
> >>> complex, as we need to observe the bigger picture instead of overlays
> >>> and managers independently. Things like the used display and the zord=
er
> >>> of other overlays affect the validity of the settings.
> >>
> >> Minor comment:
> >>
> >> dss_ovl_check, dss_mgr_check and dss_mgr_check_zorder don't really
> >> qualify as functions which do actual applying of configurations, they
> >> could be moved from apply.c to manager.c and overlay.c.
> >
> > I had the check functions in apply.c because they used apply.c's
> > internal datastructures.
> >
> > However, looking the functions now, only dss_mgr_check_zorder() used th=
e
> > internal datas, and the function doesn't even use those variables for
> > anything =3D).
>=20
> Also, the function dss_mgr_check() takes 'struct=20
> omap_overlay_manager_info *info' as a parameter but doesn't use it. We=
=20
> might want to remove that too.

Right. And the dss_ovl/mgr_simple_check() functions could also be moved
outside apply.c.

 Tomi


--=-gs34kQ0ZqG51mBvsQgem
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO5zQFAAoJEPo9qoy8lh713BQQAKZzmY+OOgoIZhpXNsFvhhs8
hd0OL54L8qMBmoOMo00w/rUJJ2RXBvyBoEne9umr6qw2Zcirie/6wKWUiuzfEApu
C0CWDWFKRdC+lH6LHbOlxfp96DTU3ACEQq24adgz27ERyiDY/virgyDlrbDmrd7z
x56h/D1K7NNPAt6O7cTR/zcFiPxXD4vYvAJ2D3okFeq+0Yh/vQoYEQaYreXT7i85
RKMWOc4K22XGnZVmvOWujG7Cp5a37PpUiIJoLjAUAVJOYs0fzqYXLoj/mC3k4D1V
6AtDr9PQYw7XsfWyxZo6stngaSRgbNJ7iU/sxe+RNmlz/4z7V5LiG9EWu7X+W8M6
pg3qo/W1cNOGH45WQ+bE/TdtbJK7s4IP1/IA9ae+3saz5U8GCk+5dxVqXY+Q4hNo
mMlrDNJYB5VDwRc1tLCV6er5lKLf4wH0XvdsCcQjFCapJtmGnoWOKDfxJUCVp3Dj
bNvcvhjd9BlOOdyhtMDq8ItjNakljLC4kobqj3M2IA/clnShRKg+S+oi9QSbg1pO
oip/TP5T1x+PPmVpZCfev+1lYsjDZ3EjTh/lybTxD7z167unQAjmqNdH99DiAiAn
MN6pHj/ciaIR/QSZKHD4dvRVvHm+ylQhedONi9IyopJ5G/sFW84XNqMTN3fEf7xk
qQ3uOV16TAfTroLCt5x8
=HOH8
-----END PGP SIGNATURE-----

--=-gs34kQ0ZqG51mBvsQgem--

