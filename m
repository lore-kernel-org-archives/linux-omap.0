From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable MUSB DMA support
Date: Fri, 28 Aug 2015 15:12:28 -0500
Message-ID: <20150828201228.GE7334@saruman.tx.rr.com>
References: <1440789582-25392-1-git-send-email-tony@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0695553429790502642=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1440789582-25392-1-git-send-email-tony@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0695553429790502642==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline

--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2015 at 12:19:42PM -0700, Tony Lindgren wrote:
> With recent MUSB changes we can now build in support for multiple
> DMA implementations. So let's enable DMA by default to make life
> easier for distro use.
>=20
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
> index 789fa5a8..1d5f80f 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -350,6 +350,8 @@ CONFIG_USB_MUSB_HDRC=3Dm
>  CONFIG_USB_MUSB_OMAP2PLUS=3Dm
>  CONFIG_USB_MUSB_AM35X=3Dm
>  CONFIG_USB_MUSB_DSPS=3Dm
> +CONFIG_USB_INVENTRA_DMA=3Dy
> +CONFIG_USB_TI_CPPI41_DMA=3Dy
>  CONFIG_USB_DWC3=3Dm
>  CONFIG_USB_TEST=3Dm
>  CONFIG_AM335X_PHY_USB=3Dy
> --=20
> 2.1.4
>=20

--=20
balbi

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV4MCsAAoJEIaOsuA1yqREdf0QALLncQ0gdLF7OzNsYJlJlnmC
clOG7pNSy80QpPa89b5u74mMetAGaX1xALsQCm2C+zHHxy9U3i9MZNw2tQEyOrYH
7GD60I57KgtEVmqsQKzzNHRBwDMGtbtnOAk7qfjme3BkKY31OoxRxfZOmlmsrPb+
igBVYl8Eh+RcgU3+VnecfvFtyGSx5sApP7Dgs+O10/vNIjWi6rm4Ovn4xpP0QQTS
jFRVsbdOAy1QkPhCgQTrufslA1LDBJvwfitULSRR/ONm52RCc9Soc2GI61Ch1hLE
6PbeKDQ4czpn+zyjtbBNr6Gha3kypDQ+cjzjllsUF4Dv3EFzc0ILMUmullJVULm7
o/IZPVgjxZAgAslxmVgydyOOlL3ijb+uWwstqTlkuU5xLCLwac2nOTAGh+AgENgK
TceGRgN0MCZNR9d36647tf2kQpL6uV4OsbwC2kmoTOawGFPiCLiXQbXT68L5nYh/
UbMPhvvDcCie5BQJ2mC+ztUVvl4a//WsQkQNtk/RPPqjzkZWknnCvyyYUlDicqlB
h4cErVmc2U1TymbTDjnyhjhjsWYFXmtLkOu+ji/nDOjFrYoJMzgp3ee4GCzr3RCn
CUPWa2WyrZ8NkVbpqgEPvmb+i7E26cguo8iWnECvBj3q4ag6YPE1YmucKFMOxPJq
Hb3vumYbqGu/kR8UqIxX
=LzcE
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--


--===============0695553429790502642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0695553429790502642==--
