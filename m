From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default status for 32k counter
Date: Tue, 6 Oct 2015 10:29:29 -0500
Message-ID: <87oagc2exy.fsf@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com> <20151005175230.GG18784@saruman.tx.rr.com> <87io6lf6i4.fsf@saruman.tx.rr.com> <13543270.oBfHhoNL28@wuerfel> <87612k3uza.fsf@saruman.tx.rr.com> <20151006151805.GR23801@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151006151805.GR23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony@atomide.com> writes:

> * Felipe Balbi <balbi@ti.com> [151006 08:02]:
>> - ti,timer-alwon:	Indicates the timer is in an alway-on power
>>   domain.
>>=20
>> Tony, care to comment if we should add timer-alwon to 32k ?
>
> No that should not be needed for the 32k counter. We should be able
> to do everything we want with CLOCK_SOURCE_SUSPEND_NONSTOP for the
> 32k counter.
>
> We still need ti,timer-alwon for a while for gptimers 1 and 12 as
> they are the only ones in the always-on domain. I guess that need
> will eventually go away too once we have a proper interconnect
> driver and are using genpd.

cool, thanks. I'll try to respin this series, hopefully still this week.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWE+jbAAoJEIaOsuA1yqREeIYP/RwKjr5kbsO5VAbJBdLwvpUh
0Vqb26/Zwhp7mSVUwdqBZFnUWqW8DY+IXicQByMeJDlcV9M/EchdR5l5tfHWH8rr
zMq9CFjta7KrfcH39HmXF9lzKKQEZ18n4GsE3Q9cUuWGAkvq2KgxQeR36F5FLxxC
53xPBixFPdZ1Lq9z9QHMvtrFPDvOx/Sz8qpXarPq6QRGDUs+n+Jgg5wB3XXl8bNi
PKr1kj73cQw6nZrqfzZmOsJyQTZbwNfUpLHww2JyxF0vGJ15gaKzQg4LtaP1P0eN
LBR/8JL7D0VlSo2MGtBQDcIUrG+6jKy2fvSMQvYIxKVWJf3v6px6h0aJAb2v7owE
qg/R5tGoZ6hG8C3X6gc0NgfVs82q0+r3sWhrDZ6lTnTOTiNOniSKIDqkoPvsyq6o
tPoKwuxqT5/+vEM/NciWbIAUvPqYj30+mN39BKjcFvCukPkEZHZjGxz3XubpxXJe
bxFXO3twz0nJI/O9Nx5KQWy29s0e8uQ7s9yVWvRoa4g5PkudNmfEYZarjAd/Daph
3HS/w4ots5Jz7wNhsqZdzvZ4jy0RDEIezsR7TNCOmE5KbvutouC5azSqmTyOK1C5
ZSyV/73PdUK72QRiOA0n/CU6yd+c1k508tRW5ZzxrGUroSUUlNB64763qP7fyWoi
h/KTdT+Dq4nb44KrQia1
=exLB
-----END PGP SIGNATURE-----
--=-=-=--
