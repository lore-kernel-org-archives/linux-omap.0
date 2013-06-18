From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv3 4/6] arm: dts: add bandgap entry for OMAP4460 devices
Date: Tue, 18 Jun 2013 16:16:20 -0400
Message-ID: <51C0C014.2000402@ti.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
 <1370637968-23299-5-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7903500784342801585=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1370637968-23299-5-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?B?QmVub8OudCBDb3Vz?= =?UTF-8?B?c29u?= <b-cousson@ti.com>
Cc: linux@arm.linux.org.uk, linux-pm@vger.kernel.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7903500784342801585==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2EGWVGQWNWKXECIBWKDIG"

------enig2EGWVGQWNWKXECIBWKDIG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Benoit

On 07-06-2013 16:46, Eduardo Valentin wrote:
> Include bandgap devices for OMAP4460 devices.
>=20
> Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---

Could you please have a look on patch 3 and 4 of this series? I have
changed this one accordingly to your recommendation on v2. If nothing
else, please let me know if they can still be queued for 3.11.

I would need to rebase patch 01 to refresh on top of the thermal tree.

Thanks.

>  arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap44=
60.dtsi
> index 2cf227c..ea97201 100644
> --- a/arch/arm/boot/dts/omap4460.dtsi
> +++ b/arch/arm/boot/dts/omap4460.dtsi
> @@ -29,4 +29,13 @@
>  			     <0 55 0x4>;
>  		ti,hwmods =3D "debugss";
>  	};
> +
> +	bandgap {
> +		reg =3D <0x4a002260 0x4
> +			0x4a00232C 0x4
> +			0x4a002378 0x18>;
> +		compatible =3D "ti,omap4460-bandgap";
> +		interrupts =3D <0 126 4>; /* talert */
> +		gpios =3D <&gpio3 22 0>; /* tshut */
> +	};
>  };
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2EGWVGQWNWKXECIBWKDIG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHAwBQACgkQCXcVR3XQvP0BJwD+Mx5tt0vnYlm2Bb08tk+iKoHn
Q3seGGl2L1Ux6ExQh2ABAOB0gY8FbCOqomDjdGkSTlGRjliTdSTETdKSDlHDSHnn
=LASY
-----END PGP SIGNATURE-----

------enig2EGWVGQWNWKXECIBWKDIG--


--===============7903500784342801585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7903500784342801585==--
