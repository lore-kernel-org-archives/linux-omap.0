From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Vibrations on Droid 4?
Date: Mon, 9 Jul 2018 23:49:10 +0200
Message-ID: <20180709214910.tes6u4ivxomd3aja@earth.universe>
References: <20180709081534.GA6799@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="afdumk7vq5rawzdc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709081534.GA6799@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--afdumk7vq5rawzdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 09, 2018 at 10:15:35AM +0200, Pavel Machek wrote:
> Do you have vibrations on d4 working?
> I believe I have required drivers enabled, but no luck:
>=20
> user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> bind  uevent  unbind
> user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> bind  uevent  unbind

Have you checked probe deferrals?

-- Sebastian

--afdumk7vq5rawzdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltD2FMACgkQ2O7X88g7
+ppfow//VhWRvwAOGV4UPkWy2uJ9v7OZuPNp21Jd+JIaHXFzVr4yP9z3e4/cb7z6
SqEEroHTSu9cpAIewsTLBuCPyMmGc19sTC8NAldK5vdEHm+u2KxPyofzDEHXAjJW
pGwx82Zoo2VZdFuo6Pmql4IVGDnRDNHG3pisM7f+KrMwgGMmqc2p1EnqJUA49Hwx
UvfNcIRWlf0u9/LqlL+Nx8AbYLW8hlLWZgrYl0Q0Olxk+9r5HoZIajwno4QNVcR4
tb/zm6Mdx0KVVev70sGQfqmIMlQ6OZc5UPtIMD2HtdzinWyQ9hBD5/OS1GVaRNk7
qByO1HsCTQ1xCBVB0i+XWmo8i/LSBXayVdUgixhpHcuzekjIR+sAvPdcd/86PWyV
NRnKs1ywQ3MCKIdVgArmDzVu6P8mFBX543VBEgNe0nm7UUFgi5E7lvRJwN93zSyq
sG12jMJZPAH/l3hkSqFfOqWg9PerJ/rCgopRkGJJjyUWj/oW3pAbpBUSN+1y54Ox
ClD7Y0Sfs93aiUc+MM47v2Ct3VWWfMbViiztfAXbEN6CHkAHCR8xLCLOKwPoPcqC
rKc3iY1V0kpfjS3a9xo925y27v8oKexWikg8apZOmRrzmxTUgRIqiqjEtCjmgp7X
PlRLhqyde9oGwr7h9yvX1LPEvqgdGnVWszlSMBpsU8e+ykNH1Ug=
=GQ+z
-----END PGP SIGNATURE-----

--afdumk7vq5rawzdc--
