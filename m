From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] video/omap2. dispc_mgr_enable needs runtime PM
Date: Thu, 05 Jan 2012 09:40:22 +0200
Message-ID: <1325749222.2045.31.camel@deskari>
References: <20111230123755.384a5b5c@notabene.brown>
	 <1325663456.1875.14.camel@deskari> <20120105183241.751b8086@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-4hW20yH2Idor9ZbixMOX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48413 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754857Ab2AEHk2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 02:40:28 -0500
In-Reply-To: <20120105183241.751b8086@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-4hW20yH2Idor9ZbixMOX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-05 at 18:32 +1100, NeilBrown wrote:
> On Wed, 04 Jan 2012 09:50:56 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
> wrote:
>=20

> yep, that looks likely.  The 'disable' routines of other panels only call
> omapdss_dpi_display_disable() if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_A=
CTIVE).
> This panel calls it unconditionally.  I guess that is the real bug? (and
> putting an appropriate test in fixes it).

Yes, that's the bug then. The enable and disable calls must match.

> Thanks for your help.
>=20
> (If/when I get this td028ttec driver cleaned up, would you be the one I s=
end
> it to?)

Yep. However, I'm currently working on device tree support for omapdss,
which will affect all panel drivers, and I may reject any new panel
patches until the dev tree stuff is in. But please send anyway =3D).

 Tomi


--=-4hW20yH2Idor9ZbixMOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPBVPmAAoJEPo9qoy8lh71uhQP/0zLJhfvZ0eFM9At+qGIgpMo
TK++Jj01PWk8G+h/zaRQIpl0pYsWbaPTlzywpfvqKnUl0bw4nmYSm63UKB3SxwlL
UkoCPn0Tu8Wr0yC3syfStJqwIiGjlgLfWPIRWoq69SgRnKCHaQUBevIfHGTRK4DZ
UGzxN+3qElsgEk0eMRtm6BU0pGhsOfKLEX8CD6J0iLrZVVMnL8imoh8yAYa23YiE
iejUPkIPLZTuE5gA7M0A6/M7+a+knfCfwlk/DYFIkzKxy8WeM2A6QKAXPRIKjEc4
he7rO3vx8uhTyX5TP/8YG0YDfpkPOy8yj4SWARo6jEuUgFDh6ZnaOwBjHKL+bEDx
AHkQMt7ZOkE8fgYeX2PhlElFe8VGNJNcRQknOUJpm4jlubkZSL9DaPowUpX/fRzb
Z2HVqCYCBDf/lXmCd+SPiN82j4ifgaeKIXIAcIvOFqAJWHWxYMfASpoImX4R4eO0
7H163x9h+01ztu9Up7nLkPWBTuBfitRSMZcM8AT9hXlPqkCYkjbTpHuGK9JKD9AI
Xn0LlhoDg1DN5exh637CCr21DR2nirn1IFKilQm822AiOlTQwaiCI1MnXyZsqTDw
/eH94VtL9T+6MYFHqq0LwDzp4S7djJ2Ysgfgm6oUwnHN1b01Jc5rUDj06c0aA6uj
O1Npy/mpuXNrspEUOrsa
=jALi
-----END PGP SIGNATURE-----

--=-4hW20yH2Idor9ZbixMOX--

