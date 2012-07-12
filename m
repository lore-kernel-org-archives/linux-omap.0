From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv11 6/6] i2c: omap: Recover from Bus Busy condition
Date: Thu, 12 Jul 2012 14:22:08 +0200
Message-ID: <20120712122208.GF2194@pengutronix.de>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-7-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340896292-12112-7-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2012 at 08:41:32PM +0530, Shubhrajyoti D wrote:
> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>=20
> In case a peripheral is driving SDA bus low (ie. a start condition), prov=
ide
> a constant clock output using the test mode of the OMAP I2C controller to
> try and clear the bus. Soft reset I2C controller after attempting the bus=
 clear
> to ensure that controller is in a good state.
>=20
> Based upon Vikram Pandita's patch from TI Android 3.0.
> I acknowledge the contributions and suggestions of Jon and Hemant.
>=20
> A couple differences from the original patch ...
> 1. Add a new function for bus clear
> 2. Ensure that the CON.I2C_EN bit is set when using the SYSTEST feature to
>    output a permanent clock. This bit needs to be set and typically it wo=
uld
>    be set by the unidle function but this is not the case for all OMAP
>    generations.
> 3. Program the SYSTEST setting only the bits we care about. However, rest=
ore
>    SYSTEST registers to there original state as some OMAP generations do =
not
>    implement perform a soft-reset.
> 4. Clear the CON register after performing the bus clear, so when we call=
 the
>    init function the controller is disabled and the init function will
>    re-enable later.
>=20
> Original patch can be found here:
> http://git.omapzoom.org/?p=3Dkernel/omap.git;a=3Dcommit;h=3Da2ab04192ba25=
e60f95ba1ff3af5601a2d7b5bd1
>=20
> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

This has to wait a little bit until I can spend time on the recovery
framework (which is still in the queue, sadly :( ). There might be some
consolidation.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/+wXAACgkQD27XaX1/VRsP5ACgsuigcz6tac0G0pqLAoyPd5qw
jRAAoLviENbfJHOoB5cJt+Hw0EkIr6qS
=Hghh
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
