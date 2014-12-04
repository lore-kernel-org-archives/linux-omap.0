From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: Add dual ethernet
Date: Thu, 4 Dec 2014 14:55:31 -0600
Message-ID: <20141204205531.GC18419@saruman>
References: <1417726418-1955-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46069 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997AbaLDUzw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 15:55:52 -0500
Content-Disposition: inline
In-Reply-To: <1417726418-1955-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>

--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2014 at 02:53:38PM -0600, Felipe Balbi wrote:
> Make CPSW work - BeagleBoard-X15 has two network ports
>=20
> MUX_MODE15 means "driver off". Pins are turned off
> conserving more power.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

grrr, not sure why it signed again... I guess git cherry-pick -s isn't
very smart after all. Tony, let me know if you prefer that I resend
fixing this SoB detail. In any case:

boot logs http://hastebin.com/joxiweleyi

> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 106 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 106 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/=
am57xx-beagle-x15.dts
> index 49edbda..da1b24c 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -140,6 +140,86 @@
>  		>;
>  	};
> =20
> +	cpsw_pins_default: cpsw_pins_default {
> +		pinctrl-single,pins =3D <
> +			/* Slave 1 */
> +			0x250 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tclk */
> +			0x254 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tctl */
> +			0x258 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td3 */
> +			0x25c (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td2 */
> +			0x260 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td1 */
> +			0x264 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td0 */
> +			0x268 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rclk */
> +			0x26c (PIN_INPUT | MUX_MODE0)	/* rgmii1_rctl */
> +			0x270 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd3 */
> +			0x274 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd2 */
> +			0x278 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd1 */
> +			0x27c (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd0 */
> +
> +			/* Slave 2 */
> +			0x198 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tclk */
> +			0x19c (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tctl */
> +			0x1a0 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td3 */
> +			0x1a4 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td2 */
> +			0x1a8 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td1 */
> +			0x1ac (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td0 */
> +			0x1b0 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rclk */
> +			0x1b4 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rctl */
> +			0x1b8 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd3 */
> +			0x1bc (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd2 */
> +			0x1c0 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd1 */
> +			0x1c4 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd0 */
> +		>;
> +
> +	};
> +
> +	cpsw_pins_sleep: cpsw_pins_sleep {
> +		pinctrl-single,pins =3D <
> +			/* Slave 1 */
> +			0x250 (PIN_INPUT | MUX_MODE15)
> +			0x254 (PIN_INPUT | MUX_MODE15)
> +			0x258 (PIN_INPUT | MUX_MODE15)
> +			0x25c (PIN_INPUT | MUX_MODE15)
> +			0x260 (PIN_INPUT | MUX_MODE15)
> +			0x264 (PIN_INPUT | MUX_MODE15)
> +			0x268 (PIN_INPUT | MUX_MODE15)
> +			0x26c (PIN_INPUT | MUX_MODE15)
> +			0x270 (PIN_INPUT | MUX_MODE15)
> +			0x274 (PIN_INPUT | MUX_MODE15)
> +			0x278 (PIN_INPUT | MUX_MODE15)
> +			0x27c (PIN_INPUT | MUX_MODE15)
> +
> +			/* Slave 1 */
> +			0x198 (PIN_INPUT | MUX_MODE15)
> +			0x19c (PIN_INPUT | MUX_MODE15)
> +			0x1a0 (PIN_INPUT | MUX_MODE15)
> +			0x1a4 (PIN_INPUT | MUX_MODE15)
> +			0x1a8 (PIN_INPUT | MUX_MODE15)
> +			0x1ac (PIN_INPUT | MUX_MODE15)
> +			0x1b0 (PIN_INPUT | MUX_MODE15)
> +			0x1b4 (PIN_INPUT | MUX_MODE15)
> +			0x1b8 (PIN_INPUT | MUX_MODE15)
> +			0x1bc (PIN_INPUT | MUX_MODE15)
> +			0x1c0 (PIN_INPUT | MUX_MODE15)
> +			0x1c4 (PIN_INPUT | MUX_MODE15)
> +		>;
> +	};
> +
> +	davinci_mdio_pins_default: davinci_mdio_pins_default {
> +		pinctrl-single,pins =3D <
> +			/* MDIO */
> +			0x23c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_mclk */
> +			0x240 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_d */
> +		>;
> +	};
> +
> +	davinci_mdio_pins_sleep: davinci_mdio_pins_sleep {
> +		pinctrl-single,pins =3D <
> +			0x23c (PIN_INPUT | MUX_MODE15)
> +			0x240 (PIN_INPUT | MUX_MODE15)
> +		>;
> +	};
> +
>  	tps659038_pins_default: tps659038_pins_default {
>  		pinctrl-single,pins =3D <
>  			0x418 (PIN_INPUT_PULLUP | MUX_MODE14)	/* wakeup0.gpio1_0 */
> @@ -365,6 +445,32 @@
>  	pinctrl-0 =3D <&uart3_pins_default>;
>  };
> =20
> +&mac {
> +	status =3D "okay";
> +	pinctrl-names =3D "default", "sleep";
> +	pinctrl-0 =3D <&cpsw_pins_default>;
> +	pinctrl-1 =3D <&cpsw_pins_sleep>;
> +	dual_emac;
> +};
> +
> +&cpsw_emac0 {
> +	phy_id =3D <&davinci_mdio>, <1>;
> +	phy-mode =3D "rgmii";
> +	dual_emac_res_vlan =3D <1>;
> +};
> +
> +&cpsw_emac1 {
> +	phy_id =3D <&davinci_mdio>, <2>;
> +	phy-mode =3D "rgmii";
> +	dual_emac_res_vlan =3D <2>;
> +};
> +
> +&davinci_mdio {
> +	pinctrl-names =3D "default", "sleep";
> +	pinctrl-0 =3D <&davinci_mdio_pins_default>;
> +	pinctrl-1 =3D <&davinci_mdio_pins_sleep>;
> +};
> +
>  &mmc1 {
>  	status =3D "okay";
> =20
> --=20
> 2.1.0.GIT
>=20

--=20
balbi

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgMpDAAoJEIaOsuA1yqREXcMP/A8voxY3zkQP1SpbnmklbiXj
Nxfvl5meybUuxz1MVQrDGgbt7/TxDl7qQSuuZX3go2vgpicdWBsysCOfMBKtkfzc
bzeZNmN4H5LEfhgap0SiZtQyPiL/eo9400OOyuNMAv2dJIYI9BGFmUAHOBXCa/ls
2224+cWqNwOZek12sSGsvr6Dg/IgE2E+SDBGUnq4Yk4Z4DUIFY0JrGdIm084Z9uO
NVDxk5xFyHQv5wsdnVk1DiQT1sALk6U3R4zG7UoiF5hcfpKoBu2zJuMivublib+H
7lf9Q1KbmPTnkk038wSL2ua2/5faJyTtHqIJj6DPyvRqlJMAFwdH+3FmIRwBy1Vr
f29m/WBUR/fT4MHIwmccQ79r7SBi/+Yt/TfJSfg8aJCEB+LdUsmCG6+2oJE2qhdp
+En83RAGHpALtLjfeH6VmLqFaFaWoTIUM44WrrgjD2pkY5Id4b+Etk9FX8bpsRZ2
9VK76lFZdgfZGZ/Ware9IIIUHuchI75KyjRiuOUNTBxSg0SVm5lmiKpULgOPRws7
pkLX/XZFt5umqCj1Eb8EQi7fnDMRsULl/w3/TB+bpvCX60ODVMQj3wj3TCIDNT+E
fFIQcshSOcgTTR0RSZxyAhEMIfjqaLDKJhFWFHDUDqbIu6QPleAUkrfOumNyoDkS
840N3Ed0v8GRN2HDtbet
=/bRm
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
