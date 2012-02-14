From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Tue, 14 Feb 2012 13:57:58 +0200
Message-ID: <1329220678.1845.68.camel@deskari>
References: <1328854552-30714-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-HTNS9QhKm8GCyImYZaWG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48303 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab2BNL6D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 06:58:03 -0500
In-Reply-To: <1328854552-30714-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org


--=-HTNS9QhKm8GCyImYZaWG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2012-02-10 at 11:45 +0530, Archit Taneja wrote:
> For DSS clock domain to transition from idle to active state. It's necess=
ary
> to enable the optional clock DSS_FCLK before we enable the module using t=
he
> MODULEMODE bits in the clock domain's CM_DSS_DSS_CLKCTRL register.
>=20
> This sequence was not followed correctly for the 'dss_hdmi' hwmod and it =
led
> to DSS clock domain not getting out of idle when pm_runtime_get_sync() wa=
s
> called for hdmi's platform device.
>=20
> Since the clock domain failed to change it's state to active, the hwmod c=
ode
> disables any clocks it had enabled before for this hwmod. This led to the=
 clock
> 'dss_48mhz_clk' gettind disabled.
>=20
> When hdmi's runtime_resume() op is called, the call to dss_runtime_get()
> correctly enables the DSS clock domain this time. However, the clock
> 'dss_48mhz_clk' is needed for HDMI's PHY to function correctly. Since it =
was
> disabled previously, the driver fails when it tries to enable HDMI's PHY.
>=20
> Fix this for now by ensuring that dss_runtime_get() is called before we c=
all
> pm_runtime_get_sync() for hdmi's platform device. A correct fix for later=
 would
> be to modify the DSS related hwmod's mainclks, and also some changes in h=
ow
> opt clocks are handled in the DSS driver.
>=20
> This fixes the issue of HDMI not working when it's the default display. T=
he
> issue is not seen if any other display is already enabled as the first di=
splay
> would have correctly enabled the DSS clockdomain.

I think this looks fine, it's shouldn't have any side effects and is
easy to remove later.

Benoit, do you think we'll get the MODULEMODE mess cleaned up in the
hwmod/clk framework at some point, and the drivers could do without
these kinds of hacks? =3D)

 Tomi


--=-HTNS9QhKm8GCyImYZaWG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOkxGAAoJEPo9qoy8lh71zl0QAJ5JO5N9Y6yP66d6GUr9OP67
a2Cu3OmPB+7gXG1sHdYXA7mF1quI3hNjocvGOkDxPEHkZYF2K5JUSAiBZDdwqBWD
rGBtRX4aKa67UuqRnx4yF30WDBaPk1lKabqEStOmV51TQNXOALaAookpYIJfBrqS
2qiDj8Xlcqb1OkpGHE96fnKJe9y7XTdcSWGqnwy5MJ3oJVv79ELvEjEG9BwmYbsO
NcC+AwmWSgF08Gb6aiOvfbbiRTm9FjDmZeneTWXRrKiVwlSdiQ1+Zkdubeu+Rp/V
7Halo1maat+W65xHXSjlqRGSQ45l4zPpH6lvpzqbi4OR0ikT2NrrSGhUn/JPSdCN
rubj4o+wCW1Fz70bX0vnSM7AMfptIXUi68K18dWPkFtdme71DM67IwVD7i7S/J1o
5ZLbHIdWFz6Fi1bxH11OU0k1VbsIlFeeh1oCZ+Cn7Po6im987rkgwJiOyGBijJfp
MB3fnLGUHNfOnl9BkyXwvSHFZJKSaiKn3weWTNn9iRmJDblJKcEMMJHD81vYk4iD
e2fnobG5goJdDvYS1/bFiEDT6DfUdUHB6XJSsZuXIytYeSZIZ22sB1c6b+m0WPAk
SESUMurrF9j8UhToRCOieSWhSEZEYs++7gvOK+t1EKG7tWkSPPJjZ9qr50BoLjI4
OVZ/JQu79v7kC8FcmxP/
=vEpQ
-----END PGP SIGNATURE-----

--=-HTNS9QhKm8GCyImYZaWG--

