From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
Date: Thu, 23 Mar 2017 09:42:58 +0100
Message-ID: <20170323084258.ydlymcjtvdl3zih7@earth>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-7-tony@atomide.com>
 <20170319012927.kmyqngprpip7le4m@earth>
 <20170319161030.GA20572@atomide.com>
 <20170319225542.ts53qpwdhdrmy2ac@earth>
 <9c4a5d88-4d2a-2120-9fdf-f3fbba69147c@ti.com>
 <20170323063109.qhwxj74pbfztgopt@earth>
 <b4666cd6-9925-6143-41c3-591e68c48456@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lxkwbwyaljtvk7gn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b4666cd6-9925-6143-41c3-591e68c48456-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--lxkwbwyaljtvk7gn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 09:08:18AM +0200, Tomi Valkeinen wrote:
> On 23/03/17 08:31, Sebastian Reichel wrote:
>=20
> >> It shouldn't matter when omapdrm is initialized. omapdrm should wait
> >> until it has all the displays.
> >=20
> > I tried to trace this. I assume, that your "should wait until it has
> > all the displays" refers to the code in "omap_connect_dssdevs()".
> > Unfortunately that code does not work correctly:
>=20
> Indeed, sorry about the confusion. Apparently I was talking about TI's
> kernel, which has fixes for this.
>=20
> I have actually posted the patches, along with a lot of other stuff,
> last Nov. See "[PATCH 00/36] drm/omap: miscallaneous improvements"
> series. The patches 23-25 should fix this particular issue.

Ok, I got both initializing correctly by cherry-picking (and
rebasing) the following patches:

drm/omap: Use omapdss_stack_is_ready() to check that the display stack is up
drm/omap: dss: Support for detecting display stack readiness
drm/omap: move dss_initialized to omapdss-base
drm/omap: add omapdss-base.ko
drm/omap: dss: Functions to check components in the display/output list

What's the plan with regarding patchset?

-- Sebastian

--lxkwbwyaljtvk7gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTio8ACgkQ2O7X88g7
+poElQ/9ENa8z6sjOMJUf0eLypUpiyvXh5bpsoM+EUClJmE7Qj8iunO3289rT05g
23YlqjdKD7RfbGCAck6zyabsFbplKtnlWBZDE0bxeatP2Oim/O7WKvirxp+5cg1j
/B2rnpcNoxk50whfYQLWyOZaXJjF5jo25xbcs+mXBRMlk1ydGXLFY0g+ga74/CJp
GNGl1hWIHrS2JPcqrJeeIcJ0/Lceo0JisFNaxLnR4rCOMYH4XS0Kva90xTP9xXUU
43OmAtVJor7XRygc+7db9pNPwxFzV+K8R6Hp52VUujO1eg6JN260HviYWAaCZy0E
6eWpAu/Q4pG3YP8TAC+vV3YMS++EGji0x5/G2rHXt53S8fbjJ3wpMKBoMbut6WuY
KZMR9bjaeY3pzrUP9rQdWgOX4v5qsAaWo+cJR0dxwN84FOK+wk3AJO0JF+/K/EBq
/mHMvfHY4aEboERsi2Ap4MoZ/OdI1Zp5BHEqyYd8Vte4/x5PJi3YdJhpwiK7e86L
Xfuc9VRO5INaWVVPtz8Kn5scazIEuhb910MBHhokpwJWyO1MMHukBYFvRmJvVRxk
04yjoyqeB6nyOaVzOsJ9wWDbVsDZ3aKGhkl6QpZnodw/sP9qPgoBfi2ajJpfWBNY
6bXiWZCpIoOVR39PTa+shRXAXqM1DXwWniDcHXpYr7kaN6iLDeA=
=664m
-----END PGP SIGNATURE-----

--lxkwbwyaljtvk7gn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
