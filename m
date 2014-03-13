From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Thu, 13 Mar 2014 12:21:42 +0200
Message-ID: <532186B6.3090902@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-5-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1WjQf6bFHdAbhOgFKrhnxxsJkvXCUkTgk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35005 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851AbaCMKWI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 06:22:08 -0400
In-Reply-To: <1394701109-6721-5-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, paul@pwsan.com

--1WjQf6bFHdAbhOgFKrhnxxsJkvXCUkTgk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/03/14 10:58, Sathya Prakash M R wrote:
> Add device node for DSS module for AM4372. Both the
> AM437x-Gp evm and Am43x-Epos evm use the same LCD panel.
> The lcd timings are added in respective dts files.
> Adds display pinctrl and enables required gpio.
> Also set the right parent clock to the DSS clock.
>=20
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi        |   28 +++++++++++++
>  arch/arm/boot/dts/am437x-gp-evm.dts  |   77 ++++++++++++++++++++++++++=
++++++++
>  arch/arm/boot/dts/am43x-epos-evm.dts |   73 ++++++++++++++++++++++++++=
++++++
>  arch/arm/boot/dts/am43xx-clocks.dtsi |    2 +
>  4 files changed, 180 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.d=
tsi
> index ea55a4e..b72a7df 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -684,6 +684,34 @@
>  			num-cs =3D <4>;
>                          status =3D "disabled";
>                  };
> +
> +		dss: dss@4832A000 {
> +			compatible =3D "ti,omap3-dss", "simple-bus";
> +			reg =3D <0x4832A000 0x200>;
> +			ti,hwmods =3D "dss_core";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +
> +			dispc@4832A400 {
> +				compatible =3D "ti,omap3-dispc";
> +				reg =3D <0x4832A400 0x400>;
> +				interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +				ti,hwmods =3D "dss_dispc";
> +			};
> +
> +			dpi: encoder@0 {
> +				compatible =3D "ti,omap3-dpi";
> +			};
> +
> +			rfbi: rfbi@4832A800 {
> +				compatible =3D "ti,omap3-rfbi";
> +			reg =3D <0x4832A800 0x100>;
> +				ti,hwmods =3D "dss_rfbi";
> +			};
> +
> +		};
> +

This seems to be based on old version of the DSS DT. Please rebase this
on top of the latest one:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt=


You also need to split this into smaller pieces: the dts clock fix, the
am4372.dtsi, and the board changes.

 Tomi



--1WjQf6bFHdAbhOgFKrhnxxsJkvXCUkTgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIYa2AAoJEPo9qoy8lh71aVAP/1wF5Q3ZIDUk/dQfcSepzQkC
nroXJrl5i3J+/eXKdpSxhYOARN8aeJY59TlIfi0NKb1DsSXbe86CscddQ7v/uP2V
5OimJHeKp3LnwyI9BJODBYxvu42+HKzEFlKecqRmgTuoVvhzkbR8DoQr1YaXHzzG
z+wbulMsbMie7eF9glTcbT58aJoTIiBuQeLrmQrhROCmQzzC2mnxFiuh8erUnsaY
7E6WayLfgFN46+GkhFhXsgKwhvpgYb6P7mMrrJAKZAFGnbJZr7IWA4octgHhstG/
7J4uG1l1l8QWngl8VKl3QFlG0AYsfu6SmWcqAaGeS2/Jp+u5ciwh6COwv9Z2DoTC
gMVvqhstwJeGcd7PFMpKu+C+kYQKnVVotQZjBBO/Ef9rLaWgmFTLn2Ti4nRE3Fe8
dhLz7kORtkW2QZZktQExhShz/JKa7J3emsQcHvCzb267p8+BNzn0fdpnTZj0Casm
onJTpdKeBkRF0Xjo2rzqe3Xexx0gz3G0XicyLI290i4p8JRX8fRpHkYH6xQbMnTM
8+k87hfEXiBWMp9/J/gi+yiVopqB/VD8cGiwf2fvZIaCzg6cNR8d8UFOpY0JyWQI
jUbNBV71u70xgpbM3CF0Vby+P7v/Ac1uxwUIBujeRs/Wec5Dw+RrXY5l2pQlLkk6
14ofQs2ARUC5cRnPmxjq
=ekya
-----END PGP SIGNATURE-----

--1WjQf6bFHdAbhOgFKrhnxxsJkvXCUkTgk--
