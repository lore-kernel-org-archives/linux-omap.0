From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/6] OMAPDSS: DSI: Maintain copy of video mode timings
 in driver data
Date: Thu, 16 Aug 2012 15:14:17 +0300
Message-ID: <1345119257.2534.24.camel@deskari>
References: <343817088-29645-1-git-send-email-archit@ti.com>
	  <1345102594-6222-1-git-send-email-archit@ti.com>
	  <1345102594-6222-4-git-send-email-archit@ti.com>
	 <1345116666.15132.4.camel@lappyti> <502CE016.6060404@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-v0lmn9B79eS1gyN8vpG8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:52178 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753855Ab2HPMOX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:14:23 -0400
Received: by lagr15 with SMTP id r15so1753498lag.21
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 05:14:20 -0700 (PDT)
In-Reply-To: <502CE016.6060404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-v0lmn9B79eS1gyN8vpG8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-16 at 17:27 +0530, Archit Taneja wrote:
> On Thursday 16 August 2012 05:01 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
> >> The DSI driver currently relies on the omap_dss_device struct to recei=
ve the
> >> video mode timings requested by the panel driver. This makes the DSI i=
nterface
> >> driver dependent on the omap_dss_device struct.
> >>
> >> Make the DSI driver data maintain it's own video mode timings field. T=
he panel
> >> driver is expected to call omapdss_dsi_set_videomode_timings() to conf=
igure the
> >> video mode timings before the interface is enabled. The function takes=
 in a
> >> void pointer rather than a pointer to omap_dss_dsi_videomode_timings s=
truct.
> >> This is because this function will finally be an output op shared acro=
ss
> >> different outputs to set custom or private timings.
> >
> > I don't think the function should take a void * in any case. If we want
> > to share the function, it should take a struct that perhaps contains an
> > union of rfbi and dsi timings.
> >
> > But I'm not sure if there's any benefit for that...
> >
> > So do you see us having just one set_timings, which would take either
> > the normal video timings, rfbi timings or dsi timings?
>=20
> I thought of having 2 timing ops, one is a standard "modeline like"=20
> set_timings(), and the other a vague-ish set_custom_timings(). For=20
> us(OMAP), we need to use it for DSI videomode and RFBI, we may reduce=20
> that to only RFBI later if we calculate for DSI timings automatically.
>=20
> For these extra timings to be consistent across SoCs, we would need to=
=20
> align to get a common struct of some sort, which could then have unions=
=20
> as you said. For now, I thought having a void pointer might suffice.

I would only use void * when it's a must, i.e. when really anything can
be passed as a parameter. In our case, I think having just two separate
functions is best.

I think the timings in videomode and rfbi structs should be SoC
independent even now, at least more or less. But you're right, it should
be verified. And any names in the structs should be according to DBI or
DSI spec, not OMAP. But this is for later.

 Tomi


--=-v0lmn9B79eS1gyN8vpG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQLOQZAAoJEPo9qoy8lh71MMsP/1lmbY+x68a3Xw0SlKcJDWcJ
qHw+5eVTv1A/3pCO0LB3hu0PrZUA73cHLx9Ex7o9h9NTQfWHKAJ9uBhyUPzXud1G
4MnYcC7wGEyJnfEKILxogaE4iWuxv3v8lYb0IKbmMGe7/MDxfsclN1r+4dAMuLib
II3+svvX9UMb/5UHxsPxKxE+rxaAzUCR46/zUILSAowSZ0VCWnyR8C7Pu/YnDoox
5AImOaWSkJUjWosP+Pr+1gZb575sBxBDGmwro8qFFSzG/xGbTvLS7VjHPY0oNM9L
tKFvOF6Kq37bHFkteANWRwOLaGlktvtF3RH0wydBOPebeorE/dRIszWHwlhIrH4j
HUVKOKX8xG+EMPjRJhaQHo/tCZPmMXKUGLMDz0bq1p9APkhDIwrwLLNKdYAvHXHn
XVaYrxcXjwZRgCzhIXdFmLSkl2ci+UxfJf6ITkP0SCqDSQqZG8ntcdylMMq55WPx
M9umLTtUjteR6vPj+xoExpQ+55LjV8uELqzZMNgsOoTMYZ4G8BSmhjcEQmRResS6
8JyOY6K/FjGOBkDljZA6ThbE74u4NOhuEAJjSQsdseQkQpIdAtw0IAat+hgt3wnA
9u09HV8oIhJs9ABHnD886Sp0Mw+w5ND8KdP2sHDDPOCjMwzOBwwzr1CU1Zbkmrrl
FpQ7M198P/pMCvpIIebq
=Z0H9
-----END PGP SIGNATURE-----

--=-v0lmn9B79eS1gyN8vpG8--

