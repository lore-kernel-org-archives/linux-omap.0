From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to
 Kconfig
Date: Mon, 27 Jul 2015 19:36:26 +0200
Message-ID: <20150727173625.GC22086@earth>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-4-git-send-email-sre@kernel.org>
 <20150723123553.GE7576@n2100.arm.linux.org.uk>
 <20150724001605.GA1453@earth>
 <20150726225145.GF7576@n2100.arm.linux.org.uk>
 <20150727011447.GA23087@earth>
 <55B6011C.9070906@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B6011C.9070906@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Mon, Jul 27, 2015 at 10:59:56AM +0100, Ben Dooks wrote:
> > I think you missed the part adding the !ARCH_MULTIPLATFORM=20
> > dependency in Kconfig for ARM_ERRATA_430973. I only removed the=20
> > check in the sourcecode, since it is no longer required with the=20
> > dependency being in Kconfig.
> >=20
> > So I guess there are 3 options now:
> >=20
> > 1. Add !ARCH_MULTIPLATFORM dependency to Kconfig, keep extra check=20
> > in the sourcecode 2. Add !ARCH_MULTIPLATFORM dependency to Kconfig,
> > remove extra check in the sourcecode 3. Remove !ARCH_MULTIPLATFORM
> > dependency alltogether
> >=20
> > I will send an appropriate patch, if you tell me your preferred=20
> > option.
>=20
> This isn't the only place ARM_ERRATA_430973 is used, [...]

The dependency on ARM_ERRATA_430973 has been removed from
arch/arm/mm/proc-v7-2level.S in 4.1 (commit id e748994), so
that it always flushes. The only additional places are in the
Nokia N900 boardcode and the N900 pdata-quirk, which are
removed in PATCH 1/3.

So actually it is the only place.

-- Sebastian

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVtmwWAAoJENju1/PIO/qaEgkP/jXPKQieIb+NufYWmg4g/Shn
4NiauylJ1iw/daMUdWew6GyQVUGN0m2Uf/QOJV8+N1NZEOeLFMq9jXxaAyVlmWCq
W46EzCSJSiH0I5yx/Shmg0hXvUWL0lHdiESU7uf4HpR8wSmDJhJfkXqiutaUpUPF
M/+6+zfhJtXayh+i/cgaS+wsh6o2iQXIRTO1/Klq+HoEeuqk0iEeaYGN2SB/JmUN
dTDdDXmntkOY8lXYJZquCE0im4otsZWJkkZ6OuAgLZ3V+xlE/7vUtsvrv+Q4a3iZ
HPtuKdl+tj9nUhv5TO9kEhNyt9OPYBAZR8NBjcA4INU/JYRyqRj3H5bn7QatJBOD
OZuIZ86khvBTvRQ3lGUYSF3+YJ9nI8doovvgNzxqpfHihwSsqO2ehTSf67m36BdC
FND/ftRA8fsAc76xRlxPD581t7jxDZ9KWWh2hSlhuU5GWMLTjkFhqIeSXh8zCAj5
I4sirx6nJi7P51eYAQC2bX+jerBbZrA9szrdcAvawL8XN6LaXF3wYGfDfUbQqBKH
1Z4mCfx19MXxCyGPhUV864Al66Pc+T5wdY693PFT3kRXNgqqtjwFz2ANShkQAfb2
InUFFw+8Fj7AMqm2xpbH0m2YVOYonVlcKV/Ztzm5rHBxVsrRVjwQwUTCJCmvbDOo
s+fRFJsznWswpwxykH3B
=rdVQ
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
