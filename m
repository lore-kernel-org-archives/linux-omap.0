From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv3 0/2] Add cpcap battery driver
Date: Thu, 8 Jun 2017 13:06:43 +0200
Message-ID: <20170608110642.smjb3txlrpmz4chs@earth>
References: <20170601001921.11091-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5bwbupd6mni47t3"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170601001921.11091-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--r5bwbupd6mni47t3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 31, 2017 at 05:19:19PM -0700, Tony Lindgren wrote:
> Here's v3 cpcap pmic battery driver.

Thanks, queued. If you send *.dts patch for Droid 4, don't forget
to add power-supplies property as described in

Documentation/devicetree/bindings/power/supply/power_supply.txt

-- Sebastian

> Changes since v2:
> - Fix binding doc as noted by Rob Herring
> - Separate the binding doc into a separate patch
>=20
> Changes since v1:
> - Add support for battery low interrupts
> - Fix POWER_SUPPLY_STATUS during charging to not flip constantly
>   by using average current
>=20
> Tony Lindgren (2):
>   dt-bindings: cpcap-battery: Add binding
>   power: supply: cpcap-battery: Add a battery driver
>=20
>  .../bindings/power/supply/cpcap-battery.txt        |  27 +
>  drivers/power/supply/Kconfig                       |   8 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/cpcap-battery.c               | 808 +++++++++++++++=
++++++
>  4 files changed, 844 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-=
battery.txt
>  create mode 100644 drivers/power/supply/cpcap-battery.c
>=20
> --=20
> 2.13.0

--r5bwbupd6mni47t3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5L70ACgkQ2O7X88g7
+prYlA//UIyrrq1eEZVHRRjTSa5AsofSJjwBfRNKtx+ONfBTIbY8md8QtlgECfjH
dyGkCsJWmTEqndUJDCPoyrkxqlSiW8qeCW1HqoB9w1f4hIWrZXRwHQIRc9CjwDHO
7b5umcFHUmJZruRtJJG98rYn0OMVSvH1nZO502yL5IWZmdXRl50KbK9NSfFrPym1
XDX8cnWsMzBez84HJ/8VO/qN8jvYeO1959XsLhkCI04FFhNK+7x5KK28dBVuYO56
6lrZ5/V+tp9WlC+qa4UydAcbh29Tq6TvIixqV34TclV+Ew6YyQ7tbX1Lbv0JjGjt
R1XHJBz9Ort+WzbCdruJlhIB5kcqPAKRG7Tl4cAIhw9ve0AwBvnpCGyWS3XfV6Jm
OY2O+MX85sYAdRVDpkQUk4ifuQJhl8NIiWm5epkrmk+MtuBamPFsvA8DXM2HG5+U
+I3iEl/CzIyaluYhrcTEpBJwU9Sadw5yKUUbnGlCS8drnKQSMNC8kdz6va3T3bIp
p0TsyVfO9vlle35Gchkx3CtPon/FIpnQYfXxFTULrgF/V0OoUxAHQQzaW79yH6iM
lFkVJXn3wQPGkH4SggCCPDCfv8Uqh2ELpOdmBHHZX+aPHJGua6F2fY1OEdfvC6aL
ame+dtl97ECM1yVQ+a6CTkJgZ5dj8FjC6yBqpVeFPRc5My7V/1U=
=0ZAV
-----END PGP SIGNATURE-----

--r5bwbupd6mni47t3--
