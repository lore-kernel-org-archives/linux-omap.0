From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1] ARM: dts: omap3-n900: Specify peripherals LDO
 regulators initial mode
Date: Mon, 18 Apr 2016 07:11:46 +0200
Message-ID: <20160418051146.GA3215@earth>
References: <20160417122933.GA8093@earth>
 <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 17, 2016 at 05:29:23PM +0300, Ivaylo Dimitrov wrote:
> Without that, regulators are left in the mode last set by the bootloader =
or
> by the kernel the device was rebooted from. This leads to various problem=
s,
> like non-working peripherals.
>=20
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXFGyPAAoJENju1/PIO/qaS5MP/1IamRu4v72Z2QKdDpfmCKz9
dnEar9Mz2XvBPI24XDWZPyh9RUxtKP89onAawzh0TCgSsxzFmRKEqC89ZWwrmSU/
/436lhnXfLHcwNieXIwlexPQ/qqI7QYt0zVd1DAn1gmbaiyQu6YEgARvgEonJkkf
tRMINsGwuCn63ZI1LRpuUSYmH0X+gpkZySeVaJeqrvfG79jwVHElHIssQ6kmwx8A
uAvFk3XtFNoQsG4naIRwxUnGyxC1R/ISfGRrR9Gfqst7rZIbHY0ZuHSACDdtWdhL
qyfGlFbBiYiAwsQbhPlkgJvTnVN6mKthhqxuqnDVLfKUUsTuZ/QGBBtReP6u0bOx
Cgk2Yr6gbivHWdgJ3fPXqkVPKqtWNDLThoxs7G5E/psldPCXBZqp6MBDyJVGzPXy
UF52rBvsEXy+npM7i5dZDmpAA9UsnMeZNq4qjLwJqUiqX2gFa2c7g62xDgzgpILi
W5w0OQPbS5U+NCkL0ctYXsQSxp5m1WBTA5u5pYO/snmK3awXPOU1Op1+/PI8zOyR
nAB8VJBp6NkCA1sSgV6lpfwUr5IApeCnxRq8XMOz5I4a4ithvrC3Bck8JRI6reKS
AREZxC1v+c9BScTOAvCJdJa5yStYQKpvX214z33qnSjpwCxcp0Gk1m748vUHELs9
a8ijIOQhN/wlBarZykQI
=GlPE
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
