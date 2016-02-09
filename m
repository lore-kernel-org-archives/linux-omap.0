From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain
 data
Date: Tue, 9 Feb 2016 13:52:12 -0800
Message-ID: <20160209215210.GB27284@localhost.localdomain>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2016 at 02:46:27PM +0530, Keerthy wrote:
> OMAP5 has 3 thermal zones cpu, core and multimedia.
> On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
> and iva. Currently cpu, core and multimedia are being added via dt
> and the other 2 are getting added via kernel. Add the missing thermal
> domains in dt so as give the correct trip numbers, type and temperatures.
>=20
> Tested on DRA7-EVM.

For the series:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> =20
> Keerthy (3):
>   arm: dts: DRA7: Add DSPEVE thermal data
>   arm: dts: DRA7: Add IVA thermal data
>   arm: dts: DRA7: Add missing IVA and DSPEVE thermal domain data
>=20
>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 27 ++++++++++++++++++++++++=
+++
>  arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 27 ++++++++++++++++++++++++=
+++
>  arch/arm/boot/dts/dra7.dtsi                |  2 ++
>  3 files changed, 56 insertions(+)
>  create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>  create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi
>=20
> --=20
> 1.9.1
>=20

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWul+HAAoJEMLUO4d9pOJWqEoH/RKjzo2L4FnupaQPqS7XeeQu
BizhvonxWnwpmaR3JOovADdQLFCLNv/NdEkrn55yxAjQUYw5rDNXrAGiZk1krFGv
tD3qNUTZWTUZhBr8FqlJFGsWYXNu1ws9G47pOM76hsh7dU9Ec3CgCoXxGET5c7aF
bdGzaWjiHlMu2xXBlbUzIhlYDE6X6OFFHNHQZiLRTiMTlkufu0VMDHzZQoaMDdWq
779t5I7euI/tmCBq9cnmyxRy21j++eZhFbWttCcZhRR7NwNs/3hJDWxvUI4vxOiL
zfugj+E/GZ6dw9+ACxYi0hDYFmW9i7EW1+2IfN+AYw0iElOat9n22YMWaZCi61E=
=uQuX
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
