From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] arm: dts: AM57XX: Correct the thermal thresholds
Date: Tue, 9 Feb 2016 14:09:01 -0800
Message-ID: <20160209220901.GC28102@localhost.localdomain>
References: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2016 at 03:15:05PM +0530, Keerthy wrote:
> The thermal threholds for am57xx are different from that of dra7.
> Correcting the thresholds for the same.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> Depends on: https://lkml.org/lkml/2016/2/8/90
>=20
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> Index: linux/arch/arm/boot/dts/am57xx-beagle-x15.dts
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:0=
5.514959101 +0530
> +++ linux/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.510=
959168 +0530

Sorry, did not bother to check, but is this the only user of am57xx?

Apart from the above:

Acked-by: Eduardo Valentin <edubezval@gmail.com>


> @@ -825,3 +825,27 @@
>  		status =3D "okay";
>  	};
>  };
> +
> +&cpu_alert0 {
> +	temperature =3D <90000>; /* milliCelsius */
> +};
> +
> +&cpu_crit {
> +	temperature =3D <105000>; /* milliCelsius */
> +};
> +
> +&gpu_crit {
> +	temperature =3D <105000>; /* milliCelsius */
> +};
> +
> +&core_crit {
> +	temperature =3D <105000>; /* milliCelsius */
> +};
> +
> +&dspeve_crit {
> +	temperature =3D <105000>; /* milliCelsius */
> +};
> +
> +&iva_crit {
> +	temperature =3D <105000>; /* milliCelsius */
> +};

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWumN5AAoJEMLUO4d9pOJWDLYH/1a7sE3jhwtfeZGroJ9hwtf3
tOnwVdPhx6jnxuEiOAucbHFlwt6aTdIVTT+Eq36jIL9Ssl2Sdqr4yiZWkU5bGeja
Co15ecHdJtgeMLnnTg0Aa1SZeaLOWA71xxHncAJbce2oJF1wKDudQWXxbOf8NqVi
sdLbs++Uyf/gsQ7269syYPSEcWzvzp3cl9bl6KVizDIs8YnY9Lt7gH0VSuuMSDVp
i6xzxIGgpDU7RjnWhRGoqWcMSxbhU7Fb2ro+HNAzSrd+WYC8rq2JAaqDEcRMvDa+
4wqouDmsBd9Rs3ua2GzYurovJx8PEp1xl350sZ4hycQsrAzfOFQwfTEMtp0DLcY=
=cdI0
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
