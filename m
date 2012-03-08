From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/21] OMAPDSS: clean up the omapdss platform data mess
Date: Thu, 08 Mar 2012 10:33:52 +0200
Message-ID: <1331195632.2354.37.camel@deskari>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331124290-6285-9-git-send-email-tomi.valkeinen@ti.com>
	 <4F57A4E5.6070201@ti.com> <1331193777.2354.21.camel@deskari>
	 <4F586B28.1050403@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-blCI/VIVOmh4xfZ/D/E3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:42593 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755361Ab2CHId4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 03:33:56 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so424873lag.17
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 00:33:54 -0800 (PST)
In-Reply-To: <4F586B28.1050403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-blCI/VIVOmh4xfZ/D/E3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-08 at 13:47 +0530, Archit Taneja wrote:
> On Thursday 08 March 2012 01:32 PM, Tomi Valkeinen wrote:

> >> why do we check board_data being NULL here and not in omap_display_ini=
t()?
> >
> > I added it for DT case, because then we don't have board_data for the
> > devices defined in the DT data. However, for now we always have the
> > board_data, and in this patch I should just move the code. So I'll
> > remove the check, and add it later with DT code if needed.
>=20
> Ok. When DT will be in use, would omap_display_init() be called or not?

No. Currently the board files create and fill the board_data, and then
call omap_display_init.

With DT, the DT data will contain all the dynamic, per-board
information. Something like:

dss {
	dpi {
		dvi {
			pd-gpio =3D <10>;
			...
		};
	};

	dsi@1 {
		taal {
			reset-gpio =3D <20>;
			...
		};
	}

	...
};

The DT data will be passed individually to each dss driver (i.e. dsi
driver will get its DT node, etc.). The drivers will read the data, and
initialize themselves with that, more or less the same manner they'd do
with the board_data from board files.

However, we currently have this "omapdss" device, which is not a hwmod
device at all. In the long run I think the omapdss device should be
removed, but for now we need it. And device has to be created in the
arch code, the same way it's now created in omap_display_init().

So with DT we need a new func, omap_display_init_dt() or such, which
creates the omapdss device, and also creates a board_data which contains
the ctx_loss etc function pointers. But the board data won't have any
display data, those come directly from DT data.

It's a bit messy solution, but it should allow us to have both DT and
non-DT working at the same time, with quite minimal changes to the board
files.

 Tomi


--=-blCI/VIVOmh4xfZ/D/E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWG7vAAoJEPo9qoy8lh71v5MP/1JiURgvDKUbD9MVCj6ZdS9G
gMdKqQYQL3NNMsaq4/oCJn3cIpy9xoD/upAq1hLQalkNQExvQjJMKKU/0e0s1KKS
/vNOuOqQF4HiRVZMnxF8XBw9IFD6OIuEfkqdotgNtVipasralqez62GmUUMN1dDy
XonSLcVSv3DhZkX6owtBtPdtx9oCjllaNUamydp+V4cSOyXqqE0xx9TkJYd1XfUY
EASbFEkYfAr8i0BNSpb+tUOpvWTItfCeW/CtzTuQNk4cqvOkUOfH25OF8jZmkVQG
AuP71ZVXCqi4iXqWTqGdHXmc+WUfh+Pdcvh0FSpH04ZjVGipTPF8t+03cmSKYF1D
k2DxTECcdSbpceG//mNwfbD+rj/B8a7GlM0eDaFj+B6w3vyxejdbOoK3Xdv1sIKu
UPhaphuPBUUEHtuB4iP0ylOk/9MRHYC1fzL+yHWquiemCLjXb9r4MTFLmmcA4yCM
v2HBWLT7htqlh/CF/vNMvtGNcFqqmLCohIDIOKdcVhvgQLKLcbLRukCf3BSws9op
Ipc8a2He1sBWMMXc+SwwsGw6v1vi/BLnzce1QNiIh/1zf1zx415/FrR1EKAZGz9X
NRn/yCSGSq5OoChwioQkJfxyv0Ub9Ov9DAoAi2ZrBhBTkuubVf+UVwFfwTrB6d3e
EGRti05MVImnsMm832zR
=I1tl
-----END PGP SIGNATURE-----

--=-blCI/VIVOmh4xfZ/D/E3--

