From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] usb: dwc3: core.h: add some register definitions
Date: Mon, 20 Jun 2016 12:28:14 +0300
Message-ID: <87fus8qkep.fsf@linux.intel.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com> <1465564650-27516-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564650-27516-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> Add OTG and GHWPARAMS6 register definitions
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/core.h | 84 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8fb6361..32bb7531 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -197,6 +197,15 @@
>  #define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
>  #define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
>=20=20
> +/* Global Status Register */
> +#define DWC3_GSTS_OTG_IP	BIT(10)
> +#define DWC3_GSTS_BC_IP		BIT(9)
> +#define DWC3_GSTS_ADP_IP	BIT(8)
> +#define DWC3_GSTS_HOST_IP	BIT(7)
> +#define DWC3_GSTS_DEVICE_IP	BIT(6)
> +#define DWC3_GSTS_CSR_TIMEOUT	BIT(5)
> +#define DWC3_GSTS_BUS_ERR_ADDR_VLD	BIT(4)
> +
>  /* Global USB2 PHY Configuration Register */
>  #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
>  #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
> @@ -269,7 +278,12 @@
>  #define DWC3_MAX_HIBER_SCRATCHBUFS		15
>=20=20
>  /* Global HWPARAMS6 Register */
> -#define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
> +#define DWC3_GHWPARAMS6_BCSUPPORT		BIT(14)
> +#define DWC3_GHWPARAMS6_OTG3SUPPORT		BIT(13)
> +#define DWC3_GHWPARAMS6_ADPSUPPORT		BIT(12)
> +#define DWC3_GHWPARAMS6_HNPSUPPORT		BIT(11)
> +#define DWC3_GHWPARAMS6_SRPSUPPORT		BIT(10)
> +#define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)

Keep consistency, we don't use BIT() here.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ7cuAAoJEIaOsuA1yqRE5NMP/3F98zYF5YxTxD8FKP7F3wV6
cH+nkeO8k+y4+rIv1qFYeLNYDQRp0oVZ6wxb/o4vTJ40Y3ExzaR5bdEnUOsLgEA8
PGkZ977RPs+qPugpfiQCIHt01HvQSFkRw2hoKvxrvURYPDzpEu32Rw1GWnplsi25
g6d/Yao1nMUZq8IoETSLSeRLIubF0WGUqvVyZbuvdhZWuox8ME2b+SUy81xBp3++
rN6rLvNd/kqeq04sB8GKduXboGOxTDf97kJT6LY3fY6ZXJPUFNymfmuZI5YCQIQM
cKB9sLA1oCUKvQInPC4jhXhrrlgKYriG2vX6q9+jKTwpc2Sje0FlVXZ84xxak1Nx
7vw1BmExdUedxA4hQLLnIAbHcyWSIdP8S6s9JydvUr13OIoy+IoWegYxAtWmHufs
mePcsb+PHaK5fjstKHKAiI/tND0G2+DwsfVn8H6+/6Z4SRQVHRcIrr8H9nN7EzYX
Dxg/GF5WAvlYTA7mfL/IAVvL15h5HB2JgUmf6L7W8UR6MMhxJiVebRhFsXed82cO
CiFfPgf1JTqz2iLVlDfTkb0yUpwb5hlHE017KLxQIc5JN26DZVwM7hNDWu00k+kl
U7f3wx+sLmEX0ahoWEjsosR8DFWtGHv9HkfFyb1IHcEX88GFRe91yP3NyLv5VzE4
e4QJFgIE1c5Y24/9lJNl
=9mCw
-----END PGP SIGNATURE-----
--=-=-=--
