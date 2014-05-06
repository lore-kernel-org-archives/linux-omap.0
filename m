From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] ARM: dts: am335x-bone-common: use phandles for USB
 and DMA refs
Date: Tue, 6 May 2014 11:16:36 -0500
Message-ID: <20140506161636.GK25849@saruman.home>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5945678696313684243=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, LKML <linux-kernel@vger.kernel.org>, robh+dt@kernel.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5945678696313684243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
Content-Disposition: inline

--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 10:58:29AM -0300, Guido Mart=EDnez wrote:
> Use phandles instead of unit adresses to reference usb and dma nodes.
> This makes the DT more robust and readable.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dt=
s/am335x-bone-common.dtsi
> index 2e7d932..b95bc9a 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -183,28 +183,28 @@
>  &usb {
>  	status =3D "okay";
> =20
> -	control@44e10620 {
> +	&usb_ctrl_mod {
>  		status =3D "okay";
>  	};
> =20
> -	usb-phy@47401300 {
> +	&usb0_phy {
>  		status =3D "okay";
>  	};
> =20
> -	usb-phy@47401b00 {
> +	&usb1_phy {
>  		status =3D "okay";
>  	};
> =20
> -	usb@47401000 {
> +	&usb0 {
>  		status =3D "okay";
>  	};
> =20
> -	usb@47401800 {
> +	&usb1 {
>  		status =3D "okay";
>  		dr_mode =3D "host";
>  	};
> =20
> -	dma-controller@47402000  {
> +	&cppi41dma  {
>  		status =3D "okay";
>  	};
>  };
> --=20
> 1.9.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaQrkAAoJEIaOsuA1yqRE0FAQALPjKkVIiQ6BpssfsBVMXrxu
fXoVrT9zwkruJSyjmUlS9Lny3t77A/h95tM4vJz5d2wWUPCFoV6nKDYhGZAAiLjl
+bkgTLseFDBwpuAMeIMCjszG74djrDCijtIo9iYmBcVgqIDBAlkgCn1ChD5FYk8a
HBONTCGrywBNNmblqdHN3uJG9BQ1Muq5ZDgoD2GEbKMnB0AtrQSg7aQNArJPJqYF
sSAJYCRMlf8rByYcDfu3mQdtnF9bVnDJydT7J0c7pb7O+I1j4TsdP30GgVgwSReI
Xps/zCmpZoG6xLiRLtuRWTXJ4lErtJS1WWGUQuuAYGsjYjXnVUimXLWxx8BzVTp1
ooxOZannB1rzHZFmRlEHrHfpsprJi+ksG89byRqVZRcfZxzyH88JFt2NYk+zadiB
JR1A2pZa/o7sbtocaRuXaL3krMUNu8s4qgNCPzHDhGhYcl6GjxdugBp01OJ2NACQ
snWQVfKyP04ram8F8x4Fe4qUM0eLJZXuWmwqboPBTLfDxGg9Ov1NXAhYd+k5owYy
WxgVXb172RZpUsaEVkQ1V4fGhOj3+4nJayEpMQf872zJqa+ljM/Cd8APMfsHaoYT
XcImkNwjp+k7Lc34uqWlR8jZdA8Mshio2/kRJXsyDtJi0zYOvl/EBSN0neuwuMn8
BY4gPBzPChWKeGH86NaV
=xF/E
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--


--===============5945678696313684243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5945678696313684243==--
