From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: add bluetooth
Date: Sun, 16 Apr 2017 17:26:50 +0200
Message-ID: <20170416152650.5376wwhhdcbpdba5@earth>
References: <20170415221832.16175-1-sre@kernel.org>
 <CAEz3QY0duPa91TT3e86xA=tDGppiq0UXmDzuUm2i6cXbBi9CgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27d4wug236boznlo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEz3QY0duPa91TT3e86xA=tDGppiq0UXmDzuUm2i6cXbBi9CgQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Scott <michael.scott@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org


--27d4wug236boznlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sat, Apr 15, 2017 at 07:00:29PM -0700, Michael Scott wrote:
> On Apr 15, 2017 3:18 PM, "Sebastian Reichel" <sre@kernel.org> wrote:
>> Droid 4 has wl1835 connected to the OMAP's UART4 port, which is
>=20
> Technically, I believe the Droid 4 has WL1283 WLAN chip.
>
> - Mike

iFixit [0] has a nice photo in step 15, which clearly shows,
that its a WL1285C, with 1835 looking similar I didn't notice
Rob's binding does not cover wl128x. I will resend with proper
compatible value (+ patches for the driver and binding).

[0] https://www.ifixit.com/Teardown/Motorola+Droid+4+Teardown/7759#s31961

-- Sebastian

--27d4wug236boznlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljzjTgACgkQ2O7X88g7
+pqqGA//Ww82SoiL2DPhNwx3M6X4jQHSitUYjtQVZjLchXi6kY1SXIsFSfO9/oon
5tAUUNQThEzEdVHjgcP0q1ogBFakdhujHaF3ns9sMlj2pCrvdPwAzwnhebUClsNn
CbY02SjYrJEf8IS3ZqwmBvPgnL7wjSVljPnAB3R3uqv0z8658ALCUI+qIku+hWjL
iSoJubWe10ozAcEc6k2Srii+pImHZKJWBcHpNUdr4hDbdGZwXKJ8uik9RpDrRrEV
tbKf8uNCdK4nTYliOoTLZYIWjF8dqC+w4zBo8IOhILDsW57PVdOTHXwG8qTtzKqy
ccYRhmkvsYgp3YZIO0pslRGQmc5pz6AgDOLaRFs+SFZVGPEcQ0I73/sKJmMxvEv9
Y6DM8BU6L5jSFzmetD8MEF90fQICQs5n5yWVpQnNdXjGlkAKlK9jPwK0fe3282rz
iks42vFxDAXv+CXf3crV9uU8zlzUyswMWWK4G3cJVBZBNchIlaSEUsAMzX7BjiiH
AJLR5tFmXDaM8qQHuWG79XI1PSOT3S2A1bq6pdtUV6JQbrougNWd/nDrYTUQTjmu
b9ntHaFzl8sASmL0zYl12bRgT0ncR55yZJQDToiXr/rinEtBOH9lpg6xLMp5nswk
xZuv73G94EDtFAiLWTVHDG9vhq33HcYosWHD8gnW05Q437RzmzM=
=afKz
-----END PGP SIGNATURE-----

--27d4wug236boznlo--
