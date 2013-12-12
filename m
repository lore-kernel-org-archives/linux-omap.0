From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/26] OMAPDSS: add of helpers
Date: Thu, 12 Dec 2013 09:48:30 +0200
Message-ID: <52A96A4E.1010006@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-11-git-send-email-tomi.valkeinen@ti.com> <4533892.HJaRcDt4Q8@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OHLOcccQebkoPWMTKxeuttuxGt4anx9xb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51305 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab3LLHsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 02:48:36 -0500
In-Reply-To: <4533892.HJaRcDt4Q8@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--OHLOcccQebkoPWMTKxeuttuxGt4anx9xb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-12 01:19, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Wednesday 04 December 2013 14:28:37 Tomi Valkeinen wrote:
>> Add helpers to get ports and endpoints from DT data.
>>
>> While all the functions in dss-of.c might be useful for panel drivers =
if
>> they need to parse full port/endpoint data, at the moment we only need=
 a
>> few of them outside dss-of.c, so only those functions are exported.
>=20
> I totally understand that it was easier to add this code to the OMAP DS=
S=20
> driver, but I believe we should refactor the existing drivers/media/v4l=
2-
> core/v4l2-of.c and move it to a non V4L2-specific location (what about =

> drivers/media ?) sooner rather than later. That's on my to-do list for =

> Saturday.

I agree. I just didn't want to go that way yet =3D).

Have you thought of the API? You had one version in your CDF series, but
I think that was a bit too limited (I don't remember right now how), so
I wrote my own versions.

What I tried to do here is to add simple ways for the drivers to iterate
the ports and endpoints with omapdss_of_get_next_port and
omapdss_of_get_next_endpoint.

But I'm not sure what the use pattern would be. If in most of the cases
the driver always goes through all the ports and all the endpoints, we
could as well have a helper function that goes through all the endpoints
in all the ports, and returns both the port and endpoint for each iterati=
on.

 Tomi



--OHLOcccQebkoPWMTKxeuttuxGt4anx9xb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqWpOAAoJEPo9qoy8lh71N7AP/jY9D9qYgfWTZbfUrJ6GQIK6
Tken/0aGCgvkU/gpW8Nwgru2jcaCcAcRBGWQiyyzLnz7B2dH/SEmRJdyw6cdMVLK
P6LKuabAQ1lmjPToQxBwH8oMbY9TT8ZPy1DvvnDSDL0f3jf6yYNQ2JkuPLc/Zxpb
knSgh/gveOdUS8XCrJwctzXO4CBRMkAE/TRR/pNFPxR/WMQX4TYph9FzHnYLlaj6
voyJDcGFaccWBb/o4wdLttZfmzG+LuRdBBVejWcWRB5NcBDMHPZx0pK5cfl8TkFI
DDE8I+WOaNM/2xf3dasQ1STE5Wkcac3O1fUEF+Qen+MGuk1k7UedSYfxeNXmTvSn
D665nc9CQgwAaqjXab6YZSSsugW8IXZUjeOfTMMHCvq0jquN/eFYYKKP9whEiHbF
goYB7pnCTw2sUc/L6/RPEslMwuzz37V48WzWy8W/INw9G2apH9eXTFIZtmwep85k
mJyMY1vEq335Ph7XAMSJEQCfLDVIAWKsgJ6fnKU6wgHw1w1wkjH+sBwG338oIbH6
A8nuWsYEUAB/RQQpQ3e27rSkBH/hD8KUYOgMd0Fqf1InzAbSG2VeLj5cRShHIKtT
QSVwtJwQjHZZF61RoR3X++GVP6G1FFGYLzXzZ7t6rFTKPu6C23JKHfCzd2AwptpZ
rqCbVUnCO8/9WMaPKCWk
=bydW
-----END PGP SIGNATURE-----

--OHLOcccQebkoPWMTKxeuttuxGt4anx9xb--
