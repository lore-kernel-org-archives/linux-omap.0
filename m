From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Tue, 08 May 2012 11:52:31 +0300
Message-ID: <1336467151.5761.20.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	   <1336028864-13895-1-git-send-email-archit@ti.com>
	   <1336028864-13895-5-git-send-email-archit@ti.com>
	  <1336403017.3522.2.camel@lappyti> <4FA8A927.9080705@ti.com>
	 <1336461377.1896.23.camel@lappyti> <4FA8CD6D.3010503@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ANXbO4lKPUk3eWd/bvRL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:48916 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab2EHIwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 04:52:36 -0400
Received: by lagr15 with SMTP id r15so4581239lag.30
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 01:52:33 -0700 (PDT)
In-Reply-To: <4FA8CD6D.3010503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-ANXbO4lKPUk3eWd/bvRL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 13:08 +0530, Archit Taneja wrote:
> On Tuesday 08 May 2012 12:46 PM, Tomi Valkeinen wrote:

> > I'm not sure if it applies here, but as a general strategy, I suggest
> > doing things in apply.c that require data from apply.c's internal data.
> > When that's not possible, apply.c should call the functions outside
> > apply.c, and pass the internal data as parameters (like calls to dispc)=
.
> >
> > In your case, I for example see dss_mgr_check() calling
> > dss_mgr_get_timings(). It would be quite easy to pass the timings to
> > dss_mgr_check() from apply.c, thus removing the need to call the
> > function. And, as you see, dss_mgr_check() already has a bunch of
> > parameters, and the idea is the same with those: give the params, so
> > that dss_mgr_check() doesn't need to ask for them.
>=20
> Right, I can do this for dss_mgr_check() and dss_ovl_check(), but if I=
=20
> you see the misc cleanup patch series I posted, I use=20
> dss_mgr_get_timings()  in dispc.c functions to remove some=20
> omap_dss_device references. These DISPC functions are called in=20
> dispc_ovl_setup(), I could pass manager timings in dispc_ovl_setup() so=
=20
> that it comes directly from apply.c. What do you say?

Yes, I guess dispc_ovl_setup should get the timings pointer also. It's
getting a bit complex, but I don't see any simpler way. Especially dispc
functions should be quite self contained, dispc.c should not call
elsewhere, but it should get all the needed data as parameters.

> I guess we can get away from exposing private data in apply to DSS, but=
=20
> it might get a bit harder when we try to remove other omap_dss_device=20
> references in the future. I'm just guessing though.

We have two cases here: 1) using timings when doing apply.c things, as
your patches do. In these cases the timings can be passed from apply.c
as parameters. 2) using timings "outside" apply.c. I guess we currently
don't have these, but for those we could have a get_timings() function
that does take the locks. And similarly for other configs.

Of course, that's still not perfect. Even if get_timings() is protected
properly, there's no guarantee that the timings won't change right after
get_timings has returned. But hopefully all writes and reads to timings
would go via the same place, for example dpi.c. And dpi.c's own lock
will protect the change of timings while another thread is using them.

Btw, there's a typo in "OMAPDSS: DISPC: Remove usage of
dispc_mgr_get_device()"'s description, dss_mgr_get_device() should be
get_timings in one place.

 Tomi


--=-ANXbO4lKPUk3eWd/bvRL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqN7PAAoJEPo9qoy8lh71ijcP/294rAhVk1DyWZtd7fQ6zeBQ
8CF9L4FthUvD7IZxYDGyX9Ld9Me71B2I5xPu01WtYX0/lAa1IBEq6TgK3q5xAv2u
S9NP1PYPK5VkgbSHD5Fg0G/PRG82+uAnJR8ORmmChvPRZwqev6LaoWDCNH3vWHjA
4GJHEbGqY4ZRYgZvAFhV6+jN7t4MUNGwjGBJxDBc5IYvwQ4Da7HVcJHbUDd6reZw
8KeHoC6LJXAG7iJofwgLLNnhQm9UJ8Pm9Yk/ARBiZbXI24CBlAPUrYEABqKzu7vy
BXOBdNl4QcjOQz3ox+/GN3lH31Ipuy05WgtsXYweiVfYi0F61kR+a4w/tJB/Fmoc
FNjvGYqHukfScxBJ1TY5WqruQjrGqkRmEnbzLnuaAJoxSrjbKtTNH3Sn9k/qK15M
Pk+49pyMIK+XgNqGrD5qvKn1YXY4WDtzh+og4QhM2XF+4Y0x8FLdv0oe3co6LigX
FXtIzopl/Ic5iRZLcrxaRh6uaPWNZtMrJQhCeuMMlUuirLkmmpKms1L+FICvnuIH
fmH/vY0/J6gn5aF7Uxp22zT7FvHyi7RZ1R1iYDI1wdNIc9AM1ppeUcOKumOqT+8g
GNFJsaWT8H0+T7LJg4W2KOhagSOd0FiRtCC2qhsRRwnhhX/PWS0HqWohfdQms+1G
VzAZgDqrdqK2aKyFiy+u
=EBRC
-----END PGP SIGNATURE-----

--=-ANXbO4lKPUk3eWd/bvRL--

