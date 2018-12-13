From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-droid4: Configure wlcore wakeirq
Date: Fri, 14 Dec 2018 00:22:28 +0100
Message-ID: <20181213232228.beiwpqeixfvadjjf@earth.universe>
References: <20181213230411.5009-1-tony@atomide.com>
 <20181213230411.5009-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0786285351205322301=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213230411.5009-3-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0786285351205322301==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="avp7gkj5j2dtz5yr"
Content-Disposition: inline


--avp7gkj5j2dtz5yr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 13, 2018 at 03:04:11PM -0800, Tony Lindgren wrote:
> With wlcore supporting optional wakeirqs, we can configure it
> for pandaboard.

-ENOPANDA

-- Sebastian

> This makes ssh connection usable with the SoC
> entering deeper idle states.
>=20
> Let's configure a wakeirq both for the wlcore GPIO and the SDIO
> dat1 pin in case wlcore starts supporting SDIO dat1 interrupt at
> some point.
>=20
> And let's also add the missing keep-power-in-suspend while at it.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -359,20 +359,24 @@
> =20
>  &mmc3 {
>  	vmmc-supply =3D <&wl12xx_vmmc>;
> +	/* uart2_tx.sdmmc3_dat1 pad as wakeirq */
>  	interrupts-extended =3D <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
>  			       &omap4_pmx_core 0xde>;
> -
> +	interrupt-names =3D "irq", "wakeup";
>  	non-removable;
>  	bus-width =3D <4>;
>  	cap-power-off-card;
> +	keep-power-in-suspend;
> =20
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
>  	wlcore: wlcore@2 {
>  		compatible =3D "ti,wl1285", "ti,wl1283";
>  		reg =3D <2>;
> -		interrupt-parent =3D <&gpio4>;
> -		interrupts =3D <4 IRQ_TYPE_EDGE_RISING>; /* gpio100 */
> +		/* gpio_100 with gpmc_wait2 pad as wakeirq */
> +		interrupts-extended =3D <&gpio4 4 IRQ_TYPE_EDGE_RISING>,
> +				      <&omap4_pmx_core 0x4e>;
> +		interrupt-names =3D "irq", "wakeup";
>  		ref-clock-frequency =3D <26000000>;
>  		tcxo-clock-frequency =3D <26000000>;
>  	};
> --=20
> 2.19.2

--avp7gkj5j2dtz5yr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwS6bEACgkQ2O7X88g7
+prDPQ/+JSdbMwouHsYbluZAUpbH2LP66c0y+U7zxguTK56DvBTvB8DFzF2zBvqs
nf0DMCg0/Dxpt6PLgIlURLi38Ptr3RF5OweYS0o+GNuJreRsFwdWNAcFtDs8gHTV
mTvMoyhUGgHbzoUCRNtXnoca0zc6D0mY3jfLU6dFZz3rvdq+1b3d+ZFJknidERTe
Ejwx+TwTD8r0brGWUxxjmTGElhBxiIKOxOVeggQ+Zbdqo109f/QBDNAVgXGUBDNW
w2cK9C35xeULgDyMmxt1EPoon/tNSWl2pMYZHRe+qqcnIWvpS8WAZx+g32FvO79h
g+p1lzsiTn5/92qU7TpiuLBhSL5Ei45WqO2NZdSzlkW8j5DiRRcBe6vdegJNhdjz
Yp5POQIzPzP387cM2hWCSs1LfhG1Hm5dbkWgEARCgKRcE1F4loyBIdGgNwrpoCQx
JPCoEafxlBGbWjjEAaR+X+iIhSMgCTv83PkYsMnLtchugU2yYw9n8N3RA8Ggvg3Q
vjoqZvOCQ8XIbXO25UL99G5TGo98nUIZwSOvaQ7hMnG7SwQi0ux+KB7I/t0FRQxa
zWZk8uiNyr8LPozfH9Iuy/x3BtkmB+tmG58IN58J1NJxIzI4JdYpepx4U8J2/MR6
FYbducy7FG1mCoWizkIkHZ2Ujf+9ssR1iyegTM456DvQuPPUMkM=
=uzC4
-----END PGP SIGNATURE-----

--avp7gkj5j2dtz5yr--


--===============0786285351205322301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0786285351205322301==--
