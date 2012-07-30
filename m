From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] OMAPDSS: DISPC: Improvements to DIGIT sync signal
 selection
Date: Mon, 30 Jul 2012 14:11:56 +0300
Message-ID: <1343646716.8019.22.camel@lappyti>
References: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-do0HIPNpbkzFbR3fmUcq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:39276 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753232Ab2G3LMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 07:12:00 -0400
Received: by lbgc1 with SMTP id c1so2924785lbg.15
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 04:11:57 -0700 (PDT)
In-Reply-To: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org


--=-do0HIPNpbkzFbR3fmUcq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-07-27 at 19:21 -0500, Ricardo Neri wrote:
> Hello,
>=20
> DSS code wrongly assumes that VENC is always available as source for the =
external
> sync signal for the display controller DIGIT channel. One cannot blindly
> rely only on the value of DSS_CONTROL register as certain processors may =
not
> have VENC (e.g., OMAP5).
>=20
> These patches add logic to correctly set/get the sync signal based on the
> available displays in the DIGIT channel.
>=20
> For the HDMI driver, handle the error in the selection of the source.

Is there an actual problem seen that this resolves? If so, It'd be nice
to have a brief description of the problem.

Does the bit 15 in DSS_CONTROL still exist on OMAP5? What does it return
on OMAP5?

I think it's clear that dss_get_hdmi_venc_clk_source() needs to return a
correct value so that DSS operates correctly. But I'm not sure we need
the extra code in dss_select_hdmi_venc_clk_source().

dss_select_hdmi_venc_clk_source() should be called by venc or hdmi, and
there should be any possibility of using it in the wrong way. For extra
sanity checking there could be a BUG_ON() check in the
dss_select_hdmi_venc_clk_source() to point out if there's a bad bug in
venc or hdmi.

I'd like to keep the lowest level dss-internal functions as simple as
possible, and written in the manner that they presume they are called
correctly. Otherwise we'll end up with lots of new code, checking for
errors that can never happen in practice.

 Tomi


--=-do0HIPNpbkzFbR3fmUcq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQFmv8AAoJEPo9qoy8lh718rcQAK3Qw73OYbOl1F30GaFEJHKP
ZhiysGOFLfmU5OjKmiGm1GVJYQlD6zuy43q2sHxGuQv9CsLy3nBIAd7yqQIYM5MB
5XK3Cko37QtpCd+FdtDhrY1sexU1GmaJLr62IkFndgxvt1MSjjKnlW01A/4NBKk1
cP1usICbO19B77CWqkEhq4C+as2RqepDyFR8MbbS8JdnLkoAC95ypuugIrpy8U2r
BGxC0H0vO5vST39NAzmJbg0V/QwKUV6qZDqJLsVDzteabl4EtN3haeLsnhzzGzLi
Jl72fbDUi2jHvWp25Lsqha8zLrManSifZUaJOq4S8oS1UWEQj+k+TEhROesUS/sW
NZXguFnnPvCbJZc++6oICTjI+sUJSBC/Hr5rFerKp6Qtyzx2Pe0fYaTVsMoL9+9e
38IaXOSHC0dEpLM6ePVLdQpD1bG23OaZglXmeFrXA7Qg92Ve2Njg/ph5eaDj3bWW
JSxpWzcPJHEGWNCcAm6OQu01m443de9IxxeyVtlffKAKGn1j6NYPkd+yfOMDTDmc
9SGtKDedPLxqtNzEEgqW1gqprBiZ7UpwXprmF66Z9f/1p8XO1Mlww2hO23/GGck/
0Rle1fNmcZRF/3b47h1rM64ig6WGPQ/flzNVNjqEVeUg3ddFlPfl/EYELS8KJKLw
Xsb9zbQ9n28ujmg87pdf
=5d42
-----END PGP SIGNATURE-----

--=-do0HIPNpbkzFbR3fmUcq--

