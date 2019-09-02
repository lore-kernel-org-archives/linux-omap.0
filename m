From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/6] bus/ti-pwmss: move TI PWMSS driver from PWM to
 bus subsystem
Date: Mon, 2 Sep 2019 17:02:45 +0200
Message-ID: <20190902150245.GE1445@ulmo>
References: <20190901225827.12301-1-david@lechnology.com>
 <20190901225827.12301-2-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190901225827.12301-2-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2019 at 05:58:22PM -0500, David Lechner wrote:
> The TI PWMSS driver is a simple bus driver for providing power
> power management for the PWM peripherals on TI AM33xx SoCs, namely
> eCAP, eHRPWM and eQEP. The eQEP is a counter rather than a PWM, so
> it does not make sense to have the bus driver in the PWM subsystem
> since the PWMSS is not exclusive to PWM devices.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>=20
> v3 changes:
> - none
> v2 changes:
> - new patch
>=20
>  drivers/bus/Kconfig                           | 9 +++++++++
>  drivers/bus/Makefile                          | 1 +
>  drivers/{pwm/pwm-tipwmss.c =3D> bus/ti-pwmss.c} | 0
>  drivers/pwm/Kconfig                           | 9 ---------
>  drivers/pwm/Makefile                          | 1 -
>  5 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/{pwm/pwm-tipwmss.c =3D> bus/ti-pwmss.c} (100%)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1tLxUACgkQ3SOs138+
s6Ex9g//T+ZKzUz859zn7FRpj13m+ndi84IulhyCYr54G2sXpuiLxVOo9q9WVI/v
QNkuu8KOb1W91FXpJudcY4eagg0PoJtE0/8u2kO7PX9QNe5vMoUbIm0j/CrMJH1O
3RJEfArqrHlRIfWxik5gkAnbVMvkhTrEv+zVUZyNAQFNua8qw1mTCSDac+iX7QLH
/zubXqDPaDP/FCq/avt+hB4Rlzywv6G6GFzs4boUjwXN814RsVTdf2XBz8Hx+So2
a3o0Qtht/NVcO5p1/UM/Ps9JChuTHB0gy7/pOe2sx3ayQ7Nd/wgcUsaVkwOlQ02z
emSxOqYCLze1rHba6O1iqJb3QwKKVaIFfswfH2xSy94gSCZZmExukdDfVRunfQcS
YO//p3px8p8wdxUR3E6CwgylIo8QlQthMLEywC3BZkVR29W/bE7301GfDEw4MmQa
kT+GmJF4Fh1Zp7WYMsD4peV71pEAvycWO56CS83uSOSJ0kF0gGG6f9SFuIqD/lYj
Zn+ODFy5c3VEbSfOIUBtKy+IFG5lhYhjXHc9SfPXAtk/5Mybv2/NI9hP8PtKbRRN
q/wfXpZ/S/C+rRJ00HkO8druk8zMfts87+q5XUMg/Sr3OixDQvW4qT4T2bKUzRBB
bCA5jRYdMVnX2eAdrMNsZY2ZQL+/3YF3B2j5R8ZmWTIP1AI2xsQ=
=6nvw
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--
