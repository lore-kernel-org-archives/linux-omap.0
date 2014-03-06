From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND PATCH 1/1] arm: dts: am33xx: correcting dt node unit
 address for usb
Date: Thu, 6 Mar 2014 09:26:37 -0600
Message-ID: <20140306152637.GB25648@saruman.home>
References: <1394109094-19205-1-git-send-email-mugunthanvnm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5362118876725491750=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394109094-19205-1-git-send-email-mugunthanvnm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: devicetree@vger.kernel.org, tony@atomide.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5362118876725491750==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2014 at 06:01:34PM +0530, Mugunthan V N wrote:
> DT node's unit address should be its own register offset address to make =
it a
> unique across the system. This patch corrects the incorrect USB entries w=
ith
> correct register offset for unit address.
>=20
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
> This patch was posted long back (Aug. 30, 2013), below is the archive of =
the
> orginal patch.
> https://patchwork.kernel.org/patch/2852163/
>=20
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 7073429..9770e35 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -453,7 +453,7 @@
>  			ti,hwmods =3D "usb_otg_hs";
>  			status =3D "disabled";
> =20
> -			usb_ctrl_mod: control@44e10000 {
> +			usb_ctrl_mod: control@44e10620 {
>  				compatible =3D "ti,am335x-usb-ctrl-module";
>  				reg =3D <0x44e10620 0x10
>  					0x44e10648 0x4>;
> @@ -556,7 +556,7 @@
>  					"tx14", "tx15";
>  			};
> =20
> -			cppi41dma: dma-controller@07402000 {
> +			cppi41dma: dma-controller@47402000 {
>  				compatible =3D "ti,am3359-cppi41";
>  				reg =3D  <0x47400000 0x1000
>  					0x47402000 0x1000
> --=20
> 1.9.0
>=20

--=20
balbi

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTGJOtAAoJEIaOsuA1yqRErGAP/0c2Z08DjRTUQutZiuYgvp54
Oas99qOL07xHgZSXnjXNNQGe0mJaa1lKb5EO7iIU/2aVFJYPktmX43bdk7DSsD/b
U1rplrDdsaHR7RooprBY1JD9/ufs9mtjotvV5gonwpmwb/Bf8WdUgIlRHYTS+ipr
BDFtLrecyicZuu1AmnDWR1sJrp4SrboOcpO1vjZ49lTDIZfnL+3vj7YjAk+JDbHZ
DpRRBDJ+MR30/CZfmrxbKwfFf67VcW5pc1dLaIUdWJHQKCSjxStXVwXg+n3mUQ/I
ipLGmcoa4sgmSASt2vvxjDkONH+i07CZJD02UTIFHrO+06AScTzN6lzFaEeI82Vl
AIBKK0zD8x0WvvAOOiA0Lwci1MWRtJQ2Q/yeeGvfdvomQi53C/v4KLnLzJhmnpVF
BhWonKRUgD0F7zTQv+ckqDhuBEdsg7AKRX0/bqYvIR9J/DnKeExJc8++NPdZa1ha
nW6wXBsC4LJyhv7RavBY8iHXZng1QbOG8q/Ing9tlGn0MlKbtsU6LQPVXSIsulHZ
keFm+1bSfDWk475XWhFi/VutOzxYM3dkuAx9FdK1A6cvHyOtm+ayJ2eyV41KUli2
CFr9ohdDO2qfb79SwVsjafeFYUB2BMkmxR2sw1D3KCGta+/ETIRsJmf/tDk5l2xu
+9UweRgVg4ulgqNAQ7K5
=AYoB
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--


--===============5362118876725491750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5362118876725491750==--
